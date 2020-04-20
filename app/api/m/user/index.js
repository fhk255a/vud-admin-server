const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const CONFIG = require('../../../../lib/config');
const jwt = require('jsonwebtoken');
const {SEARCH,UPDATE,INSERT,DELETE,WHERE_TOTAL} = require('../../../../lib/sql');
const router = new Router();
const TABLE_NAME = 'member';
let URL = '/m/user/collect/'
// 获取用户信息
router.get('/m/user/getUserInfo',async ctx=>{
  if(!ctx.session.mUserInfo.id*1){
    ctx.body = new MyError('请登录');
    return;
  }
  let userId = ctx.session.mUserInfo.id*1;
  const userInfo = await query(`
    select COUNT(c.id) as collectNum,m.* ,mu.price,mu.head,mu.cion from 
    member as m,memberinfo as mu , collect AS c
    WHERE m.id=${userId} and  m.id=mu.id and c.userId = m.id and c.userId = m.id 
  `);
  let orderNum = await query(WHERE_TOTAL('orderlist',{userId}));
  let addressNum = await query(WHERE_TOTAL('address',{userId}));
  let unPaid = await query(WHERE_TOTAL('orderlist',{userId,orderStatus:-1})); // 未付款
  let notShip = await query(WHERE_TOTAL('orderlist',{userId,orderStatus:0})); // 未发货
  let shiped = await query(WHERE_TOTAL('orderlist',{userId,orderStatus:1})); // 已发货
  let overed = await query(WHERE_TOTAL('orderlist',{userId,orderStatus:3})); // 已退款 已结束
  userInfo[0].orderNum = orderNum[0].total;
  userInfo[0].addressNum = addressNum[0].total;
  userInfo[0].unPaid = unPaid[0].total;
  userInfo[0].notShip = notShip[0].total;
  userInfo[0].shiped = shiped[0].total;
  userInfo[0].overed = overed[0].total;
  delete userInfo[0].password;
  ctx.body = new Success(userInfo[0]);
})
router.name = 'm/user/index';
module.exports = router;