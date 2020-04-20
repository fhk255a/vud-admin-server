const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const CONFIG = require('../../../../lib/config');
const {CATEGORYTREE,Price} = require('../../../../lib/common');
const {SEARCH,UPDATE,INSERT,UPDATES,DELETES} = require('../../../../lib/sql');
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
  if(!ctx.request.body.addressId){
    ctx.body = new MyError('地址不能为空');
    return;
  }
  const ids = orderInfo.map(item=>item.id);
  let result = [];
  const sql = `SELECT s.count,p.shopId,p.title,s.outPrice,s.label,s.id as skuId,p.id as productId from product as p ,skuList as s where s.id in(${ids}) and s.productId = p.id and s.status != 0 and count != 0 `;
  let skuRes = await query(sql);
  let skuIds = [];
  let totalPrice = 0;
  let productNum = 0;
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
        productNum+=item.num;
        result.push(item);
        totalPrice+=Price(item.outPrice)*item.num;
      }
    }
    const userInfo = ctx.session.mUserInfo;
    let order = {
      createTime:new Date().getTime(),
      userId:userInfo.id*1,
      orderStatus:-1,
      addressId:ctx.request.body.addressId,
      totalPrice:totalPrice,
      remark:ctx.request.body.remark,
      num:productNum,
      resultPrice:totalPrice , //后面需要查优惠券 减去优惠券内容
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
      await query(UPDATES('member',{isFirst:0},{id:userInfo.id*1}))
      if(insertOrderProductRes && updateSkuRes){
        // 如果是从购物车下单
        if(cartIds.length>0){
          await query(DELETES('cart',cartIds));
        }
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
router.get(URL+'id/:id',async ctx=>{
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
      const sql = `SELECT sp.name,sp.logo,p.mainImage,s.num,p.shopId,s.title,s.price,s.skuName,s.productId,p.shopId as productId from product as p ,
      orderProduct as s, shop as sp where s.orderId in(${orderInfoRes[0].id}) and s.productId = p.id and s.shopId = sp.id`;
      // const productRes = await query(SEARCH('orderProduct',{orderId:orderInfoRes[0].id}));
      const productRes = await query(sql);
      let products = []
      for(let i in productRes){
        let item = productRes[i];
        let INDEX = products.findIndex(it=>it.shopId==item.shopId);
        if(INDEX==-1){
          products.push({
            shopId:item.shopId,
            name:item.name,
            logo:item.logo,
            price:Price(item.price)* item.num,
            products:[item]
          });
        }else{
          products[INDEX].price+=Price(item.price)* item.num;
          products[INDEX].products.push(item);
        }
      }
      const addressRes = await query(SEARCH('address',{id:orderInfoRes[0].addressId}));
      orderInfoRes[0].products = products;
      console.log(orderInfoRes[0].products)
      orderInfoRes[0].address = addressRes[0];
      ctx.body = new Success(orderInfoRes[0]);
      return;
    }
  }else{
    ctx.body = new MyError('订单不存在',400,400);
    return;
  }
})
router.post(URL+'toPay',async ctx=>{
  const ID = ctx.request.body.id; 
  const PASSWORD = ctx.request.body.password; 
  if(!ID){
    ctx.body = new MyError('ID不能为空');
    return;
  }
  if(!PASSWORD){
    ctx.body = new MyError('密码不能为空');
    return;
  }
  const USERID = ctx.session.mUserInfo.id;
  const orderRes = await query(SEARCH('orderList',{id:ID,userId:USERID}));
  if(orderRes.length==0){
    ctx.body = new MyError('不存在该订单');
    return;
  }
  const userInfo = await query(`SELECT * from member, memberinfo WHERE member.id = ${USERID} and memberinfo.payPassword = ${PASSWORD} and memberinfo.id=${USERID}`);
  if(userInfo.length>0){
    let price = userInfo[0].price-orderRes[0].resultPrice;
    if( price > 0){
      const order = {
        payTime:new Date().getTime(),
        orderStatus:0,
        orderType:1,
      }
      await query(UPDATE('orderList',order,{id:ID}));
      await query(UPDATE('memberinfo',{price},{id:USERID}));
      ctx.body = new Success(null,'支付成功');
      // 付款成功 
      // 1 改订单状态
      // 2 修改订单付款时间
      // 3 减去用户金额
    }else{
      ctx.body = new MyError('支付失败，余额不足');
      return;
    }
  }else{
    ctx.body = new MyError('支付失败，密码错误');
    return;
  }
})
router.get(URL+'list' ,async ctx=>{
  const orderRes = await query(SEARCH('orderList',{userId:ctx.session.mUserInfo.id}));
  for(let i in orderRes){
    let item = orderRes[i];
    item.products = await query(`
    SELECT product.mainImage, orderProduct.* FROM orderProduct , product  WHERE orderId=${item.id} and orderproduct.productId = product.id`);
  }
  ctx.body = new Success(orderRes);
})
router.name = 'm/order';
module.exports = router;