const Router = require('koa-router');
const Success = require('../../../lib/success');
const MyError = require('../../../lib/error');
const query = require('../../../lib/query');
const TABLE_NAME = 'product';
const {WHERE_TOTAL,SEARCH_PAGE,UPDATE,SEARCH,INSERT,DELETES,DELETE,UPDATES} = require('../../../lib/sql');
const router = new Router();
// 获取商品列表
router.get('/product/list', async (ctx,next)=>{
  const SQL = SEARCH_PAGE(TABLE_NAME,ctx.query,['title_zh']);
  const TOTAL = WHERE_TOTAL(TABLE_NAME,ctx.query,['title_zh']);
  let body = {
    total:0,
    data:[]
  };
  await query(TOTAL).then(res=>{
    body.total=res[0].total;
  });
  await query(SQL).then(res=>{
    body.data = res;
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
      await query(SEARCH('skuList',{productId:res[0].id})).then(ress=>{
        ctx.body = new Success({
          skuList:ress,
          ...res[0]
        });
      }).catch(()=>{
        ctx.body = new MyError('商品SKU有问题',400,404);
        return;
      })
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
  let deleteSkus = DATA.deleteIds?DATA.deleteIds.split(','):[];
  let skuItems = [];
  let addSkus = [];
  if(deleteSkus.length>0){
    await query(DELETES('skuList',deleteIds))
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
  // 存在就更新数据
  if(INFO.id){
    // 用productId更新原有的sku
    if(skuItems.length>0){
      await query(UPDATES('skuList',skuItems,'id'));
    }
    // 用productId新增sku
    if(addSkus.length>0){
      await query(INSERT('skuList',addSkus[0],addSkus));
    }
    console.log(PRODUCTINFO)
    await query(UPDATE(TABLE_NAME,PRODUCTINFO,{id:INFO.id})).then(res=>{
      ctx.body = new Success('修改成功');
    })
  }
  // 新创
  else{
    delete PRODUCTINFO.id;
    PRODUCTINFO.createTime = new Date().getTime();
    await query(INSERT(TABLE_NAME,PRODUCTINFO,[PRODUCTINFO])).then(async res=>{
      await query('select max(id) as id from product').then(async res=>{
        if(res.length>0){
          addSkus.map(item=>{
            item.productId = res[0].id;
            return item;
          })
          await query(INSERT('skuList',addSkus[0],addSkus));
          ctx.body = new Success({id:res[0].id},'创建成功');
        }
      })
    }).catch(err=>{
      console.log(err);
    })
  }
})

router.name="product";
module.exports=router;