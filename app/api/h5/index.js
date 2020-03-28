const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const QRCODE = require('qr-image'); 
const TABLE_NAME = 'page';
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,UPDATE,INSERT} = require('../../../lib/sql');
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
    if(res.length>0){
      const result = {
        ...res[0],
        status:res[0].status==1?true:false
      }
      ctx.body = new Success(result);
    }else{
      ctx.body = new MyError('该页面不存在',500,1000);
      return;
    }
  })
})
// 保存 & 创建
router.post('/h5/save', async (ctx,next)=>{
  const params = ctx.request.body;
  // 插入
  if(!params.id){
    ctx.body = new MyError('ID不能为空',404,1000);
    return;
  }
  // 保存
  else{
    // 先查看有没有这条数据
    let data = {
      ...params,
      status:params.status=='true'||params.status==true?1:0
    }
    delete data.id;
    const SQL = SEARCH(TABLE_NAME,{pid:params.id});
    // 判断是否存在 保证pid是唯一
    await query(SQL).then(async res=>{
      // 走保存
      if(res.length>0){
        await query(UPDATE(TABLE_NAME,data,{pid:params.id})).then(res=>{
          ctx.body = new Success(params.id,'保存成功');
          return;
        })
      }
      // 走创建
      else{
        data.pid = params.id;
        await query(INSERT(TABLE_NAME,data,[data])).then(res=>{
          ctx.body = new Success(params.id,'创建成功');
          return;
        })
      }
    })
  }
})
// 生成二维码
router.post('/h5/qr', async (ctx, next) =>{
  const params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('ID不能为空',404,1000);
    return;
  }
  const url = 'http://h5.fhk255.cn/';
  const img = QRCODE.image(url+params.id,{size :10,type:'svg'});
  ctx.body = img;
})
router.get('/h5/getPid/:id', async (ctx,next)=>{
  await query(SEARCH(TABLE_NAME,{pid:ctx.params.id})).then(res=>{
    if(res.length>0){
      if(res[0].status!=1){
        ctx.body = new MyError('该页面未发布',500,500);
        return;
      }else{
        const data = {
          pid:res[0].pid,
          name:res[0].name,
          content:JSON.parse(res[0].content)
        }
        ctx.body = new Success(data);
      }
    }else{
      ctx.body = new MyError('不存在该页面',400,400);
      return;
    }
  })
})
module.exports=router;