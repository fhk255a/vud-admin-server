// 递归获取树状
// 结构
/**
 * {
 *   id:1
 *   parentId:0,
 *   children:[
 *     {
*        id:1
*        parentId:0,
*        children:[]
 *     }
 *   ]
 * }
 */
const path = require('path');
const fs = require('fs');
const mkdirp = require('mkdirp');
const TREE = (arr, parentId=0) =>{
  let temp = [];  // 输出模板
  let treeArr = arr;
  treeArr.forEach((item, index) => {
    item.isHide = item.isHide*1 == 1?true:false; 
    item.parentId *= 1; 
    if(item.parentId == parentId) {
      if(TREE(treeArr, treeArr[index].id).length > 0) {
        // 递归调用此函数
        treeArr[index].children =TREE(treeArr, treeArr[index].id);
      }
      temp.push({...treeArr[index]});
    }
  });
  return temp;
};
const ID =() =>{
  return Math.random().toString(32).slice(2)
}


const jwt = require('jsonwebtoken');
const Promise = require("bluebird");
const verify = Promise.promisify(jwt.verify);
const CONFIG = require('./config');
const Success = require('./success');
const MyError = require('./error');
const query = require('./query');
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,INSERT,UPDATE,DELETE} = require('./sql');


const login = async (ctx,next)=>{
  const TABLE_NAME = 'user';
  if(!ctx.request.body.username){
    ctx.body = new MyError('用户名不能为空',400,1000);
    return;
  }
  if(!ctx.request.body.password){
    ctx.body = new MyError('密码不能为空',400,1000);
    return;
  }
  let userInfo = {
    userInfo:{},
    menu:[],
    resource:[],
    token:''
  };
  let lastLogin = new Date().getTime();
  // 1查询用户信息
  let user_info = {};
  await query(SEARCH(TABLE_NAME,ctx.request.body)).then(res=>{
    if(res.length>0){
      user_info = res[0];
      userInfo.userInfo = {
        nickName:res[0].nickName,
        role:res[0].role,
        phone:res[0].phone,
        qq:res[0].qq,
        mail:res[0].mail,
        username:res[0].username,
        createTime:res[0].createTime,
        lastLogin:lastLogin,
        remark:res[0].remark,
      }
    }
  }).catch();
  // 2修改用户登录时间
  if(!user_info.id){
    ctx.body = new MyError('用户名或者密码错误',400,1000);
    return;
  }
  if(user_info.status!=1){
    ctx.body = new MyError('你的账户已被冻结',202,404);
    return;
  }
  const UPDATE_SQL = UPDATE(TABLE_NAME,{lastLogin},{id:user_info.id});
  await query(UPDATE_SQL);
  // 3查询用户权限信息
  let role_info = {};
  await query(SEARCH('role',{id:user_info.role})).then( res=>{
    if(res.length>0){
      userInfo.userInfo['role'] = res[0].name;
      role_info = res[0];
    }
  });
  // 4根据用户权限查询用户所有菜单
  const menuSQL = `SELECT \`menu\`.path FROM \`menu\` WHERE find_in_set(id,'${role_info.menu}')`;
  await query(menuSQL).then(res=>{
    userInfo.menu = res.map(item=>item.path);
  });
  // 5根据用户权限查询用户所有资源
  const resourceSQL = `SELECT \`resource\`.value FROM \`resource\` WHERE find_in_set(id,'${role_info.resource}')`;
  await query(resourceSQL).then(res=>{
    userInfo.resource = res.map(item=>item.value);
  });
  let payload = {username:user_info.username,time:new Date().getTime(),timeout:CONFIG.tokenTime}
  userInfo.token = jwt.sign(payload, CONFIG.tokenVerify);
  ctx.session.userInfo = {
    ...user_info,
    token:userInfo.token
  };
  ctx.body = new Success(userInfo,'登录成功');
}


module.exports={
  TREE,
  ID,
  login
}