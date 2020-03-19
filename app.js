const Koa = require('koa');
const app = new Koa();
const Router = require('./init/router');
const BodyParser = require('koa-bodyparser');
const cors = require('koa-cors');
const tryCatch = require('./lib/tryCatch');
// 初始化所有路由
// 注册异常捕获
app.use(tryCatch);
// 支持跨域
app.use(cors());
Router.init(app);


// 解析post的data
app.use(BodyParser());
app.listen(3000);