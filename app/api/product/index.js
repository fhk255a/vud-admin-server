const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const fs = require('fs');
const mkdirp = require('mkdirp');
const path = require('path');
const TABLE_NAME = 'product';
const {WHERE_TOTAL,UPDATE,SEARCH,INSERT,DELETES,getParentSql,UPDATES} = require('../../../lib/sql');
const {getColumn,getValue} = require('../../../lib/sqlRow');
const router = new Router();
// 获取商品列表
router.get('/product/list', async (ctx,next)=>{
  // 查询shop跟product表
  let params = getColumn(TABLE_NAME,['id','title','mainImage','outPrice','status','createTime','categoryId','shopId']);
  const SQL = `SELECT ${params},shop.name as shopName FROM ${TABLE_NAME},shop WHERE product.shopId = shop.id ${getValue(ctx.query,['title'])}`;
  const TOTAL = WHERE_TOTAL(TABLE_NAME,ctx.query,['title']);
  let body = {
    total:0,
    data:[]
  };
  await query(TOTAL).then(res=>{
    body.total=res[0].total;
  });
  await query(SQL).then(async res=>{
    for(let i = 0 ; i < res.length;i++){
      // 查询分类名称
      const category = await query(getParentSql('category',res[i].categoryId));
      res[i].categoryName = category.map(it=>it.label).join('>');
      body.data.push(res[i]);
    }
  });
  ctx.body = new Success(body);
})
// 获取商品详情
router.get('/product/details/:id' , async (ctx,next)=>{
  const ID = ctx.params.id;
  if(!ID){
    ctx.body = new MyError('商品ID不能为空',500,1000);
    return;
  }
  await query(SEARCH(TABLE_NAME,{id:ID})).then(async res=>{
    if(res.length>0){
      let info = res[0];
      for(let i in info){
        info[i] = info[i] && info[i]!='null'?info[i]:null;
      }
      // 查店铺信息
      await query(SEARCH('shop',{id:res[0].shopId})).then(async res=>{
        if(res.length>0){
          info.shopName = res[0].name;
        }else{
          const res = await query(SEARCH('shop',{id:1}));
          await query(UPDATE(TABLE_NAME,{shopId:1}));
          info.shopName = res[0].name;
          info.shopId = 1;
        }
      })
      // 查分类信息
      await query(getParentSql('category',res[0].categoryId)).then(async cate=>{
        info.categoryName = cate.map(item=>item.label).join('>');
      })
      // 查sku信息
      await query(SEARCH('skulist',{productId:res[0].id})).then(ress=>{
        info.skuList = ress;
      }).catch(()=>{
        ctx.body = new MyError('商品SKU有问题',400,404);
        return;
      })
      ctx.body = new Success(info);
    }else{
      ctx.body = new MyError('商品不存在',400,404);
      return;
    }
  })
})
// 保存或创建商品
router.post('/product/save' , async (ctx,next)=>{
  const DATA = ctx.request.body;
  let INFO = JSON.parse(DATA.json);
  if(INFO.title.trim()==''){
    ctx.body = new MyError('标题不能为空',500,1000);
    return;
  }
  if(INFO.inPrice.trim()==''){
    ctx.body = new MyError('进货价不能为空',500,1000);
    return;
  }
  if(INFO.outPrice.trim()==''){
    ctx.body = new MyError('销售价不能为空',500,1000);
    return;
  }
  if(INFO.skuList.length==0){
    ctx.body = new MyError('商品SKU不能为空',500,1000);
    return;
  }
  if(INFO.images.length==0){
    ctx.body = new MyError('商品图片不能为空',500,1000);
    return;
  }
  let deleteSkus = DATA.deleteIds?DATA.deleteIds.split(','):[];
  let skuItems = [];
  let addSkus = [];
  if(deleteSkus.length>0){
    await query(DELETES('skulist',deleteSkus))
  }
  INFO.skuList.forEach(item=>{
    item.productId=INFO.id; 
    item.status = item.status == true?1:0;
    item.updateTime = new Date().getTime();
    if(item.id){
      skuItems.push(item);
    }else{
      delete item.id;
      item.createTime = new Date().getTime();
      addSkus.push(item);
    }
  })
  let PRODUCTINFO = {...INFO};
  PRODUCTINFO.updateTime = new Date().getTime();
  delete PRODUCTINFO.skuList;
  delete PRODUCTINFO.shopName;
  delete PRODUCTINFO.categoryName;
  // 存在就更新数据
  if(INFO.id){
    // 用productId更新原有的sku
    if(skuItems.length>0){
      await query(UPDATES('skulist',skuItems,'id'));
    }
    // 用productId新增sku
    if(addSkus.length>0){
      await query(INSERT('skulist',addSkus[0],addSkus));
    }
    await query(UPDATE(TABLE_NAME,PRODUCTINFO,{id:INFO.id})).then(res=>{
      ctx.body = new Success('p118修改成功');
      return;
    }).catch(err=>{
      ctx.body = new MyError('p122修改失败');
      return;
    })
  }
  // 新创
  else{
    delete PRODUCTINFO.id;
    let productImages = PRODUCTINFO.images;
    delete PRODUCTINFO.images;
    PRODUCTINFO.createTime = new Date().getTime();
    await query(INSERT(TABLE_NAME,PRODUCTINFO,[PRODUCTINFO])).then(async ress=>{
      await query('select max(id) as id from product').then(async res=>{
        if(res.length>0){
          addSkus.map(item=>{
            item.productId = res[0].id;
            item.imgUrl = item.imgUrl.replace('default',res[0].id);
            return item;
          })
          // 在img.fhk255.cn 下 创建 pid文件夹
          const resultPath = path.join(__dirname,'../../../../../');
          //最终要保存到的文件夹目录
          let dir = resultPath+'/img.fhk255.cn/product/'+res[0].id;
          if(!fs.existsSync(dir)) mkdirp.sync(dir);
          if(productImages.length>0){
            let images = productImages.map(item=>{
              item.productId = res[0].id;
              item.image = item.image.replace('default',res[0].id);
              // 新建pid得图
              let readStream = fs.createReadStream(item.serverPath+'.'+item.type);
              let readStreamX100 = fs.createReadStream(item.serverPath+'x100.'+item.type);
              let readStreamX240 = fs.createReadStream(item.serverPath+'x240.'+item.type);
              // 删除原本路径得图
              fs.unlinkSync(`${item.serverPath}x100.${item.type}`);
              fs.unlinkSync(`${item.serverPath}x240.${item.type}`);
              fs.unlinkSync(`${item.serverPath}.${item.type}`);
              let newPath = item.serverPath.replace('default',res[0].id);
              item.serverPath = newPath;
              // 移动pid图
              let writeStream = fs.createWriteStream(newPath+'.'+item.type);
              let writeStreamX100 = fs.createWriteStream(newPath+'x100.'+item.type);
              let writeStreamX240 = fs.createWriteStream(newPath+'x240.'+item.type);
              // 完成移动
              readStream.pipe(writeStream);
              readStreamX100.pipe(writeStreamX100);
              readStreamX240.pipe(writeStreamX240);
              return item;
            })
            let imgs = images.map(item=>item.image);
            // 更改商品图片里面得图
            await query(UPDATE(TABLE_NAME,{images:imgs},{id:res[0].id}))
            await query(UPDATES('productimage',images,'fileName'))
            if(addSkus.length>0){
              await query(INSERT('skulist',addSkus[0],addSkus));
            }
            ctx.body = new Success({id:res[0].id},'创建成功');
            return;
          }else{
            if(addSkus.length>0){
              await query(INSERT('skulist',addSkus[0],addSkus));
            }
            ctx.body = new Success({id:res[0].id},'创建成功');
            return;
          }
        }
      })
    }).catch(err=>{
      ctx.body = new MyError('创建失败');
      return;
    })
  }
})
// 上下架商品
router.post('/product/changeStatus/:id', async ctx=>{
  if(!ctx.params.id){
    ctx.body = new MyError('商品ID不能为空');
    return;
  }
  const status = ctx.request.body.status;
  await query(UPDATE('product',{status},{id:ctx.params.id})).then(res=>{
    ctx.body = new Success(null,status==1?'该商品已上架':'该商品已下架');
    return;
  }).catch(err=>{
    ctx.body = new MyError('更改状态失败');
    return;
  })
})

router.name="product";
module.exports=router;