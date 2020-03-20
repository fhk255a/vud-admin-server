class Success {
  constructor(data=null){
    this.msg = '成功';
    this.code = 200;
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