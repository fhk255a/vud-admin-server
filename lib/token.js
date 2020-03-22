const Promise = require("bluebird");
const jwt = require("jsonwebtoken");
const tokenVerify = require('./config').tokenVerify;
const verify = Promise.promisify(jwt.verify);
const MyError = require('./error');

const token = (async (ctx, next)=> {
  let url = ctx.request.url;
  // 登录 不用检查
  if (url == "/user/login") await next();
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
      if(ctx.session.userInfo.token && ctx.session.userInfo.token == token){
        if (data - time <= timeout) {
            // 未过期
          await next();
        } else {
            //过期
          ctx.body = new MyError('token已失效',401,401)
        }
      }else{
        ctx.body = new MyError('改token被篡改，请重新登录',401,401)
      }
    }).catch(err=>{
      ctx.body = new MyError('token有误，请重新登录',401,401)
      return;
    })
  }
});

module.exports = token;