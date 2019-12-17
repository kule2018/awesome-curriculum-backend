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

const accessLogStream = fs.createWriteStream(__dirname + '/access.log',{ flags: 'a' })


app.use(cors({
  origin: 'http://localhost:3000',
  credentials: true,
  allowHeaders: ['Content-Type', 'Authorization', 'Accept'],
  allowMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
}));
app.use(morgan('combined', { stream: accessLogStream }))
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
    if (response.length && id && response[0].userId===id) {
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
app.listen(3001);