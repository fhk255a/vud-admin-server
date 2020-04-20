const Promise = require("bluebird");
const jwt = require("jsonwebtoken");
const tokenVerify = require('./config').tokenVerify;
const verify = Promise.promisify(jwt.verify);
const MyError = require('./error');
const ignore = require('../init/ignore');

const token = (async (ctx, next)=> {
  let url = ctx.request.url;
  // 判断是否是商店 还是admin
  let isShop = url.substr(0,3) === '/m/'?true:false;
  // 登录 不用检查'
  if(isShop){
    // 不需要检验的路由
    if(ignore.find(item=>url.indexOf(item)==0)){
      await next();
    }else{
      console.log('阻止了',url)
      let token = ctx.request.headers["authorization"];
      if(!token){
        ctx.body = new MyError('token不存在',401,401);
        return;
      }
      // 解码
      await verify(token,tokenVerify).then(async res=>{
        let { time, timeout } = res;
        let data = new Date().getTime();
        // 直接判断session的token跟存进来的token对比 有问题 直接砍掉
        if(ctx.session.mUserInfo.token && ctx.session.mUserInfo.token == token){
          if (data - time <= timeout) {
            // 未过期
            await next();
          } else {
              //过期
            ctx.body = new MyError('token已失效',401,401)
            return;
          }
        }else{
          ctx.body = new MyError('改token被篡改，请重新登录',401,401)
          return;
        }
      }).catch(err=>{
        console.log(ctx.session.mUserInfo.token);
        ctx.body = new MyError('token有误，请重新登录',401,401)
        return;
      })
    }
  }else{
    if (url == "/user/login") await next();
    else if (url.indexOf("/h5/getPid")!=-1) await next();
    else if (url.indexOf("/user/getLoginCode")!=-1) await next();
    else if (url.indexOf("/user/qrLogin")!=-1) await next();
    else {
      let token = ctx.request.headers["authorization"];
      if(!token){
        ctx.body = new MyError('token不存在',401,401);
        return;
      }
      // 解码
      await verify(token,tokenVerify).then(async res=>{
        let { time, timeout } = res;
        let data = new Date().getTime();
        // 直接判断session的token跟存进来的token对比 有问题 直接砍掉
        if(res.username == 'test'){
          if(ctx.request.method != 'GET'){
            ctx.body = new MyError('体验账号无法执行此操作',9999,9999);
            return;
          }else{
            await next();
          }
        }else{
          if(ctx.session.userInfo.token && ctx.session.userInfo.token == token){
            if (data - time <= timeout) {
              // 未过期
              await next();
            } else {
                //过期
              ctx.body = new MyError('token已失效',401,401)
              return;
            }
          }else{
            ctx.body = new MyError('改token被篡改，请重新登录',401,401)
            return;
          }
        }
      }).catch(err=>{
        ctx.body = new MyError('token有误，请重新登录',401,401)
        return;
      })
    }
  }
});

module.exports = token;