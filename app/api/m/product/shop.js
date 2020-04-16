const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query')
const {WHERE_TOTAL,SEARCH_PAGE,UPDATE,SEARCH,INSERT,DELETE,getParentSql,UPDATES} = require('../../../../lib/sql');
const {getColumn,getValue} = require('../../../../lib/sqlRow');
const router = new Router();
const TABLE_NAME = 'product';
const URL = '/m/product/shop/'
// 获取店铺列表
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
  await query(SQL).then(async res=>{
    for(let i in res){
      let item = res[i];
      item.status = item.status==1?true:false;
      item.num = item.num?item.num:0;
      let productIds = await query(`SELECT ${getColumn(p_n,['id','title','mainImage','outPrice'])} FROM ${p_n} WHERE product.shopId = ${item.id} LIMIT 3`);
      item.data = productIds;
      body.data.push(item);
    }
  });
  ctx.body = new Success(body);
})
// 获取店铺信息
router.get(URL+':id',async ctx=>{
  const sid = ctx.params.id;
  let p_n = 'product'; // 商品表
  let s_n = 'shop'; // 店铺表
  const SQL = `select * from ${s_n} as s left join 
  (select count(*) as num,shopId from ${p_n} GROUP BY shopId) as p on s.id = p.shopId WHERE s.id = ${sid}`;
  const TOTAL = WHERE_TOTAL(p_n,{shopId:sid});
  let body = {
    total:0,
    data:[]
  };
  const params = ctx.query;
  await query(TOTAL).then(res=>{
    body.total=res[0].total;
  });
  
  let size = params.size?params.size:20;
  let current = params.current?params.current:1;
  const res = await query(SQL);
  if(res.length>0){
    let item = res[0];
    item.status = item.status==1?true:false;
    item.num = item.num?item.num:0;
    let productIds = await query(`SELECT ${getColumn(p_n,['id','title','mainImage','outPrice'])} FROM ${p_n} WHERE product.shopId = ${sid} LIMIT ${(current-1)*size}, ${size}`);
    item.data = productIds;
    body.data=item;
    ctx.body = new Success(body);
    return;
  }else{
    ctx.body = new MyError('该店铺不存在');
    return;
  }
})
router.name = '/m/product/shop';
module.exports = router;