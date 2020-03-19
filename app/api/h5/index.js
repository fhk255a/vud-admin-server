const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const router = new Router();
router.get('/h5/list', async (ctx,next)=>{
  const params = ctx.query;
  // let content = `SELECT * FROM 'page' WHERE 1 LIMIT ${(params.current-1)*params.size},${params.size};`
  let content = 'SELECT * FROM `page` LIMIT 0, 1000';
  await query(content).then(res=>{
    ctx.body = new Success(res);
  })
})

module.exports=router;