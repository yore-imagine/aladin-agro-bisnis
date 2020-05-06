/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 100411
Source Host           : localhost:3306
Source Database       : bjb-attendance

Target Server Type    : MYSQL
Target Server Version : 100411
File Encoding         : 65001

Date: 2020-04-19 06:18:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for attendances
-- ----------------------------
DROP TABLE IF EXISTS `attendances`;
CREATE TABLE `attendances` (
  `id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `nrp` int(64) NOT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `checkin_at` timestamp NULL DEFAULT NULL,
  `checkin_ip_address` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checkin_user_agent` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checkout_at` timestamp NULL DEFAULT NULL,
  `checkout_ip_address` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checkout_user_agent` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `approved_by` int(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_attendance_pk` (`id`) USING BTREE,
  KEY `ix_attendance_nrp` (`nrp`) USING BTREE,
  KEY `ix_attendance_idx1` (`nrp`,`checkin_at`) USING BTREE,
  KEY `ix_attendance_idx3` (`nrp`,`approved_at`) USING BTREE,
  KEY `ix_attendance_type` (`type`),
  KEY `ix_attendance_idx2` (`nrp`,`type`) USING BTREE,
  CONSTRAINT `fk_attendance_nrp` FOREIGN KEY (`nrp`) REFERENCES `users` (`nrp`),
  CONSTRAINT `fk_attendance_type` FOREIGN KEY (`type`) REFERENCES `attendance_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of attendances
-- ----------------------------
INSERT INTO `attendances` VALUES ('1', '0', 'WFH', '2020-04-18', '2020-04-18 05:40:00', '127.0.0.1', 'Mozila', null, null, null, null, null);

-- ----------------------------
-- Table structure for attendance_types
-- ----------------------------
DROP TABLE IF EXISTS `attendance_types`;
CREATE TABLE `attendance_types` (
  `id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1 = active, 0 = inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(64) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of attendance_types
-- ----------------------------
INSERT INTO `attendance_types` VALUES ('WFH', 'Work From Home', '1', '2020-04-18 01:39:17', '0', null, null);
INSERT INTO `attendance_types` VALUES ('WFO', 'Work From Office', '1', '2020-04-18 01:39:33', '0', null, null);

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES ('1', '2014_10_12_000000_create_users_table', '1');
INSERT INTO `migrations` VALUES ('2', '2019_08_19_000000_create_failed_jobs_table', '1');
INSERT INTO `migrations` VALUES ('3', '2020_04_17_162000_create_sessions_table', '1');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1 = active, 0 = inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(64) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('admin', 'Administrator', '1', '2020-04-18 01:40:06', '0', null, null);
INSERT INTO `roles` VALUES ('user', 'User Unit Kerja', '1', '2020-04-18 01:39:51', '0', null, null);

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('aOUB1geFZ0moYa49agZ0bopo5dFlHIejOs9RGSeh', '0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36', 'ZXlKcGRpSTZJbXhoVVRoMGRYVldhWFpaWW1wT2NWRlBOMVZKU0hjOVBTSXNJblpoYkhWbElqb2ljRVprVEROTGVESk9aV3hpVFN0bVVGUnBSM0psUlVWNFYwMDVWMUkzWTIxR0sxRnhhMncxWVhsblVtbDFSR1pNUzJwR1MyZEtTbVJsV0UwclNuZHdNV1pMUVZKblkyZE1hMlpJWTBGT0wxbHBiR3BKVTBKVWRHbHRaeTgxYTJoMmJVOWpZbkpDTXpWTEsxaFZXVXhwVFdkc1RVZG1VazR3UlZwU1RFSTNOMkY0VDBKbGJWSnZSbkJ2T0c5NlNVdFhUR3gyTVUxYVVITlVjVVpqZWsxMVUwVnZZMnM1VTNKbVFtNVNRWEZuWVc5TU5Xb3hNVkZtY1VSTlNUSkphbWxMU0RkVE1WaEZWVWxuYW5SU1UzbDFjazFJY1dRNU5UVm1ieTlhTlhjNFlrRjRPRFVyUjBGNVduaDVWV1ZJUWxaelNFTXhlblJ3T1RFclFXWktPWEpUY1RNMk16Y3lVMWxQUjI5UFQwOWtMMlpEUkdsVFNsSnpXaXM1YTBoVGNWWkNOM0ZSV25WdlNrVnliVWR5TVdsS1FYSjZZazh3TWtSRk9IZHVObFk0T0hsT1IxVllNbEpPWlVOWk4yNTBaamhJT0RkbmQyeFNjemxyUkUxU05WaFNVVEptUlZaMlRFSk5NRWRaUFNJc0ltMWhZeUk2SW1WaE9EUmpNRGsxTkRVMFpUQmlNREUyTkRCa1lqUTROekJsWlRFME5HVmxOV016TkdFd01HVTROMkV6TmpGbU1XTTFOakV5TnpReE1XUXpNREV4TlRVaWZRPT0=', '1587214050');

-- ----------------------------
-- Table structure for timezones
-- ----------------------------
DROP TABLE IF EXISTS `timezones`;
CREATE TABLE `timezones` (
  `id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1 = active, 0 = inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(64) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of timezones
-- ----------------------------
INSERT INTO `timezones` VALUES ('WIB', 'Waktu Indonesia Bagian Barat', 'UTC+7', '1', '2020-04-18 01:41:16', '0', null, null);
INSERT INTO `timezones` VALUES ('WIT', 'Waktu Indonesia Bagian Timur', 'UTC+9', '1', '2020-04-18 01:41:49', '0', null, null);
INSERT INTO `timezones` VALUES ('WITA', 'Waktu Indonesia Bagian Tengah', 'UTC+8', '1', '2020-04-18 01:41:37', '0', null, null);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `nrp` int(64) NOT NULL,
  `nip` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kode_unit_kerja` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `kode_induk` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `nama_unit_kerja` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nama_induk` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kode_kanwil` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `nama_kanwil` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kode_jabatan` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nama_jabatan` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kode_grade` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `grade` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `approver` int(64) NOT NULL DEFAULT 0,
  `timezone_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `image_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1 = active, 0 = inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(64) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(64) DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `last_login_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login_ua` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'User Agent',
  PRIMARY KEY (`nrp`),
  KEY `ix_users_pk` (`nrp`),
  KEY `ix_users_nip` (`nip`),
  KEY `ix_users_login` (`nip`,`password`),
  KEY `ix_users_email` (`email`),
  KEY `ix_users_role` (`role_id`),
  KEY `ix_users_timezone` (`timezone_id`),
  KEY `ix_users_login2` (`nip`,`password`,`status`),
  CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `fk_users_timezone` FOREIGN KEY (`timezone_id`) REFERENCES `timezones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('0', 'XX.XX.XXXX', 'Super Administrator', 'admin@admin.com', '$2y$10$IR0v9WhTfcifBcRMrKO8NuoXP2SDEpPbAmcloL3yjuGFtAMHkpIg2', '0810000000', '0000', '0000', 'Kantor Pusat', 'Kantor Pusat', 'K000', 'Kanwil', 'XXXX', 'Super Administrator', 'XXXX', 'G0', '0', 'WIB', null, null, null, 'admin', '1', '2020-04-18 02:42:07', '0', '2020-04-18 08:33:38', null, '2020-04-18 08:33:38', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36');

-- ----------------------------
-- Table structure of student
-- ----------------------------
CREATE TABLE `students` (
  `id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nim` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1 = active, 0 = inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(64) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


