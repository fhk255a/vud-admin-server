/*
Navicat MySQL Data Transfer

Source Server         : hk_blog
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : vue_admin

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2020-04-06 23:40:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `parentId` int(10) unsigned DEFAULT '0',
  `levelName` varchar(255) DEFAULT NULL,
  `level` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '通用', '0', null, '1');
INSERT INTO `category` VALUES ('2', '男装', '0', null, '1');
INSERT INTO `category` VALUES ('3', '女装', '0', null, '1');
INSERT INTO `category` VALUES ('4', '电器', '0', null, '1');
INSERT INTO `category` VALUES ('5', '手机', '0', null, '1');
INSERT INTO `category` VALUES ('6', '鞋靴', '0', null, '1');
INSERT INTO `category` VALUES ('7', '饰品', '0', null, '1');
INSERT INTO `category` VALUES ('8', '百货', '0', null, '1');
INSERT INTO `category` VALUES ('9', '食品', '0', null, '1');
INSERT INTO `category` VALUES ('10', '美妆', '0', null, '1');
INSERT INTO `category` VALUES ('11', '运动', '0', null, '1');
INSERT INTO `category` VALUES ('12', '宠物', '0', null, '1');
INSERT INTO `category` VALUES ('13', '套装', '2', null, '2');
INSERT INTO `category` VALUES ('14', '上装', '2', null, '2');
INSERT INTO `category` VALUES ('15', '长裤', '2', null, '2');
INSERT INTO `category` VALUES ('16', '套装', '3', null, '2');
INSERT INTO `category` VALUES ('17', '上装', '3', null, '2');
INSERT INTO `category` VALUES ('18', '裤子', '3', null, '2');
INSERT INTO `category` VALUES ('19', '内衣裤', '3', null, '2');
INSERT INTO `category` VALUES ('20', '厨房小电器', '4', null, '2');
INSERT INTO `category` VALUES ('21', '个护电器', '4', null, '2');
INSERT INTO `category` VALUES ('22', '生活电器', '4', null, '2');
INSERT INTO `category` VALUES ('23', '厨房大电', '4', null, '2');
INSERT INTO `category` VALUES ('24', '大家电', '4', null, '2');
INSERT INTO `category` VALUES ('25', '手机配件', '5', null, '2');
INSERT INTO `category` VALUES ('26', '男鞋', '6', null, '2');
INSERT INTO `category` VALUES ('27', '女鞋', '6', null, '2');
INSERT INTO `category` VALUES ('28', '手表', '7', null, '2');
INSERT INTO `category` VALUES ('29', '眼镜', '7', null, '2');
INSERT INTO `category` VALUES ('30', '珠宝', '7', null, '2');
INSERT INTO `category` VALUES ('31', '厨房用品', '8', null, '2');
INSERT INTO `category` VALUES ('32', '餐饮用具', '8', null, '2');
INSERT INTO `category` VALUES ('33', '居家日用', '8', null, '0');
INSERT INTO `category` VALUES ('34', '文具教具', '8', null, '2');
INSERT INTO `category` VALUES ('35', '窗帘布艺', '8', null, '2');
INSERT INTO `category` VALUES ('36', '收纳整理', '8', null, '2');
INSERT INTO `category` VALUES ('37', '床上用品', '8', null, '2');
INSERT INTO `category` VALUES ('38', '书籍', '8', null, '2');
INSERT INTO `category` VALUES ('39', '护肤', '10', null, '0');
INSERT INTO `category` VALUES ('40', '彩妆', '10', null, '2');
INSERT INTO `category` VALUES ('41', '美容美体', '10', null, '2');
INSERT INTO `category` VALUES ('42', '户外运动', '11', null, '2');
INSERT INTO `category` VALUES ('43', '运动器材', '11', null, '2');
INSERT INTO `category` VALUES ('44', '旅游器材', '11', null, '2');
INSERT INTO `category` VALUES ('45', '宠物洗护', '12', null, '2');
INSERT INTO `category` VALUES ('46', '宠物用品', '12', null, '2');
INSERT INTO `category` VALUES ('47', '宠物粮食', '12', null, '2');
INSERT INTO `category` VALUES ('48', '宠物医护', '12', null, '2');

-- ----------------------------
-- Table structure for config_key
-- ----------------------------
DROP TABLE IF EXISTS `config_key`;
CREATE TABLE `config_key` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0',
  `label` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `node` varchar(255) DEFAULT NULL,
  `status` int(2) DEFAULT '1',
  `createTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `key` varchar(255) NOT NULL,
  `sort` int(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`key`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of config_key
-- ----------------------------
INSERT INTO `config_key` VALUES ('1', '0', '性别', null, '性别选择', '1', '2020-04-02 16:58:27', 'SEX', '0');
INSERT INTO `config_key` VALUES ('2', '1', '男', '1', '', '1', '2020-04-02 00:12:44', '', '1');
INSERT INTO `config_key` VALUES ('3', '1', '女', '0', '', '1', '2020-04-01 16:09:38', '', '2');
INSERT INTO `config_key` VALUES ('4', '0', '状态', '', '开启 & 屏蔽', '0', '2020-04-03 17:24:07', 'STATUS', '0');
INSERT INTO `config_key` VALUES ('5', '4', '开启', '1', null, '1', null, '', '0');
INSERT INTO `config_key` VALUES ('6', '4', '关闭', '0', null, '1', null, '', '0');
INSERT INTO `config_key` VALUES ('10', '0', '商品上下架', null, '', '0', null, 'PRODUCT_STATUS', '0');
INSERT INTO `config_key` VALUES ('11', '10', '上架', '1', '', '1', '0000-00-00 00:00:00', '', '1');
INSERT INTO `config_key` VALUES ('12', '10', '下架', '0', '', '1', '0000-00-00 00:00:00', '', '2');
INSERT INTO `config_key` VALUES ('13', '10', '全部', '', '', '1', null, '', '0');
INSERT INTO `config_key` VALUES ('14', '0', '店铺来源', null, '', '0', null, 'PRODUCT_FROM', '0');
INSERT INTO `config_key` VALUES ('15', '14', '全部', '', '', '1', '0000-00-00 00:00:00', '', '0');
INSERT INTO `config_key` VALUES ('16', '14', '天猫', 'tmall', '', '1', '0000-00-00 00:00:00', '', '1');
INSERT INTO `config_key` VALUES ('17', '14', '淘宝', 'taobao', '', '1', '0000-00-00 00:00:00', '', '2');
INSERT INTO `config_key` VALUES ('18', '14', '阿里巴巴', '1688', '', '1', '0000-00-00 00:00:00', '', '3');
INSERT INTO `config_key` VALUES ('19', '14', 'NOME', 'nome', '', '1', '0000-00-00 00:00:00', '', '4');
INSERT INTO `config_key` VALUES ('20', '0', 'H5发布状态', null, '', '0', null, 'H5_STATUS', '0');
INSERT INTO `config_key` VALUES ('21', '20', '全部', '', '', '1', null, '', '0');
INSERT INTO `config_key` VALUES ('22', '20', '已发布', '1', '', '1', null, '', '0');
INSERT INTO `config_key` VALUES ('23', '20', '未发布', '0', '', '1', null, '', '0');

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image` (
  `dirName` varchar(255) DEFAULT NULL COMMENT '文件夹名',
  `fileName` varchar(255) NOT NULL COMMENT '文件名',
  `image` varchar(255) DEFAULT NULL COMMENT '完整路径',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` bigint(20) DEFAULT NULL COMMENT '上传时间',
  `size` bigint(20) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `minImage` varchar(255) NOT NULL COMMENT '缩略图',
  `bigImage` varchar(255) DEFAULT NULL COMMENT '原图',
  `minSize` double DEFAULT NULL,
  `bigSize` double DEFAULT NULL,
  `serverPath` varchar(255) DEFAULT NULL COMMENT '服务器路径',
  `pathDir` varchar(255) DEFAULT 'default',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES ('2020046', '15861590526173776', 'http://img.fhk255.cn/product/2020046/15861590526173776x240.jpg', '97', '1586159052000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861590526173776x100.jpg', 'http://img.fhk255.cn/product/2020046/15861590526173776.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861590526173776', 'product');
INSERT INTO `image` VALUES ('2020046', '15861591742297807', 'http://img.fhk255.cn/product/2020046/15861591742297807x240.jpg', '98', '1586159174000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861591742297807x100.jpg', 'http://img.fhk255.cn/product/2020046/15861591742297807.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861591742297807', 'product');
INSERT INTO `image` VALUES ('2020046', '15861619864526862', 'http://img.fhk255.cn/sku/2020046/15861619864526862x240.jpg', '99', '1586161986000', '9', 'jpg', 'http://img.fhk255.cn/sku/2020046/15861619864526862x100.jpg', 'http://img.fhk255.cn/sku/2020046/15861619864526862.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/sku/2020046/15861619864526862', 'sku');
INSERT INTO `image` VALUES ('2020046', '15861620445096974', 'http://img.fhk255.cn/sku/2020046/15861620445096974x240.jpg', '100', '1586162044000', '9', 'jpg', 'http://img.fhk255.cn/sku/2020046/15861620445096974x100.jpg', 'http://img.fhk255.cn/sku/2020046/15861620445096974.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/sku/2020046/15861620445096974', 'sku');
INSERT INTO `image` VALUES ('2020046', '15861620751083558', 'http://img.fhk255.cn/sku/2020046/15861620751083558x240.jpg', '101', '1586162075000', '9', 'jpg', 'http://img.fhk255.cn/sku/2020046/15861620751083558x100.jpg', 'http://img.fhk255.cn/sku/2020046/15861620751083558.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/sku/2020046/15861620751083558', 'sku');
INSERT INTO `image` VALUES ('2020046', '15861621149445702', 'http://img.fhk255.cn/sku/2020046/15861621149445702x240.jpg', '102', '1586162114000', '8', 'jpg', 'http://img.fhk255.cn/sku/2020046/15861621149445702x100.jpg', 'http://img.fhk255.cn/sku/2020046/15861621149445702.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/sku/2020046/15861621149445702', 'sku');
INSERT INTO `image` VALUES ('2020046', '1586162201746695', 'http://img.fhk255.cn/sku/2020046/1586162201746695x240.jpg', '103', '1586162201000', '8', 'jpg', 'http://img.fhk255.cn/sku/2020046/1586162201746695x100.jpg', 'http://img.fhk255.cn/sku/2020046/1586162201746695.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/sku/2020046/1586162201746695', 'sku');
INSERT INTO `image` VALUES ('2020046', '15861622272555570', 'http://img.fhk255.cn/sku/2020046/15861622272555570x240.jpg', '104', '1586162227000', '8', 'jpg', 'http://img.fhk255.cn/sku/2020046/15861622272555570x100.jpg', 'http://img.fhk255.cn/sku/2020046/15861622272555570.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/sku/2020046/15861622272555570', 'sku');
INSERT INTO `image` VALUES ('2020046', '1586162917671431', 'http://img.fhk255.cn/product/2020046/1586162917671431x240.jpg', '105', '1586162917000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/1586162917671431x100.jpg', 'http://img.fhk255.cn/product/2020046/1586162917671431.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/product/2020046/1586162917671431', 'product');
INSERT INTO `image` VALUES ('2020046', '1586162922917613', 'http://img.fhk255.cn/product/2020046/1586162922917613x240.jpg', '106', '1586162922000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/1586162922917613x100.jpg', 'http://img.fhk255.cn/product/2020046/1586162922917613.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/1586162922917613', 'product');
INSERT INTO `image` VALUES ('2020046', '15861632247673333', 'http://img.fhk255.cn/product/2020046/15861632247673333x240.jpg', '107', '1586163224000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861632247673333x100.jpg', 'http://img.fhk255.cn/product/2020046/15861632247673333.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861632247673333', 'product');
INSERT INTO `image` VALUES ('2020046', '15861634627501252', 'http://img.fhk255.cn/product/2020046/15861634627501252x240.jpg', '108', '1586163462000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861634627501252x100.jpg', 'http://img.fhk255.cn/product/2020046/15861634627501252.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861634627501252', 'product');
INSERT INTO `image` VALUES ('2020046', '15861634663368254', 'http://img.fhk255.cn/product/2020046/15861634663368254x240.jpg', '109', '1586163466000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/15861634663368254x100.jpg', 'http://img.fhk255.cn/product/2020046/15861634663368254.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861634663368254', 'product');
INSERT INTO `image` VALUES ('2020046', '15861635032519003', 'http://img.fhk255.cn/product/2020046/15861635032519003x240.jpg', '110', '1586163503000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/15861635032519003x100.jpg', 'http://img.fhk255.cn/product/2020046/15861635032519003.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861635032519003', 'product');
INSERT INTO `image` VALUES ('2020046', '15861635402491233', 'http://img.fhk255.cn/product/2020046/15861635402491233x240.jpg', '111', '1586163540000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861635402491233x100.jpg', 'http://img.fhk255.cn/product/2020046/15861635402491233.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861635402491233', 'product');
INSERT INTO `image` VALUES ('2020046', '15861635780098062', 'http://img.fhk255.cn/product/2020046/15861635780098062x240.jpg', '112', '1586163578000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/15861635780098062x100.jpg', 'http://img.fhk255.cn/product/2020046/15861635780098062.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861635780098062', 'product');
INSERT INTO `image` VALUES ('2020046', '1586163904306441', 'http://img.fhk255.cn/product/2020046/1586163904306441x240.jpg', '113', '1586163904000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/1586163904306441x100.jpg', 'http://img.fhk255.cn/product/2020046/1586163904306441.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/product/2020046/1586163904306441', 'product');
INSERT INTO `image` VALUES ('2020046', '15861639073113727', 'http://img.fhk255.cn/product/2020046/15861639073113727x240.jpg', '114', '1586163907000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861639073113727x100.jpg', 'http://img.fhk255.cn/product/2020046/15861639073113727.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861639073113727', 'product');
INSERT INTO `image` VALUES ('2020046', '15861664791724807', 'http://img.fhk255.cn/product/2020046/15861664791724807x240.jpg', '115', '1586166479000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/15861664791724807x100.jpg', 'http://img.fhk255.cn/product/2020046/15861664791724807.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861664791724807', 'product');
INSERT INTO `image` VALUES ('2020046', '15861590233135580', 'http://img.fhk255.cn/product/2020046/15861590233135580x240.jpg', '96', '1586159023000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861590233135580x100.jpg', 'http://img.fhk255.cn/product/2020046/15861590233135580.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861590233135580', 'product');
INSERT INTO `image` VALUES ('2020046', '15861588825968578', 'http://img.fhk255.cn/product/2020046/15861588825968578x240.jpg', '95', '1586158882000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861588825968578x100.jpg', 'http://img.fhk255.cn/product/2020046/15861588825968578.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861588825968578', 'product');
INSERT INTO `image` VALUES ('2020046', '15861664834104934', 'http://img.fhk255.cn/product/2020046/15861664834104934x240.jpg', '116', '1586166483000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861664834104934x100.jpg', 'http://img.fhk255.cn/product/2020046/15861664834104934.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861664834104934', 'product');
INSERT INTO `image` VALUES ('2020046', '15861668968334296', 'http://img.fhk255.cn/product/2020046/15861668968334296x240.jpg', '117', '1586166896000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/15861668968334296x100.jpg', 'http://img.fhk255.cn/product/2020046/15861668968334296.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861668968334296', 'product');
INSERT INTO `image` VALUES ('2020046', '15861669003343465', 'http://img.fhk255.cn/product/2020046/15861669003343465x240.jpg', '118', '1586166900000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861669003343465x100.jpg', 'http://img.fhk255.cn/product/2020046/15861669003343465.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861669003343465', 'product');
INSERT INTO `image` VALUES ('2020046', '15861697104261685', 'http://img.fhk255.cn/product/2020046/15861697104261685x240.jpg', '119', '1586169710000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861697104261685x100.jpg', 'http://img.fhk255.cn/product/2020046/15861697104261685.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861697104261685', 'product');
INSERT INTO `image` VALUES ('2020046', '15861697142514283', 'http://img.fhk255.cn/product/2020046/15861697142514283x240.jpg', '120', '1586169714000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/15861697142514283x100.jpg', 'http://img.fhk255.cn/product/2020046/15861697142514283.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861697142514283', 'product');
INSERT INTO `image` VALUES ('2020046', '15861697198781704', 'http://img.fhk255.cn/product/2020046/15861697198781704x240.jpg', '121', '1586169719000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/15861697198781704x100.jpg', 'http://img.fhk255.cn/product/2020046/15861697198781704.jpg', '2.94', '153.72', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861697198781704', 'product');
INSERT INTO `image` VALUES ('2020046', '15861734468825692', 'http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg', '122', '1586173446000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/15861734468825692x100.jpg', 'http://img.fhk255.cn/product/2020046/15861734468825692.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861734468825692', 'product');
INSERT INTO `image` VALUES ('2020046', '15861734502104912', 'http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg', '123', '1586173450000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861734502104912x100.jpg', 'http://img.fhk255.cn/product/2020046/15861734502104912.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861734502104912', 'product');
INSERT INTO `image` VALUES ('2020046', '15861831056516287', 'http://img.fhk255.cn/product/2020046/15861831056516287x240.jpg', '124', '1586183105000', '9', 'jpg', 'http://img.fhk255.cn/product/2020046/15861831056516287x100.jpg', 'http://img.fhk255.cn/product/2020046/15861831056516287.jpg', '2.39', '140.96', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861831056516287', 'product');
INSERT INTO `image` VALUES ('2020046', '15861831091518486', 'http://img.fhk255.cn/product/2020046/15861831091518486x240.jpg', '125', '1586183109000', '8', 'jpg', 'http://img.fhk255.cn/product/2020046/15861831091518486x100.jpg', 'http://img.fhk255.cn/product/2020046/15861831091518486.jpg', '2.64', '26.54', 'G:\\个人项目\\img.fhk255.cn/product/2020046/15861831091518486', 'product');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `parentId` int(11) unsigned zerofill DEFAULT NULL,
  `redirect` varchar(255) DEFAULT '' COMMENT '默认跳转',
  `isHide` int(1) unsigned zerofill DEFAULT '0',
  `createTime` bigint(20) DEFAULT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`path`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '/product', '商品模块', 'icon-shangpingouwudai', '商品模块', '00000000000', '', '0', '1584947404000', '1584953990000');
INSERT INTO `menu` VALUES ('2', '/product/list', '商品列表', null, '商品列表', '00000000001', '', '0', '1584947404000', '1584953990000');
INSERT INTO `menu` VALUES ('3', '/product/details', '商品详情', null, '商品详情', '00000000001', '', '1', '1584947404000', '1584973081000');
INSERT INTO `menu` VALUES ('4', '/product/shop', '店铺列表', null, '店铺列表', '00000000001', '', '0', '1584947404000', '1584953991000');
INSERT INTO `menu` VALUES ('5', '/order', '订单模块', 'icon-biaodan', '订单模块', '00000000000', '', '0', '1584947404000', '1584953950000');
INSERT INTO `menu` VALUES ('6', '/order/list', '订单列表', null, '订单列表', '00000000005', '', '0', '1584947404000', '1584953951000');
INSERT INTO `menu` VALUES ('7', '/order/details', '订单详情', '', '订单详情', '00000000005', '', '1', '1584950664000', '1584953952000');
INSERT INTO `menu` VALUES ('8', '/competence', '权限模块', 'icon-houtaiguanli', '权限模块', '00000000000', '', '0', '1584950781000', '1584953981000');
INSERT INTO `menu` VALUES ('9', '/competence/user', '用户列表', null, '用户列表', '00000000008', '', '0', '1584950800000', '1584953955000');
INSERT INTO `menu` VALUES ('10', '/competence/role', '角色列表', null, '角色列表', '00000000008', '', '0', '1584950808000', '1584953957000');
INSERT INTO `menu` VALUES ('11', '/competence/menu', '菜单列表', null, '菜单列表', '00000000008', '', '0', '1584950810000', '1584953958000');
INSERT INTO `menu` VALUES ('12', '/competence/resource', '资源列表', null, '资源列表', '00000000008', '', '0', '1584950812000', '1584953960000');
INSERT INTO `menu` VALUES ('13', '/h5', 'H5模块', 'icon-houtaiguanli', 'H5模块', '00000000000', '', '0', '1584953663000', '1584953988000');
INSERT INTO `menu` VALUES ('14', '/h5/list', 'H5列表', null, 'H5列表', '00000000013', '', '0', '1584953677000', '1584953962000');
INSERT INTO `menu` VALUES ('15', '/h5/details', 'H5详情', '', 'H5详情', '00000000013', '', '1', '1584953705000', '1585028692000');
INSERT INTO `menu` VALUES ('19', '/config', null, '', '系统配置', '00000000000', '', '0', '1585535214000', null);
INSERT INTO `menu` VALUES ('20', '/config/media', null, '', '媒体库', '00000000019', '', '0', '1585535235000', null);
INSERT INTO `menu` VALUES ('21', '/config/keys', null, '', '参数配置', '00000000019', '', '0', '1585816166000', '1585816222000');
INSERT INTO `menu` VALUES ('22', '/config/components', null, '', '页面组件', '00000000019', '', '0', '1586011450000', null);
INSERT INTO `menu` VALUES ('23', '/product/category', null, '', '基础分类', '00000000001', '', '0', '1586018252000', null);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `orderSn` varchar(255) DEFAULT NULL,
  `orderType` varchar(255) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `addressId` int(11) DEFAULT NULL,
  `productSnapshot` varchar(255) DEFAULT NULL,
  `addressSnapshot` varchar(255) DEFAULT NULL,
  `totalPrice` decimal(10,2) DEFAULT NULL,
  `serviceFee` varchar(255) DEFAULT NULL,
  `cancelPrice` decimal(10,2) DEFAULT NULL,
  `farePrice` decimal(10,2) DEFAULT NULL,
  `payMethod` varchar(255) DEFAULT NULL,
  `orderStatus` varchar(255) DEFAULT NULL,
  `payStatus` varchar(255) DEFAULT NULL,
  `expire` varchar(255) DEFAULT NULL,
  `createTime` varchar(255) DEFAULT NULL,
  `updateTime` varchar(255) DEFAULT NULL,
  `signTime` datetime DEFAULT NULL,
  `cancelCode` varchar(255) DEFAULT NULL,
  `discountAmount` varchar(255) DEFAULT NULL,
  `goodsNumber` varchar(255) DEFAULT NULL,
  `orderStatusVal` varchar(255) DEFAULT NULL,
  `erpId` int(11) DEFAULT NULL,
  `parentOrderNo` int(11) DEFAULT NULL,
  `total` varchar(255) DEFAULT NULL,
  `cancelPriceSign` varchar(255) DEFAULT NULL,
  `fare` varchar(255) DEFAULT NULL,
  `discount` varchar(255) DEFAULT NULL,
  `goldDiscount` varchar(255) DEFAULT NULL,
  `orderPrice` decimal(10,2) DEFAULT NULL,
  `serviceFeeSign` varchar(255) DEFAULT NULL,
  `purchaseInfo` varchar(255) DEFAULT NULL,
  `cancelDate` varchar(255) DEFAULT NULL,
  `cancelUser` varchar(255) DEFAULT NULL,
  `countryCode` varchar(255) DEFAULT NULL,
  `payTime` datetime DEFAULT NULL,
  `pushFailReason` varchar(255) DEFAULT NULL,
  `erpOrderStatus` varchar(255) DEFAULT NULL,
  `isSpecialOrder` varchar(255) DEFAULT NULL,
  `parentOrder` varchar(255) DEFAULT NULL,
  `trackCode` varchar(255) DEFAULT NULL,
  `couponCode` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `subtotal` varchar(255) DEFAULT NULL,
  `activityId` int(11) DEFAULT NULL,
  `goldNumber` int(11) DEFAULT NULL,
  `goldAmount` varchar(255) DEFAULT NULL,
  `pushErpTime` varchar(255) DEFAULT NULL,
  `isUploadCert` varchar(255) DEFAULT NULL,
  `payMethodName` varchar(255) DEFAULT NULL,
  `isCancel` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('144096', 'A15828677713825', 'ORDINARY_ORDER', '1120260', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/068/318/10876813860_14842097.jpg\",\"quantity\":100,\"productId\":1225691,\"price\":6.15,\"title\":\"เครื่องล้างถังซักผ้าสำหรับเครื่องซักผ้าทุกชนิดด้านในเพื่อกำจัดสิ่งสกปรกจากโรงงานโดยตรงขายส่งรุ่นเดียว\",\"skuId', '', '746.00', '0', '0.00', '131.00', '9', 'CANCEL', '1', '1583472571000', '1582867771000', '1582867776000', '0000-00-00 00:00:00', '', '0', '100', 'To Be Delivered', '0', '0', '฿746.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144101116', 'A15828927737026', 'ORDINARY_ORDER', '1183658', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/116/059/9105950611_1623572582.jpg\",\"quantity\":300,\"productId\":1163627,\"price\":7.41,\"title\":\"ขายส่งความงามขนตากำจัดเล็บ AD-1 ลบกาวเล็บลบกาวขนตาปลอม\",\"skuId\":\"1163627001\",\"attrs\":\"การติดฉลาก 10ML\"}]', '', '2403.00', '0', '0.00', '180.00', '9', 'CANCEL', '1', '1583497574000', '1582892773000', '1582892777000', '0000-00-00 00:00:00', '', '0', '300', 'Wait Payment', '0', '0', '฿2403.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144106', 'A15828927737026', 'ORDINARY_ORDER', '1183658', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/116/059/9105950611_1623572582.jpg\",\"quantity\":300,\"productId\":1163627,\"price\":7.41,\"title\":\"ขายส่งความงามขนตากำจัดเล็บ AD-1 ลบกาวเล็บลบกาวขนตาปลอม\",\"skuId\":\"1163627001\",\"attrs\":\"การติดฉลาก 10ML\"}]', '', '2403.00', '0', '0.00', '180.00', '9', 'CANCEL', '1', '1583497574000', '1582892773000', '1582892777000', '0000-00-00 00:00:00', '运营后台取消', '0', '300', 'Wait Payment', '0', '0', '฿2403.00', '', '', '', '', '0.00', '', null, '1584724283614', 'Joker', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144105', 'A15828914003329', 'ORDINARY_ORDER', '1027979', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/900/945/12031549009_1970550388.jpg\",\"quantity\":34,\"productId\":1352903,\"price\":8.84,\"title\":\"กล่องบรรจุภัณฑ์ กล่องใส่ฟองน้ำรูปไข่ ฟองน้ำแต่งหน้า\",\"skuId\":\"1352903001\",\"attrs\":\"เนโอเนส\"},{\"mainImage\":\"h', '', '3089.00', '0', '0.00', '80.00', '9', 'CANCEL', '1', '1583496201000', '1582891400000', '1582891416000', '0000-00-00 00:00:00', '运营后台取消', '0', '64', 'Wait Payment', '0', '0', '฿3089.00', '', '', '', '', '0.00', '', null, '1584785949820', 'Joker', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144104', 'A15828896299964', 'ORDINARY_ORDER', '1000835', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/304/957/11242759403_1161482004.jpg\",\"quantity\":10,\"productId\":1463667,\"price\":30.51,\"title\":\"แฟชั่นยุโรปและอเมริกาฮิปฮอปหวานสร้อยข้อมือแนวโน้มถนนอุปกรณ์การถ่ายภาพรักเย็นสร้อยข้อมือคู่ผู้หญิง E8477\",\"s', '', '340.00', '0', '0.00', '50.00', '6', 'CANCEL', '1', '1583494429000', '1582889629000', '1582889632000', '0000-00-00 00:00:00', '运营后台取消', '0', '10', 'Wait Payment', '0', '0', '฿340.00', '', '', '', '', '0.00', '', null, '1584893256829', 'admin', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'TRANSFER', 'true');
INSERT INTO `order` VALUES ('144103', 'A15828879577477', 'ORDINARY_ORDER', '1014623', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/308/393/11305393803_2094667046.jpg\",\"quantity\":15,\"productId\":1253878,\"price\":20.79,\"title\":\"ins ดั้งเดิมอย่างง่าย酷嘻哈土酷ชายและหญิงฮาราจูกุคู่ hipster hooks เบ็ดเบ็ดรอบสร้อยคอจี้\",\"skuId\":\"1253878001\",\"', '', '359.00', '0', '0.00', '50.00', '9', 'CANCEL', '1', '1583492757000', '1582887957000', '1582887958000', '0000-00-00 00:00:00', '运营后台取消', '0', '15', 'To Be Delivered', '0', '0', '฿359.00', '', '', '', '', '0.00', '', null, '1584936709976', 'admin', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144102', 'A15828863733614', 'ORDINARY_ORDER', '1163290', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/075/222/10312222570_1223746898.jpg\",\"quantity\":30,\"productId\":1403684,\"price\":17.44,\"title\":\"ครีมรองพื้นสำหรับผิวหน้าผู้ชายปรับผิวเรียบเนียนมีออร่าพร้อมการบำรุงเนื้อบางเบาเป็นพิเศษ มีให้เลือก 3 เฉดสีผ', '', '577.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583491173000', '1582886373000', '1582886376000', '0000-00-00 00:00:00', '', '0', '30', 'To Be Delivered', '0', '0', '฿577.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144101', 'A15828821708073', 'ORDINARY_ORDER', '1009531', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/486/933/9059339684_1612980370.jpg\",\"quantity\":10,\"productId\":1135696,\"price\":70.82,\"title\":\"A175 ins ใหม่ลมน่ารักบลัชออใบหน้าในแนวทแยงกระเป๋าสะพายไหล่ปรับสายคล้องไหล่กระเป๋าช้อปปิ้งสีเขียวหญิง\",\"skuId', '', '778.00', '0', '0.00', '70.00', '9', 'PAYSUCC', '1', '1583486970000', '1582882170000', '1582882174000', '0000-00-00 00:00:00', '', '0', '10', 'To Be Delivered', '0', '0', '฿778.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144100', 'A15828754982241', 'ORDINARY_ORDER', '1014623', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/911/788/11437887119_1424872694.jpg\",\"quantity\":15,\"productId\":1301598,\"price\":22.45,\"title\":\"Tu 雅风蹦迪สาว Tu เย็นสแตนเลสสร้อยคอดอกไม้หญิงโซ่ลูกปัด ins สาวฮิปฮอปสร้อยคอ\",\"skuId\":\"1301598003\",\"attrs\":\"ด้ว', '', '689.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583480298000', '1582875498000', '1582875500000', '0000-00-00 00:00:00', '', '0', '36', 'To Be Delivered', '0', '0', '฿689.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144099', 'A15828696726662', 'ORDINARY_ORDER', '1007768', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/781/880/10312088187_1939512170.jpg\",\"quantity\":3,\"productId\":1219143,\"price\":122.85,\"title\":\"ใหม่ 5 ลูกอมแปรงสายรุ้งน้ำตาลแปรงแต่งหน้าชุด 5 คริสตัลใสจับความงามเครื่องมือโรงงานจุด\",\"skuId\":\"1219143001\"', '', '419.00', '0', '0.00', '50.00', '9', 'CANCEL', '1', '1583474472000', '1582869672000', '1582869672000', '0000-00-00 00:00:00', 'A1000202', '0', '34', 'Cancelled', '0', '0', '฿411.00', '', '', '', '', '0.00', '', null, '1582869684000', '1007768', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'false');
INSERT INTO `order` VALUES ('144098', 'A15828696010073', 'ORDINARY_ORDER', '1007768', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/781/880/10312088187_1939512170.jpg\",\"quantity\":3,\"productId\":1219143,\"price\":122.85,\"title\":\"ใหม่ 5 ลูกอมแปรงสายรุ้งน้ำตาลแปรงแต่งหน้าชุด 5 คริสตัลใสจับความงามเครื่องมือโรงงานจุด\",\"skuId\":\"1219143001\"', '', '419.00', '0', '0.00', '50.00', '', 'CANCEL', '1', '1583474401000', '1582869601000', '1582869601000', '0000-00-00 00:00:00', 'A1000202', '0', '3', 'Cancelled', '0', '0', '฿419.00', '', '', '', '', '0.00', '', null, '1582869625000', '1007768', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'false');
INSERT INTO `order` VALUES ('144097', 'A15828695603775', 'ORDINARY_ORDER', '1007768', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/068/894/10373498860_1083885393.jpg\",\"quantity\":10,\"productId\":1346341,\"price\":39.17,\"title\":\"รุ่นร้อนเอวเดียวขนาดเล็กแป้งฝุ่นแปรงแต่งหน้าชุดแปรง Rose g old จับหัวใหญ่น้ำผึ้งผงแปรงเครื่องมือเสริมความงา', '', '462.00', '0', '0.00', '70.00', '', 'CANCEL', '1', '1583474360000', '1582869560000', '1582869560000', '0000-00-00 00:00:00', 'A1000202', '0', '10', 'Cancelled', '0', '0', '฿462.00', '', '', '', '', '0.00', '', null, '1582869748000', '1007768', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'false');
INSERT INTO `order` VALUES ('144095', 'A15828657896660', 'ORDINARY_ORDER', '1009531', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/486/933/9059339684_1612980370.jpg\",\"quantity\":20,\"productId\":1135696,\"price\":67.96,\"title\":\"A175 ins ใหม่ลมน่ารักบลัชออใบหน้าในแนวทแยงกระเป๋าสะพายไหล่ปรับสายคล้องไหล่กระเป๋าช้อปปิ้งสีเขียวหญิง\",\"skuId', '', '1439.00', '0', '0.00', '80.00', '9', 'CANCEL', '1', '1583470589000', '1582865789000', '1582865826000', '0000-00-00 00:00:00', 'A1000201', '0', '20', 'Cancelled', '0', '0', '฿1439.00', '', '', '', '', '0.00', '', null, '1582882138000', '1009531', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144094', 'A15828634116238', 'ORDINARY_ORDER', '1041600', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/621/565/11010565126_1145112722.jpg\",\"quantity\":2,\"productId\":1190898,\"price\":176.77,\"title\":\"2019 ฤดูใบไม้ผลิขากว้างย้อนยุคบางลำลองเอวสูงกางเกงซับนักเรียนหญิงหลวมหญิงสาวกางเกงตรงขายส่ง\",\"skuId\":\"11908', '', '2780.00', '0', '0.00', '131.00', '9', 'PENDING_REVIEW', '1', '1583468212000', '1582863412000', '1582863421000', '0000-00-00 00:00:00', '', '0', '27', 'Wait Payment', '0', '0', '฿2780.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144093', 'A15828615449138', 'ORDINARY_ORDER', '1055813', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/900/945/12031549009_1970550388.jpg\",\"quantity\":34,\"productId\":1352903,\"price\":8.84,\"title\":\"กล่องบรรจุภัณฑ์ กล่องใส่ฟองน้ำรูปไข่ ฟองน้ำแต่งหน้า\",\"skuId\":\"1352903001\",\"attrs\":\"เนโอเนส\"}]', '', '371.00', '0', '0.00', '70.00', '9', 'PAYSUCC', '1', '1583466345000', '1582861544000', '1582861549000', '0000-00-00 00:00:00', '', '0', '34', 'To Be Delivered', '0', '0', '฿371.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144092', 'A15828612589617', 'ORDINARY_ORDER', '1188148', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/212/277/11090772212_2082842830.jpg\",\"quantity\":2,\"productId\":1160095,\"price\":168.28,\"title\":\"ข้ามพรมแดนสำหรับผู้หญิงของ Amazon eBay AliExpress ยุโรปและสหรัฐอเมริกาไหล่หลวมแขนสั้นแยกชุดชุดลำลอง\",\"skuId', '', '753.00', '0', '0.00', '80.00', '', 'NEW', '1', '1583466059000', '1582861259000', '1582861259000', '0000-00-00 00:00:00', '', '0', '4', 'Wait Payment', '0', '0', '฿753.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'true');
INSERT INTO `order` VALUES ('144091', 'A15828554162819', 'ORDINARY_ORDER', '1087586', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/608/638/10512836806_562244402.jpg\",\"quantity\":20,\"productId\":1248219,\"price\":70.96,\"title\":\"ใหม่เซนชุดวรรณกรรมลูกเห็บกันน้ำหนาผ้าใบกระเป๋าสะพายกระเป๋าสะพายกระเป๋าช้อปปิ้งสะพายกุญแจมือถนนแฟชั่นกระเป๋า\"', '', '1456.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583460216000', '1582855416000', '1582874410000', '0000-00-00 00:00:00', '', '0', '20', 'To Be Delivered', '0', '0', '฿1456.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144090', 'A15828493849686', 'ORDINARY_ORDER', '1153622', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/653/547/11214745356_450914828.jpg\",\"quantity\":8,\"productId\":1222063,\"price\":65.44,\"title\":\"Vinimay ข้ามพรมแดนพิเศษสำหรับระเบิดขนถ่ายกาวเล็บแต่งเล็บเมจิกขนถ่ายเล็บแต่งเล็บพิเศษขนถ่ายครีมยาทาเล็บ\",\"skuI', '', '574.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583454185000', '1582849385000', '1582849398000', '0000-00-00 00:00:00', '', '0', '8', 'To Be Delivered', '0', '0', '฿574.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144089', 'A15828268540784', 'ORDINARY_ORDER', '1088760', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/112/826/11892628211_607849376.jpg\",\"quantity\":36,\"productId\":1339434,\"price\":28.44,\"title\":\"Mi Mi Leni เมคอัพรีมูฟเวอร์ 300ml น้ำยาล้างเครื่องสำอางสูตรอ่อนโยนไม่มีการระคายเคืองผิวหน้าทำความสะอาดลึกรอบ', '', '4049.00', '0', '0.00', '261.00', '9', 'PENDING_REVIEW', '1', '1583431654000', '1582826854000', '1582826859000', '0000-00-00 00:00:00', '', '0', '136', 'Wait Payment', '0', '0', '฿4049.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144088', 'A15828246950712', 'ORDINARY_ORDER', '1142337', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/694/049/9558940496_1439501637.jpg\",\"quantity\":1,\"productId\":1227071,\"price\":325.08,\"title\":\"ชุดผ้าปูเตียงผ้าลินินนอร์ดิกสไตล์นอร์ดิกที่เรียบง่ายชุดนักเรียนสี่ชิ้น 1.5 เมตร 1.2 เมตรหอพักนักเรียนสามชิ้น', '', '395.00', '0', '0.00', '70.00', '9', 'PAYSUCC', '1', '1583429495000', '1582824695000', '1582824700000', '0000-00-00 00:00:00', '', '0', '1', 'To Be Delivered', '0', '0', '฿395.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144087', 'A15828216990858', 'ORDINARY_ORDER', '1043431', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/101/488/11676884101_711410394.jpg\",\"quantity\":60,\"productId\":1384791,\"price\":5.33,\"title\":\"แฟน ๆ ขายส่ง Tianzhuo ดินสออัตโนมัติความหลากหลายของรูปแบบแขวนดินสอ 0.5 / 0.7 เด็กกิจกรรมดินสอด้านกด\",\"skuId\":', '', '374.00', '0', '0.00', '70.00', '9', 'PAYSUCC', '1', '1583426499000', '1582821699000', '1582821704000', '0000-00-00 00:00:00', '', '0', '60', 'To Be Delivered', '0', '0', '฿374.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144086', 'A15828215910400', 'ORDINARY_ORDER', '1065241', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/049/238/10761832940_1112063208.jpg\",\"quantity\":12,\"productId\":1155012,\"price\":92.21,\"title\":\"Short-sleeved t-shirt women\'s summer 2019 new Korean version of the loose wild half-sleeved jacket shirt in', '', '2002.00', '0', '0.00', '80.00', '9', 'CANCEL', '1', '1583426392000', '1582821592000', '1582821734000', '0000-00-00 00:00:00', 'A1000205', '0', '21', 'Cancelled', '0', '0', '฿2002.00', '', '', '', '', '0.00', '', null, '1582857588000', '1065241', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144085', 'A15828210463415', 'ORDINARY_ORDER', '1167823', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/575/440/9489044575_699823549.jpg\",\"quantity\":2,\"productId\":1215136,\"price\":285.22,\"title\":\"เวอร์ชั่นเกาหลีของฤดูใบไม้ผลิรองเท้ากีฬาระบายอากาศนักเรียนหญิงฮาราจูกุป่ารองเท้าผู้หญิงเก่าโรงงานรุ่นขายส่งโด', '', '670.00', '0', '0.00', '100.00', '9', 'PAYSUCC', '1', '1583425846000', '1582821046000', '1582821049000', '0000-00-00 00:00:00', '', '0', '2', 'To Be Delivered', '0', '0', '฿670.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144084', 'A15828168323397', 'ORDINARY_ORDER', '1171182', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/426/686/10910686624_204206876.jpg\",\"quantity\":11,\"productId\":1223007,\"price\":29.88,\"title\":\"ทำเล็บผ้าฝ้ายชิ้นไม่ขุยขนถ่ายยากผ้าฝ้ายทำความสะอาดผ้าฝ้ายชิ้นผ้าขนหนูล้างเล็บน้ำเล็บพิเศษผ้าขนหนูเล็บผ้าขนหน', '', '369.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583421633000', '1582816833000', '1582816838000', '0000-00-00 00:00:00', '', '0', '11', 'To Be Delivered', '0', '0', '฿369.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144083', 'A15828127433661', 'ORDINARY_ORDER', '1154950', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/586/737/10163737685_1256831650.jpg\",\"quantity\":11,\"productId\":1186077,\"price\":28.19,\"title\":\"อายแชโดว์ 10 สีแวววาวสูงแวววาวสิบสีที่ละเอียดอ่อนเคลือบมุกโลกสีอายแชโดว์สีส้มถาดกันน้ำกุหลาบทะเลทราย\",\"skuI', '', '365.00', '0', '0.00', '55.00', '', 'CANCEL', '1', '1583417543000', '1582812743000', '1582812743000', '0000-00-00 00:00:00', 'A1000201', '0', '11', 'Cancelled', '0', '0', '฿365.00', '', '', '', '', '0.00', '', null, '1582853963000', '1154950', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'false');
INSERT INTO `order` VALUES ('144082', 'A15828071775091', 'ORDINARY_ORDER', '1084900', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/404/798/11450897404_1661043951.jpg\",\"quantity\":3,\"productId\":1284467,\"price\":116.70,\"title\":\"ขายส่งกาแฟชานมถุงกรองเหล็กสไตล์ฮ่องกงแหวนดึงถุงชาถุงน่องเครือข่ายชาหลายมาตรฐานดึงผ้ากรองชา\",\"skuId\":\"128446', '', '1051.00', '0', '0.00', '100.00', '9', 'PAYSUCC', '1', '1583411977000', '1582807177000', '1582867889000', '0000-00-00 00:00:00', '', '0', '47', 'To Be Delivered', '0', '0', '฿1051.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144081', 'A15828035515401', 'ORDINARY_ORDER', '1023903', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/422/645/9480546224_42653761.jpg\",\"quantity\":2,\"productId\":1131816,\"price\":336.38,\"title\":\"การจับคู่สีสดคอวีต้นฤดูใบไม้ร่วงเสื้อกันหนาวไหลบ่าเข้ามาของนักเรียนหญิงเกาหลีหลวมเสื้อบาง ๆ 2018 เสื้อฤดูใบไม้', '', '743.00', '0', '0.00', '70.00', '9', 'PAYSUCC', '1', '1583408351000', '1582803551000', '1582803569000', '0000-00-00 00:00:00', '', '0', '2', 'To Be Delivered', '0', '0', '฿743.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144080', 'A15828004368697', 'ORDINARY_ORDER', '1124402', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/571/361/10458163175_555973190.jpg\",\"quantity\":20,\"productId\":1102801,\"price\":28.21,\"title\":\"เครื่องประดับโรงงานที่มา lavieen ขายส่งที่เรียบง่ายอารมณ์น่ารักสีฟ้าโอปอลกำไลเพศหญิง๖๒๓๙\",\"skuId\":\"110280100', '', '587.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583405236000', '1582800436000', '1582800452000', '0000-00-00 00:00:00', '', '0', '20', 'To Be Delivered', '0', '0', '฿587.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144079', 'A15827958573690', 'ORDINARY_ORDER', '1019684', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/289/794/9901497982_1231334969.jpg\",\"quantity\":15,\"productId\":1168814,\"price\":99.62,\"title\":\"กระเป๋าหญิง 2018 ถุงผ้าใบใหม่หญิงกระเป๋าสะพายกระเป๋า Messenger ถุงผ้าใบสีเขียวกระเป๋านักเรียนรุ่น\",\"skuId\":\"', '', '2634.00', '0', '0.00', '90.00', '6', 'PAYSUCC', '2', '1583400657000', '1582795857000', '1582796423000', '0000-00-00 00:00:00', '', '0', '25', 'To Be Delivered', '0', '0', '฿2634.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'TRANSFER', 'true');
INSERT INTO `order` VALUES ('144078', 'A15827942604106', 'ORDINARY_ORDER', '1069510', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/051/443/10527344150_765467379.jpg\",\"quantity\":165,\"productId\":1283410,\"price\":1.82,\"title\":\"5 กรัมกรัมตารางด้านล่างครีมครีมกล่องขวดตัวอย่างเครื่องสำอางตัวอย่างกล่องกล่องสี่เหลี่ยมเล็ก ๆ\",\"skuId\":\"1283', '', '795.00', '0', '0.00', '191.00', '9', 'PAYSUCC', '1', '1583399060000', '1582794260000', '1582794263000', '0000-00-00 00:00:00', '', '0', '345', 'To Be Delivered', '0', '0', '฿795.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144077', 'A15827923561764', 'ORDINARY_ORDER', '1069510', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/447/040/11224040744_149082906.jpg\",\"quantity\":71,\"productId\":1351737,\"price\":31.05,\"title\":\"3d ขนตาปลอมแต่งหน้าทุกวันจำลองธรรมชาติหนาต้นกำเนิดขนตานุ่มเริ่มต้นโรงงานอุปทานโดยตรงขายส่ง\",\"skuId\":\"1351737', '', '4113.00', '0', '0.00', '45.00', '9', 'PAYSUCC', '1', '1583397157000', '1582792356000', '1582793335000', '0000-00-00 00:00:00', '', '0', '131', 'To Be Delivered', '0', '0', '฿4113.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144076', 'A15827872556401', 'ORDINARY_ORDER', '1000835', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/452/175/11099571254_1563848373.jpg\",\"quantity\":10,\"productId\":1217001,\"price\":56.37,\"title\":\"สร้อยข้อมือยูนิคอร์นสีสันรุ้งสร้อยข้อมือตาข่ายสีแดงออกแบบเครื่องประดับนักศึกษา\",\"skuId\":\"1217001001\",\"attrs', '', '907.00', '0', '0.00', '70.00', '6', 'PAYSUCC', '2', '1583392056000', '1582787256000', '1582792078000', '0000-00-00 00:00:00', '', '0', '26', 'To Be Delivered', '0', '0', '฿907.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'TRANSFER', 'true');
INSERT INTO `order` VALUES ('144075', 'A15827849023014', 'ORDINARY_ORDER', '1027435', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/796/136/10790631697_844664585.jpg\",\"quantity\":5,\"productId\":1495912,\"price\":79.77,\"title\":\"Pop ball handle battery box holder aluminum film tow bar 70cm transparent matte holder balloon accessories fa', '', '680.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583389702000', '1582784902000', '1582784905000', '0000-00-00 00:00:00', '', '0', '56', 'To Be Delivered', '0', '0', '฿680.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144074', 'A15827829747028', 'ORDINARY_ORDER', '1081854', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/283/076/9684670382_1434930476.jpg\",\"quantity\":8,\"productId\":1241288,\"price\":38.21,\"title\":\"ROSALIND ยาทาเล็บเล็บเจล AliExpress ระเบิดรุ่นระเบิดการค้าต่างประเทศเล็บกาวข้ามพรมแดนสำหรับเล็บ\",\"skuId\":\"124', '', '356.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583387774000', '1582782974000', '1582782977000', '0000-00-00 00:00:00', '', '0', '8', 'To Be Delivered', '0', '0', '฿356.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144073', 'A15827827500803', 'ORDINARY_ORDER', '1081854', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/611/386/8743683116_451497216.jpg\",\"quantity\":4,\"productId\":1329790,\"price\":86.93,\"title\":\"ในฐานะที่เป็นยาทาเล็บกาวเพชรกาวส่องไฟ QQ ตุ๊กตาบาร์บี้กาวเล็บแววแฟลชเพชรกาวเล็บที่ถอดออกได้เป็นมิตรกับสิ่งแวดล', '', '398.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583387551000', '1582782751000', '1582782753000', '0000-00-00 00:00:00', '', '0', '4', 'To Be Delivered', '0', '0', '฿398.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144072', 'A15827757772702', 'ORDINARY_ORDER', '1013960', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/093/864/9344468390_2125187189.jpg\",\"quantity\":6,\"productId\":1112763,\"price\":55.24,\"title\":\"2018 ใหม่แฟชั่นฤดูใบไม้ร่วงของผู้หญิงกระเป๋าผ้าบิดล็อคถุงเล็ก ๆ สีทึบง่ายโซ่ญี่ปุ่นและเกาหลีไหล่เดี่ยวแพคเกจใ', '', '411.00', '0', '0.00', '80.00', '', 'CANCEL', '1', '1583380577000', '1582775777000', '1582775777000', '0000-00-00 00:00:00', 'A1000202', '0', '6', 'Cancelled', '0', '0', '฿411.00', '', '', '', '', '0.00', '', null, '1582775820000', '1013960', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'false');
INSERT INTO `order` VALUES ('144071', 'A15827712091184', 'ORDINARY_ORDER', '1137247', '0', '[{\"mainImage\":\"https://os.aopcdn.com/1582597837192.jpg\",\"quantity\":1,\"productId\":1486637,\"price\":1000.0,\"title\":\"Stainless 3-Piece Cookware Set\",\"skuId\":\"1486637001\",\"attrs\":\"Chinared,Three-piece suit: frying pan 24cm + stockpot 24cm + wok 32cm\"}]', '', '1000.00', '0', '0.00', '0.00', '', 'NEW', '1', '1583376009000', '1582771209000', '1582771209000', '0000-00-00 00:00:00', '', '0', '1', 'Wait Payment', '0', '0', '฿1000.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'true');
INSERT INTO `order` VALUES ('144070', 'A15827432606488', 'ORDINARY_ORDER', '1191396', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/012/466/10269664210_79719074.jpg\",\"quantity\":1,\"productId\":1135768,\"price\":2912.53,\"title\":\"MELROSE S9P รุ่นที่ปรับปรุง 4G Android มาร์ทโฟนบุคลิกภาพมินิไมโครบางเฉียบการ์ดขนาดเล็กโทรศัพท์มือถือ\",\"skuId', '', '2963.00', '0', '0.00', '50.00', '9', 'PENDING_REVIEW', '1', '1583348061000', '1582743261000', '1582743264000', '0000-00-00 00:00:00', '', '0', '1', 'Wait Payment', '0', '0', '฿2963.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144069', 'A15827431299742', 'ORDINARY_ORDER', '1191396', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/012/466/10269664210_79719074.jpg\",\"quantity\":1,\"productId\":1135768,\"price\":2912.53,\"title\":\"MELROSE S9P รุ่นที่ปรับปรุง 4G Android มาร์ทโฟนบุคลิกภาพมินิไมโครบางเฉียบการ์ดขนาดเล็กโทรศัพท์มือถือ\",\"skuId', '', '2963.00', '0', '0.00', '50.00', '9', 'PENDING_REVIEW', '1', '1583347929000', '1582743129000', '1582743161000', '0000-00-00 00:00:00', '', '0', '1', 'Wait Payment', '0', '0', '฿2963.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144068', 'A15827416842986', 'ORDINARY_ORDER', '1190839', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/635/799/10871997536_1110387669.jpg\",\"quantity\":4,\"productId\":1182568,\"price\":77.16,\"title\":\"2019 ฤดูใบไม้ผลิผอมเอวสูงกางเกงยืดหญิงเกาหลีกางเกงฮาเร็มป่าสวมใส่ด้านนอกหลวมหลาใหญ่ผอมไขมัน MM\",\"skuId\":\"118', '', '1592.00', '0', '0.00', '120.00', '9', 'PAYSUCC', '1', '1583346484000', '1582741684000', '1582797853000', '0000-00-00 00:00:00', '', '0', '15', 'To Be Delivered', '0', '0', '฿1592.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144067', 'A15827374650766', 'ORDINARY_ORDER', '1014623', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/100/711/11890117001_2064979949.jpg\",\"quantity\":10,\"productId\":1423264,\"price\":31.77,\"title\":\"2019 ข้ามพรมแดนใหม่ Amazon รุ่นระเบิดตัวอักษรภาษาอังกฤษโบราณ Babygirl สแตนเลสสร้อยคอต่างประเทศรุ่น\",\"skuId\"', '', '734.00', '0', '0.00', '70.00', '9', 'PAYSUCC', '1', '1583342266000', '1582737465000', '1582737468000', '0000-00-00 00:00:00', '', '0', '40', 'To Be Delivered', '0', '0', '฿734.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144066', 'A15827361136194', 'ORDINARY_ORDER', '1155042', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/068/318/10876813860_14842097.jpg\",\"quantity\":49,\"productId\":1225691,\"price\":6.15,\"title\":\"เครื่องล้างถังซักผ้าสำหรับเครื่องซักผ้าทุกชนิดด้านในเพื่อกำจัดสิ่งสกปรกจากโรงงานโดยตรงขายส่งรุ่นเดียว\",\"skuId\"', '', '705.00', '0', '0.00', '110.00', '9', 'PAYSUCC', '1', '1583340914000', '1582736114000', '1582736125000', '0000-00-00 00:00:00', '', '0', '57', 'To Be Delivered', '0', '0', '฿705.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144065', 'A15827292176847', 'ORDINARY_ORDER', '1009989', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/490/837/9587738094_1339703784.jpg\",\"quantity\":5,\"productId\":1095014,\"price\":97.71,\"title\":\"กระจกสำหรับแต่งหน้ารูปหัวใจหุ้มกรอบสีชมพู\",\"skuId\":\"1095014001\",\"attrs\":\"สีชมพู\"}]', '', '544.00', '0', '0.00', '55.00', '9', 'PAYSUCC', '1', '1583334017000', '1582729217000', '1582729220000', '0000-00-00 00:00:00', '', '0', '5', 'To Be Delivered', '0', '0', '฿544.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144064', 'A15827286284152', 'ORDINARY_ORDER', '1136126', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/360/365/12001563063_1308325897.jpg\",\"quantity\":40,\"productId\":1360026,\"price\":28.43,\"title\":\"เอสเซ้นส์บำรุงผิวหน้า Hansser Blood Orange 100ml\",\"skuId\":\"1360026001\",\"attrs\":\"เซรั่มบำรุงโลหิต Hansser Bl', '', '1924.00', '0', '0.00', '131.00', '9', 'PAYSUCC', '1', '1583333428000', '1582728628000', '1582781534000', '0000-00-00 00:00:00', '', '0', '80', 'To Be Delivered', '0', '0', '฿1924.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144063', 'A15827282166387', 'ORDINARY_ORDER', '1093253', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2017/064/668/4149866460_676195737.jpg\",\"quantity\":3,\"productId\":1150198,\"price\":101.26,\"title\":\"ลื่นที่ไม่มีสายหนังชุดแต่งงานครึ่งถ้วยไม่มีร่องรอยที่มองไม่เห็นความมหัศจรรย์ชุดชั้นในเปลือยรวบรวมสุดนวดชุดชั้', '', '354.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583333016000', '1582728216000', '1582728219000', '0000-00-00 00:00:00', '', '0', '3', 'To Be Delivered', '0', '0', '฿354.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144062', 'A15827281219017', 'ORDINARY_ORDER', '1094027', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/864/843/10171348468_1715710926.jpg\",\"quantity\":1,\"productId\":1121212,\"price\":559.39,\"title\":\"โรงงานผ้าไหมผลไม้เครื่องหน้ากากโฮมเมดบ้านอัตโนมัติอัจฉริยะ DIY ไวท์เทนนิ่งให้ความชุ่มชื้นเครื่องดนตรีความงา', '', '604.00', '0', '0.00', '45.00', '6', 'INTRACK', '2', '1583332922000', '1582728121000', '1582862921000', '0000-00-00 00:00:00', '', '0', '1', 'Shipped', '0', '0', '฿604.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ALL_PACKAGE', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'TRANSFER', 'false');
INSERT INTO `order` VALUES ('144061', 'A15827228430481', 'ORDINARY_ORDER', '1190632', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/218/065/11258560812_770716268.jpg\",\"quantity\":4,\"productId\":1270978,\"price\":81.72,\"title\":\"ผู้ชายในช่วงฤดูร้อนสภาพอากาศแขนสั้นเสื้อยืดห้าแบรนด์เกาหลีน้ำขึ้นน้ำลงหลวมป่าที่เรียบง่ายแนวโน้มแฟชั่นเสื้อผ้', '', '1606.00', '0', '0.00', '110.00', '6', 'PAYSUCC', '2', '1583327643000', '1582722843000', '1582771292000', '0000-00-00 00:00:00', '', '110', '24', 'To Be Delivered', '0', '0', '฿1606.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', 'b6eda10e3e0a4e47b95d478508a52d61', '', '', '', '0', '0', '', '', 'false', 'TRANSFER', 'true');
INSERT INTO `order` VALUES ('144060', 'A15827204351352', 'ORDINARY_ORDER', '1181822', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/518/286/10934682815_145368955.jpg\",\"quantity\":3,\"productId\":1203401,\"price\":370.39,\"title\":\"หยินชิคเนื้อย้อนยุค Messenger กระเป๋าสะพายไหล่หญิง 2019 คลื่นลูกใหม่ของเกาหลีป่าสายคล้องไหล่กว้างพกพาสี่เหลี', '', '1171.00', '0', '0.00', '60.00', '9', 'PENDING_REVIEW', '1', '1583325235000', '1582720435000', '1582720438000', '0000-00-00 00:00:00', '', '0', '3', 'Wait Payment', '0', '0', '฿1171.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144059', 'A15827203224682', 'ORDINARY_ORDER', '1083686', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/518/249/9248942815_702880060.jpg\",\"quantity\":50,\"productId\":1494268,\"price\":13.14,\"title\":\"แฟชั่นฤดูร้อนส่วนบางหน้ากากผ้าไหมน้ำแข็งหญิงครีมกันแดด UV ฝ้ายฝุ่นหน้ากากระบายอากาศน่ารักเกาหลี\",\"skuId\":\"149', '', '757.00', '0', '0.00', '100.00', '9', 'CANCEL', '1', '1583325122000', '1582720322000', '1582720326000', '0000-00-00 00:00:00', 'A1000503', '0', '50', 'Cancelled', '0', '0', '฿757.00', '', '', '', '', '0.00', '', null, '1582782420000', 'Erp-System', 'TH', '0000-00-00 00:00:00', '', 'ORDER_CANCEL', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144058', 'A15827153022981', 'ORDINARY_ORDER', '1176400', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/641/991/10769199146_565350807.jpg\",\"quantity\":2,\"productId\":1419542,\"price\":156.25,\"title\":\"กระทะเหล็ก, หยก, ไม่ติด, ไข่หนา, ไม่เคลือบผิว, กระทะแบนก้นญี่ปุ่น, ม้วนไข่หนา, หม้อไข่ทอด\",\"skuId\":\"14195420', '', '777.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583320103000', '1582715303000', '1582715306000', '0000-00-00 00:00:00', '', '0', '4', 'To Be Delivered', '0', '0', '฿777.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144057', 'A15827126753987', 'ORDINARY_ORDER', '1003800', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/605/074/8800470506_1089762827.jpg\",\"quantity\":10,\"productId\":1190930,\"price\":55.65,\"title\":\"สร้อยคอสตรี ห้อยจี้รูปผีเสื้อ\",\"skuId\":\"1190930001\",\"attrs\":\"OneSize\"}]', '', '607.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583317475000', '1582712675000', '1582712677000', '0000-00-00 00:00:00', '', '0', '10', 'To Be Delivered', '0', '0', '฿607.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144056', 'A15827102670298', 'ORDINARY_ORDER', '1117874', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2015/905/582/1978285509_490011509.jpg\",\"quantity\":10,\"productId\":1481998,\"price\":108.46,\"title\":\"ระฆังทารกเตียงแขวนผ้าของเล่นกล่องดนตรีเตียงแขวน\",\"skuId\":\"1481998001\",\"attrs\":\"สีชมพู\"},{\"mainImage\":\"https:', '', '2249.00', '0', '0.00', '80.00', '9', 'PENDING_REVIEW', '1', '1583315067000', '1582710267000', '1582710270000', '0000-00-00 00:00:00', '', '0', '20', 'Wait Payment', '0', '0', '฿2249.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144055', 'A15827087733073', 'ORDINARY_ORDER', '1027652', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/061/324/8740423160_282454669.jpg\",\"quantity\":4,\"productId\":1404059,\"price\":80.76,\"title\":\"ชุดนอนแขนสั้นหญิงฤดูร้อนนางสาววอร์มชุดสูทเวอร์ชั่นเกาหลีของผู้หญิงคอกลมชุดนอนผ้าไหมนมขายส่งรุ่น\",\"skuId\":\"1404', '', '387.00', '0', '0.00', '80.00', '6', 'NEW', '1', '1583313574000', '1582708773000', '1582708794000', '0000-00-00 00:00:00', '', '0', '4', 'Wait Payment', '0', '0', '฿387.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'TRANSFER', 'true');
INSERT INTO `order` VALUES ('144054', 'A15827061711173', 'ORDINARY_ORDER', '1131904', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/029/352/10438253920_134683661.jpg\",\"quantity\":26,\"productId\":1295459,\"price\":15.53,\"title\":\"Hanse gold nicotinamide stock solution 15ml ทองคำเปลว 24K เอสเซ้นส์ให้ความชุ่มชื่นแก่ผิว\",\"skuId\":\"129545900', '', '464.00', '0', '0.00', '60.00', '9', 'PAYSUCC', '1', '1583310972000', '1582706172000', '1582706176000', '0000-00-00 00:00:00', '', '0', '26', 'To Be Delivered', '0', '0', '฿464.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144053', 'A15827061303880', 'ORDINARY_ORDER', '1131904', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/029/352/10438253920_134683661.jpg\",\"quantity\":26,\"productId\":1295459,\"price\":15.53,\"title\":\"Hanse gold nicotinamide stock solution 15ml ทองคำเปลว 24K เอสเซ้นส์ให้ความชุ่มชื่นแก่ผิว\",\"skuId\":\"129545900', '', '464.00', '0', '0.00', '60.00', '', 'NEW', '1', '1583310930000', '1582706130000', '1582706130000', '0000-00-00 00:00:00', '', '0', '26', 'Wait Payment', '0', '0', '฿464.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'true');
INSERT INTO `order` VALUES ('144052', 'A15827021509928', 'ORDINARY_ORDER', '1124515', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/699/798/9248897996_702880060.jpg\",\"quantity\":20,\"productId\":1493884,\"price\":15.29,\"title\":\"รุ่นอัพเกรดของดาวสามมิติหน้ากากผ้าไหมน้ำแข็งผ้าไหมน้ำแข็ง\",\"skuId\":\"1493884003\",\"attrs\":\"สีชมพู\"},{\"mainImage', '', '690.00', '0', '0.00', '110.00', '9', 'CANCEL', '1', '1583306950000', '1582702150000', '1582702155000', '0000-00-00 00:00:00', 'A1000205', '0', '54', 'Cancelled', '0', '0', '฿690.00', '', '', '', '', '0.00', '', null, '1582708348000', '1124515', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144051', 'A15826993204059', 'ORDINARY_ORDER', '1191369', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/768/339/10519933867_68700971.jpg\",\"quantity\":2,\"productId\":1141241,\"price\":225.59,\"title\":\"2019 ฤดูร้อนคำหวานสลิงคอส่วนยาวที่ไม่มีสายหนังชีฟองดอกไม้วันหยุดชุดแกว่งใหญ่หญิง\",\"skuId\":\"1141241002\",\"attrs', '', '1116.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583304121000', '1582699320000', '1582707670000', '0000-00-00 00:00:00', '', '110', '4', 'To Be Delivered', '0', '0', '฿1116.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '268f3b5e18c548e28fb757ed8077d6f1', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144050', 'A15826980180736', 'ORDINARY_ORDER', '1124515', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/699/798/9248897996_702880060.jpg\",\"quantity\":20,\"productId\":1493884,\"price\":15.29,\"title\":\"รุ่นอัพเกรดของดาวสามมิติหน้ากากผ้าไหมน้ำแข็งผ้าไหมน้ำแข็ง\",\"skuId\":\"1493884003\",\"attrs\":\"สีชมพู\"},{\"mainImage', '', '690.00', '0', '0.00', '110.00', '9', 'CANCEL', '1', '1583302819000', '1582698018000', '1582698023000', '0000-00-00 00:00:00', 'A1000205', '0', '54', 'Cancelled', '0', '0', '฿690.00', '', '', '', '', '0.00', '', null, '1582700930000', '1124515', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144049', 'A15826950125754', 'ORDINARY_ORDER', '1083686', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2017/456/399/5282993654_1091200012.jpg\",\"quantity\":30,\"productId\":1450402,\"price\":10.99,\"title\":\"Debonding ทำเล็บพิเศษถอดเล็บเล็บขนถ่ายการฝึกซ้อมนอกเหนือไปจากกาวแท้ขนถ่ายขนตาสินบนตัวทำละลายขายส่ง\",\"skuId\":', '', '690.00', '0', '0.00', '100.00', '5', 'NEW', '1', '1583299812000', '1582695012000', '1582695022000', '0000-00-00 00:00:00', '', '0', '62', 'Wait Payment', '0', '0', '฿690.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'PAYPAL', 'true');
INSERT INTO `order` VALUES ('144048', 'A15826948028648', 'ORDINARY_ORDER', '1109248', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2017/744/927/6809729447_1904776824.jpg\",\"quantity\":69,\"productId\":1414842,\"price\":4.40,\"title\":\"ฮันเหว่ยหอยทากของเหลวคอลลาเจนทำให้ผิวนวลชุ่มชื้นเรียบหน้ากากหน้ากากผิวให้ความชุ่มชื่นสิวสดใสผิวขายตรงไมโครธุร', '', '994.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583299602000', '1582694802000', '1582694805000', '0000-00-00 00:00:00', '', '0', '83', 'To Be Delivered', '0', '0', '฿994.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144047', 'A15826915550701', 'ORDINARY_ORDER', '1178073', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/014/650/11075056410_1149871974.jpg\",\"quantity\":8,\"productId\":1480561,\"price\":61.86,\"title\":\"EXO TOO ฤดูร้อนรุ่นระเบิดเห็ดอากาศเบาะ BB C REAM คอนซีลเลอร์น้ำความงามครีม 20 กรัมเครื่องสำอางโรงงานขายตรง\",', '', '545.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583296356000', '1582691556000', '1582691564000', '0000-00-00 00:00:00', '', '0', '8', 'To Be Delivered', '0', '0', '฿545.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144046', 'A15826895657245', 'ORDINARY_ORDER', '1018542', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/741/541/11602145147_2011584070.jpg\",\"quantity\":20,\"productId\":1397940,\"price\":15.65,\"title\":\"ถุงเท้าหุ้มข้อลายการ์ตูนฮีโร่สุดชิคสไตล์เกาหลี มีหลากหลายลายให้เลือก\",\"skuId\":\"1397940001\",\"attrs\":\"จับคู่ ', '', '363.00', '0', '0.00', '50.00', '9', 'INTRACK', '1', '1583294366000', '1582689565000', '1582884441000', '0000-00-00 00:00:00', '', '0', '20', 'Shipped', '0', '0', '฿363.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ALL_PACKAGE', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144045', 'A15826887784079', 'ORDINARY_ORDER', '1018542', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/148/781/10280187841_209169175.jpg\",\"quantity\":22,\"productId\":1182630,\"price\":14.21,\"title\":\"ถุงเท้าหุ้มข้อสั้นมี 3 สีให้เลือก ขาว เทา ดำ Free Size\",\"skuId\":\"1182630001\",\"attrs\":\"สีดำและสีขาวและสีเทาผส', '', '695.00', '0', '0.00', '70.00', '9', 'INTRACK', '1', '1583293578000', '1582688778000', '1582884441000', '0000-00-00 00:00:00', '', '0', '44', 'Shipped', '0', '0', '฿695.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ALL_PACKAGE', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144044', 'A15826886137762', 'ORDINARY_ORDER', '1018542', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/448/373/9194373844_1557890765.jpg\",\"quantity\":19,\"productId\":1315335,\"price\":16.00,\"title\":\"ถุงเท้าหุ้มข้อสุดชิคสไตล์เกาหลี คละลาย มีหลายสี หลายลายให้เลือก Free Size\",\"skuId\":\"1315335001\",\"attrs\":\"ขนา', '', '354.00', '0', '0.00', '50.00', '9', 'INTRACK', '1', '1583293414000', '1582688613000', '1582787486000', '0000-00-00 00:00:00', '', '0', '19', 'Shipped', '0', '0', '฿354.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ALL_PACKAGE', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144043', 'A15826847367365', 'ORDINARY_ORDER', '1011636', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/068/318/10876813860_14842097.jpg\",\"quantity\":500,\"productId\":1225691,\"price\":6.15,\"title\":\"เครื่องล้างถังซักผ้าสำหรับเครื่องซักผ้าทุกชนิดด้านในเพื่อกำจัดสิ่งสกปรกจากโรงงานโดยตรงขายส่งรุ่นเดียว\",\"skuId', '', '3768.00', '0', '0.00', '693.00', '9', 'PAYSUCC', '1', '1583289537000', '1582684737000', '1582691500000', '0000-00-00 00:00:00', '', '0', '500', 'To Be Delivered', '0', '0', '฿3768.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144042', 'A15826846952301', 'ORDINARY_ORDER', '1011636', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/068/318/10876813860_14842097.jpg\",\"quantity\":1000,\"productId\":1225691,\"price\":6.15,\"title\":\"เครื่องล้างถังซักผ้าสำหรับเครื่องซักผ้าทุกชนิดด้านในเพื่อกำจัดสิ่งสกปรกจากโรงงานโดยตรงขายส่งรุ่นเดียว\",\"skuI', '', '7587.00', '0', '0.00', '1437.00', '', 'CANCEL', '1', '1583289495000', '1582684695000', '1582684695000', '0000-00-00 00:00:00', 'A1000203', '0', '1000', 'Cancelled', '0', '0', '฿7587.00', '', '', '', '', '0.00', '', null, '1582684711000', '1011636', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'false');
INSERT INTO `order` VALUES ('144041', 'A15826493379245', 'ORDINARY_ORDER', '1069813', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/844/099/11399990448_720927188.jpg\",\"quantity\":6,\"productId\":1185299,\"price\":112.26,\"title\":\"แก้วน้ำพลาสติกลายการ์ตูนน้องหมาพร้อมหลอดดูด+ฝาปิด\",\"skuId\":\"1185299001\",\"attrs\":\"301-400ml,ถ้วย + ฝาถ้วย + ฟ', '', '710.00', '0', '0.00', '70.00', '9', 'CANCEL', '1', '1583254138000', '1582649337000', '1582649344000', '0000-00-00 00:00:00', 'A1000503', '0', '6', 'Cancelled', '0', '0', '฿710.00', '', '', '', '', '0.00', '', null, '1582797746000', 'Erp-System', 'TH', '0000-00-00 00:00:00', '', 'ORDER_CANCEL', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144040', 'A15826489730344', 'ORDINARY_ORDER', '1108995', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/582/000/11115000285_1558196378.jpg\",\"quantity\":34,\"productId\":1304661,\"price\":8.97,\"title\":\"แบบพกพามินิมือทิ้งสบู่สบู่ขนาดเล็กกระดาษเดินทางกลางแจ้งยืนอุปกรณ์กระดาษสบู่กระดาษสบู่\",\"skuId\":\"1304661002\",', '', '385.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583253773000', '1582648973000', '1582648975000', '0000-00-00 00:00:00', '', '0', '34', 'To Be Delivered', '0', '0', '฿385.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144039', 'A15826489034410', 'ORDINARY_ORDER', '1108995', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/268/272/10275272862_704644627.jpg\",\"quantity\":67,\"productId\":1158948,\"price\":4.54,\"title\":\"มาส์กหน้าเพิ่มความชุ่มชื้นเติมน้ำให้ผิว มีให้เลือกถึง 4 สูตร\",\"skuId\":\"1158948001\",\"attrs\":\"มะนาวสดใสและบริสุ', '', '384.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583253704000', '1582648903000', '1582648915000', '0000-00-00 00:00:00', '', '0', '67', 'To Be Delivered', '0', '0', '฿384.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144038', 'A15826454488366', 'ORDINARY_ORDER', '1124402', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/337/433/9505334733_2018554361.jpg\",\"quantity\":17,\"productId\":1440789,\"price\":30.51,\"title\":\"หวานน่ารักกระต่ายน้อยสีขาวมุกสร้อยข้อมืออารมณ์ความรักที่เรียบง่ายรูปร่างนักศึกษาสาวลมสร้อยข้อมือที่ทำด้วยมือ', '', '543.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583250249000', '1582645448000', '1582645453000', '0000-00-00 00:00:00', '', '0', '17', 'To Be Delivered', '0', '0', '฿543.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144037', 'A15826421719312', 'ORDINARY_ORDER', '1135459', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/782/344/8549443287_410252092.jpg\",\"quantity\":40,\"productId\":1387574,\"price\":119.54,\"title\":\"E53 ใหม่เกาหลีเก๋ความจุขนาดใหญ่กระเป๋าสะพายสามตารางขั้นพื้นฐานในช่วงฤดูร้อนที่เรียบง่ายพิมพ์ถุงผ้าใบหญิง\",\"s', '', '4885.00', '0', '0.00', '103.00', '9', 'PAYSUCC', '1', '1583246971000', '1582642171000', '1582691541000', '0000-00-00 00:00:00', '', '0', '40', 'To Be Delivered', '0', '0', '฿4885.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144036', 'A15826419515916', 'ORDINARY_ORDER', '1135459', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/981/574/11057475189_2081503147.jpg\",\"quantity\":30,\"productId\":1173745,\"price\":136.16,\"title\":\"2019 ใหม่เก๋เกาหลียิ้มใบหน้าถุงผ้าใบไหล่เดี่ยวกระเป๋าช้อปปิ้งกระเป๋านักเรียนแบบพกพาอุปทานโรงงานโดยตรง\",\"sk', '', '4185.00', '0', '0.00', '100.00', '9', 'PAYSUCC', '1', '1583246751000', '1582641951000', '1582691521000', '0000-00-00 00:00:00', '', '0', '30', 'To Be Delivered', '0', '0', '฿4185.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144035', 'A15826415405045', 'ORDINARY_ORDER', '1104247', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2017/028/347/7665743820_2067091414.jpg\",\"quantity\":11,\"productId\":1434494,\"price\":54.95,\"title\":\"แยกแขนกุดนักเรียนสวมเซ็กซี่เกมเครื่องแบบนักเรียนสิ่งล่อใจเล่นตามบทบาทชุดชั้นในเซ็กซี่ขายส่ง\",\"skuId\":\"143449', '', '684.00', '0', '0.00', '80.00', '', 'CANCEL', '1', '1583246341000', '1582641540000', '1582641540000', '0000-00-00 00:00:00', 'A1000202', '0', '11', 'Cancelled', '0', '0', '฿684.00', '', '', '', '', '0.00', '', null, '1582641571000', '1104247', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'false');
INSERT INTO `order` VALUES ('144034', 'A15826339341403', 'ORDINARY_ORDER', '1174301', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/513/043/10719340315_964219921.jpg\",\"quantity\":28,\"productId\":1454438,\"price\":10.99,\"title\":\"สติกเกอร์บัญชีมือเกาหลีสร้างสรรค์น่ารักตัวละครชุดบัญชีมือวัสดุ DIY สติ๊กเกอร์ตกแต่งขายส่ง 3 แผ่น\",\"skuId\":\"1', '', '352.00', '0', '0.00', '50.00', '', 'NEW', '1', '1583238735000', '1582633935000', '1582633935000', '0000-00-00 00:00:00', '', '0', '28', 'Wait Payment', '0', '0', '฿352.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'true');
INSERT INTO `order` VALUES ('144033', 'A15826303627383', 'ORDINARY_ORDER', '1163290', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/283/256/9016652382_37161790.jpg\",\"quantity\":10,\"productId\":1097272,\"price\":74.52,\"title\":\"10ยูนิคอร์นแต่งหน้าแปรงสักคิ้วขาวผมเกลียวแต่งหน้าชุดมืออาชีพแต่งหน้าสีปรับแต่ง\",\"skuId\":\"1097272002\",\"attrs\":\"', '', '758.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583235162000', '1582630362000', '1582630366000', '0000-00-00 00:00:00', '', '0', '10', 'To Be Delivered', '0', '0', '฿758.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144032', 'A15826272494592', 'ORDINARY_ORDER', '1069510', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2016/985/800/3016008589_1769649754.jpg\",\"quantity\":16,\"productId\":1259020,\"price\":39.68,\"title\":\"เกาหลีแบบพกพาที่เก็บกระเป๋าเดินทางกระเป๋าสุภาพสตรีกันน้ำถุงเก็บกระเป๋าเดินทางธุรกิจล้างกระเป๋าเครื่องสำอางง่', '', '2471.00', '0', '0.00', '100.00', '9', 'PENDING_REVIEW', '1', '1583232049000', '1582627249000', '1582627251000', '0000-00-00 00:00:00', '', '0', '43', 'Wait Payment', '0', '0', '฿2471.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144031', 'A15826233364247', 'ORDINARY_ORDER', '1191244', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/179/260/10227062971_958827814.jpg\",\"quantity\":4,\"productId\":1125208,\"price\":81.72,\"title\":\"โรงงานขายส่ง 2019 ฤดูใบไม้ผลิและฤดูร้อนแขนสั้นผู้หญิงเสื้อยืดเสื้อเสื้อ bottoming Taobao ไมโครธุรกิจตัวแทนแจ็', '', '981.00', '0', '0.00', '60.00', '9', 'CANCEL', '1', '1583228137000', '1582623337000', '1582623535000', '0000-00-00 00:00:00', 'A1000503', '60', '12', 'Cancelled', '0', '0', '฿981.00', '', '', '', '', '0.00', '', null, '1582798263000', 'Erp-System', 'TH', '0000-00-00 00:00:00', '', 'ORDER_CANCEL', '', '', '', 'dedf1de559064385a6107c722d09d325', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144030', 'A15826228946252', 'ORDINARY_ORDER', '1136126', '0', '[{\"mainImage\":\"https://os.aopcdn.com/1582597837192.jpg\",\"quantity\":1,\"productId\":1486637,\"price\":1000.0,\"title\":\"ชุดเครื่องครัวสเตนเลสสตีล 3 ชิ้น\",\"skuId\":\"1486637001\",\"attrs\":\"สีแดงจีน,ชุดสูทสามชิ้น: กระทะ 24 ซม. + stockpot 24 ซม. + กระทะ 32 ซม\"}]', '', '1000.00', '0', '0.00', '0.00', '', 'NEW', '1', '1583227694000', '1582622894000', '1582622894000', '0000-00-00 00:00:00', '', '0', '1', 'Wait Payment', '0', '0', '฿1000.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'true');
INSERT INTO `order` VALUES ('144029', 'A15826132549397', 'ORDINARY_ORDER', '1084614', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/948/392/11458293849_584388597.jpg\",\"quantity\":15,\"productId\":1375685,\"price\":20.66,\"title\":\"Tide brand necklace women\'s tide ins hip-hop cool long European and American pendant chain accessories whole', '', '360.00', '0', '0.00', '50.00', '6', 'PAYSUCC', '2', '1583218054000', '1582613254000', '1582617219000', '0000-00-00 00:00:00', '', '0', '15', 'To Be Delivered', '0', '0', '฿360.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'TRANSFER', 'true');
INSERT INTO `order` VALUES ('144028', 'A15826059930599', 'ORDINARY_ORDER', '1018719', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/530/699/11208996035_364356864.jpg\",\"quantity\":15,\"productId\":1480348,\"price\":40.66,\"title\":\"ไทเทเนียมเหล็กเคลือบทองเพชรรักจี้สร้อยคอต่างหูชุดเครื่องประดับเพชรหัวใจข้ามชายแดน\",\"skuId\":\"1480348001\",\"att', '', '690.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583210793000', '1582605993000', '1582605996000', '0000-00-00 00:00:00', '', '0', '15', 'To Be Delivered', '0', '0', '฿690.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144027', 'A15826057854708', 'ORDINARY_ORDER', '1018719', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/293/009/11797900392_793437558.jpg\",\"quantity\":11,\"productId\":1399431,\"price\":27.64,\"title\":\"ยุโรปและสหรัฐอเมริกาข้ามพรมแดนเครื่องประดับมือใหม่สร้างสรรค์ย้อนยุคที่เรียบง่ายแบรนด์ใหญ่ลมมุกรักสร้อยข้อมือ', '', '678.00', '0', '0.00', '70.00', '9', 'CANCEL', '1', '1583210586000', '1582605785000', '1582605789000', '0000-00-00 00:00:00', 'A1000203', '0', '22', 'Cancelled', '0', '0', '฿678.00', '', '', '', '', '0.00', '', null, '1582732072000', '1018719', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144026', 'A15826053284495', 'ORDINARY_ORDER', '1018719', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2017/291/233/4001332192_793437558.jpg\",\"quantity\":10,\"productId\":1370171,\"price\":82.92,\"title\":\"ยุโรปและอเมริกาแฟชั่นโอ้อวดคริสตัลเครื่องประดับเจ้าสาวสร้อยคอต่างหูชุดสี่ชิ้น AliExpress บูติกเครื่องประดับขา', '', '909.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583210129000', '1582605328000', '1582605331000', '0000-00-00 00:00:00', '', '0', '10', 'To Be Delivered', '0', '0', '฿909.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144025', 'A15826051803688', 'ORDINARY_ORDER', '1018719', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/986/784/11317487689_756654166.jpg\",\"quantity\":10,\"productId\":1422747,\"price\":83.64,\"title\":\"รุ่นระเบิดเกาหลีใต้ต่างหูสร้อยคอเหล็กไทเทเนียมตั้งตัวเลขโรมันจี้สแตนเลสผู้ผลิตต่างหูสร้อยคอขายส่ง\",\"skuId\":\"', '', '916.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583209981000', '1582605180000', '1582605186000', '0000-00-00 00:00:00', '', '0', '10', 'To Be Delivered', '0', '0', '฿916.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144024', 'A15826048647095', 'ORDINARY_ORDER', '1018719', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/896/363/10205363698_1009129682.jpg\",\"quantity\":4,\"productId\":1283431,\"price\":92.73,\"title\":\"ระเบิดการค้าต่างประเทศยุโรปและอเมริกา AliExpress / อีเบย์เซ็กซี่ลูกไม้สายรัดเปลือย jumpsuit ชุดว่ายน้ำบิกินี', '', '1193.00', '0', '0.00', '80.00', '9', 'CANCEL', '1', '1583209665000', '1582604864000', '1582604868000', '0000-00-00 00:00:00', 'A1000203', '0', '12', 'Cancelled', '0', '0', '฿1193.00', '', '', '', '', '0.00', '', null, '1582683805000', '1018719', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144023', 'A15826042572288', 'ORDINARY_ORDER', '1018719', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/051/156/11363651150_1255285543.jpg\",\"quantity\":12,\"productId\":1290032,\"price\":25.38,\"title\":\"แมวเจ็ดสีใหม่โรงงานโดยตรงเซ็กซี่ชุดชั้นในชุดชั้นในสิ่งล่อใจรุ่นของชุดนอนเซ็กซี่ของผู้หญิง\",\"skuId\":\"1290032', '', '719.00', '0', '0.00', '110.00', '9', 'CANCEL', '1', '1583209057000', '1582604257000', '1582604265000', '0000-00-00 00:00:00', 'A1000203', '0', '24', 'Cancelled', '0', '0', '฿719.00', '', '', '', '', '0.00', '', null, '1582606455000', '1018719', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144022', 'A15826003798800', 'ORDINARY_ORDER', '1125149', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/262/084/11151480262_529239801.jpg\",\"quantity\":50,\"productId\":1330559,\"price\":38.70,\"title\":\"อายแชโดว์รุ่น Super Fire 15 สีสีแดงกับสีแดงลายเสือดาวเหมาะสำหรับผู้เริ่มต้นจากโรงงานโดยตรง\",\"skuId\":\"1330559', '', '2046.00', '0', '0.00', '111.00', '9', 'PAYSUCC', '1', '1583205179000', '1582600379000', '1582600525000', '0000-00-00 00:00:00', '', '0', '50', 'To Be Delivered', '0', '0', '฿2046.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144021', 'A15825978850960', 'ORDINARY_ORDER', '1191160', '0', '[{\"mainImage\":\"https://os.aopcdn.com/1575859075964.jpg\",\"quantity\":1,\"productId\":1474727,\"price\":1000.0,\"title\":\"เจลมาส์กหน้าที่อุดมไปด้วยคอลลาเจนและมอยเจอร์ไรซ์เซอร์ 2 กล่อง\",\"skuId\":\"1474727001\",\"attrs\":\"รวม 2 กล่อง\"}]', '', '1000.00', '0', '0.00', '0.00', '', 'NEW', '1', '1583202686000', '1582597885000', '1582597885000', '0000-00-00 00:00:00', '', '0', '1', 'Wait Payment', '0', '0', '฿1000.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'true');
INSERT INTO `order` VALUES ('144020', 'A15825883339983', 'ORDINARY_ORDER', '1135748', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/658/206/10242602856_87127959.jpg\",\"quantity\":3,\"productId\":1166500,\"price\":147.86,\"title\":\"Pico ดัดขนตาไฟฟ้าไฟฟ้าติดทนนานมินิแบบพกพาดัดขนตาใหม่สร้างสรรค์ดัดขนตาขายส่ง\",\"skuId\":\"1166500001\",\"attrs\":\"เน', '', '471.00', '0', '0.00', '50.00', '9', 'CANCEL', '1', '1583193134000', '1582588334000', '1582588355000', '0000-00-00 00:00:00', 'A1000205', '0', '3', 'Cancelled', '0', '0', '฿471.00', '', '', '', '', '0.00', '', null, '1582588371000', '1135748', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144019', 'A15825624522991', 'ORDINARY_ORDER', '1000195', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/396/264/11414462693_1318014952.jpg\",\"quantity\":3,\"productId\":1331928,\"price\":234.09,\"title\":\"สาว 1/2 ถ้วยผ้าฝ้ายกิริยาชุดชั้นในหน้าอกเล็กหญิงไม่มีขอบชุดชั้นในบางย้อนยุคครึ่งถ้วยนักเรียนงามกลับ\",\"skuId', '', '749.00', '0', '0.00', '50.00', '', 'NEW', '1', '1583167253000', '1582562452000', '1582562452000', '0000-00-00 00:00:00', '', '0', '3', 'Wait Payment', '0', '0', '฿749.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'true');
INSERT INTO `order` VALUES ('144018', 'A15825616003969', 'ORDINARY_ORDER', '1178915', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/097/399/10347993790_1112063208.jpg\",\"quantity\":5,\"productId\":1191571,\"price\":74.30,\"title\":\"เสื้อแฟชั่นเกาหลี เสื้อ Over Size มี 3 สี ขาว เทา ดำ （S/ M /L /XL）\",\"skuId\":\"1191571010\",\"attrs\":\"M,ขาว 9908', '', '422.00', '0', '0.00', '50.00', '', 'CANCEL', '1', '1583166401000', '1582561600000', '1582561600000', '0000-00-00 00:00:00', 'A1000202', '0', '5', 'Cancelled', '0', '0', '฿422.00', '', '', '', '', '0.00', '', null, '1582561620000', '1178915', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', '', 'false');
INSERT INTO `order` VALUES ('144017', 'A15825588560921', 'ORDINARY_ORDER', '1069480', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/093/987/11864789390_365841345.jpg\",\"quantity\":2,\"productId\":1435760,\"price\":161.40,\"title\":\"ใหม่กางเกงยีนส์เอวสูงหญิงเกาหลีสวมใส่กางเกงผู้หญิงขนาดใหญ่ยืดกางเกงดินสอบางแน่นถุงน่อง\",\"skuId\":\"1435760007\"', '', '393.00', '0', '0.00', '70.00', '9', 'CANCEL', '1', '1583163657000', '1582558856000', '1582558863000', '0000-00-00 00:00:00', 'A1000503', '0', '2', 'Cancelled', '0', '0', '฿393.00', '', '', '', '', '0.00', '', null, '1582625940000', 'Erp-System', 'TH', '0000-00-00 00:00:00', '', 'ORDER_CANCEL', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144016', 'A15825572499580', 'ORDINARY_ORDER', '1028966', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/364/197/10353791463_1419194072.jpg\",\"quantity\":10,\"productId\":1182268,\"price\":30.82,\"title\":\"DNM ขนาดเล็กหลอดทองคอนซีลเลอร์ปกสิวเครื่องหมายแผลเป็นรอยสักรอยคล้ำฝ้ากระมูลนิธิเหลวข้ามพรมแดน 14 สีตัวเลือก', '', '995.00', '0', '0.00', '70.00', '9', 'PAYSUCC', '1', '1583162050000', '1582557250000', '1582557265000', '0000-00-00 00:00:00', '', '0', '30', 'To Be Delivered', '0', '0', '฿995.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144015', 'A15825568829650', 'ORDINARY_ORDER', '1127626', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/006/941/10147149600_1813472780.jpg\",\"quantity\":5,\"productId\":1146924,\"price\":68.37,\"title\":\"2019 ชาใหม่ West Lake Longjing Longjing ชาชาเขียวชาสนับสนุนขายส่งคลิกเดียวรุ่น\",\"skuId\":\"1146924001\",\"attrs\"', '', '817.00', '0', '0.00', '100.00', '9', 'PAYSUCC', '1', '1583161683000', '1582556883000', '1582556887000', '0000-00-00 00:00:00', '', '0', '7', 'To Be Delivered', '0', '0', '฿817.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144014', 'A15825532692783', 'ORDINARY_ORDER', '1026692', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2017/248/746/4297647842_426497174.jpg\",\"quantity\":30,\"productId\":1156294,\"price\":10.27,\"title\":\"ถุงเท้าหุ้มข้อผู้หญิง ใส่ง่ายนุ่มสบายเหมาะกับหลายๆโอกาส\",\"skuId\":\"1156294001\",\"attrs\":\"ขนาดเดียว,5 สีมีผมทั้ง', '', '1618.00', '0', '0.00', '80.00', '9', 'PAYSUCC', '1', '1583158069000', '1582553269000', '1582781662000', '0000-00-00 00:00:00', '', '0', '132', 'To Be Delivered', '0', '0', '฿1618.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144013', 'A15825500392051', 'ORDINARY_ORDER', '1028029', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/057/838/11442838750_1242536146.jpg\",\"quantity\":14,\"productId\":1216346,\"price\":22.69,\"title\":\"Huanling Mengli ตุ๊กตา 3D จริงความงามตา 16 ซม. DJD เปลี่ยนแต่งหน้าตุ๊กตาร่างกาย Burberry ตุ๊กตาสีกล้ามเนื้อ', '', '680.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583154839000', '1582550039000', '1582550045000', '0000-00-00 00:00:00', '', '0', '25', 'To Be Delivered', '0', '0', '฿680.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144012', 'A15825466337094', 'ORDINARY_ORDER', '1091024', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/320/076/8719670023_402479132.jpg\",\"quantity\":16,\"productId\":1229543,\"price\":19.76,\"title\":\"mosquito น้ำยาไล่ยุงไฟฟ้าในครัวเรือนน้ำหอมยากันยุงน้ำยากันยุงไม่มีกลิ่นน้ำส่งชุดเครื่องทำความร้อน\",\"skuId\":\"1', '', '366.00', '0', '0.00', '50.00', '9', 'INTRACK', '1', '1583151434000', '1582546633000', '1582603748000', '0000-00-00 00:00:00', '', '0', '16', 'Shipped', '0', '0', '฿366.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ALL_PACKAGE', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144011', 'A15825466128302', 'ORDINARY_ORDER', '1091024', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/320/076/8719670023_402479132.jpg\",\"quantity\":20,\"productId\":1229543,\"price\":19.76,\"title\":\"mosquito น้ำยาไล่ยุงไฟฟ้าในครัวเรือนน้ำหอมยากันยุงน้ำยากันยุงไม่มีกลิ่นน้ำส่งชุดเครื่องทำความร้อน\",\"skuId\":\"1', '', '439.00', '0', '0.00', '50.00', '9', 'CANCEL', '1', '1583151413000', '1582546612000', '1582708295000', '0000-00-00 00:00:00', 'A1000203', '0', '20', 'Cancelled', '0', '0', '฿439.00', '', '', '', '', '0.00', '', null, '1582708324000', '1091024', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'false');
INSERT INTO `order` VALUES ('144010', 'A15825456403891', 'ORDINARY_ORDER', '1021492', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/925/747/10617747529_1595671832.jpg\",\"quantity\":8,\"productId\":1298424,\"price\":37.63,\"title\":\"ฟองออกซิเจนห้องน้ำน้ำยาทำความสะอาดกระเบื้องแก้วขนาดฟองทำความสะอาดขจัดคราบสกปรกที่แข็งแกร่งขจัดคราบตะกรัน\",\"s', '', '401.00', '0', '0.00', '100.00', '9', 'PAYSUCC', '1', '1583150440000', '1582545640000', '1582545669000', '0000-00-00 00:00:00', '', '0', '8', 'To Be Delivered', '0', '0', '฿401.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144009', 'A15825412693966', 'ORDINARY_ORDER', '1190928', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/729/600/10511006927_996761267.jpg\",\"quantity\":2,\"productId\":1186681,\"price\":152.29,\"title\":\"ฤดูร้อนใหม่แฟชั่นเกาหลีกระเป๋าเอวสูงสะโพกกระเป๋าเอวสูงกระโปรงยีนส์กระโปรงสั้นสีทึบกระโปรงคำน้ำหญิง\",\"skuId\":', '', '6369.00', '0', '0.00', '160.00', '', 'CANCEL', '1', '1583146070000', '1582541270000', '1582541270000', '0000-00-00 00:00:00', 'A1000202', '160', '33', 'Cancelled', '0', '0', '฿6369.00', '', '', '', '', '0.00', '', null, '1582541296000', '1190928', 'TH', '0000-00-00 00:00:00', '', '', '', '', '', '0ee1397f5b19485abf73bf096ccde9b6', '', '', '', '0', '0', '', '', 'false', '', 'false');
INSERT INTO `order` VALUES ('144008', 'A15825387821924', 'ORDINARY_ORDER', '1087350', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/854/964/10594469458_472470698.jpg\",\"quantity\":5,\"productId\":1210887,\"price\":61.50,\"title\":\"A สปริงใหม่ทองเลดี้หน้ากากตาชุ่มชื้นชุ่มชื้นวงกลมสีดำแพนด้าตาทองตาหน้ากาก 60 สติกเกอร์ / 30 คู่\",\"skuId\":\"121', '', '342.00', '0', '0.00', '50.00', '9', 'PAYSUCC', '1', '1583143583000', '1582538782000', '1582538786000', '0000-00-00 00:00:00', '', '0', '5', 'To Be Delivered', '0', '0', '฿342.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');
INSERT INTO `order` VALUES ('144007', 'A15825374257412', 'ORDINARY_ORDER', '1022593', '0', '[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/118/531/10575135811_1659606264.jpg\",\"quantity\":13,\"productId\":1209637,\"price\":66.91,\"title\":\"ไฟ LED สตริงลูกกลมไฟคริสต์มาสไฟกระพริบ Amazon Dragon Ball แบตเตอรี่กล่องไฟสตริงแต่งงานไฟวันหยุด\",\"skuId\":\"1', '', '930.00', '0', '0.00', '60.00', '9', 'PAYSUCC', '1', '1583142225000', '1582537425000', '1582537429000', '0000-00-00 00:00:00', '', '0', '13', 'To Be Delivered', '0', '0', '฿930.00', '', '', '', '', '0.00', '', null, '', '', 'TH', '0000-00-00 00:00:00', '', 'ENTER_SUCCESS', '', '', '', '', '', '', '', '0', '0', '', '', 'false', 'COD', 'true');

-- ----------------------------
-- Table structure for page
-- ----------------------------
DROP TABLE IF EXISTS `page`;
CREATE TABLE `page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '0',
  `pid` varchar(30) NOT NULL,
  `createTime` bigint(20) NOT NULL,
  `content` text,
  `updateTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of page
-- ----------------------------
INSERT INTO `page` VALUES ('1', '测2试页', '这是一个测试页\r\n', 'h5.fhk255.cn/ufjnh87hp1o', '1', 'ufjnh87hp1o', '1584893790000', '[{\"type\":\"banner\",\"title\":\"轮播图\",\"color\":\"#FFFFFF\",\"isShowTitle\":false,\"background\":\"rgba(0, 0, 0, 0.07)\",\"postion\":\"bottom\",\"height\":\"200\",\"data\":[{\"id\":\"oigsusmhd3\",\"title\":\"joker\",\"image\":\"http://project.fhk255.cn/media/5.jpg\"}],\"id\":\"7tngc3rfo6\"},{\"type\":\"product\",\"title\":\"推荐商品\",\"itemType\":\"50%\",\"isShowTitle\":true,\"showBtn\":\"1\",\"showRemark\":\"1\",\"showPrice\":\"1\",\"showTitle\":\"1\",\"color\":\"#9D3D3D\",\"background\":\"rgba(0,0,0,0.13)\",\"data\":[{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/389/598/13075895983_1960059920.jpg\",\"title_zh\":\"新款潮流气质百搭耳骨夹女士简约个性无耳洞耳夹耳挂批发\",\"id\":1144024,\"remark\":\"11\",\"priceRange\":7.4626,\"link\":\"baidu.com\"},{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/451/477/12789774154_1228803637.jpg\",\"title_zh\":\"速卖通爆款锆石耳环不锈钢耳骨钉欧美微镶太阳花螺丝耳朵穿刺批发\",\"id\":1144012,\"remark\":\"11\",\"priceRange\":0.7672,\"link\":\"baidu.com\"},{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2018/678/148/9617841876_1069880368.jpg\",\"title_zh\":\"莫特瑞 美甲店专用光疗甲油胶蔻丹芭比美甲指甲油胶持久40天\",\"id\":1144008,\"remark\":\"122\",\"priceRange\":0.591,\"link\":\"baidu.com\"},{\"mainImage\":\"https://cbu01.alicdn.com/img/ibank/2019/851/140/12253041158_875394864.jpg\",\"title_zh\":\"新款针织触屏手套女冬季韩版加厚小鹿毛线手套\",\"id\":1144007,\"remark\":\"33\",\"priceRange\":2.3582,\"link\":\"opshop.com\"}],\"id\":\"uhm5elpttbo\"}]', '1585224364000');
INSERT INTO `page` VALUES ('6', '测试页', '', '', '0', 'lg3l0jebumo', '1585110089501', '[{\"type\":\"product\",\"title\":\"商品列表\",\"itemType\":\"50%\",\"isShowTitle\":true,\"showBtn\":\"1\",\"showRemark\":\"1\",\"showPrice\":\"1\",\"showTitle\":\"1\",\"color\":\"#333\",\"background\":\"rgba(0,0,0,0.13)\",\"data\":[],\"id\":\"3hahtd8bqg8\"},{\"type\":\"banner\",\"title\":\"轮播图\",\"color\":\"#333\",\"isShowTitle\":true,\"background\":\"rgba(0,0,0,0.13)\",\"postion\":\"bottom\",\"height\":\"200\",\"data\":[],\"id\":\"lq171c014n\"},{\"type\":\"title\",\"title\":\"公告\",\"isShowTitle\":true,\"data\":{\"content\":\"默认文本\",\"color\":\"#333333\",\"background\":\"#ffffff\",\"textAlign\":\"left\",\"fontWeight\":\"normal\",\"fontSize\":\"14px\",\"paddingLeftRight\":0,\"paddingTopBottom\":0,\"margin\":\"\"},\"id\":\"p7391th39tg\"}]', '1585111988000');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `fromUrl` varchar(255) NOT NULL,
  `updateTime` bigint(20) NOT NULL,
  `createTime` bigint(20) NOT NULL,
  `desc` text,
  `inPrice` varchar(255) DEFAULT NULL COMMENT '进货价',
  `outPrice` varchar(255) DEFAULT NULL COMMENT '销售价',
  `status` int(1) DEFAULT '1' COMMENT '状态',
  `mainImage` varchar(255) DEFAULT NULL COMMENT '主图',
  `shopId` int(11) DEFAULT NULL,
  `categoryId` varchar(255) DEFAULT NULL,
  `from` varchar(255) DEFAULT NULL,
  `subTitle` varchar(255) DEFAULT NULL,
  `propList` text,
  `images` varchar(255) DEFAULT NULL,
  `attrList` text,
  `tag` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1144040 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1144024', '新款潮流气质百搭耳骨夹女士简约个性无耳洞耳夹耳挂批发', 'https://detail.1688.com/offer/610415517942.html?', '2020', '2020', 'New trendy temperament wild ear bone clip ladies simple personality no pierced ear clip ear hook wholesale', '4.4776', '3.7313', '1', 'https://cbu01.alicdn.com/img/ibank/2019/389/598/13075895983_1960059920.jpg', '65924', 'General -> 1688 -> 耳夹', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144013', '新款弧形椭圆钢化玻璃手机壳适用苹果11Pro/OPPOReno2/VIVOS1/V30', 'https://detail.1688.com/offer/563151816211.html?', '2020', '2020', 'New curved oval tempered glass phone case for Apple 11Pro / OPPOReno2 / VIVOS1 / V30', '0.5374-1.5224', '0.4478', '0', 'https://cbu01.alicdn.com/img/ibank/2019/349/668/13052866943_352634785.jpg', '65921', 'General -> 1688 -> 手机保护套', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144012', '速卖通爆款锆石耳环不锈钢耳骨钉欧美微镶太阳花螺丝耳朵穿刺批发', 'https://detail.1688.com/offer/596448266225.html?', '2020', '2020', 'AliExpress Explosion Style Zircon Earrings Stainless Steel Ear Bone Studs European and American Micro-Set Sunflower Screw Ear Piercing', '0.4603-0.9725', '0.3836', '1', 'https://cbu01.alicdn.com/img/ibank/2019/451/477/12789774154_1228803637.jpg', '65920', 'Apparel & Accessories -> Clothing Accessories -> Balaclavas', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144008', '莫特瑞 美甲店专用光疗甲油胶蔻丹芭比美甲指甲油胶持久40天', 'https://detail.1688.com/offer/564782453735.html?', '2019', '2019', 'Mortray Nail Polish Dedicated Nail Polish Gel', '0.3546-0.5015', '0.2955', '1', 'https://cbu01.alicdn.com/img/ibank/2018/678/148/9617841876_1069880368.jpg', '65916', 'General -> 1688 -> 甲油胶', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144007', '新款针织触屏手套女冬季韩版加厚小鹿毛线手套', 'https://detail.1688.com/offer/605107717900.html?', '2019', '2019', 'New Knitted Touchscreen Gloves Female Winter Korean Thicken Fawn Wool Gloves', '1.4149', '1.1791', '1', 'https://cbu01.alicdn.com/img/ibank/2019/851/140/12253041158_875394864.jpg', '65915', 'General -> 1688 -> 成人手套', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144006', '狗窝可拆洗 泰迪卡通宠物窝 宠物用品 大型犬金毛狗床狗垫子批发', 'https://detail.1688.com/offer/526228423192.html?', '2019', '2019', 'Dog kennel removable and washable Teddy cartoon pet kennel pet supplies large dog golden retriever dog bed dog mat wholesale', '3.3672-12.1792', '2.806', '1', 'https://cbu01.alicdn.com/img/ibank/2017/377/455/4582554773_813356358.jpg', '65914', 'General -> 1688 -> 狗狗窝、笼', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144005', '【男女袜多款式可选】袜子女短袜子四季款棉透气男士船袜女士袜子', 'https://detail.1688.com/offer/574437693492.html?', '2019', '2019', '[men and women socks more styles available] socks female short socks four seasons cotton breathable men\'s boat socks ladies socks', '0.0895-0.1343', '0.0746', '0', 'https://cbu01.alicdn.com/img/ibank/2019/757/444/11417444757_442655963.jpg', '65913', 'VIP', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144004', '盒装抽纸定做酒店银行保险抽取式餐巾纸定做印logo广告纸巾定制', 'https://detail.1688.com/offer/591674846945.html?', '2019', '2019', 'Boxed paper custom hotel bank insurance removable napkins custom printed logo advertising paper towel custom', '0.1164-0.1523', '0.097', '0', 'https://cbu01.alicdn.com/img/ibank/2019/105/171/11722171501_878688472.jpg', '65912', 'VIP', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144003', '冬新款13cm恨天高松糕厚底弹力绒内增高显瘦女靴水钻过膝长筒靴', 'https://detail.1688.com/offer/580499195894.html?', '2019', '2019', 'Winter new 13cm hate sky high sponge cake thick bottom stretch velvet increase high thin women\'s boots rhinestones over the knee boots', '16.2985-21.6716', '0', '1', 'https://cbu01.alicdn.com/img/ibank/2018/983/124/9533421389_81353897.jpg', '65911', 'VIP', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144002', '跨境货源LOGO可定制USB背包休闲商务男包笔记本双肩包一件代发', 'https://detail.1688.com/offer/595435329502.html?', '2019', '2019', 'Cross-border supply LOGO customizable USB backpack casual business men\'s bag notebook backpack one generation', '4.8359-5.1941', '4.0299', '1', 'https://cbu01.alicdn.com/img/ibank/2019/578/232/12073232875_604889811.jpg', '65910', 'VIP', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144001', '故宫 金桂浮月挂饰钥匙扣包挂送礼礼品故宫博物院官方旗舰店', 'https://detail.tmall.com/item.htm?id=602826511597', '2019', '2019', 'Forbidden City Jingui Floating Moon Hanging Keychain Bag Hanging Gift Gifts Palace Museum Official Flagship Store', '11.8208', '9.8507', '0', 'http://img.alicdn.com/bao/uploaded/i4/2893966855/O1CN0143D5MS20VdaYlqH8o_!!0-item_pic.jpg', '65909', 'VIP', 'tmall', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144000', '亚马逊宠物碗双碗防滑不锈钢狗碗 糖果色狗食盆圆形两用猫碗', 'https://detail.1688.com/offer/1017228275.html?', '2019', '2019', 'Amazon pet bowl double bowl non-slip stainless steel dog bowl candy color dog food bowl round dual-use cat bowl', '0.7075-2.597', '0.5896', '1', 'https://cbu01.alicdn.com/img/ibank/2018/252/678/9051876252_973676538.jpg', '65908', 'VIP', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1143999', '35连30连马卡龙模具 不粘曲奇饼干模具曲奇烤盘 电烤箱烘焙模具', 'https://detail.1688.com/offer/598008516338.html?', '2019', '2019', '35 even30 even macaron mold non-stick cookie mold cookie baking tray electric oven baking mold', '2.8298-3.009', '2.3582', '1', 'https://cbu01.alicdn.com/img/ibank/2019/869/082/11485280968_1529814816.jpg', '65907', 'VIP', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1143998', '工厂批发定做 可重复使用疫苗/血浆/奶制品运输冷链冰袋冰包', 'https://detail.1688.com/offer/561993785449.html?', '2019', '2019', 'Factory wholesale custom Reusable vaccine / plasma / dairy transport cold chain ice pack ice pack', '0.3941-0.4477', '0.3284', '1', 'https://cbu01.alicdn.com/img/ibank/2017/901/919/7190919109_1031885222.jpg', '65906', 'VIP', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1143997', '帽子男女秋冬天韩版潮人棒球帽百搭休闲潮牌时尚嘻哈鸭舌帽渔夫帽', 'https://detail.1688.com/offer/584238072916.html?', '2019', '2019', 'Hat men and women autumn and winter Korean version of the tide baseball cap wild casual tide brand fashion hip hop cap fisherman hat', '0.8956-1.0746', '0.7463', '1', 'https://cbu01.alicdn.com/img/ibank/2018/263/920/10126029362_1648360977.jpg', '65905', 'VIP', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1143996', '美国king糖果王国新款电子烟油烟味水果味大烟雾秒杀果酱怪兽', 'https://detail.1688.com/offer/591441685940.html?', '2019', '2019', 'United States king candy kingdom new electronic cigarette oil smoke flavor fruit flavor big smoke spike jam monster', '', '37313432.8358', '1', 'https://cbu01.alicdn.com/img/ibank/2019/253/255/10798552352_963618484.jpg', '0', 'VIP', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1143916', '彩色极简双头马克笔', '', '2019', '2019', 'Mark pen', '102.9851', '85.8209', '1', '', '12', 'General -> nome -> 文体礼品>马克笔', 'nome', null, null, null, null, null);
INSERT INTO `product` VALUES ('1143915', '水磨圆碗', '', '2019', '2019', '阿斯蒂芬', '3.7612', '3.1343', '1', '', '12', 'General -> nome -> 家居生活>陶瓷杯', 'nome', null, null, null, null, null);
INSERT INTO `product` VALUES ('1143914', '新款无钢圈性感文胸聚拢小胸上托少女胸罩无痕美背调整型侧收抹胸', 'https://detail.1688.com/offer/591114098006.html?', '2019', '2019', 'New non-steel sexy bra gathered small chest on the girl bra without traces beautiful back adjustment side chest tube', '2.1492-2.5075', '1.791', '1', 'https://cbu01.alicdn.com/img/ibank/2019/033/038/10760830330_1267726488.jpg', '65897', 'Sporting Goods -> Outdoor Recreation -> Hunting & Shooting -> Paintball & Airsoft -> Paintball -> Paintball Gun Parts & Accessories -> Paintball Hoppers', '1688', null, null, null, null, null);
INSERT INTO `product` VALUES ('1143911', '水磨圆碗', '', '2019', '2019', '阿斯蒂芬', '3.7612', '3.1343', '1', '', '0', 'General -> nome -> 家居生活>陶瓷杯', 'nome', null, null, null, null, null);
INSERT INTO `product` VALUES ('1143912', '彩色极简双头马克笔', '', '2019', '2019', 'Mark pen', '102.9851', '85.8209', '1', '', '0', 'General -> nome -> 文体礼品>马克笔', 'nome', null, null, null, null, null);
INSERT INTO `product` VALUES ('1144026', '\"66\"', '\"66\"', '0', '0', '\"<p>6</p><p>6</p><p>6</p><p>1</p><p>1</p><p>1</p><p>1</p><p>11</p><p>2</p><p>3</p><p>12</p><p>312</p><p>3</p><p>123</p><p>123</p><p>1</p><p>312</p><p>3</p><p>123</p><p>123</p><p>12</p><p>312</p><p>312</p><p>3</p><p>123</p><p>123</p><p>12</p><p>31</p><p>23</p><p>123</p><p>123</p><p>12</p><p>3</p>\"', '\"\"', '\"2\"', '1', '\"\"', null, '1', null, '\"66\"', '[{\"key\":\"材质\",\"value\":\"塑料\"},{\"key\":\"保质期\",\"value\":\"2018\"}]', '[\"http://img.fhk255.cn/product/2020046/15861697104261685x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861697142514283x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861697198781704x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144027', '\"66\"', '\"66\"', '0', '0', '\"<p>6</p><p>6</p><p>6</p><p>1</p><p>1</p><p>1</p><p>1</p><p>11</p><p>2</p><p>3</p><p>12</p><p>312</p><p>3</p><p>123</p><p>123</p><p>1</p><p>312</p><p>3</p><p>123</p><p>123</p><p>12</p><p>312</p><p>312</p><p>3</p><p>123</p><p>123</p><p>12</p><p>31</p><p>23</p><p>123</p><p>123</p><p>12</p><p>3</p>\"', '\"\"', '\"2\"', '1', '\"\"', null, null, null, '\"66\"', '[{\"key\":\"材质\",\"value\":\"塑料\"},{\"key\":\"保质期\",\"value\":\"2018\"}]', '[\"http://img.fhk255.cn/product/2020046/15861697104261685x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861697142514283x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861697198781704x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144028', '66', '66', '0', '0', '<p>6</p><p>6</p><p>6</p><p>1</p><p>1</p><p>1</p><p>1</p><p>11</p><p>2</p><p>3</p><p>12</p><p>312</p><p>3</p><p>123</p><p>123</p><p>1</p><p>312</p><p>3</p><p>123</p><p>123</p><p>12</p><p>312</p><p>312</p><p>3</p><p>123</p><p>123</p><p>12</p><p>31</p><p>23</p><p>123</p><p>123</p><p>12</p><p>3</p>', '', '2', '1', '', null, '1', null, '66', '[{\"key\":\"材质\",\"value\":\"塑料\"},{\"key\":\"保质期\",\"value\":\"2018\"}]', '[\"http://img.fhk255.cn/product/2020046/15861697104261685x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861697142514283x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861697198781704x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144029', '标题', 'ffff', '0', '0', '<p>哒哒哒哒哒哒多多</p><p>dddd</p><p><br></p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p><br></p>', '', '', '1', '', null, null, null, '副标题', '[{\"key\":\"材质\",\"value\":\"塑料\"}]', '[\"http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144030', '标题', 'ffff', '0', '0', '<p>哒哒哒哒哒哒多多</p><p>dddd</p><p><br></p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p><br></p>', '', '', '1', '', null, null, null, '副标题', '[{\"key\":\"材质\",\"value\":\"塑料\"}]', '[\"http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144031', '标题', 'ffff', '0', '0', '<p>哒哒哒哒哒哒多多</p><p>dddd</p><p><br></p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p><br></p>', '', '', '1', '', null, null, null, '副标题', '[{\"key\":\"材质\",\"value\":\"塑料\"}]', '[\"http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144032', '标题', 'ffff', '0', '0', '<p>哒哒哒哒哒哒多多</p><p>dddd</p><p><br></p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p><br></p>', '', '', '1', '', null, '15', null, '副标题', '[{\"key\":\"材质\",\"value\":\"塑料\"}]', '[\"http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144033', '标题', 'ffff', '0', '0', '<p>哒哒哒哒哒哒多多</p><p>dddd</p><p><br></p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p><br></p>', '', '', '1', '', null, null, null, '副标题', '[{\"key\":\"材质\",\"value\":\"塑料\"}]', '[\"http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144034', '标题', 'ffff', '1586187373601', '0', '<p>哒哒哒哒哒哒多多</p><p>dddd</p><p><br></p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p><br></p>', '', '', '1', '', '0', '2', 'null', '副标题', '[{\"key\":\"材质\",\"value\":\"塑料\"}]', '[\"http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144035', '标题', 'ffff', '1586186951118', '0', '<p>哒哒哒哒哒哒多多</p><p>dddd</p><p><br></p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p><br></p>', '', '', '1', '', '0', 'null', 'null', '副标题', '[object Object]', '[\"http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144036', '标题', 'ffff', '1586185741195', '0', '<p>哒哒哒哒哒哒多多</p><p>dddd</p><p><br></p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p>1</p><p><br></p>', '', '2', '1', '', '0', 'null', 'null', '副标题', '[object Object]', '[\"http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144037', '商品标题', '地址', '0', '0', '<p>6</p><p>66</p><p>666</p><p>66</p><p>66</p><p>66</p><p>66</p>', '', '22', '1', '', null, '23', null, '副标题', '[{\"key\":\"材质\",\"value\":\"塑料\"}]', '[\"http://img.fhk255.cn/product/2020046/15861831056516287x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861831091518486x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144038', '商品标题1', '地址', '1586185307566', '0', '<p>6</p><p>66</p><p>666</p><p>66</p><p>66</p><p>66</p><p>66</p>', '', '22', '1', '', '0', '8', 'null', '副标题', '[object Object]', '[\"http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg\"]', '[]', '[]');
INSERT INTO `product` VALUES ('1144039', '商品标题', '地址1', '2020', '0', '<p>6</p><p>66</p><p>666</p><p>66</p><p>66</p><p>66</p><p>66</p>', '', '22', '1', '', '0', '7', 'null', '副标题1', '[object Object]', '[\"http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg\",\"http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg\"]', '[]', '[]');

-- ----------------------------
-- Table structure for qr_login
-- ----------------------------
DROP TABLE IF EXISTS `qr_login`;
CREATE TABLE `qr_login` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `timer` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qr_login
-- ----------------------------
INSERT INTO `qr_login` VALUES ('hmshdn2ssb8', null, '1585827520000');

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`value`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('1', 'product::', '0', '商品模块', null, '1585029273000', '1585029580000');
INSERT INTO `resource` VALUES ('2', 'product::list::', '1', '商品列表', null, '1585029273000', '1585046449000');
INSERT INTO `resource` VALUES ('3', 'product::list::edit', '2', '编辑商品', null, '1585029273000', '1585029581000');
INSERT INTO `resource` VALUES ('4', 'product::list::remove', '2', '删除商品', null, '1585029273000', '1585029582000');
INSERT INTO `resource` VALUES ('5', 'product::list::status', '2', '切换状态', null, '1585029273000', '1585029582000');
INSERT INTO `resource` VALUES ('6', 'product::shop::', '1', '店铺列表', null, '1585029273000', '1585046575000');
INSERT INTO `resource` VALUES ('7', 'product::shop::edit', '6', '编辑店铺', null, '1585029273000', '1585029583000');
INSERT INTO `resource` VALUES ('8', 'product::shop::remove', '6', '删除店铺', null, '1585029273000', '1585029584000');
INSERT INTO `resource` VALUES ('9', 'product::shop::add', '6', '添加店铺', null, '1585029273000', '1585029585000');
INSERT INTO `resource` VALUES ('10', 'product::details::', '1', '商品详情', null, '1585029273000', '1585029586000');
INSERT INTO `resource` VALUES ('11', 'product::shop::skuStatus', '10', 'SKU上下架', null, '1585029273000', null);
INSERT INTO `resource` VALUES ('12', 'product::details::editJianJie', '10', '编辑简介', null, '1585029294000', null);
INSERT INTO `resource` VALUES ('13', 'product::details::editDetails', '10', '编辑详情', null, '1585029307000', null);
INSERT INTO `resource` VALUES ('14', 'product::details::save', '10', '保存按钮', null, '1585029317000', null);
INSERT INTO `resource` VALUES ('15', 'order::', '0', '订单模块', null, '1585029337000', '1585029346000');
INSERT INTO `resource` VALUES ('16', 'order::list::', '15', '订单列表', null, '1585029365000', '1585046580000');
INSERT INTO `resource` VALUES ('17', 'order::list::cancel', '16', '取消订单', null, '1585029380000', null);
INSERT INTO `resource` VALUES ('18', 'competence::', '0', '权限模块', null, '1585029397000', null);
INSERT INTO `resource` VALUES ('19', 'competence::user::', '18', '用户列表', null, '1585029414000', null);
INSERT INTO `resource` VALUES ('20', 'competence::user::edit', '19', '编辑用户', null, '1585029434000', null);
INSERT INTO `resource` VALUES ('21', 'competence::user::remove', '19', '删除用户', null, '1585029455000', null);
INSERT INTO `resource` VALUES ('22', 'competence::user::add', '19', '添加用户', null, '1585029460000', null);
INSERT INTO `resource` VALUES ('23', 'competence::user::status', '19', '冻结用户', null, '1585029477000', null);
INSERT INTO `resource` VALUES ('24', 'competence-role::', '18', '角色列表', null, '1585029488000', null);
INSERT INTO `resource` VALUES ('25', 'competence::role::edit', '24', '编辑角色', null, '1585029503000', null);
INSERT INTO `resource` VALUES ('26', 'competence::role::remove', '24', '删除角色', null, '1585029518000', '1585029530000');
INSERT INTO `resource` VALUES ('27', 'competence::role::add', '24', '添加角色', null, '1585029529000', '1585029536000');
INSERT INTO `resource` VALUES ('28', 'competence::role::menu', '24', '设置菜单', null, '1585029556000', null);
INSERT INTO `resource` VALUES ('29', 'competence::role::resource', '24', '设置资源', null, '1585029559000', '1585029573000');
INSERT INTO `resource` VALUES ('30', 'h5::', '0', 'H5模块', null, '1585049195000', '1585049360000');
INSERT INTO `resource` VALUES ('31', 'h5::list::', '30', 'H5列表', null, '1585049480000', null);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `resource` text,
  `menu` longtext,
  `createTime` bigint(20) DEFAULT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `createUser` varchar(255) DEFAULT NULL,
  `createUserId` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10006 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('9999', '超级管理员', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29', '1,2,3,4,23,5,6,7,8,9,10,11,12,13,14,15,19,20,21,22', '1582107045000', '1585816191000', 'admin', '10000', '一看就很拽');
INSERT INTO `role` VALUES ('10000', '普通用户', '3,5,7,9,10,11,12,13,14,20,23,25', '1,2,3,4,5,6,7,9,10,13,14,15', '1582107045000', '1585732032000', 'admin', '10000', '苦逼1');
INSERT INTO `role` VALUES ('8888', '体验账号', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,19,20', '1585547587000', '1585732014000', 'admin', '10000', '');

-- ----------------------------
-- Table structure for skulist
-- ----------------------------
DROP TABLE IF EXISTS `skulist`;
CREATE TABLE `skulist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `inPrice` decimal(10,2) DEFAULT NULL,
  `outPrice` decimal(10,2) DEFAULT NULL,
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) NOT NULL,
  `status` int(1) DEFAULT '0',
  `imgUrl` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL COMMENT '库存',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of skulist
-- ----------------------------
INSERT INTO `skulist` VALUES ('1', '1144034', '小', '1.00', '2.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg', '1');
INSERT INTO `skulist` VALUES ('2', '1144035', '小', '1.00', '2.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg', '1');
INSERT INTO `skulist` VALUES ('3', '1144035', '中', '2.00', '3.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg', '2');
INSERT INTO `skulist` VALUES ('4', '1144036', '小', '1.00', '2.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861734468825692x240.jpg', '1');
INSERT INTO `skulist` VALUES ('5', '1144036', '中', '2.00', '3.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861734502104912x240.jpg', '2');
INSERT INTO `skulist` VALUES ('6', '1144037', '小', '22.00', '34.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861831056516287x240.jpg', '1');
INSERT INTO `skulist` VALUES ('7', '1144037', '中', '22.00', '34.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861831091518486x240.jpg', '2');
INSERT INTO `skulist` VALUES ('8', '1144038', '小', '22.00', '34.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861831056516287x240.jpg', '1');
INSERT INTO `skulist` VALUES ('9', '1144038', '中', '22.00', '341.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861831091518486x240.jpg', '2');
INSERT INTO `skulist` VALUES ('10', '1144039', '小', '22.00', '34.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861831056516287x240.jpg', '1');
INSERT INTO `skulist` VALUES ('11', '1144039', '中', '22.00', '34.00', '0', '0', '0', 'http://img.fhk255.cn/product/2020046/15861831091518486x240.jpg', '2');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '123456',
  `mail` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  `phone` varchar(255) DEFAULT NULL,
  `nickName` varchar(255) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `role` varchar(255) NOT NULL DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  `lastLogin` bigint(20) DEFAULT NULL,
  `createUser` varchar(255) DEFAULT NULL,
  `createUserId` int(11) DEFAULT '10000',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10003 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('10000', 'admin', '123456', '215537936@qq.com', '215537936', '1', '13226627208', 'Joker', '1584878000000', '1585884860000', '9999', '超级管理员', '1586156034093', 'ADMIN', '10000');
INSERT INTO `user` VALUES ('10001', 'joker', '123456', '3', '', '1', '22222', 'FHK', '1584878000000', '1585731778000', '10000', '普通用户', '1585534641027', 'Joker', '10000');
INSERT INTO `user` VALUES ('9999', 'test', 'fhk255.cn/test', null, null, '1', null, '体验者账号', '1585547569000', '1585737268000', '8888', '体验账号', '1585737268898', null, '10000');
DROP TRIGGER IF EXISTS `image_create_time`;
DELIMITER ;;
CREATE TRIGGER `image_create_time` BEFORE INSERT ON `image` FOR EACH ROW SET new.createTime = unix_timestamp(now())*1000
;
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `menu_create_time`;
DELIMITER ;;
CREATE TRIGGER `menu_create_time` BEFORE INSERT ON `menu` FOR EACH ROW SET new.createTime = unix_timestamp(now())*1000;
;;
DELIMITER ;
