const Router = require('koa-router');
const Success = require('../../../lib/success');
const query = require('../../../lib/query');
const router = new Router();
router.get('/product/list', async (ctx,next)=>{
  const params = ctx.query;
  let sql = `
    SELECT
    product.id,
    product.title_zh,
    product.create_time,
    product.`+'status'+`,
    product.`+'from'+`
    FROM
    product
    LIMIT ${(params.current-1)*params.size}, ${params.size}
  `;
  let total = `
      SELECT
      COUNT(*) AS total ,
      product.id,
      product.title_zh,
      product.create_time,
      product.status,
      product.from
      FROM
      product
  `;
  let body = {
    total:0,
    data:[]
  };
  await query(total).then(res=>{
    body.total=res[0].total;
  });
  await query(sql).then(res=>{
    body.data = res;
    ctx.body = new Success(body);
  });
}).post('/product/add' , async (ctx,next)=>{
  const params = ctx.request.body;
  let sql = "INSERT INTO `product` (`id`, `title_zh`, `from_url`, `update_time`, `create_time`,"+
   "`title`, `price_range_cn`, `purchaseRange`, `status`, `mainImage`, `from_shop_id`, `baseCategoryName`, `from`, `priceRange`) VALUES ";
  for(let i in params){
    sql+=`("${params[i+''].id}","${params[i+''].title_zh?params[i+''].title_zh:''}","${params[i+''].from_url?params[i+''].from_url:''}","${params[i+''].update_time}","${params[i+''].create_time?params[i+''].create_time:''}","${params[i+''].title}","${params[i+''].price_range_cn?params[i+''].price_range_cn:''}","${params[i+''].purchaseRange?params[i+''].purchaseRange:''}","${params[i+''].status}","${params[i+''].mainImage?params[i+''].mainImage:''}","${params[i+''].from_shop_id?params[i+''].from_shop_id:''}","${params[i+''].baseCategoryName?params[i+''].baseCategoryName:''}","${params[i+''].from?params[i+''].from:''}","${params[i+''].priceRange?params[i+''].priceRange:''}"),`;
  }
  let s = sql.lastIndexOf(',')
  sql = sql.substr(0,s)+';';
  query(sql).then(res=>{
    ctx.body = new Success(res);
  })
  ctx.body=sql;
})

module.exports=router;