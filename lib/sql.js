// 根据条件获取当前的总数
const WHERE_TOTAL = (tableName,params,likeArr=[]) => {
  let sql = ``;
  for(let item in params){
    if(item !='current' && item != 'size'){
      if(likeArr.indexOf(item)!=-1){
        sql += `${params[item]?item+' LIKE "%'+params[item]+'%" AND ':''}`
      }else{
        sql += `${params[item]?item+'="'+params[item]+'" AND ':''}`
      }
    }
  }
  sql = sql.lastIndexOf('AND')!=-1 ? sql.substr(0,sql.lastIndexOf('AND'))+'' : sql;
  return `SELECT COUNT(*) AS total FROM \`${tableName}\` ${sql?'WHERE '+sql:''}`;
};
// 分页查询
const SEARCH_PAGE = (tableName,params,likeArr=[]) => {
  let sql = ``;
  for(let item in params){
    if(item !='current' && item != 'size'){
      if(likeArr.indexOf(item)!=-1){
        sql += `${params[item]?item+' LIKE "%'+params[item]+'%" AND ':''}`
      }else{
        sql += `${params[item]?item+'="'+params[item]+'" AND ':''}`
      }
    }
  }
  sql = sql.substr(0,sql.lastIndexOf('AND'))+'';
  const ISKEY = sql==''?false:true;
  sql += `LIMIT ${(params.current-1)*params.size}, ${params.size}`
  return `SELECT * FROM \`${tableName}\` ${ISKEY?'WHERE '+sql:sql}`;
};
// 查询
const SEARCH = (tableName,params=null,key=[]) => {
  let sql = ``;
  let column = '*';
  let columnArr = [];
  if(key.length>0){
    for(let item in key){
      if(item !='current' && item != 'size'){
        columnArr.push(`\`${tableName}\`.${key[item]}`)
      }
    }
    column = columnArr.join(',');
  }
  if(params){
    for(let item in params){
      if(item !='current' && item != 'size'){
        if(params[item] !== ''){
          sql += `\`${item}\`='${params[item]}' AND `;
          // sql += `${params[item]!==''?`\`${item}\`='${params[item]}' AND `:''}`
        }
      }
    }
    sql = sql.substr(0,sql.lastIndexOf('AND'))+' ';
  }
  return `SELECT ${column} FROM \`${tableName}\` ${sql!==''?'WHERE '+sql:' '}`;
};
// 添加
const INSERT = (tableName,keys,values=[]) => {
  let SQL = `INSERT INTO \`${tableName}\` `;
  let keySql = [];
  let valueSql = `VALUES `;
  for(let key in keys){
    keySql.push(`
      \`${key}\`
    `);
  }
  let result = values.map(item=>{
    let arr = [];
    for(let key in item){
      arr.push(`
        ${typeof item[key] == 'object'?`'${JSON.stringify(item[key])}'`:`${JSON.stringify(item[key])}`}
      `);
    }
    return `
      (${arr.join(',')})
    `;
  })
  valueSql += result.join(',');
  keySql = `(${keySql.join(',')}) `;
  return SQL+keySql+valueSql;
}
// 修改
const UPDATE =(tableName,keys,where=1)=>{
  let SQL = `UPDATE \`${tableName}\` SET`;
  let keySql = [];
  for(let key in keys){
    // keySql.push(`
    //   \`${key}\` = \'${keys[key]}\'  
    // `);
    keySql.push(`
      \`${key}\` = ${typeof keys[key] == 'object'?`'${JSON.stringify(keys[key])}'`:`${JSON.stringify(keys[key])}`}
    `);
  }
  // 要改的key
  let whereSql = [];
  let isObject = false;
  if(where==1){
    isObject = true;
  }else{
    for(let key in where){
      whereSql.push(`
        \`${key}\` = \'${where[key]}\'
      `);
    }
  }
  let ssql = (whereSql.join('AND'));
  ssql = ssql.substr(0,ssql.lastIndexOf('AND')==-1?ssql.length+' ':ssql.lastIndexOf('AND')+' ');
  return `${SQL} ${keySql.join(',')} WHERE ${isObject?1:`(${ssql})`}`;
}
// 删除
const DELETE=(tableName,key)=>{
  let whereSql = [];
  for(let i in key){
    whereSql.push(`
      \`${i}\` = \'${key[i]}\'
    `);
  }
  return `DELETE FROM \`${tableName}\` WHERE (${whereSql.join(',')})`;
}
/* 批量修改 
  data: 要修改的数据源 [{key:value},{key:value}]
  itemKey：每个修改子节点的指定key  假如id等等
*/
const UPDATES = (tableName,data,key='id')=>{
  let header = `UPDATE ${tableName} SET `;
  let whereId = [];
  if(!data[0].hasOwnProperty(key)){
    console.log('不存在where关键字');
    return null;
  }
  let cols = {};
  for(let i in data[0]){
    if(i != key){
      cols[i] = `\`${i}\` = CASE ${key?key:''} `;
    }
  }
  data.forEach(item=>{
    whereId.push(item[key]);
    for(let k in item){
      if(k != key){
        cols[k]+=` WHEN '${item[key]}' THEN '${item[k]}' \n`;
      }
    }
  })
  let result = [];
  for(let col in cols){
    result.push(cols[col]);
  }
  let end = `END WHERE ${key} IN (${whereId.join(',')})`
  return header+result.join('END, ')+end;
}
/* 批量删除
*/
const DELETES = (tableName,data,key='id')=>{
  if(!data){
    console.log('where key 不能为空');
    return null;
  }
  const sql = typeof data == 'string'?data:data.join(',');
  return `DELETE FROM ${tableName} WHERE ${key} IN (${sql});`
}


module.exports = {
  WHERE_TOTAL,
  SEARCH_PAGE,
  SEARCH,
  INSERT,
  UPDATE,
  UPDATES,
  DELETE,
  DELETES
}
