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
    html: `
        <div id="contentDiv" onmouseover="getTop().stopPropagation(event);"
        onclick="getTop().preSwapLink(event, 'html', 'ZC0705-6sa8qKO1peMKHEwRlnQUe9c');"
        style="position:relative;font-size:14px;height:auto;padding:15px 15px 10px 15px;z-index:1;zoom:1;line-height:1.7;"
        class="body">
        <div id="qm_con_body">
          <div id="mailContentContainer" class="qmbox qm_con_body_content qqmail_webmail_only" style="">
            <style></style>
            <div class="WordSection1">
              <p class="MsoNormal">用户您好：<span lang="EN-US">
                  <o:p></o:p>
                </span></p>
              <p class="MsoNormal"><span lang="EN-US">
                  <o:p>&nbsp;</o:p>
                </span></p>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; </span>感谢您注册课程助手账号，您的验证码是：<span
                  lang="EN-US">
                  <o:p></o:p>
                </span></p>
              <p class="MsoNormal"><span lang="EN-US">
                  <o:p>&nbsp;</o:p>
                </span></p>
              <p class="MsoNormal" align="center" style="text-align:center"><b><span lang="EN-US"
  style="font-size:24.0pt">${verificationCode}<o:p></o:p></span></b></p>
              <p class="MsoNormal" align="center" style="text-align:center"><b><span lang="EN-US" style="font-size:24.0pt">
                    <o:p>&nbsp;</o:p>
                  </span></b></p>
              <p class="MsoNormal" align="left" style="text-align:left">祝好！<span lang="EN-US">
                  <o:p></o:p>
                </span></p>
            </div>
            <style type="text/css">
              .qmbox style,
              .qmbox script,
              .qmbox head,
              .qmbox link,
              .qmbox meta {
                display: none !important;
              }

            </style>
          </div>
        </div>
        <style>
          #mailContentContainer .txt {
            height: auto;
          }

        </style>
      </div>
    ` // html body
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

