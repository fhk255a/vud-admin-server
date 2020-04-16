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
const URL = '/m/order/';
// 获取页面信息
router.post(URL+'create',async ctx=>{
  const orderInfo = JSON.parse(ctx.request.body.skuData);
  if(orderInfo.length<1){
    ctx.body = new MyError('sku不能不传');
    return;
  }
  const ids = orderInfo.map(item=>item.id);
  let result = [];
  const sql = `SELECT s.count,p.shopId,p.title,s.outPrice,s.label,s.id as skuId,p.id as productId from product as p ,skuList as s where s.id in(${ids}) and s.productId = p.id and s.status != 0 and count != 0 `;
  let skuRes = await query(sql);
  let skuIds = [];
  let totalPrice = 0;
  if(ids.length == skuRes.length){
    for(let i in skuRes){
      let item = skuRes[i];
      let sameItem = orderInfo.find(it=>it.id==item.skuId && it.num <= item.count);
      if(!sameItem){
        ctx.body = new MyError(`${item.productId}-${item.label}数量不足`);
        return;
      }else{
        item.num = sameItem.num;
        skuIds.push({
          id:item.skuId,
          count:(item.count)*1-(sameItem.num)*1
        });
        result.push(item);
        totalPrice+=(item.outPrice*item.num)*1;
      }
    }
    const userInfo = ctx.session.mUserInfo;
    let order = {
      createTime:new Date().getTime(),
      userId:userInfo.id,
      orderStatus:-1,
      totalPrice:totalPrice,
    }
    let orderRes = await query(INSERT('orderList',order,[order]));
    if(orderRes && orderRes.insertId){
      // orderRes.insertId  最新的orderId 
      // 这一步 要剔除原本的sku数量
      let skuPushData = [];
      // 把sku数据存到orderproduct里面
      for(let i in result){
        const item = result[i];
        skuPushData.push({
          orderId:orderRes.insertId,
          price:item.outPrice,
          num:item.num,
          title:item.title,
          skuId:item.skuId,
          productId:item.productId,
          shopId:item.shopId,
          skuName:item.label
        })
      }
      const insertOrderProductRes = await query(INSERT('orderProduct',skuPushData[0],skuPushData));
      const updateSkuRes = await query(UPDATES('skuList',skuIds))
      if(insertOrderProductRes && updateSkuRes){
        ctx.body = new Success({orderId:orderRes.insertId},'创建成功');
        return;
      }else{
        ctx.body = new MyError('生成订单失败');
        return;
      }
    }else{
      ctx.body = new MyError('订单创建失败');
      return;
    }
  }else{
    ctx.body = new MyError('有部分SKU下架或者库存不够');
    return;
  }
});
router.get(URL+':id',async ctx=>{
  if(!ctx.params.id){
    ctx.body = new MyError('订单ID不能为空');
    return;
  }
  let orderInfoRes = await query(SEARCH('orderList',{id:ctx.params.id}));
  if(orderInfoRes.length>0){
    if(orderInfoRes[0].userId*1!== ctx.session.mUserInfo.id*1){
      ctx.body = new MyError('不能偷看别人得订单噢',404,404);
      return;
    }else{

      const sql = `SELECT s.count,p.shopId,s.title,s.price,s.skuName,s.productId,p.shopId as productId from product as p ,
      orderProduct as s where s.orderId in(${orderInfoRes[0].id}) and s.productId = p.id`;
      const productRes = await query(SEARCH('orderProduct',{orderId:orderInfoRes[0].id}));
      orderInfoRes[0].products = productRes;
      ctx.body = new Success(orderInfoRes[0]);
      return;
    }
  }else{
    ctx.body = new MyError('订单不存在',400,400);
    return;
  }
})
router.name = 'm/order';
module.exports = router;