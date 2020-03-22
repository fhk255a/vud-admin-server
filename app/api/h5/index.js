const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'page';
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,UPDATE} = require('../../../lib/sql');
const router = new Router();
router.get('/h5/list', async (ctx,next)=>{
  const SQL = SEARCH_PAGE(TABLE_NAME,ctx.query,['name','remark']);
  const TOTAL = WHERE_TOTAL(TABLE_NAME,ctx.query,['name','remark']);
  let result = {};
  await query(SQL).then(res=>{
    result.data = res.map(item=>{
      delete item.content;
      item.status = item.status==1?true:false;
      return item;
    });
  })
  await query(TOTAL).then(res=>{
    result.total = res[0].total;
  })
  ctx.body = new Success(result);
})
router.get('/h5/details', async (ctx,next)=>{
  if(!ctx.query.pid){
    ctx.body = new MyError('pid不能为空',500,1000);
    return;
  }
  await query(SEARCH(TABLE_NAME,{pid:ctx.query.pid})).then(res=>{
    ctx.body = new Success(res[0]);
  })
})
router.post('/h5/save', async (ctx,next)=>{
  const params = ctx.request.body;
  // 插入
  if(!params.id){
    
  }
  // 保存
  else{
    // 先查看有没有这条数据
    let data = {
      ...params
    }
    delete data.id;
    ctx.body=UPDATE(TABLE_NAME,data,{pid:params.id});
    await query(UPDATE(TABLE_NAME,data,{pid:params.id})).then(res=>{
      ctx.body = new Success();
    })
  }
})

module.exports=router;