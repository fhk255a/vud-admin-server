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
const path = require('path');
const fs = require('fs');
const mkdirp = require('mkdirp');
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
const getUploadDirName=()=>{
  const date = new Date();
  let month = Number.parseInt(date.getMonth()) + 1;
  month = month.toString().length > 1 ? month : `0${month}`;
  const dir = `${date.getFullYear()}${month}${date.getDate()}`;
  return dir;
};
const getUploadFileName=(ext)=>{
  return `${Date.now()}${Number.parseInt(Math.random() * 10000)}.${ext}`;
}
 
const checkDirExist=(p)=> {
  if (!fs.existsSync(p)) {
    mkdirp.sync(p);
  }
}
const getUploadFileExt=(name)=> {
  let ext = name.split('.');
  return ext[ext.length - 1];
}

module.exports={
  TREE,
  getUploadFileName,
  checkDirExist,
  getUploadFileExt,
  getUploadDirName
}