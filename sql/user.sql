/*
Navicat MySQL Data Transfer

Source Server         : vue_admin
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : vue_admin

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2020-04-08 17:38:06
*/

SET FOREIGN_KEY_CHECKS=0;

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
INSERT INTO `user` VALUES ('10000', 'admin', '123456', '215537936@qq.com', '215537936', '1', '13226627208', 'Joker', '1584878000000', '1585884860000', '9999', '超级管理员', '1586332592577', 'ADMIN', '10000');
INSERT INTO `user` VALUES ('10001', 'joker', '123456', '3', '', '1', '22222', 'FHK', '1584878000000', '1585731778000', '10000', '普通用户', '1585534641027', 'Joker', '10000');
INSERT INTO `user` VALUES ('9999', 'test', 'fhk255.cn/test', null, null, '1', null, '体验者账号', '1585547569000', '1585737268000', '8888', '体验账号', '1585737268898', null, '10000');
