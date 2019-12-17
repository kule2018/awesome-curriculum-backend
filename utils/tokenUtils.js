const fs = require('fs');
const path = require('path');
const jwt = require('jsonwebtoken');
//生成token的方法
function generateToken(data) {
  let created = Math.floor(Date.now() / 1000);
  let cert = fs.readFileSync(path.join(__dirname, '../config/rsa_private_key.pem'));//私钥
  let token = jwt.sign({
    data,
    exp: created + 3600 * 24 * 3
  }, cert, { algorithm: 'RS256' });
  return token;
}

function verifyToken(token) {
  let res = {}
  let cert = fs.readFileSync(path.join(__dirname, '../config/rsa_public_key.pem'));//公钥
  try {
    let result = jwt.verify(token, cert, { algorithms: ['RS256'] }) || {};
    let { exp = 0 } = result, current = Math.floor(Date.now() / 1000);
    if (current <= exp) {
      res = result.data || {};
    }
  } catch (e) {
    console.error(e);
  }
  return res;
}

module.exports = {
  generateToken,
  verifyToken
};

