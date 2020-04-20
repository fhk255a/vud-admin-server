const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'orderlist';
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,UPDATE,INSERT} = require('../../../lib/sql');
const router = new Router();
// 获取订单列表
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
// 取消订单
router.post('/order/cancel',async (ctx,next)=>{
  if(!ctx.request.body.id){
    ctx.body = new MyError('订单ID不能为空',400,1000);
    return;
  }
  let key ={
    cancelTime:new Date().getTime(),
    cancelReason:'运营后台取消',
    cancelUserId:ctx.session.userInfo.username,
    orderStatus:3,
    orderType:-1,
  }
  const SQL = UPDATE(TABLE_NAME,key,{id:ctx.request.body.id});
  await query(SQL).then(res=>{
    ctx.body = new Success();
  }).catch(err=>{
    ctx.body = err;
  });
})
// 查询订单详情
router.get('/order/details',async (ctx,next)=>{
  // if(!ctx.query.id){
  //   ctx.body = new MyError('订单ID不能为空',400,1000);
  //   return;
  // }
  // const SQL = SEARCH(TABLE_NAME,ctx.query);
  // await query(SQL).then(res=>{
  //   ctx.body = new Success(res[0]);
  // }).catch(err=>{
  //   ctx.body = err;
  // });
  if(!ctx.query.id){
    ctx.body = new MyError('订单ID不能为空');
    return;
  }
  let orderInfoRes = await query(`SELECT member.username, member.nickname,orderlist.* from orderlist,member WHERE orderlist.id = ${ctx.query.id} and orderlist.userId = member.id`);
  if(orderInfoRes.length>0){
    const sql = `SELECT sp.name,sp.logo,p.mainImage,s.num,p.shopId,s.title,s.price,s.skuName,s.productId,p.shopId as productId from product as p ,
    orderProduct as s, shop as sp where s.orderId in(${orderInfoRes[0].id}) and s.productId = p.id and s.shopId = sp.id `;
    // const productRes = await query(SEARCH('orderProduct',{orderId:orderInfoRes[0].id}));
    const productRes = await query(sql);
    let products = []
    for(let i in productRes){
      let item = productRes[i];
      let INDEX = products.findIndex(it=>it.shopId==item.shopId);
      if(INDEX==-1){
        products.push({
          name:item.name,
          logo:item.logo,
          price:item.price*1*item.num,
          products:[item]
        });
      }else{
        products[INDEX].price+=item.price*1*item.num;
        products[INDEX].products.push(item);
      }
    }
    const addressRes = await query(SEARCH('address',{id:orderInfoRes[0].addressId}));
    orderInfoRes[0].products = products;
    orderInfoRes[0].address = addressRes[0];
    ctx.body = new Success(orderInfoRes[0]);
    return;
  }else{
    ctx.body = new MyError('订单不存在',400,400);
    return;
  }
})

// 查询未发货订单
router.get('/order/review/list', async ctx=>{
  let params = {
    userId:ctx.query.userId,
    current:ctx.query.current,
    size:ctx.query.size,
    orderId:ctx.query.orderId,
    orderStatus:'0'
  }
  const total = WHERE_TOTAL(TABLE_NAME,params);
  const SQL = SEARCH_PAGE(TABLE_NAME,params);
  const resultTotal = await query(total);
  const resultData = await query(SQL);
  ctx.body = new Success({
    total:resultTotal[0].total,
    data:resultData
  })
})
// 发货
router.post('/order/ship', async ctx=>{
  const params = ctx.request.body;
  let data = {
    orderId:params.orderId,
    createTime:new Date().getTime(),
    expressName:params.expressName,
    expressNo:params.expressNo,
    expressPrice:params.expressPrice
  }
  const oldExpress = await query(SEARCH('express',{orderId:data.orderId}));
  if(oldExpress.length>0){
    await query(UPDATE('express',data,{id:oldExpress[0].id}))
    await query(UPDATE('orderlist',{orderStatus:1},{id:data.orderId}))
    ctx.body = new Success('发货成功');
  }else{
    const expressRes = await query(INSERT('express',data,[data]));
    if(expressRes.insertId){
      await query(UPDATE('orderlist',{orderStatus:1},{id:data.orderId}))
      ctx.body = new Success('发货成功');
      // 修改orderId的状态
    }else{
      ctx.body = new MyError('发货失败');
    }
  }
})
// 拒绝退款
router.post('/order/rejuct/:id', async ctx=>{
  const ID = ctx.params.id;
  let data = {
    orderId:params.orderId,
    createTime:new Date().getTime(),
    expressName:params.expressName,
    expressNo:params.expressNo,
    expressPrice:params.expressPrice
  }
  isRefund = 0 ;
  const oldExpress = await query(SEARCH('orderlist',{orderId:ID}));
  if(oldExpress.length>0){
    await query(UPDATE('express',data,{id:oldExpress[0].id}))
    await query(UPDATE('orderlist',{orderStatus:1},{id:data.orderId}))
    ctx.body = new Success('发货成功');
  }else{
    ctx.body = new MyError('订单不存在');
  }
})
// 添加
  // const SQL = INSERT('order',ctx.request.body.data[0],ctx.request.body.data);

router.name="order";
module.exports=router;