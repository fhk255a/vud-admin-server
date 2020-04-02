/*
Navicat MySQL Data Transfer

Source Server         : vue_admin
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : vue_admin

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2020-04-01 19:42:31
*/

SET FOREIGN_KEY_CHECKS=0;

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
DROP TRIGGER IF EXISTS `qr_login_end_time`;
DELIMITER ;;
CREATE TRIGGER `qr_login_end_time` BEFORE INSERT ON `qr_login` FOR EACH ROW SET new.timer = (unix_timestamp(now())+30)*1000
;;
DELIMITER ;
