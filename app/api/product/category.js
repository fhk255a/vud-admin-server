const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const {TREE} = require('../../../lib/common');
const fs = require('fs');
const path = require('path');
const mkdirp = require('mkdirp');
const sharp = require('sharp');
const {DELETE,SEARCH,INSERT,UPDATE,UPDATES,DELETES} = require('../../../lib/sql');
const router = new Router();
const TABLE_NAME = 'category';
const URL = '/category/';

router.get(URL+'tree',async ctx=>{
  await query(SEARCH(TABLE_NAME)).then(res=>{
    ctx.body = new Success(TREE(res,0));
  }).catch(err=>{

  })
})
router.name='category';
module.exports=router;