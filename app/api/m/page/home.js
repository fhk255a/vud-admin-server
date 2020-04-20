const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const CONFIG = require('../../../../lib/config');
const {CATEGORYTREE} = require('../../../../lib/common');
const {SEARCH,UPDATE,INSERT} = require('../../../../lib/sql');
const {queryProductIds,queryCollections} = require('../function/product');
const router = new Router();
const TABLE_NAME = 'apppageconfig';

// 获取页面信息
router.get('/m/page/:id',async ctx=>{
  if(!ctx.params.id){
    ctx.body = new MyError('ID不能为空');
    return;
  }
  let page = {};
  await query(SEARCH(TABLE_NAME,{id:ctx.params.id})).then(async res=>{
    if(res.length>0){
      page = res[0];
      page.content = JSON.parse(res[0].content);
      for(let i in page.content){
        if(page.content[i].type=='shareTop'){
          page.content[i].data = await queryProductIds(page.content[i].data.map(item=>item.id));
        }
        if(page.content[i].type=='collection'){
          page.content[i].data = await queryCollections(page.content[i].data.map(item=>item.id));
        }
      }
    }else{
      ctx.body = new MyError('用户不存在');
      return;
    }
  })
  ctx.body = new Success(page);
  return;
})

// 获取展示分类
router.get('/m/category/list',async ctx=>{
  await query(SEARCH('h5Category')).then(res=>{
    ctx.body = new Success(CATEGORYTREE(res));
  }).catch(err=>{

  })
})
router.name="/m/page/home";
module.exports = router;