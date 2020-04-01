const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const {TREE} = require('../../../lib/common');
const TABLE_NAME = 'menu';
const {DELETE,SEARCH,INSERT,UPDATE} = require('../../../lib/sql');
const router = new Router();

router.get('/menu/list',async (ctx,next)=>{
  await query(SEARCH(TABLE_NAME)).then(res=>{
    ctx.body=new Success(TREE(res));
  }).catch(err=>{
    ctx.body=new MyError('系统繁忙,menu-list');
  })
})
// 创建修改菜单
router.post('/menu/save',async (ctx,next)=>{
  const params = ctx.request.body;
  if(params.title.trim()==''){
    ctx.body=new MyError('菜单标题不能为空',500,1000);
    return;
  }
  if(params.path.trim()==''){
    ctx.body=new MyError('菜单路径不能为空',500,1000);
    return;
  }
  if(params.parentId<1){
    params.parentId = 0;
  }
  // 为了不能重复 先跑一下库 看看有没有path存在
  // 若修改就先判断存在的是不是同个id
  const sql = `SELECT * FROM \`menu\` WHERE ( path = '${params.path}' )`;
  await query(sql).then(async res=>{
    if(res.length>0){
      if(params.id){
        if(res[0].id != params.id){
          ctx.body = new MyError('该菜单路径已存在,请检查路径.',500,1000);
          return;
        }else{
          await query(UPDATE(TABLE_NAME,params,{id:params.id})).then(res=>{
            ctx.body = new Success(null,'保存成功');
          }).catch(err=>{
            ctx.body = new MyError('保存错误,menu-update',400,500);
          })
        }
      }else{
        ctx.body = new MyError('该菜单路径已存在,请检查路径.',500,1000);
        return;
      }
    }else{
      if(params.id){
        await query(UPDATE(TABLE_NAME,params,{id:params.id})).then(res=>{
          ctx.body = new Success(null,'保存成功');
        }).catch(err=>{
          ctx.body = new MyError('保存错误,menu-update',400,500);
        })
      }else{
        await query(INSERT(TABLE_NAME,params,[params])).then(res=>{
          ctx.body = new Success(null,'创建成功');
        }).catch(err=>{
          ctx.body = new MyError('创建失败,menu-save',400,500);
        })
      }
    }
  }).catch(err=>{
    ctx.body = new MyError('系统繁忙',500,500);
    return;
  })
})
// 更改状态
router.post('/menu/changeStatus',async (ctx,next)=>{
  const params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('ID不能为空',400,1000);
  }
  const data = {
    id:params.id,
    isHide:params.isHide
  }
  await query(UPDATE(TABLE_NAME,data,{id:params.id})).then(res=>{
    ctx.body = new Success(null,'修改成功');
  }).catch(err=>{
    ctx.body = new MyError('修改失败,menu-update',400,500);
  })
})
// 删除菜单
router.post('/menu/delete', async(ctx,next)=>{
  const params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('ID不能为空',400,1000);
  }
  await query(DELETE(TABLE_NAME,{id:params.id})).then(res=>{
    ctx.body = new Success(null,'删除成功');
  }).catch(err=>{
    ctx.body = new MyError('删除失败,menu-delete',400,500);
  })
})
router.name="menu";
module.exports = router;