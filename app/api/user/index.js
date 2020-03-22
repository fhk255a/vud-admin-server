const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const CONFIG = require('../../../lib/config');
const jwt = require('jsonwebtoken')
const TABLE_NAME = 'user';
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,INSERT,UPDATE} = require('../../../lib/sql');
const router = new Router();

// 登录
router.post('/user/login',async (ctx,next)=>{
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
  ctx.body = new Success(userInfo);
})

// 注册
router.post('/user/register',async (ctx,next)=>{
  let params = ctx.request.body;
  if(!params.username){
    ctx.body = new MyError('用户名不能为空',400,1000);
    return;
  }
  await query(SEARCH(TABLE_NAME,{username:params.username})).then(async res=>{
    if(res.length>0){
      ctx.body = new MyError('该用户已经存在',400,1000);
      return;
    }else{
      let key = {
        username:params.username,
        role:params.role,
        remark:params.remark,
        mail:params.mail,
        qq:params.qq,
        phone:params.phone,
        nickName:params.nickName?params.nickName:params.username,
        createUser:ctx.session.userInfo.nickName?ctx.session.userInfo.nickName:'ADMIN',
        createUserId:ctx.session.userInfo.id?ctx.session.userInfo.id:'ADMIN',
      }
      const ADD_SQL = INSERT(TABLE_NAME,key,[key]);
      await query(ADD_SQL).then(res=>{
        ctx.body = new Success(null,'添加成功',200);
      }).catch(err=>{
        ctx.body = new MyError('添加失败',500,500);
      })
    }
  }).catch(err=>{
    ctx.body = new MyError(err);
  })
});

// 获取用户列表
router.get('/user/userList',async (ctx,next)=>{
  const SQL = SEARCH_PAGE(TABLE_NAME,ctx.query,['username','nickName']);
  const TOTAL = WHERE_TOTAL(TABLE_NAME,ctx.query,['username','nickName']);
  await query(SQL).then( async res=>{
    await query(TOTAL).then(total=>{
      ctx.body = new Success({
        total:total[0].total,
        data:res.map(item=>{
          delete item.password;
          return item;
        })
      });
    })
  })
})
module.exports=router;