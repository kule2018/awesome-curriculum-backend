const router = require('koa-router')()
const api = require('../api')


router.post('/api/user/registerCode', api.user.registerCode)
router.post('/api/user/register', api.user.register)
router.post('/api/user/login', api.user.login)
router.get('/api/user/logout', api.user.logout)

module.exports = router