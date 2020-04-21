const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const {SEARCH,UPDATE,INSERT} = require('../../../../lib/sql');
const {Price} = require('../../../../lib/common');
const router = new Router();
const TABLE_NAME = 'skulist';
const URL = '/m/sku';
router.post(URL+'/querySkuProductInfo',async ctx =>{
  const skuData = JSON.parse(ctx.request.body.skuData);
  const ids = skuData.map(item=>item.id);
  const sql = `SELECT s.count,p.shopId,p.title,s.outPrice,s.label,s.id as skuId,p.mainImage,p.id as productId from product as p ,skulist as s where s.id in(${ids}) and s.productId = p.id and s.status != 0`;
  let res = await query(sql);
  let result = [];
  console.log(skuData);
  if(res.length>0){
    for(let i in res){
      let item = res[i];
      let skuItem = skuData.find(it=>it.id==item.skuId && it.num <= item.count);
      if(!skuData.find(it=>it.id==item.skuId && it.num <= item.count)){
        ctx.body = new MyError(`${item.productId}商品数量不足`);
        return;
      }else{
        item.num = skuItem.num;
        if(skuItem.cartId){
          item.cartId = skuItem.cartId;
        }
        console.log(item);
        let Index = result.findIndex(it=>item.shopId==it.id);
        if(Index==-1){
          let shopInfo = await query(`SELECT * from shop where id = ${item.shopId}`);
          let data = {
            ...shopInfo[0],
            products:[item],
            price:Price(item.outPrice)*item.num ,
          }
          result.push(data);
        }else{
          result[Index].price += Price(item.outPrice)*item.num; 
          result[Index].products.push(item);
        }
      }
    }
    let totalPrice = 0;
    for(let i in result){
      totalPrice+= Price(result[i].price); 
    }
    ctx.body = new Success({totalPrice,result});
  }
  else{
    ctx.body = new MyError('SKU不存在');
  }
})

router.name="/m/sku";
module.exports = router;