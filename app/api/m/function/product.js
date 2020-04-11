const {searchs} = require('../../../../lib/sqlRow');
const Success = require('../../../../lib/success');
const MyError = require('../../../../lib/error');
const query = require('../../../../lib/query');
const CONFIG = require('../../../../lib/config');
const {SEARCH,UPDATE,INSERT} = require('../../../../lib/sql');
// 批量查询商品
const queryProductIds = async (ids) =>{
  const TABLE_NAME = 'product';
  let res = await query(searchs(TABLE_NAME,'id',ids));
  if(res.length>0){
    return res;
  }else{
    return [];
  }
}
// 批量查询商品集
const queryCollections = async (ids) =>{
  const TABLE_NAME = 'collection';
  const res = await query(searchs(TABLE_NAME,'id',ids));
  let data = [];
  if(res.length>0){
    for(let i = 0 ; i < res.length;i++){
      let item = res[i];
      item.status = item.status==1?true:false;
      let pids = await query(searchs('product','id',item.productIds.split(','),['id','mainImage']));
      item.count = pids.length;
      item.productIds = pids;
      data.push(item); 
    }
    return data;
  }else{
    return [];
  }
}

module.exports = {
  queryProductIds,
  queryCollections
}