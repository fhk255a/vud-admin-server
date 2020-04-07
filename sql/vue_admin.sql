/*
Navicat MySQL Data Transfer

Source Server         : vue_admin
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : vue_admin

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2020-04-07 20:01:48
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
  `ids` varchar(255) DEFAULT NULL COMMENT '连续的id',
  `level` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM AUTO_INCREMENT=1144077 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for productimage
-- ----------------------------
DROP TABLE IF EXISTS `productimage`;
CREATE TABLE `productimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) NOT NULL,
  `serverPath` varchar(255) DEFAULT NULL,
  `fileName` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `size` double DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

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
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '店铺id',
  `name` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `from` varchar(255) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `productCount` int(10) DEFAULT NULL,
  `score` double(3,0) DEFAULT NULL COMMENT '分数',
  `status` int(1) NOT NULL DEFAULT '1',
  `updateTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

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
-- Function structure for getChildList
-- ----------------------------
DROP FUNCTION IF EXISTS `getChildList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getChildList`(rootId INT) RETURNS varchar(1000) CHARSET utf8
BEGIN 
	 DECLARE pTemp VARCHAR(1000);  
	 DECLARE cTemp VARCHAR(1000);  #两个临时变量
	
	 SET pTemp = '$';  
	 SET cTemp =cast(rootId as CHAR);  #把rootId强制转换为字符。
	
	 WHILE cTemp is not null DO  
		 SET pTemp = concat(pTemp,',',cTemp);  #把所有节点连接成字符串。
		 SELECT group_concat(id) INTO cTemp FROM tmpcity   
		 WHERE FIND_IN_SET(parentId,cTemp)>0;
	 END WHILE;  
	 RETURN pTemp; 
 END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `image_create_time`;
DELIMITER ;;
CREATE TRIGGER `image_create_time` BEFORE INSERT ON `image` FOR EACH ROW SET new.createTime = unix_timestamp(now())*1000
;
;;
DELIMITER ;
