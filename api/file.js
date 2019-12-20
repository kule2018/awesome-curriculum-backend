
const tips = require('../config/response');
const fs = require('fs');
const path = require('path');
const mysql = require('../utils/mysql');


let upload = async (ctx, next) => {
	const file = ctx.request.files.file;	// 获取上传文件
	console.log(file);
	const reader = fs.createReadStream(file.path);	// 创建可读流
	const time = String(new Date().getTime());
	const fileName = `${time}-${file.name}`;
	const filePath = path.join(__dirname, '../../curriculum/upload/') + `/${fileName}`;
	const upStream = fs.createWriteStream(filePath);
	reader.pipe(upStream);	// 可读流通过管道写入可写流
	const insertAvatar = `
		update user
		set avatar='${fileName}'
		where id=${ctx.state};
	`;
	await mysql.query(insertAvatar);
	return ctx.body = {
		...tips[1],
		fileName
	};
}

module.exports = {
  upload
}