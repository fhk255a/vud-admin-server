const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const fs = require('fs');
const TABLE_NAME = 'image';
const {DELETE,SEARCH} = require('../../../lib/sql');
const router = new Router();
// 获取服务器文件夹
router.get('/media/dirList',async (ctx,next)=>{
  const sql = `select dirName,count(1) num from \`image\` group by dirName`;
  await query(sql).then(res=>{
    if(res.length>0){
      ctx.body = new Success(res.map(item=>{
        item.files=[];
        return item;
      }));
    }else{
      ctx.body = new MyError('无内容');
    }
  }).catch(err=>{
    ctx.body = new MyError('获取失败');
  })
})
// 获取文件夹下得所有文件
router.get('/media/dirQueryFiles',async (ctx,next)=>{
  const params = ctx.query;
  if(!params.dirName){
    ctx.body = new MyError('请传入文件夹名称');
    return;
  }
  const sql = SEARCH(TABLE_NAME,{dirName:params.dirName},['fileName','minImage','size','minSize','bigSize','id']);
  await query(sql).then(res=>{
    if(res.length>0){
      ctx.body = new Success(res);
    }else{
      ctx.body = new MyError('无内容');
    }
  }).catch(err=>{
    ctx.body = new MyError('获取失败');
  })
})
// 删除文件
router.post('/media/deleteFileItem',async (ctx,next)=>{
  const params = ctx.request.body;
  if(!params.id){
    ctx.body = new MyError('请传入文件ID');
    return;
  }
  await query(SEARCH(TABLE_NAME,{id:params.id})).then(async res=>{
    if(res.length>0){
      // fileName 文件名称
      // dir 服务器根路径
      // dirName 文件夹名称
      if(fs.existsSync(`${res[0].serverPath}.${res[0].type}`)){
        fs.unlinkSync(`${res[0].serverPath}.${res[0].type}`);
      }
      if(fs.existsSync(`${res[0].serverPath}x100.${res[0].type}`)){
        fs.unlinkSync(`${res[0].serverPath}x100.${res[0].type}`);
      }
      if(fs.existsSync(`${res[0].serverPath}x240.${res[0].type}`)){
        fs.unlinkSync(`${res[0].serverPath}x240.${res[0].type}`);
      }
      await query(DELETE(TABLE_NAME,{id:params.id})).then(res=>{
        ctx.body = new Success(null,'删除成功');
        return;
      }).catch(err=>{
        ctx.body = new MyError('删除失败');
        return;
      })
    }else{
      ctx.body = new MyError('删除失败');
      return;
    }
  }).catch(err=>{
    ctx.body = new MyError('删除失败');
  })
})
router.name="media";
module.exports=router;