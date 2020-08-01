/*
 Navicat Premium Data Transfer

 Source Server         : aliyun
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 47.102.117.126:3306
 Source Schema         : curriculum

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 01/08/2020 22:26:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=291 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for clickLog
-- ----------------------------
DROP TABLE IF EXISTS `clickLog`;
CREATE TABLE `clickLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courseId` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `course_id` (`courseId`) USING BTREE,
  KEY `user_id` (`userId`) USING BTREE,
  CONSTRAINT `course_id` FOREIGN KEY (`courseId`) REFERENCES `webCourses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `user_id` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for cluster
-- ----------------------------
DROP TABLE IF EXISTS `cluster`;
CREATE TABLE `cluster` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for curriculum
-- ----------------------------
DROP TABLE IF EXISTS `curriculum`;
CREATE TABLE `curriculum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `week` int(11) DEFAULT NULL,
  `start` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `teacherName` varchar(255) DEFAULT NULL,
  `room` varchar(255) DEFAULT NULL,
  `courseNo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `课表-用户` (`userId`) USING BTREE,
  CONSTRAINT `课表-用户` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=486 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `courseId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `couse` (`courseId`) USING BTREE,
  KEY `user` (`userId`) USING BTREE,
  CONSTRAINT `couse` FOREIGN KEY (`courseId`) REFERENCES `webCourses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for groups
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `school` varchar(255) DEFAULT NULL,
  `courseNo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) DEFAULT NULL,
  `fromUser` int(11) DEFAULT NULL,
  `toGroup` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `togroup` (`toGroup`) USING BTREE,
  KEY `from` (`fromUser`) USING BTREE,
  CONSTRAINT `from` FOREIGN KEY (`fromUser`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `togroup` FOREIGN KEY (`toGroup`) REFERENCES `groups` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=544 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity
-- ----------------------------
DROP TABLE IF EXISTS `similarity`;
CREATE TABLE `similarity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC
/*!50100 PARTITION BY KEY (id)
(PARTITION p0 ENGINE = InnoDB,
 PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB) */;

