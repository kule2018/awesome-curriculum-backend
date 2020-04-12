const router = require('koa-router')()
const api = require('../api')

// 用户相关api
router.post('/api/user/registerCode', api.user.registerCode)
router.post('/api/user/register', api.user.register)
router.post('/api/user/login', api.user.login)
router.get('/api/user/logout', api.user.logout)
router.post('/api/user/updateName', api.user.updateName)
router.post('/api/user/updateSchool', api.user.updateSchool)


// 课程相关api
router.post('/api/course/addCourse', api.course.addCourse)
router.get('/api/course/queryCourse', api.course.queryCourse)
router.post('/api/course/updateCourse', api.course.updateCourse)
router.post('/api/course/deleteCourse', api.course.deleteCourse)
router.get('/api/course/queryUpdateTime', api.course.queryUpdateTime)
router.post('/api/course/autoImportCourse', api.course.autoImportCourse)

// 文件上传
router.post('/api/file/uploadFile', api.file.upload)

// 信息相关api
router.post('/api/message/queryHistoryMessage', api.message.queryHistoryMessage)
router.post('/api/message/queryHistoryMessageByCourse', api.message.queryHistoryMessageByCourse)
router.post('/api/message/checkMessageSendByMyself', api.message.checkMessageSendByMyself)


module.exports = router