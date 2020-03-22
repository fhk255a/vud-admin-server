const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'order';
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,UPDATE} = require('../../../lib/sql');
const router = new Router();
// 获取订单列表
router.get('/order/list',async (ctx,next)=>{
  console.log('session',ctx.session);
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
    cancelDate:new Date().getTime(),
    isCancel:true,
    cancelCode:'运营后台取消',
    cancelUser:ctx.session.userInfo.username,
    orderStatus:'CANCEL'
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
  if(!ctx.query.id){
    ctx.body = new MyError('订单ID不能为空',400,1000);
    return;
  }
  const SQL = SEARCH(TABLE_NAME,ctx.query);
  await query(SQL).then(res=>{
    ctx.body = new Success(res[0]);
  }).catch(err=>{
    ctx.body = err;
  });
})
// 添加
  // const SQL = INSERT('order',ctx.request.body.data[0],ctx.request.body.data);

module.exports=router;