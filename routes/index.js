const router = require('koa-router')()
const api = require('../api')


router.get('/api/user/getUserInfo', api.user.getUserInfo)
router.post('/api/user/registerCode', api.user.registerCode)
router.post('/api/user/register', api.user.register)
router.post('/api/user/login', api.user.login)

module.exports = router