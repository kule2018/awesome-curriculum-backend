const router = require('koa-router')()
const api = require('../api')

// 用户相关api
router.post('/api/user/registerCode', api.user.registerCode)
router.post('/api/user/register', api.user.register)
router.post('/api/user/login', api.user.login)
router.get('/api/user/logout', api.user.logout)


// 课程相关api
router.post('/api/course/addCourse', api.course.addCourse)
router.get('/api/course/queryCourse', api.course.queryCourse)
router.post('/api/course/updateCourse', api.course.updateCourse)


module.exports = router