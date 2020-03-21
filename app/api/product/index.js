const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'product';
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH} = require('../../../lib/sql');
const router = new Router();
// 获取商品列表
router.get('/product/list', async (ctx,next)=>{
  console.log(ctx.state);
  const SQL = SEARCH_PAGE(TABLE_NAME,ctx.query,['title_zh']);
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
// 获取商品详情
router.get('/product/details' , async (ctx,next)=>{
  const SQL = SEARCH(TABLE_NAME,ctx.query);
  await query(SQL).then(res=>{
    if(res.length>0){
      ctx.body = new Success(res[0]);
    }else{
      ctx.body = new MyError('商品不存在',400,404);
    }
  })
})

module.exports=router;