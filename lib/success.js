class Success {
  constructor(data=null,msg='成功',code=200){
    this.msg = 'msg';
    this.code = code;
    this.data = data;
    this.init();
  }

  init(){
    return{
      msg:this.msg,
      code:this.code,
      data:this.data
    }
  }
}

module.exports = Success;