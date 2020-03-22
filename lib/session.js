
const sesstionUser = async (ctx,next)=> {
  // 对/favicon.ico网站图标请求忽略
  console.log('进来了');
  if (ctx.path === '/favicon.ico') return;
  // console.log('session',ctx.session);
  // if (!ctx.session.logged) {  // 如果登录属性为undefined或者false，对应未登录和登录失败
  //     // 设置登录属性为false
  //     ctx.session.logged = false;

  //     // 判断用户名密码是否为空
  //     if (query.nickname && query.passwd) {

  //         // 比对并分情况返回结果  
  //         if (databaseUserName == query.nickname) {  // 如果存在该用户名

  //             // 进行密码比对并返回结果 
  //             ctx.body = (databaseUserPasswd == query.passwd) ? "登录成功" : "用户名或密码错误";
  //             ctx.session.logged = true;
  //         } else {                    // 如果不存在该用户名                                           //  如果用户名不存在
  //             ctx.body = "用户名不存在";
  //         }
  //     } else {
  //         ctx.body = "用户名密码不能为空";
  //     }
  // } else {
  //     ctx.body = "已登录";
  //     await next();
  // }
};



module.exports = sesstionUser;