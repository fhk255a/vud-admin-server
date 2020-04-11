const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'collection';
const {WHERE_TOTAL,SEARCH_PAGE,UPDATE,SEARCH,INSERT,DELETE,getParentSql,UPDATES} = require('../../../lib/sql');
const {getColumn,getValue,searchs} = require('../../../lib/sqlRow');
const router = new Router();
const URL = '/collection/';
// 店铺列表
router.get(URL+'list',async ctx=>{
  const SQL = SEARCH_PAGE(TABLE_NAME,ctx.query,['title']);
  const TOTAL = WHERE_TOTAL(TABLE_NAME,ctx.query,['title']);
  let body = {
    total:0,
    data:[]
  };
  await query(TOTAL).then(res=>{
    body.total=res[0].total;
  });
  await query(SQL).then(async res=>{
    for(let i = 0 ; i < res.length;i++){
      let item = res[i];
      item.status = item.status==1?true:false;
      item.productIds = item.productIds.split(',');
      let pids = await query(searchs('product','id',item.productIds,['id','mainImage']));
      item.count = pids.length;
      item.productIds = pids;
      body.data.push(item); 
    }
    ctx.body = new Success(body);
  });
})
router.name = 'product/collection';
module.exports = router;