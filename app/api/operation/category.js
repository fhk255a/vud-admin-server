const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const {CATEGORYTREE} = require('../../../lib/common');
const {DELETE,SEARCH,INSERT,UPDATE,UPDATES,DELETES} = require('../../../lib/sql');
const router = new Router();
const TABLE_NAME = 'h5category';
const URL = '/operation/category/';
// 展示分类列表
router.get(URL+'list',async ctx=>{
  await query(SEARCH(TABLE_NAME)).then(res=>{
    ctx.body = new Success(CATEGORYTREE(res));
  }).catch(err=>{

  })
})
// 编辑展示分类
router.post(URL+'update',async ctx=>{
  let params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('分类ID不能为空');
    return;
  }
  if(params.label.trim()==''){
    ctx.body = new MyError('分类名称不能为空');
    return;
  }
  if(params.baseCategoryId==0){
    ctx.body = new MyError('绑定的ID不能为0');
    return;
  }
  await query(UPDATE('h5category',params,{id:params.id})).then(res=>{
    ctx.body = new Success(null,'修改成功');
  }).catch(err=>{
    ctx.body = new MyError('修改失败')
  })
})
// 添加展示分类
router.post(URL+'add',async ctx=>{
  let params = ctx.request.body;
  if(params.id){
    ctx.body = new MyError('新建不能传ID');
    return;
  }
  if(params.label.trim()==''){
    ctx.body = new MyError('分类名称不能为空');
    return;
  }
  if(params.baseCategoryId==0){
    ctx.body = new MyError('绑定的ID不能为0');
    return;
  }
  let parentLevel = 1;
  delete params.id;
  if(params.parentId!=0){
    let level = await query(SEARCH('h5category',{id:params.parentId}));
    if(level.length>0){
      parentLevel = level[0].level;
      params.level=parentLevel+1;
    }
  }
  if(params.level>3){
    ctx.body = new MyError('目前最高等级是3，小项目不想拓展太大哦。');
    return;
  }
  // 先查父级的level  再从父级的level+1
  const categoryRes = await query(INSERT('h5category',params,[params]));
  if(categoryRes.insertId){
    ctx.body = new Success(null,'添加成功');
  }else{
    ctx.body = new MyError('添加失败')
  }
})
router.name='operation/category';
module.exports=router;