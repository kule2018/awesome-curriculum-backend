const nodemailer = require('nodemailer');
const emailInfo = require('../config/email');
const mysql = require('./mysql');

let transporter = nodemailer.createTransport({
  // host: 'smtp.ethereal.email',
  service: 'qq', // 使用了内置传输发送邮件 查看支持列表：https://nodemailer.com/smtp/well-known/
  port: 465, // SMTP 端口
  secureConnection: true, // 使用了 SSL
  auth: {
    user: emailInfo.user,
    // 这里密码不是qq密码，是你设置的smtp授权码
    pass: emailInfo.pass,
  }
});

const sendEmail = (to, verificationCode) => {
  let mailOptions = {
    from: `"课程助手" <${emailInfo.user}>`, // sender address
    to: to, // list of receivers
    subject: '课程助手注册验证码', // Subject line
    // 发送text或者html格式
    html: `<b>Hello world?</b>${verificationCode}` // html body
  };

  // send mail with defined transport object
  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      return console.log(error);
    }
    const time = new Date().getTime();
    const writeVerificationCode = `
      insert into verificationCode
      (email, time, value)
      values
      ('${to}', ${time}, '${verificationCode}');
    `
    mysql.query(writeVerificationCode).then(response => {
      console.log(response);
    })
    console.log('Message sent: %s', info.messageId);
    // Message sent: <04ec7731-cc68-1ef6-303c-61b0f796b78f@qq.com>
  });
}

module.exports = sendEmail;

