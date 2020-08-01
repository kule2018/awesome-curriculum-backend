<p align="center"><img src="./readme-assets/logo.png"></p>
<p align="center"><g-emoji class="g-emoji" alias="fire" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f525.png">🔥</g-emoji>课程助手后端</p>

## 项目说明

awesome-curriculum 系统的后端

## 项目构建方法

### 配置文件

你应该可以发现项目目录`/config/`下的三个文件里面的配置项都为空，因为我使用的云服务器作为 MySQL 数据存储，包括 qq 邮箱密钥，为了保护隐私，还请大家自己填写调试程序。

```js
// PASS_SECERT.js
const PASS_SECRET = {
  SECRET_KEY: "" // 加密密码的密钥，自己随便填写就好
};
```

```js
// dbConfig.js
const dbConfig = {
  DATABASE: "", //数据库
  USERNAME: "", //用户
  PASSWORD: "", //密码
  PORT: "", //端口
  HOST: "" //服务ip地址
};
```

```js
// email.js
const emailInfo = {
  user: "",
  pass: "" // QQ邮箱密钥，注意：不是密码
};
```

另外，config 目录下还有两个 pem 文件，这个是生成的密钥和公钥，请按照以下方法生成

1. 打开命令行工具，输入 openssl，打开 openssl;
2. 生成私钥
   `genrsa -out rsa_private_key.pem 2048`
3. 生成公钥
   `rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem`
### 配置数据库
根目录下有 sql 文件，直接运行该文件即可
### 安装依赖

```bash
npm run install
```

### 运行项目

```bash
npm run start
```

## 项目依赖

| 名称           | 版本        | 说明             |
| -------------- | ----------- | ---------------- |
| `koa`          | :car:2.11.0 | 项目框架         |
| `jsonwebtoken` | :car:8.5.1  | 生成与验证 token |
| `koa2-cors`    | :car:2.0.6  | 允许跨域         |
| `mysql`        | :car:2.17.1 | 连接 `MySQL`     |
| `nodemailer`   | :car:6.3.1  | 发送邮件         |
