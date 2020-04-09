const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const CONFIG = require('../../../../lib/config');
const jwt = require('jsonwebtoken');
const Promise = require("bluebird");
const {SEARCH,UPDATE} = require('../../../../lib/sql');
const router = new Router();
const TABLE_NAME = 'member';
router.post('/m/user/login',async ctx=>{
  const params = ctx.request.body;
  if(!params.username){
    ctx.body = new MyError('用户名不能为空',400,1000);
    return;
  }
  if(!params.password){
    ctx.body = new MyError('密码不能为空',400,1000);
    return;
  }
  let userInfo = {
    userInfo:{},
    token:''
  };
  let lastLoginTime = new Date().getTime();
  // 1查询用户信息
  let user_info = {};
  await query(SEARCH(TABLE_NAME,params)).then(async res=>{
    if(res.length>0){
      await query(SEARCH('memberInfo',{id:res[0].id})).then(ress=>{
        user_info = {
          ...ress[0],
          ...res[0],
          lastLoginTime,
        };
      })
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
  // 存储信息给用户
  userInfo.userInfo = user_info;
  delete userInfo.userInfo.password;
  // 生成token
  let payload = {username:user_info.username,time:new Date().getTime(),timeout:CONFIG.tokenTime}
  userInfo.token = jwt.sign(payload, CONFIG.tokenVerify);
  // 3修改登录时间  
  await query(UPDATE(TABLE_NAME,{lastLoginTime},{id:user_info.id}));
  ctx.session.userInfo = {
    ...user_info,
    token:userInfo.token
  };
  ctx.body = new Success(userInfo,'登录成功');
})

router.name="m/user/login";
module.exports=router;