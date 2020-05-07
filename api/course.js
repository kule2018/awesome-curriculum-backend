const tips = require("../config/response");
const mysql = require("../utils/mysql");

/**
 * @description 添加课程
 * @param {string} name
 * @param {number} week
 * @param {number} start
 * @param {number} time
 * @param {number} color
 */
let addCourse = async (ctx, next) => {
  const data = ctx.request.body;
  const userId = ctx.state;
  let timeList = data.timeList;
  if(typeof timeList=='string'){
    timeList = JSON.parse(timeList);
  }
  for(let item of timeList){
    const insertCourse = `
    insert into curriculum
      (name, week, start, time, userId, color, teacherName, room, courseNo)
      values
      ('${data.name}', ${item.week}, ${item.start}, ${item.time}, ${userId}, '${data.color}', '${data.teacherName}', '${data.room}', '${data.courseNo==''?'000':data.courseNo}');
    `;
    await mysql.query(insertCourse);
  }
  await updateTime(userId);
  
  return (ctx.body = {
    ...tips[1],
    // id: JSON.parse(JSON.stringify(response)).insertId
  });
};

/**
 * @description 删除课程
 * @param {string} name
 * @param {number} id
 * @param {boolean} all
 */
let deleteCourse = async (ctx, next) => {
  const data = ctx.request.body;
  const userId = ctx.state;
  const deleteOne = `
    delete from curriculum
    where
    id=${data.id} and name='${data.name}' and userId=${userId};
  `;
  const deleteAll = `
    delete from curriculum
    where
    name='${data.name}' and userId=${userId};
  `;
  let response = "";
  if (!data.all) {
    response = await mysql.query(deleteOne);
  } else {
    response = await mysql.query(deleteAll);
  }
  await updateTime(userId);
  return ctx.body = tips[1];
};

/**
 * @description 获取所有课程
 */
let queryCourse = async (ctx, next) => {
  const queryAllCourse = `
    select * from curriculum
    where
    userId=${ctx.state};
  `;
  let response = await mysql.query(queryAllCourse);
  return (ctx.body = {
    ...tips[1],
    data: JSON.parse(JSON.stringify(response)),
    label: ctx.label
  });
};

/**
 * @description 修改课程
 * @param {string} name
 * @param {number} week
 * @param {number} start
 * @param {number} time
 * @param {string} color
 * @param {number} id
 */
let updateCourse = async (ctx, next) => {
  const userId = ctx.state;
  const data = ctx.request.body;
  console.log("update", data);
  const queryOldName = `
    select *
    from curriculum
    where id=${data.id};
  `;
  let oldName = await mysql.query(queryOldName);
  const deleteCourse = `
    delete from curriculum
    where
    name='${oldName[0].name}' and userId=${userId}
  `;
  let timeList = data.timeList;
  if(typeof timeList=='string'){
    timeList = JSON.parse(timeList);
  }
  await mysql.query(deleteCourse);
  for(let item of timeList){
    const insertCourse = `
      insert into curriculum
      (name, week, start, time, userId, color, teacherName, room, courseNo)
      values
      ('${data.name}', ${item.week}, ${item.start}, ${item.time}, ${userId}, '${data.color}', '${data.teacherName}', '${data.room}', '${data.courseNo}');
    `;
    await mysql.query(insertCourse);
  }
  await updateTime(userId);
  return (ctx.body = {
    ...tips[1]
  });
};


/**
 * @description 刷新更新数据的时间
 * @param {number} userId 
 */
let updateTime = async (userId) => {
  const time = +new Date();
  const searchTime = `
    select * from updateTime
    where
    userId=${userId};
  `;
  const updateTime = `
    update updateTime
    set time='${time}'
    where userId=${userId};
  `;
  let users = await mysql.query(searchTime);
  users = JSON.parse(JSON.stringify(users));
  console.log(users);
  let update = 0;
  if(users.length != 0){
    await mysql.query(updateTime);
  }else{
    await mysql.query(`
      insert into updateTime
      (userId, time)
      values
      (${userId}, '${time}');
    `)
  }
}


let queryUpdateTime = async (ctx, next) => {
  const userId = ctx.state;
  const query = `
    select * from updateTime
    where userId=${userId};
  `;
  let response = await mysql.query(query);
  response = JSON.parse(JSON.stringify(response));
  let time = 0;
  if(response.length != 0){
    time = response[0].time;
  }
  return (ctx.body = {
    ...tips[1],
    time
  });
}