-- ----------------------------
-- Table structure for similarity1
-- ----------------------------
DROP TABLE IF EXISTS `similarity1`;
CREATE TABLE `similarity1` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity10
-- ----------------------------
DROP TABLE IF EXISTS `similarity10`;
CREATE TABLE `similarity10` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity100
-- ----------------------------
DROP TABLE IF EXISTS `similarity100`;
CREATE TABLE `similarity100` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity11
-- ----------------------------
DROP TABLE IF EXISTS `similarity11`;
CREATE TABLE `similarity11` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity12
-- ----------------------------
DROP TABLE IF EXISTS `similarity12`;
CREATE TABLE `similarity12` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity13
-- ----------------------------
DROP TABLE IF EXISTS `similarity13`;
CREATE TABLE `similarity13` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity14
-- ----------------------------
DROP TABLE IF EXISTS `similarity14`;
CREATE TABLE `similarity14` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity15
-- ----------------------------
DROP TABLE IF EXISTS `similarity15`;
CREATE TABLE `similarity15` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity16
-- ----------------------------
DROP TABLE IF EXISTS `similarity16`;
CREATE TABLE `similarity16` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity17
-- ----------------------------
DROP TABLE IF EXISTS `similarity17`;
CREATE TABLE `similarity17` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity18
-- ----------------------------
DROP TABLE IF EXISTS `similarity18`;
CREATE TABLE `similarity18` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity19
-- ----------------------------
DROP TABLE IF EXISTS `similarity19`;
CREATE TABLE `similarity19` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity2
-- ----------------------------
DROP TABLE IF EXISTS `similarity2`;
CREATE TABLE `similarity2` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity20
-- ----------------------------
DROP TABLE IF EXISTS `similarity20`;
CREATE TABLE `similarity20` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity21
-- ----------------------------
DROP TABLE IF EXISTS `similarity21`;
CREATE TABLE `similarity21` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity22
-- ----------------------------
DROP TABLE IF EXISTS `similarity22`;
CREATE TABLE `similarity22` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity23
-- ----------------------------
DROP TABLE IF EXISTS `similarity23`;
CREATE TABLE `similarity23` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity24
-- ----------------------------
DROP TABLE IF EXISTS `similarity24`;
CREATE TABLE `similarity24` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity25
-- ----------------------------
DROP TABLE IF EXISTS `similarity25`;
CREATE TABLE `similarity25` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity26
-- ----------------------------
DROP TABLE IF EXISTS `similarity26`;
CREATE TABLE `similarity26` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity27
-- ----------------------------
DROP TABLE IF EXISTS `similarity27`;
CREATE TABLE `similarity27` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity28
-- ----------------------------
DROP TABLE IF EXISTS `similarity28`;
CREATE TABLE `similarity28` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity29
-- ----------------------------
DROP TABLE IF EXISTS `similarity29`;
CREATE TABLE `similarity29` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity3
-- ----------------------------
DROP TABLE IF EXISTS `similarity3`;
CREATE TABLE `similarity3` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity30
-- ----------------------------
DROP TABLE IF EXISTS `similarity30`;
CREATE TABLE `similarity30` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity31
-- ----------------------------
DROP TABLE IF EXISTS `similarity31`;
CREATE TABLE `similarity31` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity32
-- ----------------------------
DROP TABLE IF EXISTS `similarity32`;
CREATE TABLE `similarity32` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity33
-- ----------------------------
DROP TABLE IF EXISTS `similarity33`;
CREATE TABLE `similarity33` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity34
-- ----------------------------
DROP TABLE IF EXISTS `similarity34`;
CREATE TABLE `similarity34` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity35
-- ----------------------------
DROP TABLE IF EXISTS `similarity35`;
CREATE TABLE `similarity35` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity36
-- ----------------------------
DROP TABLE IF EXISTS `similarity36`;
CREATE TABLE `similarity36` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity37
-- ----------------------------
DROP TABLE IF EXISTS `similarity37`;
CREATE TABLE `similarity37` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity38
-- ----------------------------
DROP TABLE IF EXISTS `similarity38`;
CREATE TABLE `similarity38` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity39
-- ----------------------------
DROP TABLE IF EXISTS `similarity39`;
CREATE TABLE `similarity39` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity4
-- ----------------------------
DROP TABLE IF EXISTS `similarity4`;
CREATE TABLE `similarity4` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity40
-- ----------------------------
DROP TABLE IF EXISTS `similarity40`;
CREATE TABLE `similarity40` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity41
-- ----------------------------
DROP TABLE IF EXISTS `similarity41`;
CREATE TABLE `similarity41` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity42
-- ----------------------------
DROP TABLE IF EXISTS `similarity42`;
CREATE TABLE `similarity42` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity43
-- ----------------------------
DROP TABLE IF EXISTS `similarity43`;
CREATE TABLE `similarity43` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity44
-- ----------------------------
DROP TABLE IF EXISTS `similarity44`;
CREATE TABLE `similarity44` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity45
-- ----------------------------
DROP TABLE IF EXISTS `similarity45`;
CREATE TABLE `similarity45` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity46
-- ----------------------------
DROP TABLE IF EXISTS `similarity46`;
CREATE TABLE `similarity46` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity47
-- ----------------------------
DROP TABLE IF EXISTS `similarity47`;
CREATE TABLE `similarity47` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity48
-- ----------------------------
DROP TABLE IF EXISTS `similarity48`;
CREATE TABLE `similarity48` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity49
-- ----------------------------
DROP TABLE IF EXISTS `similarity49`;
CREATE TABLE `similarity49` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity5
-- ----------------------------
DROP TABLE IF EXISTS `similarity5`;
CREATE TABLE `similarity5` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity50
-- ----------------------------
DROP TABLE IF EXISTS `similarity50`;
CREATE TABLE `similarity50` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity51
-- ----------------------------
DROP TABLE IF EXISTS `similarity51`;
CREATE TABLE `similarity51` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity52
-- ----------------------------
DROP TABLE IF EXISTS `similarity52`;
CREATE TABLE `similarity52` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity53
-- ----------------------------
DROP TABLE IF EXISTS `similarity53`;
CREATE TABLE `similarity53` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity54
-- ----------------------------
DROP TABLE IF EXISTS `similarity54`;
CREATE TABLE `similarity54` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity55
-- ----------------------------
DROP TABLE IF EXISTS `similarity55`;
CREATE TABLE `similarity55` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity56
-- ----------------------------
DROP TABLE IF EXISTS `similarity56`;
CREATE TABLE `similarity56` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity57
-- ----------------------------
DROP TABLE IF EXISTS `similarity57`;
CREATE TABLE `similarity57` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity58
-- ----------------------------
DROP TABLE IF EXISTS `similarity58`;
CREATE TABLE `similarity58` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity59
-- ----------------------------
DROP TABLE IF EXISTS `similarity59`;
CREATE TABLE `similarity59` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity6
-- ----------------------------
DROP TABLE IF EXISTS `similarity6`;
CREATE TABLE `similarity6` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity60
-- ----------------------------
DROP TABLE IF EXISTS `similarity60`;
CREATE TABLE `similarity60` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity61
-- ----------------------------
DROP TABLE IF EXISTS `similarity61`;
CREATE TABLE `similarity61` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity62
-- ----------------------------
DROP TABLE IF EXISTS `similarity62`;
CREATE TABLE `similarity62` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity63
-- ----------------------------
DROP TABLE IF EXISTS `similarity63`;
CREATE TABLE `similarity63` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity64
-- ----------------------------
DROP TABLE IF EXISTS `similarity64`;
CREATE TABLE `similarity64` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity65
-- ----------------------------
DROP TABLE IF EXISTS `similarity65`;
CREATE TABLE `similarity65` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity66
-- ----------------------------
DROP TABLE IF EXISTS `similarity66`;
CREATE TABLE `similarity66` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity67
-- ----------------------------
DROP TABLE IF EXISTS `similarity67`;
CREATE TABLE `similarity67` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity68
-- ----------------------------
DROP TABLE IF EXISTS `similarity68`;
CREATE TABLE `similarity68` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity69
-- ----------------------------
DROP TABLE IF EXISTS `similarity69`;
CREATE TABLE `similarity69` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity7
-- ----------------------------
DROP TABLE IF EXISTS `similarity7`;
CREATE TABLE `similarity7` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity70
-- ----------------------------
DROP TABLE IF EXISTS `similarity70`;
CREATE TABLE `similarity70` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity71
-- ----------------------------
DROP TABLE IF EXISTS `similarity71`;
CREATE TABLE `similarity71` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity72
-- ----------------------------
DROP TABLE IF EXISTS `similarity72`;
CREATE TABLE `similarity72` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity73
-- ----------------------------
DROP TABLE IF EXISTS `similarity73`;
CREATE TABLE `similarity73` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity74
-- ----------------------------
DROP TABLE IF EXISTS `similarity74`;
CREATE TABLE `similarity74` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity75
-- ----------------------------
DROP TABLE IF EXISTS `similarity75`;
CREATE TABLE `similarity75` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity76
-- ----------------------------
DROP TABLE IF EXISTS `similarity76`;
CREATE TABLE `similarity76` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity77
-- ----------------------------
DROP TABLE IF EXISTS `similarity77`;
CREATE TABLE `similarity77` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity78
-- ----------------------------
DROP TABLE IF EXISTS `similarity78`;
CREATE TABLE `similarity78` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity79
-- ----------------------------
DROP TABLE IF EXISTS `similarity79`;
CREATE TABLE `similarity79` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity8
-- ----------------------------
DROP TABLE IF EXISTS `similarity8`;
CREATE TABLE `similarity8` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity80
-- ----------------------------
DROP TABLE IF EXISTS `similarity80`;
CREATE TABLE `similarity80` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity81
-- ----------------------------
DROP TABLE IF EXISTS `similarity81`;
CREATE TABLE `similarity81` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity82
-- ----------------------------
DROP TABLE IF EXISTS `similarity82`;
CREATE TABLE `similarity82` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity83
-- ----------------------------
DROP TABLE IF EXISTS `similarity83`;
CREATE TABLE `similarity83` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity84
-- ----------------------------
DROP TABLE IF EXISTS `similarity84`;
CREATE TABLE `similarity84` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity85
-- ----------------------------
DROP TABLE IF EXISTS `similarity85`;
CREATE TABLE `similarity85` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity86
-- ----------------------------
DROP TABLE IF EXISTS `similarity86`;
CREATE TABLE `similarity86` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity87
-- ----------------------------
DROP TABLE IF EXISTS `similarity87`;
CREATE TABLE `similarity87` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity88
-- ----------------------------
DROP TABLE IF EXISTS `similarity88`;
CREATE TABLE `similarity88` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity89
-- ----------------------------
DROP TABLE IF EXISTS `similarity89`;
CREATE TABLE `similarity89` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity9
-- ----------------------------
DROP TABLE IF EXISTS `similarity9`;
CREATE TABLE `similarity9` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity90
-- ----------------------------
DROP TABLE IF EXISTS `similarity90`;
CREATE TABLE `similarity90` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity91
-- ----------------------------
DROP TABLE IF EXISTS `similarity91`;
CREATE TABLE `similarity91` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity92
-- ----------------------------
DROP TABLE IF EXISTS `similarity92`;
CREATE TABLE `similarity92` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity93
-- ----------------------------
DROP TABLE IF EXISTS `similarity93`;
CREATE TABLE `similarity93` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity94
-- ----------------------------
DROP TABLE IF EXISTS `similarity94`;
CREATE TABLE `similarity94` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity95
-- ----------------------------
DROP TABLE IF EXISTS `similarity95`;
CREATE TABLE `similarity95` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity96
-- ----------------------------
DROP TABLE IF EXISTS `similarity96`;
CREATE TABLE `similarity96` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity97
-- ----------------------------
DROP TABLE IF EXISTS `similarity97`;
CREATE TABLE `similarity97` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity98
-- ----------------------------
DROP TABLE IF EXISTS `similarity98`;
CREATE TABLE `similarity98` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for similarity99
-- ----------------------------
DROP TABLE IF EXISTS `similarity99`;
CREATE TABLE `similarity99` (
  `id` int(11) NOT NULL,
  `courseA` int(11) DEFAULT NULL,
  `courseB` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(1000) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `token-用户` (`userId`) USING BTREE,
  CONSTRAINT `token-用户` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for updateTime
-- ----------------------------
DROP TABLE IF EXISTS `updateTime`;
CREATE TABLE `updateTime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `time` text,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `userId` (`userId`) USING BTREE,
  CONSTRAINT `课表更新时间` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `school` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for userLabel
-- ----------------------------
DROP TABLE IF EXISTS `userLabel`;
CREATE TABLE `userLabel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `labelId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `userId` (`userId`) USING BTREE,
  KEY `labelId` (`labelId`) USING BTREE,
  CONSTRAINT `labelId` FOREIGN KEY (`labelId`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for verificationCode
-- ----------------------------
DROP TABLE IF EXISTS `verificationCode`;
CREATE TABLE `verificationCode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for webCourses
-- ----------------------------
DROP TABLE IF EXISTS `webCourses`;
CREATE TABLE `webCourses` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `category` varchar(1000) DEFAULT NULL,
  `name` varchar(1000) DEFAULT NULL,
  `site` varchar(1000) DEFAULT NULL,
  `imgUrl` varchar(2550) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `collectionNum` int(11) DEFAULT '0',
  `clickNum` int(11) DEFAULT '0',
  `cluster` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `categoryId` (`categoryId`) USING BTREE,
  KEY `cluster` (`cluster`) USING BTREE,
  CONSTRAINT `categoryId` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `cluster` FOREIGN KEY (`cluster`) REFERENCES `cluster` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=177362 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
