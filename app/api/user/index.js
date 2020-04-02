const Router = require('koa-router');
const TABLE_NAME = 'user';
const QRCODE = require('qr-image'); 
const jwt = require('jsonwebtoken');
const Promise = require("bluebird");
const verify = Promise.promisify(jwt.verify);
const CONFIG = require('../../../lib/config');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const {login} = require('../../../lib/common');
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,INSERT,UPDATE,DELETE} = require('../../../lib/sql');
const router = new Router();


// 登录
router.post('/user/login',async (ctx,next)=>{
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
})
// 获取用户信息
router.post('/user/userinfo',async (ctx,next)=>{
  const token = await verify(ctx.headers['authorization'],CONFIG.tokenVerify);
  const userinfo = ctx.session.userInfo;
  let result = {
    userInfo:{
      nickName:userinfo.nickName,
      role:userinfo.role,
      phone:userinfo.phone,
      qq:userinfo.qq,
      mail:userinfo.mail,
      username:userinfo.username,
      createUser:userinfo.createUser,
      createTime:userinfo.createTime,
      remark:userinfo.remark,
      lastLogin:userinfo.lastLogin,
    },
    menu:[],
    resource:[],
  };
  delete result.userInfo.password
  if(token.username == userinfo.username){
    // 3查询用户权限信息
    let role_info = {};
    await query(SEARCH('role',{id:userinfo.role})).then( res=>{
      if(res.length>0){
        result.userInfo['role'] = res[0].name;
        role_info = res[0];
      }
    });
    // 4根据用户权限查询用户所有菜单
    const menuSQL = `SELECT \`menu\`.path FROM \`menu\` WHERE find_in_set(id,'${role_info.menu}')`;
    await query(menuSQL).then(res=>{
      result.menu = res.map(item=>item.path);
    });
    // 5根据用户权限查询用户所有资源
    const resourceSQL = `SELECT \`resource\`.value FROM \`resource\` WHERE find_in_set(id,'${role_info.resource}')`;
    await query(resourceSQL).then(res=>{
      result.resource = res.map(item=>item.value);
    });
    ctx.body = new Success(result);
  }
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
          item.status = item.status==1?true:false;
          delete item.password;
          return item;
        })
      });
    })
  })
})
// 修改用户信息
router.post('/user/update',async (ctx,next)=>{
  let params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('用户名ID不能为空',400,1000);
    return;
  }
  if(params.id==9999 || params.id == 10000){
    ctx.body = new MyError('系统用户不能被编辑',400,1000);
    return;
  }
  let data = {
    ...params
  };
  delete data.username;
  delete data.createUserId;
  delete data.createUser;
  delete data.lastLogin;
  delete data.updateTime;
  delete data.createTime;
  delete data.status;
  await query(UPDATE(TABLE_NAME,data,{id:data.id})).then(res=>{
    if(res){
      ctx.body = new Success(null,'修改成功');
      return;
    }else{
      ctx.body = new MyError('修改失败',400,1000);
      return;
    }
  }).catch(()=>{
    ctx.body = new MyError('修改失败',500,500);
    return;
  })
})
// 删除角色
router.post('/user/delete',async (ctx,next)=>{
  let params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('用户名ID不能为空',400,1000);
    return;
  }
  if(params.id==9999 || params.id == 10000){
    ctx.body = new MyError('系统用户不能被删除',400,1000);
    return;
  }
  await query(DELETE(TABLE_NAME,{id:params.id})).then(res=>{
    ctx.body = new Success(null,'删除成功');
    return;
  }).catch(()=>{
    ctx.body = new MyError('删除失败',500,500);
    return;
  })
});
// 获取登录二维码
router.get('/user/getLoginCode',async (ctx,next)=>{
  const uuid = ctx.query.uuid;
  // 服务器ip
  const url = 'http://project.fhk255.cn/user/qrLogin/'+uuid;
  // 本地ip
  // const url = 'http://172.18.3.51:3000/user/qrLogin/'+uuid;
  // 清除失效的二维码
  await query(`DELETE from \`qr_login\` WHERE timer < ${new Date().getTime()}`);
  await query(INSERT('qr_login',{key:uuid},[{key:uuid}])).then(res=>{
    const img = QRCODE.imageSync(url,{size :5,type:'svg'});
    ctx.body = new Success({uuid:uuid,img:img});
    return;
  }).catch(err=>{
    ctx.body = new MyError('二维码已过期,请刷新页面重新获取.',500,500);
    return;
  })
})
// 扫码登录
router.get('/user/qrLogin/:id',async (ctx,next)=>{
  const key = ctx.params.id;
  const divStyle=`display:flex;flex-direction: column;width: 100%;align-items: center;height: 60vh;background: #fff;justify-content: center;`
  const imgStyle=`width:50%;height:auto;`;
  const pStyle=`font-size:40px;color:#666;margin:10px 0;`
  const ERR_IMG = 'http://img.fhk255.cn/2020041/15857240399412454.png';
  const SUCC_IMG = 'http://img.fhk255.cn/2020041/15857240448687197.png';
  const HTML = (title='登录失败',msg='',img=0)=>{
    return `<div style="${divStyle}">
      <img src="${img==0?ERR_IMG:SUCC_IMG}" style="${imgStyle}"/>
      <p style="${pStyle}font-size:60px;font-weight:600">${title}</p>
      <p style="${pStyle}">${msg}</p>
    </div>`
  }
  // 清除失效得二维码
  await query(`DELETE from \`qr_login\` WHERE timer < ${new Date().getTime()}`);
  await query(SEARCH('qr_login',{key:key})).then(async res=>{
    if(res.length>0){
      if(res[0].timer*1 < new Date().getTime()*1){
        await query(DELETE('qr_login',{key:key})).then(res=>{
          ctx.body = HTML('登录失败','二维码已过期,请重新刷新网页');
          return;
        }).catch(err=>{
          ctx.body = HTML('登录失败','二维码已过期,请重新刷新网页');
          return;
        })
      }else{
        await query(UPDATE('qr_login',{value:ctx.params.id},{key:ctx.params.id}));
        ctx.body = HTML('登录成功','',1);
        return;
      }
    }else{
      ctx.body = HTML('登录失败','二维码无效,请刷新浏览器重新获取');
      return;
    }
  }).catch(err=>{
    ctx.body = HTML('登录失败','二维码无效,请刷新浏览器重新获取');
    return;
  })
})
router.name="user";
module.exports=router;