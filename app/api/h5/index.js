const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const router = new Router();
router.get('/list', async (ctx,next)=>{
  let content = 'SELECT * FROM `page` LIMIT 0, 1000';
  await query(content).then(res=>{
    ctx.body = new Success(res);
  })
})

module.exports=router;