const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const fs = require('fs');
const path = require('path');
const mkdirp = require('mkdirp');
const sharp = require('sharp');
const {DELETE,SEARCH,INSERT,UPDATE} = require('../../../lib/sql');
const router = new Router();
const TABLE_NAME = 'config_key';
const URL = '/config/key/';
// 返回全部下拉框父级
router.get(URL+'list', async ctx=>{
  const params = {
    ...ctx.query,
    pid:0
  }
  await query(SEARCH(TABLE_NAME,params)).then(res=>{
    ctx.body = new Success(res.map(item=>{
      item.status = item.status == 1? true:false;
      return item;
    }));
  }).catch(err=>{
    ctx.body = new MyError('获取数据字典失败');
  })
})
// 选择某个选择区
router.get(URL+'item/:id', async ctx=>{
  if(!ctx.params.id){
    ctx.body = new MyError('请传入ID');
    return;
  }
  await query(SEARCH(TABLE_NAME,{id:ctx.params.id})).then(async res=>{
    if(res.length>0){
      await query(SEARCH(TABLE_NAME,{pid:ctx.params.id})).then(ress=>{
        ctx.body = new Success(ress.map(item=>{
          item.status = item.status == 1 ? true: false;
          return item;
        }));
      })
    }else{
      ctx.body = new MyError('该字典无效');
      return;
    }
  }).catch(err=>{
    ctx.body = new MyError('获取数据字典失败');
  })
})
router.name="config_key";
module.exports = router;