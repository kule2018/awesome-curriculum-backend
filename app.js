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
const path = require('path');
const koaBody = require('koa-body');
// 导入WebSocket模块:
const WebSocket = require('ws');
// 引用Server类:
const WebSocketServer = WebSocket.Server;


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


let wss = new WebSocketServer({
  port: 3002
});

wss.on('connection', async (ws, req) => {
  parseUser(req).then(response => {
    const userId = response;
    console.log(`userId:${userId}的用户登录成功`);
    if (!userId) {
      ws.close(4001, 'invalid user');
    }
  });
});

