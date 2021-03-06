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
// 上传系统图片
router.post('/function/upload',async (ctx,next)=>{
  const file = ctx.request.files.image;
  const otherDir = ctx.request.body.path;
  let returnSize = ctx.request.body.size;
  returnSize = returnSize==0?'':returnSize==1?'x240':'x100';
  if(file){
    if(file.size/1024 > 500){
      ctx.body = new MyError('图片大小不能超过500KB',400,1000);
      return;
    }else{
      // 文件夹  根据当前时间生成
      const date = new Date();
      let month = Number.parseInt(date.getMonth()) + 1;
      month = month.toString().length > 1 ? month : `0${month}`;
      let ddir = `${date.getFullYear()}${month}${date.getDate()}`;
      let dirD = `${otherDir?otherDir:`${date.getFullYear()}${month}${date.getDate()}`}`;
      // 创建可读流
      const reader = fs.createReadStream(file.path);    
      // 获取后缀
      const ext = file.name.split('.').pop();
      // 返回到img.fhk255.cn目录
      const resultPath = path.join(__dirname,'../../../../../');
      //最终要保存到的文件夹目录
      dir = resultPath+'img.fhk255.cn/'+dirD;
      // 判断文件夹是否存在
      // 同步创建多级文件夹
      if(!fs.existsSync(dir)) mkdirp.sync(dir);
      //检查文件夹是否存在如果不存在则新建文件夹
      // 文件名称
      let pName = `${Date.now()}${Number.parseInt(Math.random() * 10000)}`; 
      // 文件二级路径 img.fhk255.cn / 文件夹
      let fileP = `img.fhk255.cn/${dirD}/`;
      // 文件真实路径 服务器
      const oldFileP = file.path;
      file.path = `${dir}/${pName}.${ext}`;
      const params = {
        dirName:dirD,
        serverPath:`${dir}/${pName}`,
        fileName:pName,
        pathDir:otherDir?otherDir:'default',
        bigSize:(file.size/1024).toFixed(2),
        minImage:`http://${fileP}${pName}x100.${ext}`,
        image:`http://${fileP}${pName}x240.${ext}`,
        type:ext,
        bigImage:`http://${fileP}${pName}.${ext}`
      }
      await query(INSERT('image',params,[params])).then(async (res)=>{
        if(res){
          // 缩略图
          const imgBuffer = sharp(oldFileP);
          await imgBuffer.clone().resize({ width: 100}).toBuffer(async (err,data,info)=>{
            // 存进小尺寸内存
            let size = (info.size/1024).toFixed(2);
            await query(UPDATE('image',{minSize:size},{fileName:pName,dirName:dirD}))
            await fs.writeFile(`${dir}/${pName}x100.${ext}`,data, async ()=>{})
          });
          await imgBuffer.clone().resize({ width: 240}).toBuffer(async (err,data,info)=>{
            // 存进中尺寸内存
            let size = (info.size/1024).toFixed(2);
            await query(UPDATE('image',{size:size},{fileName:pName,dirName:dirD}))
            await fs.writeFile(`${dir}/${pName}x240.${ext}`,data, async ()=>{})
          });
          // 存原始图
          const upStream = fs.createWriteStream(file.path);
          reader.pipe(upStream);
          let returnImage = `http://${fileP}${pName}${returnSize}.${ext}`;
          ctx.body = new Success(returnImage,'上传成功');
          return;
        }else{
          ctx.body = new MyError('上传失败,数据库插入失败');
          return;
        }
      }).catch(err=>{
        ctx.body = new MyError('上传失败');
        return;
      });
    }
  }else{
    ctx.body = new MyError('请上传图片',400,1000);
    return;
  }
})

// 上传商品图片
router.post('/function/uploadProduct',async (ctx,next)=>{
  const file = ctx.request.files.image;
  const pid = ctx.request.body.id;
  if(file){
    if(!pid){
      ctx.body = new MyError('商品id不能为空',400,1000);
      return;
    }
    if(file.size/1024 > 500){
      ctx.body = new MyError('图片大小不能超过500KB',400,1000);
      return;
    }else{
      // pid 就是文件夹名称
      //img.fhk255.cn/product/{pid}/{timertemp};
      // 创建可读流
      const reader = fs.createReadStream(file.path);    
      // 获取后缀
      const ext = file.name.split('.').pop();
      // 返回到img.fhk255.cn目录
      const resultPath = path.join(__dirname,'../../../../../');
      //最终要保存到的文件夹目录
      dir = resultPath+'/img.fhk255.cn/product/'+pid;
      // 判断文件夹是否存在
      // 同步创建多级文件夹
      if(!fs.existsSync(dir)) mkdirp.sync(dir);
      //检查文件夹是否存在如果不存在则新建文件夹
      // 文件名称
      let pName = `${Date.now()}${Number.parseInt(Math.random() * 10000)}`; 
      // fileP->二级路径 img.fhk255.cn / proudct / {pid} / 文件
      let fileP = `img.fhk255.cn/product/${pid}/`;
      // 文件真实路径 服务器
      const oldFileP = file.path;
      file.path = `${dir}/${pName}.${ext}`;
      const params = {
        productId:pid,
        serverPath:`${dir}/${pName}`,
        fileName:pName,
        size:(file.size/1024).toFixed(2),
        image:`http://${fileP}${pName}.${ext}`,
        type:ext,
        createTime:new Date().getTime()
      }
      await query(INSERT('productimage',params,[params])).then(async (res)=>{
        if(res){
          // 缩略图
          const imgBuffer = sharp(oldFileP);
          await imgBuffer.clone().resize({ width: 100}).toBuffer(async (err,data,info)=>{
            // 存进小尺寸内存
            await fs.writeFile(`${dir}/${pName}x100.${ext}`,data, async ()=>{})
          });
          await imgBuffer.clone().resize({ width: 240}).toBuffer(async (err,data,info)=>{
            // 存进中尺寸内存
            await fs.writeFile(`${dir}/${pName}x240.${ext}`,data, async ()=>{})
          });
          const upStream = fs.createWriteStream(file.path);
          reader.pipe(upStream);
          if(pid=='default'){
            ctx.body = new Success(params,'上传成功');
            return;
          }else{
            ctx.body = new Success(params.image,'上传成功');
            return;
          }
          
        }else{
          ctx.body = new MyError('上传失败,数据库插入失败');
          return;
        }
      }).catch(err=>{
        ctx.body = new MyError('上传失败');
        return;
      });
    }
  }else{
    ctx.body = new MyError('请上传图片',400,1000);
    return;
  }
});

router.name="function";
module.exports=router;