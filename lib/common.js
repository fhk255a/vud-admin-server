// 递归获取树状
// 结构
/**
 * {
 *   id:1
 *   parentId:0,
 *   children:[
 *     {
*        id:1
*        parentId:0,
*        children:[]
 *     }
 *   ]
 * }
 */
const TREE = (arr, parentId=0) =>{
  let temp = [];  // 输出模板
  let treeArr = arr;
  treeArr.forEach((item, index) => {
    item.isHide = item.isHide*1 == 1?true:false; 
    item.parentId *= 1; 
    if(item.parentId == parentId) {
      if(TREE(treeArr, treeArr[index].id).length > 0) {
        // 递归调用此函数
        treeArr[index].children =TREE(treeArr, treeArr[index].id);
      }
      temp.push({...treeArr[index]});
    }
  });
  return temp;
};
module.exports={
  TREE
}