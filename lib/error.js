class MyError extends Error{
  constructor(msg="服务器异常",code=500,errorCode=500){
    super(...arguments)
    this.msg = msg;
    this.errorCode = errorCode;
    this.code = code;
  }
}
module.exports=MyError;