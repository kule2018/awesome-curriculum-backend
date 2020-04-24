const tips = require("../config/response");
const mysql = require("../utils/mysql");


/**
 * @description 查询课程标签
 */
let queryLabel = async (ctx, next) => {
  const userId = ctx.state;
  const queryParents = `
    select * from category
    where parentId is null;
  `;
  let parents = await mysql.query(queryParents);
  parents = JSON.parse(JSON.stringify(parents))
  for(const item of parents){
    const queryChildren = `
      select *
      from category
      where parentId=${item.id};
    `;
    let children = await mysql.query(queryChildren);
    children = JSON.parse(JSON.stringify(children));
    item.children = children;
  }
  return (ctx.body = {
    ...tips[1],
    data: parents,
  });
};

const submitUserLabel = async(ctx, next) => {
  const userId = ctx.state;
  const data = ctx.request.body;
  
  const labelId = data.id;
  for(const item of labelId){
    const insertSql = `
      insert into userLabel
      (userId, labelId)
      values
      (${userId}, ${item});
    `;
    
    await mysql.query(insertSql);
  }
  await mysql.query(`
    update user
    set label=true
    where id=${userId};
  `)
  return (ctx.body = {
    ...tips[1],
  });
}


module.exports = {
  queryLabel,
  submitUserLabel,
}