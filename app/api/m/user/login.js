const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const CONFIG = require('../../../../lib/config');
const jwt = require('jsonwebtoken');
const {SEARCH,UPDATE,INSERT} = require('../../../../lib/sql');
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
  userInfo.address = await query(SEARCH('address',{userId:userInfo.userInfo.id}));
  userInfo.address.map(item=>{
    item.isDefault = item.isDefault==1?true:false;
    return item;
  })
  await query(UPDATE(TABLE_NAME,{lastLoginTime},{id:user_info.id}));
  ctx.session.mUserInfo = {
    ...user_info,
    token:userInfo.token
  };
  ctx.body = new Success(userInfo,'登录成功');
})
// 注册
router.post('/m/user/register',async ctx=>{
  let username = ctx.request.body.username;
  let password = ctx.request.body.password;
  let nickname = ctx.request.body.nickname?ctx.request.body.nickname:ctx.request.body.username;
  if(!username){
    ctx.body = new MyError('用户名不能为空',400,1000);
    return;
  }
  if(!password){
    ctx.body = new MyError('密码不能为空',400,1000);
    return;
  }
  let params = {
    createTime:new Date().getTime(),
    username,
    password,
    nickname 
  }
  await query(SEARCH(TABLE_NAME,{username})).then(async res=>{
    if(res.length>0){
      ctx.body = new MyError('该号码已经存在',400,1000);
      return;
    }else{
      await query(INSERT(TABLE_NAME,params,[params])).then(async res=>{
        await query('select max(id) as id from member').then(async ress=>{
          await query(INSERT('memberInfo',{id:ress[0].id},[{id:ress[0].id}])).then(res=>{
            ctx.body = new Success(null,'注册成功');
            return;
          }).catch(err=>{
            ctx.body = new MyError('注册失败');
            return;
          })
        })
      })
    }
  })
})
router.name="m/user/login-register";
module.exports=router;