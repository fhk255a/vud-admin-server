const Koa = require('koa');
const websockify = require('koa-websocket')
const app = websockify(new Koa());
const RouterInit = require('./init/router');
const Body = require('koa-body');
const cors = require('koa-cors');
const tryCatch = require('./lib/tryCatch');
const token = require('./lib/token');
const koa_session = require('koa-session');
const CONFIG = require('./lib/config');
app.keys = CONFIG.session_signed_key;
// 支持跨域
app.use(cors({
  credentials: true,
}));
// 解析post的data
app.use(Body({
  multipart: true,
  formidable: {
    maxFileSize: 5 * 1024 * 1024    // 设置上传文件大小最大限500kb
  }
}));
app.use(koa_session(CONFIG.session_config, app));
// 注册异常捕获
app.use(tryCatch);
// 绑定token校验
app.use(token);
// 初始化所有路由
RouterInit.init(app);
app.listen(3000);