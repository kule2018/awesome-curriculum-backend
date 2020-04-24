const Koa = require('koa');
const app = new Koa();
const router = require('./routes/index');
const cors = require('koa2-cors');
const bodyParser = require('koa-bodyparser');
const tokenUtils = require('./utils/tokenUtils');
const mysql = require('./utils/mysql');
const tips = require('./config/response');
const morgan = require('koa-morgan');
const fs = require('fs');
const parseUser = require('./utils/parseUser');
const koaBody = require('koa-body');
const cookie = require('cookie');
const socketConnect = require('./socket/index')

const io = require('socket.io')(3002);


const accessLogStream = fs.createWriteStream(__dirname + '/access.log', { flags: 'a' })


app.use(cors({
  origin: '*',
  allowHeaders: ['Content-Type', 'Authorization', 'Accept'],
  allowMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
}));
app.use(koaBody({
  multipart: true,
  formidable: {
    maxFileSize: 2000 * 1024 * 1024	// 设置上传文件大小最大限制，默认2M
  }
}));
app.use(async (ctx, next) => {
  const { url = '' } = ctx;
  console.log(url);
  if (!url.includes('registerCode') && !url.includes('register') && !url.includes('login') && !url.includes('logout')) {
    let token = JSON.parse(JSON.stringify(ctx.query)).token;
    if (!token) {
      return ctx.body = tips[0];
    }
    let result = tokenUtils.verifyToken(token);
    let { id } = result;
    const queryToken = `
      select * from token
      where
      value = '${token}';
    `;
    let response = await mysql.query(queryToken);
    if (response.length && id && response[0].userId === id) {
      ctx.state = id;
      const userInfo = `
        select * from user
        where id=${id};
      `;
      const u = await mysql.query(userInfo);
      ctx.label = u[0].label==1 ? true : false;
      await next();
    } else {
      return ctx.body = tips[0];
    }
  } else {
    await next();
  }
})
app.use(bodyParser());
app.use(router.routes(), router.allowedMethods());
app.use(morgan('combined', { stream: accessLogStream }))


app.listen(3001);

socketConnect(io);
