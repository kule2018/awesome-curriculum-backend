const mysql = require('../utils/mysql');
let socket;

const bindUserSocket = async() => {
  const queryUser = `
    select userId
    from token
    where
    value='${socket.token}';
  `;
  let response = await mysql.query(queryUser);
  socket.userId = response[0].userId;
  console.log(response[0].userId);
}

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

const createGroup = async(groups, school) =>{
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
    console.log(typeof(res[0].id))
    socket.join(res[0].id.toString(), () => {
      console.log('rooms', socket.rooms);
    });
  }
}

const socketConnect = (io) => {
  io.on('connection',_socket => {
    socket=_socket;
    socket.emit('open');  // 通知客户端已连接
    console.log(`客户端已连接，socket.id为：${socket.id}`);
    socket.socketId = socket.id;
    // 绑定socket-id与user-id
    socket.on('binding', async data => {
      socket.token = data.from;
      await bindUserSocket();
      await createGroup(data.groups, data.school)
      console.log('绑定成功');
    })
  
    // 监听disconnect事件
    socket.on('disconnect', () => {
      console.log('客户端已断开连接');
    })
  
    socket.on('send message', async(data) => {
      console.log(`后端收到${data.from}发来的消息：${data.content}`)
      let res = await findGroup(data.school, data.to.name, data.to.courseNo);
      console.log('房间号', res);
      _socket.to(res).emit('broadcast message', {
        content: `${data.content}`,
        courseName: data.to.name
      });
    })
  })
}

module.exports = socketConnect;