/*
Navicat MySQL Data Transfer

Source Server         : hk_blog
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : vue_admin

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2020-03-29 17:09:49
*/

SET FOREIGN_KEY_CHECKS=0;

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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
DROP TRIGGER IF EXISTS `image_create_time`;
DELIMITER ;;
CREATE TRIGGER `image_create_time` BEFORE INSERT ON `image` FOR EACH ROW SET new.createTime = unix_timestamp(now())*1000
;
;;
DELIMITER ;
