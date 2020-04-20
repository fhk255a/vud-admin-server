const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'apppageconfig';
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,UPDATE,INSERT} = require('../../../lib/sql');
const router = new Router();
router.post('/operation/pageConfig/add',async ctx=>{
  let params = ctx.request.body;
  if(params.pageType.trim()==''){
    ctx.body = new MyError('页面类型不能为空',400,1000);
    return;
  }
  if(params.content.trim()==''){
    ctx.body = new MyError('页面内容不能为空',400,1000);
    return;
  }
  if(params.title.trim()==''){
    ctx.body = new MyError('页面标题不能为空',400,1000);
    return;
  }
  let pageContent = JSON.parse(params.content);
  for(let i in pageContent){
    if(pageContent[i].data.length==0){
      ctx.body = new MyError('组件不能为空');
      return;
    }
  }
  delete params.id;
  params.createTime = new Date().getTime();
  await query(INSERT(TABLE_NAME,params,[params])).then(async res=>{
    await query('select max(id) as id from '+TABLE_NAME).then(async ress=>{
      ctx.body = new Success({id:ress[0].id},'创建成功');
      return;
    })
  }).catch(err=>{
    ctx.body = new MyError('创建失败');
    return;
  })
})
router.post('/operation/pageConfig/save',async ctx=>{
  let params = ctx.request.body;
  if(params.id.trim()==''){
    ctx.body = new MyError('ID不能为空',400,1000);
    return;
  }
  if(params.pageType.trim()==''){
    ctx.body = new MyError('页面类型不能为空',400,1000);
    return;
  }
  if(params.content.trim()==''){
    ctx.body = new MyError('页面内容不能为空',400,1000);
    return;
  }
  if(params.title.trim()==''){
    ctx.body = new MyError('页面标题不能为空',400,1000);
    return;
  }
  let pageContent = JSON.parse(params.content);
  for(let i in pageContent){
    if(pageContent[i].data.length==0){
      ctx.body = new MyError('组件不能为空');
      return;
    }
  }
  let id = params.id;
  delete params.id;
  params.createTime = new Date().getTime();
  await query(UPDATE(TABLE_NAME,params,{id:id})).then(async res=>{
    ctx.body = new Success(null,'修改成功');
    return;
  }).catch(err=>{
    ctx.body = new MyError('修改失败');
    return;
  })
})
// 获取页面信息
router.get('/operation/pageConfig/getPage/:id',async ctx=>{
  if(!ctx.params.id){
    ctx.body = new MyError('ID不能为空');
    return;
  }
  await query(SEARCH(TABLE_NAME,{id:ctx.params.id})).then(res=>{
    if(res.length>0){
      ctx.body = new Success(res[0]);
      return;
    }else{
      ctx.body = new MyError('用户不存在');
      return;
    }
  })
})
router.name = 'operation/pageConfig';
module.exports=router;