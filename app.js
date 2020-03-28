const Koa = require('koa');
const app = new Koa();
const Router = require('./init/router');
const Body = require('koa-body');
const cors = require('koa-cors');
const tryCatch = require('./lib/tryCatch');
const token = require('./lib/token');
const koa_session = require('koa-session');
const CONFIG = require('./lib/config');
app.keys = CONFIG.session_signed_key;
app.use(koa_session(CONFIG.session_config, app));
// 初始化所有路由
// 注册异常捕获
// 支持跨域
app.use(cors({
  credentials: true,
}));
// 解析post的data
app.use(Body({
  multipart: true,
  formidable: {
    maxFileSize: 5 * 1024 * 1024    // 设置上传文件大小最大限制，默认2M
  }
}));
app.use(tryCatch);
app.use(token);
Router.init(app);

app.listen(3000);