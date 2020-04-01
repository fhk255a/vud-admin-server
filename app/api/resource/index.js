const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'resource';
const {TREE} = require('../../../lib/common');
const {WHERE_TOTAL,SEARCH_PAGE,SEARCH,INSERT,UPDATE,DELETE} = require('../../../lib/sql');
const router = new Router();
// 获取列表
router.get('/resource/list',async (ctx,next)=>{
  await query(SEARCH(TABLE_NAME)).then(res=>{
    ctx.body = new Success(TREE(res,0));
  })
})
// 创建 & 保存
router.post('/resource/save',async (ctx,next)=>{
  const params = ctx.request.body;
  if(params.label.trim() == ''){
    ctx.body = new MyError('资源名称不能为空',500,1000);
    return;
  }
  if(params.value.trim() == ''){
    ctx.body = new MyError('资源KEY不能为空',500,1000);
    return;
  }
  // 为了不能重复 先跑一下库 看看有没有path存在
  // 若修改就先判断存在的是不是同个id
  let data = {
    label:params.label,
    value:params.value,
    parentId:params.parentId || 0
  }
  const sql = `SELECT * FROM \`resource\` WHERE ( value = '${params.value}' )`;
  await query(sql).then(async res=>{
    // 已存在 判断是否跟当前的id一致
    if(res.length>0){
      if(params.id){
        data.id = params.id;
        if(res[0].id != data.id){
          ctx.body = new MyError('该KEY已存在,请检查.',500,1000);
          return;
        }else{
          await query(UPDATE(TABLE_NAME,data,{id:params.id})).then(res=>{
            ctx.body = new Success(null,'保存成功');
          }).catch(err=>{
            ctx.body = new MyError('保存错误,resource-update',400,500);
          })
        }
      }else{
        ctx.body = new MyError('该KEY已存在,请检查.',500,1000);
        return;
      }
    }else{
      // 修改
      if(params.id){
        data.id = params.id;
        await query(UPDATE(TABLE_NAME,data,{id:params.id})).then(res=>{
          ctx.body = new Success(null,'保存成功');
        }).catch(err=>{
          ctx.body = new MyError('保存错误,resource-update',400,500);
        })
      }else{
        // 创建
        await query(INSERT(TABLE_NAME,data,[data])).then(res=>{
          ctx.body = new Success(null,'创建成功');
        }).catch(err=>{
          ctx.body = new MyError('创建失败,resource-save',400,500);
        })
      }
    }
  })
})
// 删除
router.post('/resource/delete',async (ctx,next)=>{
  const params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('ID不能为空',400,1000);
  }
  await query(DELETE(TABLE_NAME,{id:params.id})).then(res=>{
    ctx.body = new Success(null,'删除成功');
  }).catch(err=>{
    ctx.body = new MyError('删除失败,resource-delete',400,500);
  })
})
router.name="resource";
module.exports=router;