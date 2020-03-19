const Mysql = require('mysql')
const DB_CONFIG = require('../lib/config').database



// mysql 方法
const pool = Mysql.createPool(DB_CONFIG);

const query = (sql,val)=>{
  return new Promise((resolve,reject)=>{
    pool.getConnection((err,connection)=>{
      if(err){
        reject(err)
      }
      else{
        connection.query(sql,val,(err,fields)=>{
          if(err) reject(err)
          else resolve(fields)
          connection.release()
        })
      }
    })
  })  
}

module.exports=query;