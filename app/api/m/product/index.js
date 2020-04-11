const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const CONFIG = require('../../../../lib/config');
const {SEARCH,UPDATE,INSERT} = require('../../../../lib/sql');
const {searchs} = require('../../../../lib/sqlRow');
const router = new Router();
const TABLE_NAME = 'product';

// 获取页面信息
router.get('/m/product/queryProductIds',async ctx=>{
  if(!ctx.params.id){
    ctx.body = new MyError('ID不能为空');
    return;
  }
  await query(SEARCH(TABLE_NAME,{id:ctx.params.id})).then(res=>{
    if(res.length>0){
      ctx.body = new Success(res[0]);
      return;
    }else{
      ctx.body = new MyError('用户不存在');
      return;
    }
  })
})
router.name="/m/product/product";
module.exports = router;