const Koa = require('koa');
const app = new Koa();
const Router = require('./init/router');
const BodyParser = require('koa-bodyparser');
const cors = require('koa-cors');
const tryCatch = require('./lib/tryCatch');
const token = require('./lib/token');
const koa_session = require('koa-session');
const CONFIG = require('./lib/config');
app.keys = CONFIG.session_signed_key;
app.use(koa_session(CONFIG.session_config, app));
// 初始化所有路由
// 注册异常捕获
// 解析post的data
app.use(BodyParser());
app.use(tryCatch);
// 支持跨域
app.use(cors({credentials: true}));
app.use(token);
Router.init(app);

app.listen(3000);