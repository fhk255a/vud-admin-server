
// 获取限制输出
const getColumn=(tableName,key=[])=>{
  // 默认是输出所有
  let column = `${tableName}.*`;
  if(key.length>0){
    let columnArr = [];
    for(let item in key){
      if(item !='current' && item != 'size'){
        columnArr.push(`\`${tableName}\`.${key[item]}`)
      }
    }
    column = columnArr.join(',');
  }
  return column;
}

/** 
  params 是连接在where条件后面得 {对象}
  like 模糊匹配 [数组]
*/
const getValue = (params,like=[]) =>{
  let sql = '';
  if(params){
    for(let item in params){
      if(item !='current' && item != 'size'){
        if(params[item] !== ''){
          if(like.indexOf(item)!=-1){
            sql += `\`${item}\` LIKE "%${params[item]}%" AND `;
          }else{
            sql += `\`${item}\`='${params[item]}' AND `;
          }
        }
      }
    }
    sql = sql.substr(0,sql.lastIndexOf('AND'))+'';
    if(params.current){
      let size = params.size?params.size:10;
      sql += `LIMIT ${(params.current-1)*size}, ${size}`;
    }
  }
  return sql?sql:1;
}


  
module.exports = {
  getColumn,
  getValue
}