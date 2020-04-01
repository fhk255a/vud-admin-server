const Router = require('koa-router');
const query = require('../../../lib/query');
const jwt = require('jsonwebtoken');
const CONFIG = require('../../../lib/config');
const TABLE_NAME = 'user';
const {SEARCH,UPDATE} = require('../../../lib/sql');
const router = new Router();
router.all('/loginSocket/:id', async (ctx,next) => {
  const uuid = ctx.params.id;
  const nowTime = new Date().getTime();
  let t = setInterval(async ()=>{
    let n = Math.random()
    if(n > 0.3) {
      let msg = JSON.stringify({ 'id': uuid, 'n': n })
      // 清除失效的二维码
      await query(`DELETE from \`qr_login\` WHERE timer < ${nowTime}`);
      await query(SEARCH('qr_login',{key:uuid})).then(async res=>{
        if(res.length>0){
          if(res[0].key == res[0].value){
            await login(9999,ctx).then(async ctxRes=>{
              ctx.session.userInfo = ctxRes.session;
              const result = {
                code:200,
                data:ctxRes.userInfo,
                msg:'登录成功',
              }
              clearInterval(t);
              ctx.websocket.send(JSON.stringify(result));
              await next();
              return;
            }).catch(async err=>{
              const result = {
                code:444,
                data:null,
                msg:'扫码中',
              }
              clearInterval(t);
              ctx.websocket.send(JSON.stringify(result));
              return;
            })
          }
        }else{
          let result = {
            code:400,
            data:null,
            msg:'二维码已经失效,请刷新页面',
          }
          clearInterval(t);
          ctx.websocket.send(JSON.stringify(result));
          return;
        }
      })
    }
  }, 1000)
  ctx.websocket.on('message', msg => {
    console.log('前端发过来的数据：', msg)
  })
  ctx.websocket.on('close', () => {
    console.log('前端关闭了websocket')
  })
});

const login = async (id,ctx) => {
  let user_info = {};
  let userInfo = {
    userInfo:{},
    menu:[],
    resource:[],
    token:''
  };
  let lastLogin = new Date().getTime();
  await query(SEARCH('user',{id:id})).then(res=>{
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
  const UPDATE_SQL = UPDATE(TABLE_NAME,{lastLogin},{id:user_info.id});// 3查询用户权限信息
  await query(UPDATE_SQL);
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
  let data = {
    userInfo:userInfo,
    session:{
      ...user_info,
      token:userInfo.token
    }
  }
  return data;
}


router.name="socket";
module.exports=router;