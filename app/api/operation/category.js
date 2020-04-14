const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const {CATEGORYTREE} = require('../../../lib/common');
const {DELETE,SEARCH,INSERT,UPDATE,UPDATES,DELETES} = require('../../../lib/sql');
const router = new Router();
const TABLE_NAME = 'h5Category';
const URL = '/operation/category/';

router.get(URL+'list',async ctx=>{
  await query(SEARCH(TABLE_NAME)).then(res=>{
    ctx.body = new Success(CATEGORYTREE(res));
  }).catch(err=>{

  })
})
router.name='operation/category';
module.exports=router;