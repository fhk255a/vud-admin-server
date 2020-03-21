const MyError = require('./error');
const tryCatch = async (ctx,next)=>{
  try {
    await next();
  } catch (e) {
    if(e instanceof MyError){
      ctx.body={
        msg:e.msg,
        code:e.errorCode,
      }
      ctx.status = e.code;
    }else{
      ctx.body={
        msg:'系统好像迷路了~',
        code:1000,
      }
      ctx.status = 500;
    }
  }
}
module.exports = tryCatch;