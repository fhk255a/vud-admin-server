const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const CONFIG = require('../../../../lib/config');
const {CATEGORYTREE} = require('../../../../lib/common');
const {SEARCH,UPDATE,INSERT,UPDATES} = require('../../../../lib/sql');
const {queryProductIds,queryCollections} = require('../function/product');
const router = new Router();
const TABLE_NAME = 'order';
const URL = '/m/cart/';
router.post(URL+'add',async ctx=>{
  let params = ctx.request.body;
  if(!params.skuId){
    ctx.body=new MyError('请选择商品');
    return;
  }
  params.userId = ctx.session.mUserInfo.id*1;
  const skuRes = await query(SEARCH('cart',{userId:params.userId,skuId:params.skuId}));
  if(skuRes.length>0){
    params.num=params.num*1+skuRes[0].num*1;
    await query(UPDATE('cart',{num:params.num},{id:skuRes[0].id}));
    ctx.body=new Success(null,'添加成功');
    return;
  }else{
    await query(INSERT('cart',params,[params]));
    ctx.body=new Success(null,'添加成功');
    return;
  }
})
// 购物车列表
router.get(URL+'list',async ctx=>{
  const userId = ctx.session.mUserInfo.id*1;
  const sql = `SELECT c.id as cartId ,p.shopId,shop.name,shop.logo,p.mainImage,p.title,s.outPrice,s.label,c.skuId,p.id as productId ,s.id ,c.num
  from product as p ,shop,cart as c ,skuList as s where c.userId = ${userId} and s.productId = p.id  and c.skuId = s.id and p.shopId = shop.id`;
  const cartRes = await query(sql);
  let result = [];
  for(let i in cartRes){
    let item = cartRes[i];
    const Index = result.findIndex(it=>it.shopId == item.shopId);
    if(Index==-1){
        result.push({
          shopName:item.name,
          status:true,
          logo:item.logo,
          shopId:item.shopId,
          products:[{
            productId:item.productId,
            title:item.title,
            status:true,
            mainImage:item.mainImage,
            skuList:[{
              skuId:item.skuId,
              num:item.num,
              cartId:item.cartId,
              status:true,
              price:item.outPrice,
              label:item.label
            }]
          }]
        })
    }else{
      const pIndex = result[Index].products.findIndex(it=>it.productId == item.productId);
      if(pIndex==-1){
        result[Index].products.push({
          productId:item.productId,
          mainImage:item.mainImage,
          status:true,
          title:item.title,
          skuList:[{
            skuId:item.skuId,
            num:item.num,
            cartId:item.cartId,
            price:item.outPrice,
            status:true,
            label:item.label
          }]
        })
      }else{
        result[Index].products[pIndex].skuList.push({
          skuId:item.skuId,
          num:item.num,
          price:item.outPrice,
          status:true,
          cartId:item.cartId,
          label:item.label
        })
      }
    }
  }
  ctx.body = new Success(result);
})
router.name = 'm/cart';
module.exports = router;