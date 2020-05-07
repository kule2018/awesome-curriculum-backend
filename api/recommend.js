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


const recommendCourse = async(ctx, next) => {
  const userId = ctx.state;
  const data = ctx.request.query;
  let page = data.page;
  if(!page || parseInt(page)<=0){
    return ctx.body = {
      ...tips[1011]
    }
  }
  page = parseInt(page);
  const queryClickCourse = `
    select clickLog.count, webCourses.id, webCourses.cluster
    from clickLog, webCourses
    where clickLog.courseId=webCourses.id and userId=${userId};
  `;
  const queryFavoriteCourse = `
    select *
    from favorite
    where userId=${userId};
  `;
  let predictClickNum = [];
  const clickCourses = await mysql.query(queryClickCourse);
  if(clickCourses.length == 0){
    const queryLabel = `
      select category.name
      from userLabel, category
      where category.id=userLabel.labelId and userLabel.userId=${userId};
    `;
    const labels = await mysql.query(queryLabel);
    let results = [];
    for(const item of labels){
      let _c = await mysql.query(`
        select *
        from webCourses
        where category like '%${item.name}%'
        limit ${2*page}, 2;
      `);
      results.push(..._c);
    }
    return ctx.body = {
      ...tips[1],
      data:results,
    }
  }
  for(let item of clickCourses){
    const allCourses = [];
    const queryRelatedCourseB = `
      select courseB as courseId, value
      from similarity${item.cluster+1}
      where courseA=${item.id}
    `;
    const queryRelatedCourseA = `
      select courseA as courseId, value
      from similarity${item.cluster+1}
      where courseB=${item.id}
    `;
    
    const relatedCourseA = await mysql.query(queryRelatedCourseA)
    const relatedCourseB = await mysql.query(queryRelatedCourseB)
    allCourses.push(...relatedCourseA);
    allCourses.push(...relatedCourseB);
    for(const course of allCourses){
      const c = item.count * parseFloat(course.value);
      const index = predictClickNum.findIndex(x => x.courseId==course.courseId);
      if(index >= 0){
        predictClickNum[index].value = c>predictClickNum[index].value?c:predictClickNum[index].value;
      }else{
        predictClickNum.push({
          courseId: course.courseId,
          value: c
        })
      }
    }
  }
  predictClickNum.sort((a,b)=>{return a.value>b.value?-1:1});
  const result = predictClickNum.slice(20*page, 20*(page+1));
  const res = []
  for(const item of result){
    const query = `
      select *
      from webCourses
      where id=${item.courseId};
    `;
    let cc = await mysql.query(query);
    res.push(cc[0]);
  }
  return ctx.body = {
    ...tips[1],
    data:res,
  }
}


module.exports = {
  queryLabel,
  submitUserLabel,
  recommendCourse,
}