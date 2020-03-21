const tips = require("../config/response");
const mysql = require("../utils/mysql");

/**
 * @queryHistoryMessage 获取历史信息
 */
let queryHistoryMessage = async (ctx, next) => {
  const data = ctx.request.body;
  let messages = [];
  if(data.id != 0){
    const queryGroupId = `
      select toGroup
      from message
      where id=${data.id};
    `;
    let response = await mysql.query(queryGroupId);
    const queryAllMessage = `
      select message.id, message.time, user.name, user.avatar, message.content, message.fromUser
      from message, user
      where user.id=message.fromUser and message.id<${data.id} and message.toGroup=${response[0].toGroup}
      order by message.id DESC limit 20;
    `;
    console.log('数据', data);
    response = await mysql.query(queryAllMessage);
    for(let item of JSON.parse(JSON.stringify(response))){
      messages.push({
        self: item.fromUser==ctx.state,
        content: item.content,
        from: {
          username: item.name,
          avatar: `https://coursehelper.online:3000/${item.avatar}`
        },
        id: item.id,
        time: item.time
      })
    }
    messages.reverse();
  }else{
    const courseList = data.data;
    console.log(courseList);
    for(const course of courseList){
      let groupMessage = {
        courseName: course.name,
        data: []
      }
      const queryGroupMessage = `
        select message.id, message.time, user.name, user.avatar, message.content, message.fromUser
        from message, user, groups
        where user.id=message.fromUser and message.toGroup=groups.id and groups.name='${course.name}' and groups.school='${data.school}' and groups.courseNo='${course.courseNo}'
        order by message.id DESC limit 20;
      `;
      const response = await mysql.query(queryGroupMessage);
      for(let item of JSON.parse(JSON.stringify(response))){
        groupMessage.data.push({
          self: item.fromUser==ctx.state,
          content: item.content,
          from: {
            username: item.name,
            avatar: `https://coursehelper.online:3000/${item.avatar}`
          },
          id: item.id,
          time: item.time
        })
      }
      groupMessage.data.reverse();
      messages.push(groupMessage);
    }
  }
  
  return (ctx.body = {
    ...tips[1],
    data: messages
  });
};

module.exports = {
  queryHistoryMessage,
}