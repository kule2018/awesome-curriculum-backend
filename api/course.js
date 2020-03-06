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
  for(let item of data.timeList){
    const insertCourse = `
    insert into curriculum
      (name, week, start, time, userId, color, teacherName, room)
      values
      ('${data.name}', ${item.week}, ${item.start}, ${item.time}, ${userId}, '${data.color}', '${data.teacherName}', '${data.room}');
    `;
    await mysql.query(insertCourse);
  }
  
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
  const deleteCourse = `
    delete from curriculum
    where
    name='${data.name}' and userId=${userId}
  `;
  await mysql.query(deleteCourse);
  for(let item of data.timeList){
    const insertCourse = `
      insert into curriculum
      (name, week, start, time, userId, color, teacherName, room)
      values
      ('${data.name}', ${item.week}, ${item.start}, ${item.time}, ${userId}, '${data.color}', '${data.teacherName}', '${data.room}');
    `;
    await mysql.query(insertCourse);
  }
  return (ctx.body = tips[1]);
};

module.exports = {
  addCourse,
  queryCourse,
  updateCourse,
  deleteCourse
};
