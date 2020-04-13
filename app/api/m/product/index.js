const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const {SEARCH,UPDATE,INSERT} = require('../../../../lib/sql');
const router = new Router();
const TABLE_NAME = 'product';

// 获取页面信息
router.get('/m/product/queryProductIds/:id',async ctx=>{
  if(!ctx.params.id){
    ctx.body = new MyError('ID不能为空');
    return;
  }
  let data = {};
  await query(SEARCH(TABLE_NAME,{id:ctx.params.id})).then(async res=>{
    if(res.length>0){
      data = {
        ...res[0],
        images:JSON.parse(res[0].images), 
        propList:JSON.parse(res[0].propList),
        attrList:JSON.parse(res[0].attrList)
      };
      let ress = await query(SEARCH('skulist',{productId:res[0].id}));
      let shopInfo = await query(SEARCH('shop',{id:res[0].shopId}));
      if(ress.length>0){
        data.skuList=ress.map(item=>{
          item.status = item.status == 1? true : false;
          return item;
        })
      }
      if(shopInfo.length>0){
        data.shopInfo=shopInfo[0];
      }
    }else{
      ctx.body = new MyError('商品不存在');
      return;
    }
  })
  ctx.body = new Success(data);
  return;
})
router.name="/m/product/product";
module.exports = router;