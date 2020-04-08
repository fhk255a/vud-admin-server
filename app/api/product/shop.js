const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'shop';
const {WHERE_TOTAL,SEARCH_PAGE,UPDATE,SEARCH,INSERT,DELETE,getParentSql,UPDATES} = require('../../../lib/sql');
const {getColumn,getValue} = require('../../../lib/sqlRow');
const router = new Router();
const URL = '/shop/';
// 店铺列表
router.get(URL+'list',async ctx=>{
  let p_n = 'product'; // 商品表
  let s_n = 'shop'; // 店铺表
  const SQL = `select * from ${s_n} as s left join 
  (select count(*) as num,shopId from ${p_n} GROUP BY shopId) as p on s.id = p.shopId WHERE ${getValue(ctx.query,['name'])}`;
  const TOTAL = WHERE_TOTAL(TABLE_NAME,ctx.query,['name']);
  let body = {
    total:0,
    data:[]
  };
  await query(TOTAL).then(res=>{
    body.total=res[0].total;
  });
  await query(SQL).then(res=>{
    body.data=res.map(item=>{
      item.status = item.status==1?true:false;
      item.num = item.num?item.num:0;
      return item;
    });
  });
  ctx.body = new Success(body);
})
// 添加店铺
router.post(URL+'save',async ctx=>{
  let params = ctx.request.body;
  if(params.name.trim()==''){
    ctx.body = new MyError('店铺名不能为空',500,500);
    return;
  }
  // 保存
  if(params.id){
    await query(`select * from shop where id!='${params.id}' and name='${params.name}' `).then(async res=>{
      if(res.length>0){
        ctx.body = new MyError('该店铺已存在',500,500);
        return;
      }else{
        params.updateTime = new Date().getTime();
        await query(UPDATE(TABLE_NAME,params,{id:params.id}));
        ctx.body = new Success(null,'修改成功');
        return;
      }
    });
  }else{
    await query(`select * from shop where name='${params.name}'`).then(async res=>{
      if(res.length>0){
        ctx.body = new MyError('该店铺已存在',500,500);
        return;
      }else{
        params.createTime = new Date().getTime();
        await query(INSERT(TABLE_NAME,params,[params]))
        ctx.body = new Success(null,'新建成功');
        return;
      }
    });
  }
})
// 删除店铺
router.post(URL+'delete',async ctx=>{
  const id = ctx.request.body.id;
  // 保存
  if(!id){
    ctx.body = new MyError('店铺ID不能为空',500,1000);
    return;
  }
  if(id==1){
    ctx.body = new MyError('系统店铺不能被删除',500,1000);
    return;
  }
  await query(DELETE(TABLE_NAME,{id:id})).then(async res=>{
    await query(UPDATE('product',{shopId:1},{shopId:id}));
    ctx.body = new Success(null,'删除成功');
    return;
  }).catch(()=>{
    ctx.body = new MyError('删除失败',500,1000);
    return;
  })
})
router.name = 'shop';
module.exports = router;