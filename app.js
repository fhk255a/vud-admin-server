const Koa = require('koa');
const app = new Koa();
const Router = require('./init/router');
const BodyParser = require('koa-bodyparser');
const cors = require('koa-cors');
const tryCatch = require('./lib/tryCatch');
const token = require('./lib/token');
// 初始化所有路由
// 注册异常捕获
// 解析post的data
app.use(BodyParser());
app.use(tryCatch);
// 支持跨域
app.use(cors());
app.use(token);

Router.init(app);


app.listen(3000);