const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'order';
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,INSERT} = require('../../../lib/sql');
const router = new Router();
router.get('/order/list',async (ctx,next)=>{
  const SQL = SEARCH_PAGE(TABLE_NAME,ctx.query);
  const TOTAL = WHERE_TOTAL(TABLE_NAME,ctx.query);
  let body = {
    total:0,
    data:[]
  };
  await query(TOTAL).then(res=>{
    body.total=res[0].total;
  });
  await query(SQL).then(res=>{
    body.data = res;
  });
  ctx.body = new Success(body);
})
// 添加
  // const SQL = INSERT('order',ctx.request.body.data[0],ctx.request.body.data);

module.exports=router;