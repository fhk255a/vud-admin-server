const Router = require('koa-router');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const CONFIG = require('../../../../lib/config');
const {CATEGORYTREE} = require('../../../../lib/common');
const {SEARCH,UPDATE,INSERT,UPDATES} = require('../../../../lib/sql');
const {queryProductIds,queryCollections} = require('../function/product');
const router = new Router();
const TABLE_NAME = 'order';
const URL = '/m/cart/';
router.get(URL+'list',async ctx=>{
  let userid = ctx.session.mUserInfo.id*1;
  console.log(userid);
})
router.post(URL+'add',async ctx=>{
  let params = ctx.request.body;
  console.log(params);
})
router.name = 'm/cart';
module.exports = router;