const autoImportCourse = async (ctx, next) => {
  const userId = ctx.state;
  const data = ctx.request.body;
  console.log(data);
  const deleteCourse = `
    delete from curriculum
    where userId='${userId}'
  `;
  if(data.courseList.length === 0){
    return ctx.body = {
      ...tips[1007]
    }
  }
  await mysql.query(deleteCourse);
  const courseList = JSON.parse(data.courseList);
  for(let item of courseList){
    const insertCourse = `
      insert into curriculum
      (name, week, start, time, userId, color, teacherName, room, courseNo)
      values
      ('${item.name}', ${item.week}, ${item.start}, ${item.time}, ${userId}, '${item.color}', '${item.teacherName}', '${item.room}', '${item.courseNo==''?'000':item.courseNo}');
    `;
    await mysql.query(insertCourse);
  }
  await updateTime(userId);
  return (ctx.body = {
    ...tips[1]
  });
}

const searchCourse = async(ctx, next) => {
  const userId = ctx.state;
  const data = ctx.request.body;
  if(!data.page){
    return ctx.body = {
      ...tips[1008]
    }
  }
  const query = `select * from webCourses where name like '%${data.content}%' order by name limit ${20*(data.page-1)}, 20;`;
  let response = await mysql.query(query);
  response = JSON.parse(JSON.stringify(response));
  let d = [];
  for(const item of response){
    const sql = `
      select * from favorite
      where userId=${userId} and courseId=${item.id};
    `;
    const r = await mysql.query(sql);
    d.push({
      ...item,
      favorite: r.length!==0
    })
  }
  return (ctx.body = {
    ...tips[1],
    data: d
  });
}

const collectCourse = async(ctx, next) => {
  const userId = ctx.state;
  const data = ctx.request.body;
  const courseId = data.courseId;

  const insertFavorite = `
    insert into favorite
    (userId, courseId)
    values
    (${userId}, ${courseId});
  `;

  const queryFavorite = `
    select * from favorite
    where userId=${userId} and courseId=${courseId};
  `;

  const increaseCollectNum = `
    update webCourses
    set collectionNum=collectionNum+1
    where id=${courseId};
  `;

  const res = await mysql.query(queryFavorite);
  if(res.length != 0){
    return ctx.body = {
      ...tips[1009]
    }
  }else{
    await mysql.query(insertFavorite);
    await mysql.query(increaseCollectNum);
    return ctx.body = {
      ...tips[1]
    }
  }
}

const clickCourse = async(ctx, next) => {
  const userId = ctx.state;
  const data = ctx.request.body;
  const courseId = data.courseId;
  const insertClick = `
    insert into clickLog
    (userId, courseId, count)
    values
    (${userId}, ${courseId}, 1);
  `;

  const queryClick = `
    select * from clickLog
    where userId=${userId} and courseId=${courseId};
  `;

  const increaseClickNum = `
    update webCourses
    set clickNum=clickNum+1
    where id=${courseId};
  `;

  const increaseUserClick = `
    update clickLog
    set count=count+1
    where userId=${userId} and courseId=${courseId}
  `;

  const res = await mysql.query(queryClick);
  if(res.length != 0){
    await mysql.query(increaseUserClick);
  }else{
    await mysql.query(insertClick);
  }
  await mysql.query(increaseClickNum);
  return ctx.body = {
    ...tips[1]
  }

}

const deleteFavorite = async(ctx, next) => {
  const userId = ctx.state;
  const data = ctx.request.body;
  const courseId = data.courseId;
  const queryFavorite = `
    select * from favorite
    where userId=${userId} and courseId=${courseId};
  `;
  const delFavorite = `
    delete from favorite
    where userId=${userId} and courseId=${courseId};
  `;

  const res = await mysql.query(queryFavorite);
  if(res.length == 0){
    return ctx.body = {
      ...tips[1010]
    }
  }else{
    await mysql.query(delFavorite);
    return ctx.body = {
      ...tips[1]
    }
  }
}

const favoriteCourse = async(ctx, next) => {
  const userId = ctx.state;
  const datas = ctx.request.body;
  const page = datas.page;

  const queryFavorite = `
    select * from favorite, webCourses
    where favorite.courseId=webCourses.id and userId=${userId} order by name limit ${20*(page-1)}, 20;
  `;
  const res = await mysql.query(queryFavorite);
  let data = [];
  for(const item of res){
    data.push({
      ...item,
      favorite: true
    })
  }
  return ctx.body = {
    ...tips[1],
    data
  };
}

module.exports = {
  addCourse,
  queryCourse,
  updateCourse,
  deleteCourse,
  queryUpdateTime,
  autoImportCourse,
  searchCourse,
  collectCourse,
  deleteFavorite,
  favoriteCourse,
  clickCourse
};
