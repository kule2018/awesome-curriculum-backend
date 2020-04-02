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
  console.log('add', data);
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
    console.log(insertCourse);
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
  console.log({
    ...tips[1],
    data: JSON.parse(JSON.stringify(response))
  });
  return (ctx.body = {
    ...tips[1],
    data: JSON.parse(JSON.stringify(response))
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

module.exports = {
  addCourse,
  queryCourse,
  updateCourse,
  deleteCourse,
  queryUpdateTime
};
