/*
Navicat MySQL Data Transfer

Source Server         : hk_blog
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : vue_admin

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2020-04-20 00:32:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for express
-- ----------------------------
DROP TABLE IF EXISTS `express`;
CREATE TABLE `express` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) DEFAULT NULL,
  `expressName` varchar(255) DEFAULT NULL,
  `expressNo` varchar(255) DEFAULT NULL,
  `expressPrice` double(10,2) DEFAULT NULL,
  `createTime` bigint(255) DEFAULT NULL,
  `endTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of express
-- ----------------------------
INSERT INTO `express` VALUES ('1', '100003', 'shunfeng', '2222', '222.00', '1587292109942', null);
