const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'member';
const {WHERE_TOTAL,SEARCH_PAGE,UPDATE,SEARCH,INSERT,DELETE,getParentSql,UPDATES} = require('../../../lib/sql');
const {getColumn,getValue} = require('../../../lib/sqlRow');
const router = new Router();
const URL = '/member/';
router.get(URL+'list',async ctx=>{
   // 查询shop跟product表
  //  let params = getColumn(TABLE_NAME,['id','title','mainImage','outPrice','status','createTime','categoryId','shopId']);
  const SQL = `SELECT ${getColumn(TABLE_NAME)} from ${TABLE_NAME} WHERE ${getValue(ctx.query,['nickname'])}`;
  let body = {
    total:0,
    data:[]
  }
  const TOTAL = WHERE_TOTAL(TABLE_NAME,ctx.query,['nickname']);
  await query(TOTAL).then(res=>{
    body.total=res[0].total;
  });
  await query(SQL).then(async res=>{
    for(let i = 0 ; i < res.length;i++){
      res[i].status = res[i].status == 1?true:false;
      res[i].isFirst = res[i].isFirst == 1?true:false;
      body.data.push(res[i]);
    }
  });
  ctx.body = new Success(body);
})
router.name="member";
module.exports = router;