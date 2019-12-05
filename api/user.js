const mysql = require('../utils/mysql');
const sendEmail = require('../utils/sendEmail');
const genPassword = require('../utils/genPassword');


/**
 * @description 获取用户信息
 * @param {String} name
 */
let getUserInfo = async (ctx, next) => {
  const token = ctx.query.token;
  let res = {
    code: 1,
    res: 'success',
    data: []
  };
  let _sql = `
        select * from token
        right join user on user.id=token.userid 
        where value = '${token}'
    `;
  await mysql.query(_sql).then(response => {
    const oldTime = response[0].time;
    const newTime = new Date().getTime();
    if ((newTime - oldTime) / 1000 / 60 / 60 / 24 > 15) {
      res.data.push({
        name: response[0].name
      });
    } else {
      res.code = -1;
      res.res = '登录超时，请重新登录';
    }
  })
  ctx.body = JSON.parse(JSON.stringify(res));
}

/**
 * @description 用户注册
 * @param {String} email
 */
let registerCode = async (ctx, next) => {
  const data = ctx.request.body;
  console.log('data', data);
  const code = ~~(Math.random() * 1000000);
  const queryUserSql = `
    select * from user
    where email = '${data.email}'
  `;
  let res = {
    code: 1,
    message: 'success'
  };
  await mysql.query(queryUserSql).then(response => {
    if (response.length !== 0) {
      res.code = 0;
      res.message = '此邮箱已注册，请直接登录';
    } else {
      sendEmail(data.email, code);
    }
  })
  ctx.body = res;
}
/**
 * @description 注册
 * @param {string} email
 * @param {string} pas,
 */
let register = async (ctx, next) => {
  const data = ctx.request.body;
  console.log(data);
  let res = {
    code: 1,
    message: 'success'
  }
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
    res.code = 0;
    res.message = '验证码不正确';
    ctx.body = res;
    return;
  } else {
    const oldTime = response[0].time;
    const newTime = new Date().getTime();
    if ((newTime - oldTime) / 1000 / 60 > 15) {
      res.code = 0;
      res.message = '验证码过期，请重新获取';
      ctx.body = res;
      return;
    }
  }
  await mysql.query(deleteVerification);

  response = await mysql.query(queryUserSql)
  if (response.length !== 0) {
    res.code = 0;
    res.message = '此邮箱已注册，请直接登录';
    ctx.body = res;
    return;
  }
  await mysql.query(creatUser);
  ctx.body = res;
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
  if(response.length === 0) {
    res.code = 0;
    res.message = '用户名或密码错误';
    ctx.body = res;
    return ;
  }
  ctx.body = res;
}

module.exports = {
  getUserInfo,
  registerCode,
  register,
  login
}