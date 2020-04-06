const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const fs = require('fs');
const path = require('path');
const mkdirp = require('mkdirp');
const sharp = require('sharp');
const {DELETE,SEARCH,INSERT,UPDATE,UPDATES,DELETES} = require('../../../lib/sql');
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
      // 排序
      const sql = `SELECT * FROM \`config_key\` WHERE \`pid\`=${ctx.params.id} ORDER BY sort `;
      await query(sql).then(ress=>{
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
// 更新某个key
router.post(URL+'updateItem/:id',async ctx=>{
  if(!ctx.params.id){
    ctx.body = new MyError('请传入ID');
    return;
  }
  let items = JSON.parse(ctx.request.body.items);
  // 新增的
  let addItem = [];
  // 删除的
  let deleteItem = ctx.request.body.deleteIds;
  // 修改的
  let editItem = [];
  for(let i in items){
    items[i].status = items[i].status == true?1:0;
    if(items[i].id=='null' || !items[i].id || items[i].id == null){
      delete items[i].id;
      addItem.push(items[i]);
    }else{
      editItem.push(items[i]);
    }
  }
  // 批量更新
  const UPDATE_SQL = editItem.length>0?UPDATES(TABLE_NAME,editItem):null;
  // 批量新增
  const INSERT_SQL = addItem.length>0?INSERT(TABLE_NAME,addItem[0],addItem):null;
  // 批量删除
  const DELETE_SQL = deleteItem.length>0?DELETES(TABLE_NAME,deleteItem):null;
  // const ADD_SQL = ``;
  let result = false;
  if(UPDATE_SQL){
    await query(UPDATE_SQL).then(res=>{
      result = true;
    }).catch(err=>{
      result = false;
    });
  }
  if(INSERT_SQL){
    await query(INSERT_SQL).then(res=>{
      result = true;
    }).catch(err=>{
      result = false;
    });
  }
  if(DELETE_SQL){
    await query(DELETE_SQL).then(res=>{
      result = true;
    }).catch(err=>{
      result = false;
    });
  }
  if(result){
    ctx.body = new Success(null);
  }else{
    ctx.body = new MyError('保存失败');
  }
})
// 创建key
router.post(URL+'create',async ctx=>{
  let params = ctx.request.body;
  params.status = params.status == true?1:0;
  await query(SEARCH(TABLE_NAME,{key:params.key})).then(async res=>{
    if(res.length>0){
      ctx.body = new MyError('该key已经存在，请换一个',500,1000);
      return;
    }else{
      await query(INSERT(TABLE_NAME,params,[params])).then(res=>{
        ctx.body = new Success(null,'创建成功');
      }).catch(err=>{
        ctx.body = new MyError('创建失败');
      })
    }
  }).catch(err=>{
    ctx.body = new MyError('创建失败');
  })
})
// 修改key
router.post(URL+'update',async ctx=>{
  let params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('ID不能为空');
    return;
  }
  params.status = params.status == true?1:0;
  delete params.key;
  await query(UPDATE(TABLE_NAME,params,{id:params.id})).then( res=>{
    ctx.body = new Success(null,'修改成功');
    return;
  }).catch(err=>{
    ctx.body = new MyError('修改失败',500,500);
  })
})
// 通过key获取选择数据
router.get(URL+':key',async ctx =>{
  const KEY = ctx.params.key;
  if(!KEY){
    ctx.body = new MyError('KEY不能为空',500,1000);
    return;
  }
  await query(SEARCH(TABLE_NAME,{key:KEY,pid:0})).then(async res=>{
    if(res.length>0){
      const sql = `SELECT * FROM \`config_key\` WHERE \`pid\`=${res[0].id} ORDER BY sort `;
      await query(sql).then(ress=>{
        ctx.body = new Success(ress.map(item=>{
          item.status = item.status == 1?true:false;
          return item;
        }))
      }).catch(err=>{
        ctx.body = new MyError('key查找失败');
      })
    }else{
      ctx.body = new MyError('该key不存在');
    }
  }).catch(err=>{
    ctx.body = new MyError('key查找失败');
  })
})
// 删除key
router.post(URL+'delete',async ctx=>{
  const ID = ctx.request.body.id;
  await query(DELETE(TABLE_NAME,{id:ID})).then(async res=>{
    await query(DELETE(TABLE_NAME,{pid:ID}))
    ctx.body = new Success('删除成功');
  }).catch(err=>{
    ctx.body = new MyError('删除失败');
  })
})
router.name="config_key";
module.exports = router;