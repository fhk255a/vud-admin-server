// 根据条件获取当前的总数
const WHERE_TOTAL = (tableName,params) => {
  let sql = ``;
  for(let item in params){
    if(item !='current' && item != 'size'){
      sql += `${params[item]?item+'="'+params[item]+'" AND ':''}`
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
const SEARCH = (tableName,params) => {
  let sql = ``;
  for(let item in params){
    if(item !='current' && item != 'size'){
      sql += `${params[item]?item+'="'+params[item]+'" , ':''}`
    }
  }
  sql = sql.substr(0,sql.lastIndexOf(','))+' ';
  return `SELECT * FROM \`${tableName}\` ${sql?'WHERE '+sql:''}`;
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
      arr.push(`${JSON.stringify(item[key])}`);
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
const UPDATE =(tableName,keys,where)=>{
  let SQL = `UPDATE \`${tableName}\` SET`;
  let keySql = [];
  for(let key in keys){
    keySql.push(`
      \`${key}\` = \'${keys[key]}\'
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
  return `${SQL} ${keySql.join(',')} WHERE ${isObject?1:`(${whereSql.join(',')})`}`;
}


module.exports = {
  WHERE_TOTAL,
  SEARCH_PAGE,
  SEARCH,
  INSERT,
  UPDATE
}
