const mysql = require('../utils/mysql');
const moment = require('moment')

const bindUserSocket = async(socket) => {
  const queryUser = `
    select userId, user.avatar, user.name
    from token, user
    where
    token.userId=user.id and value='${socket.token}';
  `;
  let response = await mysql.query(queryUser);
  socket.userId = response[0].userId;
  socket.username = response[0].name;
  socket.avatar = response[0].avatar;
}
/**
 * @deprecated 将聊天记录存入数据库
 */
const saveMessage = async(token, content, groupId, type) => {
  const queryUser = `
    select userId
    from token
    where
    value='${token}';
  `;
  let res = await mysql.query(queryUser);
  const userId = res[0].userId;
  const insertMysql = `
    insert into message
    (content, fromUser, toGroup, time, type)
    values
    ('${content}', ${userId}, ${groupId}, '${moment(new Date()).format('YYYY-MM-DD HH:mm:ss')}', '${type}');
  `;
  res = await mysql.query(insertMysql);
  return res.insertId;
}

/**
 * @deprecated 查找groupId
 * @param {string} school 
 * @param {string} name 
 * @param {string} courseNo 
 */
const findGroup = async(school, name, courseNo) => {
  const queryGroup = `
    select *
    from groups
    where school='${school}' and name='${name}'
    and courseNo='${courseNo}';
  `;
  let res = await mysql.query(queryGroup);
  return res[0].id;
}

/**
 * @deprecated 创建群组
 * @param {array} groups 
 * @param {string} school 
 * @param {object} socket 
 */
const createGroup = async(groups, school, socket) =>{
  for(const group of groups){
    const queryGroup = `
      select *
      from groups
      where school='${school}' and name='${group.name}'
      and courseNo='${group.courseNo}';
    `;
    let res = await mysql.query(queryGroup);
    if(res.length===0){
      const insertGroup = `
        insert into groups
        (school, name, courseNo)
        values
        ('${school}','${group.name}', '${group.courseNo}');
      `;
      await mysql.query(insertGroup);
    }
    res = await mysql.query(queryGroup);
    socket.join(res[0].id.toString(), () => {
      console.log('rooms', socket.rooms);
    });
  }
}

/**
 * @description 查找用户课程列表
 * @param {String} token 
 */
const queryCourseList = async(token) => {
  const query = `
    select name, courseNo
    from curriculum, token
    where curriculum.userId=token.userId and token.value='${token}' and courseNo!='';
  `;
  let response = await mysql.query(query);
  console.log('token', token)
  return response;
}

/**
 * @deprecated socket连接
 * @param {object} io
 */
const socketConnect = (io) => {

  io.on('connection',socket => {
    socket.emit('open');  // 通知客户端已连接
    socket.socketId = socket.id;
    // 绑定socket-id与user-id
    socket.on('binding', async data => {
      socket.token = data.from;
      await bindUserSocket(socket);
      const groups = await queryCourseList(data.from);
      await createGroup(groups, data.school, socket)
      console.log('绑定成功');
    })
  
    // 监听disconnect事件
    socket.on('disconnect', () => {
      console.log('客户端已断开连接');
    })
  
    socket.on('send message', async(data) => {
      let res = await findGroup(data.school, data.to.name, data.to.courseNo);
      console.log(data)
      const insertId = await saveMessage(data.from, data.content, res, data.type);
      
      socket.to(res).emit('broadcast message', {
        self: false,
        type: data.type || 'text',
        id: insertId,
        content: data.content,
        courseName: data.to.name,
        time: moment(new Date()).format('YYYY-MM-DD HH:mm:ss'),
        from: {
          username: socket.username,
          avatar: 'https://coursehelper.online:3000/'+socket.avatar,
        }
      });
      io.to(socket.id).emit('broadcast message', {
        self: true,
        id: insertId,
        type: data.type || 'text',
        content: data.content,
        courseName: data.to.name,
        time: moment(new Date()).format('YYYY-MM-DD HH:mm:ss'),
        from: {
          username: socket.username,
          avatar: 'https://coursehelper.online:3000/'+socket.avatar,
        }
      });
    })
  })
}

module.exports = socketConnect;