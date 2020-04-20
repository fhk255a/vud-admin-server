const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const CONFIG = require('../../../../lib/config');
const jwt = require('jsonwebtoken');
const {SEARCH,UPDATE,INSERT,DELETE} = require('../../../../lib/sql');
const router = new Router();
const TABLE_NAME = 'member';
let URL = '/m/user/collect/'
router.post(URL+'changeCollect',async ctx=>{
  const productId = ctx.request.body.productId;
  const userId = ctx.session.mUserInfo.id*1;
  if(!userId){
    ctx.body = new MyError('请登录');
    return;
  }
  if(!productId){
    ctx.body = new MyError('请添加商品');
    return;
  }
  const res = await query(SEARCH('collect',{userId,productId}));
  if(res.length>0){
    // 删除
    await query(DELETE('collect',{id:res[0].id}));
    ctx.body = new Success(false,'已取消');
    return;
  }else{
    // 添加
    let data = {
      userId,
      productId,
      createTime:new Date().getTime()
    }
    const addRes = await query(INSERT('collect',data,[data]));
    if(addRes.insertId){
      ctx.body = new Success(true,'已收藏');
      return;
    }else{
      ctx.body = new MyError('收藏失败');
      return;
    }
  }
})

// 收藏列表
router.get(URL+'list', async ctx=>{
  if(!ctx.session.mUserInfo){
    ctx.body = new MyError('身份已过期');
    return;
  }
  const userId = ctx.session.mUserInfo.id*1;
  const collectRes = await query(`select p.mainImage,p.title,p.status,p.shopId,p.id as productId,p.outPrice,
  c.id from product as p , collect as c WHERE c.userId = ${userId} and c.productId = P.id order by p.status desc`);
  ctx.body = new Success(collectRes.map(item=>{
    item.status = item.status == 1? true :false;
    return item;
  }));
})
router.name = 'm/user/collect';
module.exports = router;