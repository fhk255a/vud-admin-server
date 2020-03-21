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
      console.log(res);
      let { time, timeout } = res;
      let data = new Date().getTime();
      if (data - time <= timeout) {
          // 未过期
        await next();
      } else {
          //过期
        ctx.body = new MyError('token已失效',401,401)
      }
    }).catch(err=>{
      console.log(err);
      ctx.body = new MyError('token有误，请重新登录',401,401)
    })
  }
});

module.exports = token;