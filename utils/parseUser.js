const tokenUtils = require('./tokenUtils');
const mysql = require('./mysql');

function cookieToJson(cookie) {
    let cookieArr = cookie.split(";");
    let obj = {}
    cookieArr.forEach((i) => {
        let arr = i.split("=");
        obj[arr[0]] = arr[1];
    });
    return obj;
}

const parseUser = async(obj) => {
    if (!obj) {
        return;
    }
    let s = '';
    if (typeof obj === 'string') {
        s = obj;
    } else if (obj.headers && obj.headers.cookie) {
        let cookies = cookieToJson(obj.headers.cookie);
        s = cookies.CurriculumKey;
    } else {
        return ;
    }
    if (s) {
        let result = tokenUtils.verifyToken(s);
        let { id } = result;
        const queryToken = `
            select * from token
            where
            value = '${s}';
        `;
        let response = await mysql.query(queryToken);
        if (response.length && id && response[0].userId === id) {
            return id;
        } else {
            return ;
        }
    }
}

module.exports = parseUser;