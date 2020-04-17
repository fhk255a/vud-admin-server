const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const {SEARCH,UPDATE,INSERT,DELETE} = require('../../../../lib/sql');
const router = new Router();
const TABLE_NAME = 'product';

// 获取页面信息
router.post('/m/function/address/add',async ctx=>{
  let params = ctx.request.body;
  params.isDefault = params.isDefault?1:0;
  if(!ctx.session.mUserInfo.id){
    ctx.body = new MyError('请登录');
    return;
  }
  params.userId = ctx.session.mUserInfo.id;
  
  let addRes = await query(INSERT('address',params,[params]));
  if(addRes.insertId){
    if(params.isDefault==1){
      // 把该userid下的其他地址改默认地址为0  
      await query(`UPDATE \`address\` SET \`isDefault\`=0 WHERE (\`id\`!= ${addRes.insertId}) AND (\`userId\`=${params.userId})`);
    }
    let address = await query(SEARCH('address',{userId:params.userId}));
    ctx.body = new Success(address.map(item=>{
      item.isDefault = item.isDefault==1?true:false;
      return item;
    }));
    return;
  }else{
    ctx.body = new MyError('创建失败');
    return;
  }
})
// 获取用户地址
router.get('/m/address/list',async ctx=>{
  const addressRes = await query(SEARCH('address',{userId:ctx.session.mUserInfo.id,status:1}));
  ctx.body = new Success(addressRes.map(item=>{
    item.isDefault = item.isDefault == 1? true :false;
    delete item.userId;
    delete item.status;
    return item;
  }));
})
// 获取用户地址
router.post('/m/address/save',async ctx=>{
  const params = ctx.request.body;
  const address = await query(SEARCH('address',{id:params.id}));
  params.isDefault = params.isDefault?1:0;
  if(address.length>0){
    if(address[0].userId == ctx.session.mUserInfo.id*1){
      if(params.isDefault==1){
        await query(`UPDATE \`address\` SET \`isDefault\`='0' WHERE \`userId\`=${ctx.session.mUserInfo.id*1} and \`isDefault\`=1`);
      }
      const updateAddressRes = await query(UPDATE('address',params,{id:params.id}));
      if(updateAddressRes){
        ctx.body = new Success(null);
        return;
      }else{
        ctx.body = new MyError('修改失败');
        return;
      }
    }else{
      ctx.body = new MyError('不能修改其他人的地址噢');
      return;
    }
  }else{
    ctx.body = new MyError('该地址不存在');
    return;
  }
})
// 删除用户地址
router.post('/m/address/delete',async ctx=>{
  if(!ctx.request.body.id){
    ctx.body = new MyError('ID不能为空');
    return;
  }
  const ID = ctx.request.body.id;
  const userId = ctx.session.mUserInfo.id*1;
  const addressRes = await query(SEARCH('address',{userId:userId,id:ID}));
  if(addressRes.length>0){
    await query(UPDATE('address',{status:0},{id:addressRes[0].id}));
    ctx.body = new Success(null,'删除成功');
    return;
  }else{
    ctx.body = new MyError('删除失败,此用户不存在该地址');
    return;
  }
})
// 添加地址
router.post('/m/address/create',async ctx=>{
  let params = ctx.request.body;
  delete params.id;
  params.userId = ctx.session.mUserInfo.id*1;
  params.isDefault = params.isDefault?1:0;
  const addressRes = await query(INSERT('address',params,[params]));
  if(addressRes.insertId){
    ctx.body = new Success('添加成功');
    return;
  }else{
    ctx.body = new MyError('添加失败');
    return;
  }
})
router.name="m/function/address";
module.exports = router;