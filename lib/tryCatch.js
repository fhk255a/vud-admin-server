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
      ctx.body='系统好像迷路了~';
    }
  }
}
module.exports = tryCatch;