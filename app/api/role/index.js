const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'role';
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,INSERT,UPDATE,DELETE} = require('../../../lib/sql');
const router = new Router();
router.get('/role/list',async (ctx,next)=>{ 
  // 分页
  if(ctx.query.current){
    const SQL = SEARCH_PAGE(TABLE_NAME,ctx.query,['name']);
    const TOTAL = WHERE_TOTAL(TABLE_NAME,ctx.query);
    let result = {};
    
    console.log(SQL);
    await query(SQL).then(res=>{
      result.data = res.map(item=>{
        delete item.createUserId;
        return item;
      });
    })
    await query(TOTAL).then(res=>{
      result.total = res[0].total;
    })
    ctx.body = new Success(result);
  }else{
    let result = [];
    await query(SEARCH(TABLE_NAME)).then(res=>{
      result = res.map(item=>{
        delete item.createUserId;
        return item;
      });
    })
    ctx.body = new Success(result);
  }
})
// 修改角色
router.post('/role/update',async (ctx,next)=>{ 
  const params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('ID不能为空',400,1000);
    return;
  }
  if(params.id==10000 || params.id == 9999){
    ctx.body = new MyError('这个角色不能编辑',400,400);
    return;
  }
  if(params.name.trim() == ''){
    ctx.body = new MyError('名称不能为空',400,1000);
    return;
  }
  const data = {
    createUserId:ctx.session.userInfo.id,
    createUser:ctx.session.userInfo.username,
    ...params
  }
  delete data.id;
  // 判断是否除了自己本身外其他拥有相同名称的数据
  const sql = `SELECT * FROM \`role\` WHERE ( name = '${params.name}' AND id != ${params.id} )`;
  await query(sql).then(async res=>{
    if(res.length>0){
      ctx.body = new MyError('已存在该名称',202,1000);
      return;
    }else{
      await query(UPDATE(TABLE_NAME,data,{id:params.id})).then(res=>{
        ctx.body = new Success();
        return;
      }).catch(err=>{
        ctx.body = new MyError('系统繁忙',500,500);
        return;
      })
    }
  }).catch(err=>{
    ctx.body = new MyError('系统繁忙',500,500);
    return;
  })
})
// 创建角色
router.post('/role/create',async (ctx,next)=>{ 
  const params = ctx.request.body;
  if(params.id){
    ctx.body = new MyError('创建不需要传ID',400,1000);
    return;
  }
  if(params.name.trim() == ''){
    ctx.body = new MyError('名称不能为空',400,1000);
    return;
  }
  const data = {
    createUserId:ctx.session.userInfo.id?ctx.session.userInfo.id:10000,
    createUser:ctx.session.userInfo.username?ctx.session.userInfo.username:'ADMIN',
    ...params
  }
  // 判断是否除了自己本身外其他拥有相同名称的数据
  await query(SEARCH(TABLE_NAME,{name:params.name})).then(async res=>{
    if(res.length>0){
      ctx.body = new MyError('已存在该名称',202,1000);
      return;
    }else{
      await query(INSERT(TABLE_NAME,data,[data])).then(res=>{
        ctx.body = new Success();
        return;
      }).catch(err=>{
        ctx.body = new MyError('系统繁忙',500,500);
        return;
      })
    }
  }).catch(err=>{
    ctx.body = new MyError('系统繁忙',500,500);
    return;
  })
})
router.post('/role/delete', async (ctx,next)=>{
  const params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('请指定删除的ID',400,1000);
    return;
  }
  if(params.id == 10000 || params.id == 9999){
    ctx.body = new MyError('系统角色不能被删除',400,400);
    return;
  }
  await query(DELETE(TABLE_NAME,{id:params.id})).then(async (res)=>{
    await query(UPDATE('user',{role:10000},{role:params.id})).then(res=>{
      ctx.body = new Success();
      return;
    }).catch(err=>{
      ctx.body = new MyError('系统繁忙',500,500);
      return;
    })
  }).catch(err=>{
    ctx.body = new MyError('系统繁忙',500,500);
    return;
  })
})
module.exports = router;