const Router = require('koa-router');
const requireDirectory = require('require-directory');
// 加载api模块下的所有路由

class InitRouter {
  static init(app){
    InitRouter.app = app;
    InitRouter.router();
  }
  // 注册
  static router(){
    requireDirectory(module,'../app/api',{
      visit:loadModules
    });

    function loadModules(obj){
      if(obj instanceof Router){
        if(obj.name=='socket'){
          InitRouter.app.ws.use(obj.routes());
        }else{
          InitRouter.app.use(obj.routes());
        }
      }
    }
  }
}

module.exports = InitRouter;