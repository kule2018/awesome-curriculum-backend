const mysql = require('../utils/mysql');
const sendEmail = require('../utils/sendEmail');
const genPassword = require('../utils/genPassword');
const tokenUtils = require('../utils/tokenUtils');
const tips = require('../config/response');

/**
 * @description 用户注册
 * @param {String} email
 */
let registerCode = async (ctx, next) => {
  const data = ctx.request.body;
  const code = ~~(Math.random() * 1000000);
  console.log(code)
  const queryUserSql = `
    select * from user
    where email = '${data.email}'
  `;
  await mysql.query(queryUserSql).then(response => {
    if (response.length !== 0) {
      return ctx.body = tips[1001];
    } else {
      sendEmail(data.email, code);
      return ctx.body = tips[1];
    }
  })
}
/**
 * @description 注册
 * @param {string} email
 * @param {string} pas,
 */
let register = async (ctx, next) => {
  const data = ctx.request.body;
  const pass = genPassword.genPassword(data.password);
  const queryVerification = `
    select * from verificationCode
    where
    value='${data.verificationCode}' and email='${data.email}';
  `;
  const deleteVerification = `
    delete from verificationCode
    where
    email = '${data.email}';
  `;
  const creatUser = `
    insert into user
    (name, email, password)
    values
    ('用户', '${data.email}', '${pass}');
  `;
  const queryUserSql = `
    select * from user
    where email = '${data.email}'
  `;
  let response = await mysql.query(queryVerification)
  if (response.length === 0) {
    ctx.body = tips[1002];
    return;
  } else {
    const oldTime = response[0].time;
    const newTime = new Date().getTime();
    if ((newTime - oldTime) / 1000 / 60 > 15) {
      return ctx.body = tips[1003];
    }
  }
  await mysql.query(deleteVerification);

  response = await mysql.query(queryUserSql)
  if (response.length !== 0) {
    return ctx.body = tips[1001];
  }
  await mysql.query(creatUser);
  ctx.body = tips[1];
}

/**
 * @description 登录
 * @param {string} email 
 * @param {string} password 
 */
let login = async (ctx, next) => {
  const data = ctx.request.body;
  const pass = genPassword.genPassword(data.password);
  let res = {
    code: 1,
    message: 'success'
  }
  const queryUser = `
    select * from user
    where
    email='${data.email}' and password='${pass}';
  `;
  
  let response = await mysql.query(queryUser);
  if (response.length === 0) {
    return ctx.body = tips[1004];
  } else {
    const token = tokenUtils.generateToken({ id: response[0].id });
    res.token = token;
    res.username = response[0].name;
    res.avatar = response[0].avatar;
    const insertToken = `
      insert into token
      (value, userId)
      values
      ('${token}', '${response[0].id}');
    `;
    await mysql.query(insertToken);
  }
  return ctx.body = res;
}


/**
 * @description 登出接口
 * @param {string} token
 */
let logout = async (ctx, next) => {
  const token = ctx.query.token;
  const deleteToken = `
    delete from token
    where
    value='${token}';
  `;
  await mysql.query(deleteToken);
  return ctx.body = tips[1];
}

let updateName = async (ctx, next) => {
  console.log('修改')
  const data = ctx.request.body;
  const updateUser = `
    update user
    set
    name='${data.name}'
    where
    id=${ctx.state}
  `;
  await mysql.query(updateUser);
  return ctx.body = tips[1];
}

module.exports = {
  registerCode,
  register,
  login,
  logout,
  updateName
}