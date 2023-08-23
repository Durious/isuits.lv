-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 23, 2023 at 11:37 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `isuitslv_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `header` varchar(191) DEFAULT NULL,
  `footer` varchar(191) DEFAULT NULL,
  `state` varchar(191) DEFAULT NULL,
  `per_page` varchar(191) NOT NULL DEFAULT '10',
  `logo_path` varchar(191) DEFAULT NULL,
  `gateways` varchar(191) DEFAULT NULL,
  `notifications` tinyint(1) DEFAULT NULL,
  `email_enabled` tinyint(1) DEFAULT NULL,
  `sms_enabled` tinyint(1) DEFAULT NULL,
  `default_tax` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stripe` tinyint(1) DEFAULT NULL,
  `payu` tinyint(1) DEFAULT NULL,
  `language` varchar(2) NOT NULL DEFAULT 'en',
  `direction` varchar(3) NOT NULL DEFAULT 'ltr',
  `order_statuses` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `phone`, `email`, `address`, `header`, `footer`, `state`, `per_page`, `logo_path`, `gateways`, `notifications`, `email_enabled`, `sms_enabled`, `default_tax`, `created_at`, `updated_at`, `stripe`, `payu`, `language`, `direction`, `order_statuses`) VALUES
(1, 'ISuits SIA', '+37126443333', 'info@isuits.lv', 'Rupniecības iela 19 ofiss 2, Rīga', 'Uzticiet sava stāsta veidošanu meistariem ar vairāku paaudžu mantotu pieredzi.', 'Luminor Banka AS\r\nSWIFT/BIC: RIKOLV22\r\nKonts: LV70RIKO0002930274173', 'NC', '10', '1690354236.png', 'Cash,Monezium,Wire Transfer,Credit Card', NULL, 1, 0, 1, '2020-03-10 01:53:02', '2023-07-26 07:50:36', 0, 0, 'en', 'ltr', 'pending,reject,complete');

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `log_name` varchar(191) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `subject_type` varchar(191) DEFAULT NULL,
  `event` varchar(191) DEFAULT NULL,
  `causer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `causer_type` varchar(191) DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `batch_uuid` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`id`, `account_id`, `log_name`, `description`, `subject_id`, `subject_type`, `event`, `causer_id`, `causer_type`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Todorovic\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"alek0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":null,\"photo_path\":null,\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":null,\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-15T15:33:09.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-15 14:33:58', '2023-03-15 14:33:58'),
(2, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits Shop\",\"phone\":\"+3381922520894\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash,Cheque,Other\",\"default_tax\":null,\"per_page\":\"10\",\"address\":\"Konatice Noname street 378\",\"header\":\"Minima voluptatem ut asperiores ducimus veritatis tempora voluptates.\",\"footer\":\"Voluptatem qui debitis voluptates error.\",\"email_enabled\":0,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"1\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits Shop\",\"MAIL_FROM_NAME\":\"Tailor Shop\",\"MAIL_FROM_ADDRESS\":\"noreply@testmail.com\",\"APP_TIMEZONE\":\"UTC\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"smtp.mailtrap.io\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"admin@iteverest2.com\",\"MAIL_PASSWORD\":\"123123\",\"STRIPE_KEY\":null,\"STRIPE_SECRET\":null,\"STRIPE_CURRENCY\":null,\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"live\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"live\",\"PAYU_BIZ_KEY\":null,\"PAYU_BIZ_SALT\":null,\"SMS_FROM\":null,\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-03-15 14:37:50', '2023-03-15 14:37:50'),
(3, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Todorovic\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"alek0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":null,\"photo_path\":null,\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":null,\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-15T15:33:09.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-15 14:37:59', '2023-03-15 14:37:59'),
(4, 1, 'Service', 'Service has been created', 1, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-15 14:43:08', '2023-03-15 14:43:08'),
(5, 1, 'Tax', 'Tax has been created', 1, 'App\\Models\\Tax', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-15 14:44:10', '2023-03-15 14:44:10'),
(6, 1, 'Customer', 'Customer has been created', 1, 'App\\Models\\Customer', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-15 14:46:11', '2023-03-15 14:46:11'),
(7, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Todorovic\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"alek0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":null,\"photo_path\":null,\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":null,\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-15T15:33:09.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-15 15:11:56', '2023-03-15 15:11:56'),
(8, 1, 'default', 'Added new user', 2, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"phone\":\"54646546546\",\"name\":\"violet\",\"owner\":false,\"salary\":\"1000\",\"active\":true,\"can_sms\":\"1\",\"view_all\":\"1\",\"edit_all\":\"1\",\"password\":\"$2y$10$lojWL1Y5rJ0gLqcADvj\\/2ORGkmT0FCamDPQOYD1dDLDcdPKQ6T3pi\",\"username\":\"violet\",\"email\":\"violetfocus0618@gmail.com\",\"photo_path\":\"users\\/1SZUXYJjrh0ZfDhdSBCW4cP1Bt30zeYqghVbJdiO.jpg\",\"account_id\":1,\"updated_at\":\"2023-03-15T16:13:09.000000Z\",\"created_at\":\"2023-03-15T16:13:09.000000Z\",\"id\":2}}', NULL, '2023-03-15 15:13:09', '2023-03-15 15:13:09'),
(9, 1, 'default', 'User has been logged in', 2, 'App\\Models\\User', NULL, 2, 'App\\Models\\User', '{\"user\":{\"id\":2,\"account_id\":1,\"name\":\"violet\",\"phone\":\"54646546546\",\"email\":\"violetfocus0618@gmail.com\",\"username\":\"violet\",\"password\":\"$2y$10$lojWL1Y5rJ0gLqcADvj\\/2ORGkmT0FCamDPQOYD1dDLDcdPKQ6T3pi\",\"owner\":false,\"salary\":\"1000.0000\",\"photo_path\":\"users\\/1SZUXYJjrh0ZfDhdSBCW4cP1Bt30zeYqghVbJdiO.jpg\",\"can_sms\":1,\"view_all\":1,\"edit_all\":1,\"remember_token\":null,\"created_at\":\"2023-03-15T16:13:09.000000Z\",\"updated_at\":\"2023-03-15T16:13:09.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-15 15:13:31', '2023-03-15 15:13:31'),
(10, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Todorovic\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"alek0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":null,\"photo_path\":null,\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":null,\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-15T15:33:09.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-15 15:14:54', '2023-03-15 15:14:54'),
(11, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Todorovic\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"alek0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":null,\"photo_path\":null,\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":null,\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-15T15:33:09.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-15 15:19:37', '2023-03-15 15:19:37'),
(12, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Todorovic\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"alek0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":null,\"photo_path\":\"avatars\\/qWxG2NRVbncK8K7nw7XbI6yMzexacejAAQMRNyyQ.png\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":null,\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-15T16:19:55.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-16 01:29:07', '2023-03-16 01:29:07'),
(13, 1, 'Service', 'Service has been updated', 1, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:07:32', '2023-03-16 04:07:32'),
(14, 1, 'Service', 'Service has been created', 2, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:11:03', '2023-03-16 04:11:03'),
(15, 1, 'Service', 'Service has been created', 3, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:12:30', '2023-03-16 04:12:30'),
(16, 1, 'Service', 'Service has been created', 4, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:12:56', '2023-03-16 04:12:56'),
(17, 1, 'Service', 'Service has been created', 5, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:13:10', '2023-03-16 04:13:10'),
(18, 1, 'Service', 'Service has been created', 6, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:13:25', '2023-03-16 04:13:25'),
(19, 1, 'Service', 'Service has been created', 7, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:13:44', '2023-03-16 04:13:44'),
(20, 1, 'Service', 'Service has been updated', 2, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:13:52', '2023-03-16 04:13:52'),
(21, 1, 'Service', 'Service has been updated', 3, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:14:03', '2023-03-16 04:14:03'),
(22, 1, 'Measurement', 'Measurement has been created', 1, 'App\\Models\\Measurement', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:15:38', '2023-03-16 04:15:38'),
(23, 1, 'Measurement', 'Measurement has been updated', 1, 'App\\Models\\Measurement', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:16:02', '2023-03-16 04:16:02'),
(24, 1, 'Customer', 'Customer has been created', 2, 'App\\Models\\Customer', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:17:02', '2023-03-16 04:17:02'),
(25, 1, 'Customer', 'Customer has been updated', 2, 'App\\Models\\Customer', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:17:33', '2023-03-16 04:17:33'),
(26, 1, 'Payment', 'Payment has been created', 1, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:17:52', '2023-03-16 04:17:52'),
(27, 1, 'Payment', 'Payment has been created', 2, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:18:12', '2023-03-16 04:18:12'),
(28, 1, 'Customer', 'Customer has been updated', 2, 'App\\Models\\Customer', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:18:41', '2023-03-16 04:18:41'),
(29, 1, 'Payment', 'Payment has been created', 3, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:19:42', '2023-03-16 04:19:42'),
(30, 1, 'Payment', 'Payment has been created', 4, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:20:07', '2023-03-16 04:20:07'),
(31, 1, 'Payment', 'Payment has been updated', 4, 'App\\Models\\Payment', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:20:50', '2023-03-16 04:20:50'),
(32, 1, 'Payment', 'Payment has been updated', 3, 'App\\Models\\Payment', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:21:13', '2023-03-16 04:21:13'),
(33, 1, 'Payment', 'Payment has been created', 5, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:21:30', '2023-03-16 04:21:30'),
(34, 1, 'Payment', 'Payment has been created', 6, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:22:20', '2023-03-16 04:22:20'),
(35, 1, 'Salary', 'User (Aleksandar Todorovic) do not have salary.', NULL, NULL, NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:22:40', '2023-03-16 04:22:40'),
(36, 1, 'Salary', 'User (violet) salary created 1000.0000', 1, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:22:40', '2023-03-16 04:22:40'),
(37, 1, 'default', 'Update the user', 2, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":2,\"account_id\":1,\"name\":\"violet_stuff\",\"phone\":\"54646546546\",\"email\":\"violetfocus0618@gmail.com\",\"username\":\"violet_stuff\",\"password\":\"$2y$10$lojWL1Y5rJ0gLqcADvj\\/2ORGkmT0FCamDPQOYD1dDLDcdPKQ6T3pi\",\"owner\":false,\"salary\":\"1000.0000\",\"photo_path\":\"avatars\\/JQsbDGf21lUnuSM9zJpakyGHuQdw33i16P2G9Z5H.png\",\"can_sms\":\"1\",\"view_all\":\"1\",\"edit_all\":\"1\",\"remember_token\":null,\"created_at\":\"2023-03-15T16:13:09.000000Z\",\"updated_at\":\"2023-03-16T05:23:33.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-16 04:23:33', '2023-03-16 04:23:33'),
(38, 1, 'default', 'Update the user', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":null,\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-16 04:26:12', '2023-03-16 04:26:12'),
(39, 1, 'Expense', 'Expense has been created', 1, 'App\\Models\\Expense', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:30:48', '2023-03-16 04:30:48'),
(40, 1, 'Expense', 'Expense has been created', 2, 'App\\Models\\Expense', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:31:00', '2023-03-16 04:31:00'),
(41, 1, 'Expense', 'Expense has been created', 3, 'App\\Models\\Expense', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:31:18', '2023-03-16 04:31:18'),
(42, 1, 'Expense', 'Expense has been created', 4, 'App\\Models\\Expense', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:31:34', '2023-03-16 04:31:34'),
(43, 1, 'Expense', 'Expense has been created', 5, 'App\\Models\\Expense', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:31:49', '2023-03-16 04:31:49'),
(44, 1, 'Expense', 'Expense has been created', 6, 'App\\Models\\Expense', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-16 04:32:03', '2023-03-16 04:32:03'),
(45, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":null,\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-17 01:10:26', '2023-03-17 01:10:26'),
(46, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"RS93tT9id1G2qCrTJMVor6ij78uPyAmSNQ7S97zhgqAVpGY113kGzg9yTgW2\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-17 01:30:01', '2023-03-17 01:30:01'),
(47, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"VjHTXeym8NpegvhMoo9qtMdlvwcToVc785HRxgCRndomJJjepvKUvBsSGV4Z\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-17 14:35:27', '2023-03-17 14:35:27'),
(48, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"VjHTXeym8NpegvhMoo9qtMdlvwcToVc785HRxgCRndomJJjepvKUvBsSGV4Z\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-17 15:13:55', '2023-03-17 15:13:55'),
(49, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"4x1lCVjWEXCj7Tj6C5YkzhIrDO1yyI7ibong7bqUzjB831k74osWEtCjJSAI\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-17 18:53:13', '2023-03-17 18:53:13'),
(50, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"xSZ9NDESkzn93tQuxbTqrGXvGB9FhpRQ7zUVs4cS7pQk3gtxiH4iIxoxCWB3\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-17 18:53:33', '2023-03-17 18:53:33'),
(51, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"xtLzkOXMbRbCfznanZ2H693KLeDu90AkUYK75tHi4JF43ZYxfiMQ8bxK4enb\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-17 18:54:50', '2023-03-17 18:54:50'),
(52, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"xtLzkOXMbRbCfznanZ2H693KLeDu90AkUYK75tHi4JF43ZYxfiMQ8bxK4enb\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-17 19:46:16', '2023-03-17 19:46:16'),
(53, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"xtLzkOXMbRbCfznanZ2H693KLeDu90AkUYK75tHi4JF43ZYxfiMQ8bxK4enb\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 02:11:42', '2023-03-19 02:11:42'),
(54, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"xtLzkOXMbRbCfznanZ2H693KLeDu90AkUYK75tHi4JF43ZYxfiMQ8bxK4enb\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:35:23', '2023-03-19 12:35:23'),
(55, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"8Bjds2Cr09uLsvYu4KXpZAZwZKHFVDhsPU6RTQBVbg5aaeoySbotKQmCURaL\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:39:32', '2023-03-19 12:39:32'),
(56, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"8Bjds2Cr09uLsvYu4KXpZAZwZKHFVDhsPU6RTQBVbg5aaeoySbotKQmCURaL\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:40:23', '2023-03-19 12:40:23'),
(57, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"8Bjds2Cr09uLsvYu4KXpZAZwZKHFVDhsPU6RTQBVbg5aaeoySbotKQmCURaL\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:40:30', '2023-03-19 12:40:30'),
(58, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"8Bjds2Cr09uLsvYu4KXpZAZwZKHFVDhsPU6RTQBVbg5aaeoySbotKQmCURaL\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:41:00', '2023-03-19 12:41:00'),
(59, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"8Bjds2Cr09uLsvYu4KXpZAZwZKHFVDhsPU6RTQBVbg5aaeoySbotKQmCURaL\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:41:11', '2023-03-19 12:41:11'),
(60, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"vOtLBhhGN5OnuHXIW5cmfNkoKFzTqck3tz3cMz9KbpmAzw821RQlF83rvGRH\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:41:35', '2023-03-19 12:41:35'),
(61, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"1xtgylGxe3bkJOYtBLKl0Je3SCSXAPWqAROA9AgmEZMq1AfweFrtf8pgaOyV\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:41:54', '2023-03-19 12:41:54'),
(62, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"WZHYmYxhalNRJj01HAHNU2dWi6OpdNYyW6MHle4Bv0yAVtNGPg3Q4YhAP1xV\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:44:00', '2023-03-19 12:44:00'),
(63, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"7KJQYF1sBayTv4ucJZIVtwtJxsyPD0yTCetrtXVoFlSGJKJSnDSKkErQYT6l\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:44:45', '2023-03-19 12:44:45'),
(64, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"cdiHgV2xGJOxWrAX7LF8CT3lQWOYPXe8Zm1i9Oi0J3StS5zErjO6y9NO3PZ7\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:45:23', '2023-03-19 12:45:23'),
(65, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"F96NY6UGadapHlgsaBvIJpuzgm8OglloPsCwd3o8w9AbIsUKUPyye5ulnV4q\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 12:47:33', '2023-03-19 12:47:33'),
(66, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"7Bga7owDD8ZhAinWNARX3nZrUHZP6fUhn6ONSOSXSpmruTGMCsD4BSULbATs\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:03:34', '2023-03-19 13:03:34'),
(67, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"tZuePsPBE6BEffOw6fS7mG8L0lJSN9AUTIo2j7Hqg0FCc5gZwvXKcUTP8mrR\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:04:00', '2023-03-19 13:04:00'),
(68, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"AdpH4BtoAouw6Ekt75pFCYAG1nQj3KcPrnVzLcfeLJ9XFp5e8DWd8YyjVepX\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:04:44', '2023-03-19 13:04:44'),
(69, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"BT0oLlA6aPNRewnbpnbaK4ToalCYZeK8yVgaoNAIIhA5fZxU0Ok68BeX5Wjo\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:05:34', '2023-03-19 13:05:34'),
(70, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"dfzXXqgxJBny0JVPktMn5YWOqBLalets7fzjICk28rh7ebRxtSDfzwJykGvX\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:05:51', '2023-03-19 13:05:51'),
(71, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"6CFNmew4Gib9lEw0Zi418nc8A1Z9CjOsaO77hOrSCxVS4Mt803mbqu1sY3nw\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:06:30', '2023-03-19 13:06:30'),
(72, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"YhjPOSWv1vthNylF7cSBZlosU2R316aO8ICu5zU7XiK8He7hhhL62b6xL7Nk\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:07:34', '2023-03-19 13:07:34'),
(73, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"Jnkx4ubGWuraQ3oqTMtH4EuPVjj7Z7VPQLWKxIwXMT9oP3CvmPfL3mYkoJlm\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:07:55', '2023-03-19 13:07:55'),
(74, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:08:03', '2023-03-19 13:08:03'),
(75, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:22:35', '2023-03-19 13:22:35'),
(76, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:22:40', '2023-03-19 13:22:40'),
(77, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:22:47', '2023-03-19 13:22:47'),
(78, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:23:01', '2023-03-19 13:23:01'),
(79, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:24:39', '2023-03-19 13:24:39'),
(80, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:24:52', '2023-03-19 13:24:52'),
(81, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:26:14', '2023-03-19 13:26:14'),
(82, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:27:56', '2023-03-19 13:27:56'),
(83, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:28:41', '2023-03-19 13:28:41'),
(84, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:28:48', '2023-03-19 13:28:48'),
(85, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fSDH0TLoIBRKxIqIRKOHMloFV3p7b0ewfAOafuB5Ha8wfjt03MiLhUvaV7vF\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:29:23', '2023-03-19 13:29:23'),
(86, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"VTghqudoOnCfpZanVs69LdR6I3hUbosOzG4c5HrdXyryOc1Rz0QUucHU8Nhb\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:29:43', '2023-03-19 13:29:43'),
(87, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"i17nsXOIxKSLu58YL0fIfW9B78Fq5VHTgG1L80eDY1X4WKfvPITI4jNNg9nK\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:31:37', '2023-03-19 13:31:37'),
(88, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"AP7towBPy9ElMFdUFhE4q5mm9SJqJcqlNQLOdomQc1NrEbtoONDw8xfRNoIg\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:31:45', '2023-03-19 13:31:45'),
(89, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"AP7towBPy9ElMFdUFhE4q5mm9SJqJcqlNQLOdomQc1NrEbtoONDw8xfRNoIg\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:31:57', '2023-03-19 13:31:57'),
(90, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"AP7towBPy9ElMFdUFhE4q5mm9SJqJcqlNQLOdomQc1NrEbtoONDw8xfRNoIg\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:32:04', '2023-03-19 13:32:04'),
(91, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"AP7towBPy9ElMFdUFhE4q5mm9SJqJcqlNQLOdomQc1NrEbtoONDw8xfRNoIg\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:32:09', '2023-03-19 13:32:09');
INSERT INTO `activity_log` (`id`, `account_id`, `log_name`, `description`, `subject_id`, `subject_type`, `event`, `causer_id`, `causer_type`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(92, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"CAP54aEXi3yS7SLJirDwqrnLTbyBlHNnm59vjIFB8MmXR1G7TEVC8YX2Tig5\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:32:21', '2023-03-19 13:32:21'),
(93, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"CAP54aEXi3yS7SLJirDwqrnLTbyBlHNnm59vjIFB8MmXR1G7TEVC8YX2Tig5\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:33:10', '2023-03-19 13:33:10'),
(94, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"7FKnDeBYUwD78xv9urPO5amrmlSDg37uywp60geH6LSV2TajQNM9yjpzqqxG\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:33:35', '2023-03-19 13:33:35'),
(95, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"56eOfPsxN7iHrgQ2t9vdGOwznlI1u8YQEyzUEBQYpHc1BD5mDC25nwbCajKB\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:33:58', '2023-03-19 13:33:58'),
(96, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"eZ8FGsaTD88DD82COLToZWyOcuxXpwUbDeV5Jkw7jQ2PXK9HpeWQ5bxuwAUB\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:36:14', '2023-03-19 13:36:14'),
(97, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"pFTnIC7S0cg7Xhx9EItBhiWsPdykCeCTPri88KhIJ6CbSQlb9lDKpGA8uT79\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:36:24', '2023-03-19 13:36:24'),
(98, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"fnFNf1QelkoJJG3Z20qxQCWYzCN85E0Qa8mWpOGEMN57DxRoiHPwQnmAydh7\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:37:16', '2023-03-19 13:37:16'),
(99, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"bNl76B4z2G1Ddnh6ZjuDbjSfPfWgHizisQR2zGA0sllrWLLymA8eajKDNIq5\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:39:12', '2023-03-19 13:39:12'),
(100, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"u9sDyQ2PDL9AJ98cbKBLZbQhyjFvk2M6pyGp2bMq3yVVaDgxmojQ2xT6hqJg\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:40:09', '2023-03-19 13:40:09'),
(101, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"jlgbfe8QbYa2ykUG3BHlyflXhKaHKITpVNKs8cC0IuGMBjUk2YLZdZKXJDDh\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:40:19', '2023-03-19 13:40:19'),
(102, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"jf5vH0k03J9TKNQ49RlEz7H7ZZ3yP5vykZEXHaSXLxH7JZz3F4oszwVTaq1T\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:40:27', '2023-03-19 13:40:27'),
(103, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"WKSAOpKXdR9wgOjtgKTI4rrQXuj6r4Q7g5ZU4JD7Ez4wTfcCAx3hc1speEMJ\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:44:53', '2023-03-19 13:44:53'),
(104, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"VW4lvR60F6gU3NQqO0Ex1NJ1y3kDE1PvBCjWtZrMXfcvYINfHpuqdjmEvcKo\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:45:46', '2023-03-19 13:45:46'),
(105, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"OxMgzrxIxp2R0g9TEEBozU5lNENdQmVtmmWDqaRfpsFbMm11NDTmgrwLJykU\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:47:23', '2023-03-19 13:47:23'),
(106, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"E9UeHngryh3Ojnt7auZkOV8kwp7iI3yxo6yJIKKMUK2lSIibqDvnahvhZ1qU\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:47:29', '2023-03-19 13:47:29'),
(107, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"JqvxR29rgx3Uz3mF01pM4WVMtvyrE9oX5zxmQ98210KzP84SZNgZOAYXOu3D\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 13:47:46', '2023-03-19 13:47:46'),
(108, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"tMYJW4FO1WEr1027udRQkAwXKYdkgyzgRvhlphE3sgJ74dssBqDhux82nKCu\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:00:56', '2023-03-19 14:00:56'),
(109, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"GrCx6XI7lNU5ujwfGLhtx3Idn2FvUTmDo3Nwv2qKVbnEuPX9v3Jc22eKGor6\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:35:32', '2023-03-19 14:35:32'),
(110, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"w6eR4yUVqL7FXfTnFBHy5PyzM288AnBu0LPKYEdcH8zUmMll4uA2gQoQvrof\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:39:21', '2023-03-19 14:39:21'),
(111, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"8VLTqRqr8dB6omhZjID2FoOn94qv9ZzmTpQgfA9Lrp5htLayldiyvk5YYruU\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:39:37', '2023-03-19 14:39:37'),
(112, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"J3axHPjccGzLdnRJsXkPY2QZUcTnhNApBWG5t6iil4WWUnex1mC8X1d60NwC\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:39:54', '2023-03-19 14:39:54'),
(113, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"EmKIIC76361xqE2Dp3hqYA6WONNvZmhP1ChGWC3Bz3Fy39bLYvp86NFXM9Sv\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:40:08', '2023-03-19 14:40:08'),
(114, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"gpLLiiVCS6pLHFeyhmf9HIHI5uK4wxsz7ZkFuxaegFdlTwVMZ3je7hb9dg34\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:40:29', '2023-03-19 14:40:29'),
(115, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"gPXYa4MPzx8uu44NwNF618RKTZCVPs7ZTMDJGOpBhZg88CNzjfOvJORzNpje\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:41:06', '2023-03-19 14:41:06'),
(116, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"hyrUXF7f9gpvrsjpNCfVolbaaVv86qapSAL41ZRe4KR6FSCuKbVSV6v2EvDn\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:41:11', '2023-03-19 14:41:11'),
(117, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"mLXIFQaw2s7v6U67GxZyEACAAHY6HfKwnzcpRTI0NLwapzrLOeaVZVFLUzx3\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:42:36', '2023-03-19 14:42:36'),
(118, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"Lge2IU5KU4739hzzhmPybznRcrZCcPnYbw3jC92aKlrTlsjmBkXP3UgGZ0WO\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:47:00', '2023-03-19 14:47:00'),
(119, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"ZBmmLF29iIcPgLLMHx2rJIq90bOWuntiIwCKEkRQc90jBaOc7zefxMdVXRs8\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:47:27', '2023-03-19 14:47:27'),
(120, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"F4rtntzzqyZQQOnPWvRm196S7DTTZycHDIngUPGrDObvnZRPOrEroArHT2d8\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:50:44', '2023-03-19 14:50:44'),
(121, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"yK7W0DVIKc65a4U6Pv6DmAYJ8Ebo8j3oGoRVfQHRGXkt58SNO1RCdhM4XlTZ\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:50:51', '2023-03-19 14:50:51'),
(122, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"omLkaqCCGd8IgsWGLZXsO9YOGHavdR1P6fWGKSk65ZJdgY9tkB5sOIQWUKTe\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 14:51:00', '2023-03-19 14:51:00'),
(123, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"kVUkOYoX9Uwnlef5DV1lNRhHcetp51RsxfQoieEZ7ptExMFx5day4sPEgVJj\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 17:08:59', '2023-03-19 17:08:59'),
(124, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"kVUkOYoX9Uwnlef5DV1lNRhHcetp51RsxfQoieEZ7ptExMFx5day4sPEgVJj\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-19 18:13:04', '2023-03-19 18:13:04'),
(125, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"kVUkOYoX9Uwnlef5DV1lNRhHcetp51RsxfQoieEZ7ptExMFx5day4sPEgVJj\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 00:17:35', '2023-03-20 00:17:35'),
(126, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"kVUkOYoX9Uwnlef5DV1lNRhHcetp51RsxfQoieEZ7ptExMFx5day4sPEgVJj\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 00:17:41', '2023-03-20 00:17:41'),
(127, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"kVUkOYoX9Uwnlef5DV1lNRhHcetp51RsxfQoieEZ7ptExMFx5day4sPEgVJj\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 00:17:46', '2023-03-20 00:17:46'),
(128, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"kVUkOYoX9Uwnlef5DV1lNRhHcetp51RsxfQoieEZ7ptExMFx5day4sPEgVJj\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 00:17:52', '2023-03-20 00:17:52'),
(129, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"kVUkOYoX9Uwnlef5DV1lNRhHcetp51RsxfQoieEZ7ptExMFx5day4sPEgVJj\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 00:18:05', '2023-03-20 00:18:05'),
(130, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"M8JQcWvibYrYdj9yMFAGKcRK19tnWevMiMm8xZN4aUquXp1i5q4WovzdcQD6\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 00:18:35', '2023-03-20 00:18:35'),
(131, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"pZulbwCqk0Kxuzmh6H10XZe9BuLPiyp97OZnYgrhcOTc6ckaAZkJmO77oIo7\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 00:18:42', '2023-03-20 00:18:42'),
(132, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 00:19:15', '2023-03-20 00:19:15'),
(133, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 07:46:13', '2023-03-20 07:46:13'),
(134, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 13:24:52', '2023-03-20 13:24:52'),
(135, 1, 'Measurement', 'Measurement has been created', 2, 'App\\Models\\Measurement', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 13:33:53', '2023-03-20 13:33:53'),
(136, 1, 'Contact', 'Contact has been created', 1, 'App\\Models\\Contact', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 15:38:26', '2023-03-20 15:38:26'),
(137, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"users\\/zKEvCeMfBzJqywoqbUQEx9K1XIEK1sSLxuWsEKya.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-16T05:26:12.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-20 18:56:14', '2023-03-20 18:56:14'),
(138, 1, 'Contact', 'Contact has been deleted', 1, 'App\\Models\\Contact', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 20:47:33', '2023-03-20 20:47:33'),
(139, 1, 'Contact', 'Contact has been updated', 1, 'App\\Models\\Contact', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 20:47:37', '2023-03-20 20:47:37'),
(140, 1, 'Contact', 'Contact has been restored', 1, 'App\\Models\\Contact', 'restored', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 20:47:37', '2023-03-20 20:47:37'),
(141, 1, 'Category', 'Category has been updated', 2, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 21:22:47', '2023-03-20 21:22:47'),
(142, 1, 'Category', 'Category has been restored', 2, 'App\\Models\\Category', 'restored', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 21:22:47', '2023-03-20 21:22:47'),
(143, 1, 'Category', 'Category has been deleted', 2, 'App\\Models\\Category', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 22:36:03', '2023-03-20 22:36:03'),
(144, 1, 'Category', 'Category has been updated', 2, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 22:36:10', '2023-03-20 22:36:10'),
(145, 1, 'Category', 'Category has been restored', 2, 'App\\Models\\Category', 'restored', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 22:36:10', '2023-03-20 22:36:10'),
(146, 1, 'Product', 'Product has been created', 1, 'App\\Models\\Product', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 23:27:49', '2023-03-20 23:27:49'),
(147, 1, 'Product', 'Product has been created', 2, 'App\\Models\\Product', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-20 23:56:16', '2023-03-20 23:56:16'),
(148, 1, 'Product', 'Product has been updated', 2, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:16:27', '2023-03-21 00:16:27'),
(149, 1, 'Product', 'Product has been updated', 2, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:16:46', '2023-03-21 00:16:46'),
(150, 1, 'Category', 'Category has been created', 4, 'App\\Models\\Category', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:18:35', '2023-03-21 00:18:35'),
(151, 1, 'Category', 'Category has been updated', 3, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:18:46', '2023-03-21 00:18:46'),
(152, 1, 'Category', 'Category has been updated', 3, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:18:48', '2023-03-21 00:18:48'),
(153, 1, 'Category', 'Category has been updated', 2, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:18:56', '2023-03-21 00:18:56'),
(154, 1, 'Product', 'Product has been created', 3, 'App\\Models\\Product', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:19:31', '2023-03-21 00:19:31'),
(155, 1, 'Product', 'Product has been updated', 3, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:19:54', '2023-03-21 00:19:54'),
(156, 1, 'Product', 'Product has been deleted', 3, 'App\\Models\\Product', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:21:18', '2023-03-21 00:21:18'),
(157, 1, 'Product', 'Product has been updated', 3, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:21:36', '2023-03-21 00:21:36'),
(158, 1, 'Product', 'Product has been restored', 3, 'App\\Models\\Product', 'restored', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 00:21:36', '2023-03-21 00:21:36'),
(159, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/5dc0o5QuUR2Gvtd0Q5LJL4L0zP2LuPDBq4nfzS6u.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-20T21:12:33.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-21 05:43:05', '2023-03-21 05:43:05'),
(160, 1, 'Product', 'Product has been created', 4, 'App\\Models\\Product', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 06:19:39', '2023-03-21 06:19:39'),
(161, 1, 'Product', 'Product has been updated', 4, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 06:26:54', '2023-03-21 06:26:54'),
(162, 1, 'Product', 'Product has been created', 5, 'App\\Models\\Product', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 06:36:14', '2023-03-21 06:36:14'),
(163, 1, 'Product', 'Product has been created', 6, 'App\\Models\\Product', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 06:36:45', '2023-03-21 06:36:45'),
(164, 1, 'Category', 'Category has been updated', 2, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 06:37:25', '2023-03-21 06:37:25'),
(165, 1, 'Category', 'Category has been updated', 3, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 06:37:33', '2023-03-21 06:37:33'),
(166, 1, 'Category', 'Category has been updated', 4, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 06:37:41', '2023-03-21 06:37:41'),
(167, 1, 'Category', 'Category has been created', 5, 'App\\Models\\Category', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 06:38:31', '2023-03-21 06:38:31'),
(168, 1, 'Category', 'Category has been updated', 3, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 06:38:39', '2023-03-21 06:38:39'),
(169, 1, 'Product', 'Product has been updated', 3, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 08:24:16', '2023-03-21 08:24:16'),
(170, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-21 16:54:50', '2023-03-21 16:54:50'),
(171, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-21 19:18:32', '2023-03-21 19:18:32'),
(172, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-21 20:06:55', '2023-03-21 20:06:55'),
(173, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-21 20:52:16', '2023-03-21 20:52:16'),
(174, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-21 20:52:41', '2023-03-21 20:52:41'),
(175, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-21 20:53:01', '2023-03-21 20:53:01'),
(176, 1, 'Measurement', 'Measurement has been deleted', 1, 'App\\Models\\Measurement', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 21:00:29', '2023-03-21 21:00:29'),
(177, 1, 'Measurement', 'Measurement has been deleted', 1, 'App\\Models\\Measurement', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 21:00:32', '2023-03-21 21:00:32'),
(178, 1, 'MeasurementField', 'MeasurementField has been created', 1, 'App\\Models\\MeasurementField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 21:01:11', '2023-03-21 21:01:11'),
(179, 1, 'MeasurementField', 'MeasurementField has been updated', 1, 'App\\Models\\MeasurementField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 21:01:18', '2023-03-21 21:01:18'),
(180, 1, 'Measurement', 'Measurement has been updated', 2, 'App\\Models\\Measurement', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 21:01:41', '2023-03-21 21:01:41'),
(181, 1, 'MeasurementField', 'MeasurementField has been updated', 1, 'App\\Models\\MeasurementField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 21:03:18', '2023-03-21 21:03:18'),
(182, 1, 'MeasurementField', 'MeasurementField has been created', 2, 'App\\Models\\MeasurementField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-21 21:04:22', '2023-03-21 21:04:22'),
(183, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-21 21:39:48', '2023-03-21 21:39:48'),
(184, 1, 'CustomField', 'CustomField has been created', 1, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 02:00:31', '2023-03-22 02:00:31'),
(185, 1, 'CustomField', 'CustomField has been created', 2, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 02:01:27', '2023-03-22 02:01:27'),
(186, 1, 'CustomField', 'CustomField has been created', 3, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 02:05:54', '2023-03-22 02:05:54'),
(187, 1, 'CustomField', 'CustomField has been created', 4, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 02:07:16', '2023-03-22 02:07:16'),
(188, 1, 'CustomField', 'CustomField has been created', 5, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 04:21:18', '2023-03-22 04:21:18'),
(189, 1, 'Category', 'Category has been updated', 2, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 04:42:33', '2023-03-22 04:42:33'),
(190, 1, 'Category', 'Category has been updated', 2, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 04:43:27', '2023-03-22 04:43:27'),
(191, 1, 'Product', 'Product has been updated', 1, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 04:46:09', '2023-03-22 04:46:09'),
(192, 1, 'CustomField', 'CustomField has been created', 6, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 04:53:52', '2023-03-22 04:53:52'),
(193, 1, 'CustomField', 'CustomField has been created', 7, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 04:54:11', '2023-03-22 04:54:11'),
(194, 1, 'CustomField', 'CustomField has been created', 8, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 04:54:57', '2023-03-22 04:54:57'),
(195, 1, 'CustomField', 'CustomField has been created', 9, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 04:57:34', '2023-03-22 04:57:34'),
(196, 1, 'CustomField', 'CustomField has been updated', 9, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 05:00:30', '2023-03-22 05:00:30'),
(197, 1, 'CustomField', 'CustomField has been updated', 9, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 05:00:50', '2023-03-22 05:00:50'),
(198, 1, 'CustomField', 'CustomField has been updated', 9, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 05:04:46', '2023-03-22 05:04:46'),
(199, 1, 'Product', 'Product has been created', 7, 'App\\Models\\Product', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:05:25', '2023-03-22 06:05:25'),
(200, 1, 'Product', 'Product has been created', 8, 'App\\Models\\Product', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:06:39', '2023-03-22 06:06:39');
INSERT INTO `activity_log` (`id`, `account_id`, `log_name`, `description`, `subject_id`, `subject_type`, `event`, `causer_id`, `causer_type`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(201, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:17:26', '2023-03-22 06:17:26'),
(202, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:18:03', '2023-03-22 06:18:03'),
(203, 1, 'Product', 'Product has been updated', 7, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:20:23', '2023-03-22 06:20:23'),
(204, 1, 'Product', 'Product has been updated', 7, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:22:12', '2023-03-22 06:22:12'),
(205, 1, 'Product', 'Product has been updated', 7, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:25:35', '2023-03-22 06:25:35'),
(206, 1, 'CustomField', 'CustomField has been updated', 9, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:34:56', '2023-03-22 06:34:56'),
(207, 1, 'CustomField', 'CustomField has been updated', 5, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:39:33', '2023-03-22 06:39:33'),
(208, 1, 'CustomField', 'CustomField has been deleted', 2, 'App\\Models\\CustomField', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:48:15', '2023-03-22 06:48:15'),
(209, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:53:20', '2023-03-22 06:53:20'),
(210, 1, 'CustomField', 'CustomField has been restored', 2, 'App\\Models\\CustomField', 'restored', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:53:20', '2023-03-22 06:53:20'),
(211, 1, 'CustomField', 'CustomField has been deleted', 2, 'App\\Models\\CustomField', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:53:25', '2023-03-22 06:53:25'),
(212, 1, 'Product', 'Product has been deleted', 1, 'App\\Models\\Product', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:55:01', '2023-03-22 06:55:01'),
(213, 1, 'Product', 'Product has been updated', 1, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:55:04', '2023-03-22 06:55:04'),
(214, 1, 'Product', 'Product has been restored', 1, 'App\\Models\\Product', 'restored', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 06:55:04', '2023-03-22 06:55:04'),
(215, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 07:05:33', '2023-03-22 07:05:33'),
(216, 1, 'CustomField', 'CustomField has been restored', 2, 'App\\Models\\CustomField', 'restored', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 07:05:33', '2023-03-22 07:05:33'),
(217, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 07:07:17', '2023-03-22 07:07:17'),
(218, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 07:08:58', '2023-03-22 07:08:58'),
(219, 1, 'Category', 'Category has been created', 6, 'App\\Models\\Category', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 07:56:32', '2023-03-22 07:56:32'),
(220, 1, 'Category', 'Category has been created', 7, 'App\\Models\\Category', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:00:44', '2023-03-22 08:00:44'),
(221, 1, 'MeasurementField', 'MeasurementField has been updated', 2, 'App\\Models\\MeasurementField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:01:57', '2023-03-22 08:01:57'),
(222, 1, 'Category', 'Category has been created', 8, 'App\\Models\\Category', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:04:03', '2023-03-22 08:04:03'),
(223, 1, 'Category', 'Category has been created', 9, 'App\\Models\\Category', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:04:30', '2023-03-22 08:04:30'),
(224, 1, 'Category', 'Category has been created', 10, 'App\\Models\\Category', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:04:47', '2023-03-22 08:04:47'),
(225, 1, 'Category', 'Category has been created', 11, 'App\\Models\\Category', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:05:18', '2023-03-22 08:05:18'),
(226, 1, 'Category', 'Category has been created', 12, 'App\\Models\\Category', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:07:03', '2023-03-22 08:07:03'),
(227, 1, 'Category', 'Category has been updated', 12, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:16:22', '2023-03-22 08:16:22'),
(228, 1, 'Product', 'Product has been updated', 1, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:17:11', '2023-03-22 08:17:11'),
(229, 1, 'Product', 'Product has been updated', 1, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:17:56', '2023-03-22 08:17:56'),
(230, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-22 08:19:35', '2023-03-22 08:19:35'),
(231, 1, 'Product', 'Product has been updated', 1, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 08:34:23', '2023-03-22 08:34:23'),
(232, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-22 17:17:38', '2023-03-22 17:17:38'),
(233, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 18:34:52', '2023-03-22 18:34:52'),
(234, 1, 'CustomField', 'CustomField has been updated', 5, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 18:35:00', '2023-03-22 18:35:00'),
(235, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 18:43:08', '2023-03-22 18:43:08'),
(236, 1, 'CustomField', 'CustomField has been updated', 3, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 18:43:23', '2023-03-22 18:43:23'),
(237, 1, 'CustomField', 'CustomField has been updated', 3, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 18:43:36', '2023-03-22 18:43:36'),
(238, 1, 'CustomField', 'CustomField has been updated', 4, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 18:43:50', '2023-03-22 18:43:50'),
(239, 1, 'CustomField', 'CustomField has been updated', 5, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 18:44:28', '2023-03-22 18:44:28'),
(240, 1, 'CustomField', 'CustomField has been created', 10, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 18:44:59', '2023-03-22 18:44:59'),
(241, 1, 'CustomField', 'CustomField has been updated', 10, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 19:04:35', '2023-03-22 19:04:35'),
(242, 1, 'CustomField', 'CustomField has been updated', 3, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 20:13:15', '2023-03-22 20:13:15'),
(243, 1, 'CustomField', 'CustomField has been updated', 3, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 20:13:30', '2023-03-22 20:13:30'),
(244, 1, 'CustomField', 'CustomField has been updated', 3, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 20:44:46', '2023-03-22 20:44:46'),
(245, 1, 'CustomField', 'CustomField has been updated', 9, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 20:48:20', '2023-03-22 20:48:20'),
(246, 1, 'CustomField', 'CustomField has been updated', 4, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 22:16:22', '2023-03-22 22:16:22'),
(247, 1, 'CustomField', 'CustomField has been updated', 10, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 22:49:34', '2023-03-22 22:49:34'),
(248, 1, 'CustomField', 'CustomField has been updated', 10, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 22:53:00', '2023-03-22 22:53:00'),
(249, 1, 'CustomField', 'CustomField has been updated', 4, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 22:53:13', '2023-03-22 22:53:13'),
(250, 1, 'CustomField', 'CustomField has been updated', 5, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 22:53:42', '2023-03-22 22:53:42'),
(251, 1, 'CustomField', 'CustomField has been updated', 3, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 23:01:38', '2023-03-22 23:01:38'),
(252, 1, 'CustomField', 'CustomField has been updated', 9, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 23:01:55', '2023-03-22 23:01:55'),
(253, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-22 23:02:25', '2023-03-22 23:02:25'),
(254, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 00:27:25', '2023-03-23 00:27:25'),
(255, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:26:13', '2023-03-23 02:26:13'),
(256, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:26:17', '2023-03-23 02:26:17'),
(257, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:26:23', '2023-03-23 02:26:23'),
(258, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:26:46', '2023-03-23 02:26:46'),
(259, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:26:59', '2023-03-23 02:26:59'),
(260, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:28:52', '2023-03-23 02:28:52'),
(261, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:29:30', '2023-03-23 02:29:30'),
(262, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:29:48', '2023-03-23 02:29:48'),
(263, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:31:40', '2023-03-23 02:31:40'),
(264, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:32:01', '2023-03-23 02:32:01'),
(265, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:32:37', '2023-03-23 02:32:37'),
(266, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:34:57', '2023-03-23 02:34:57'),
(267, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:35:30', '2023-03-23 02:35:30'),
(268, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:36:11', '2023-03-23 02:36:11'),
(269, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 02:36:47', '2023-03-23 02:36:47'),
(270, 1, 'Product', 'Product has been updated', 1, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 04:06:44', '2023-03-23 04:06:44'),
(271, 1, 'CustomField', 'CustomField has been updated', 9, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 04:23:05', '2023-03-23 04:23:05'),
(272, 1, 'CustomField', 'CustomField has been updated', 3, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 04:26:26', '2023-03-23 04:26:26'),
(273, 1, 'CustomField', 'CustomField has been updated', 3, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 04:27:33', '2023-03-23 04:27:33'),
(274, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 04:30:50', '2023-03-23 04:30:50'),
(275, 1, 'CustomField', 'CustomField has been updated', 2, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 04:31:13', '2023-03-23 04:31:13'),
(276, 1, 'CustomField', 'CustomField has been updated', 5, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 04:32:00', '2023-03-23 04:32:00'),
(277, 1, 'CustomField', 'CustomField has been updated', 5, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 04:32:17', '2023-03-23 04:32:17'),
(278, 1, 'CustomField', 'CustomField has been updated', 10, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 04:32:46', '2023-03-23 04:32:46'),
(279, 1, 'CustomField', 'CustomField has been updated', 4, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 04:33:08', '2023-03-23 04:33:08'),
(280, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 07:59:55', '2023-03-23 07:59:55'),
(281, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 08:15:45', '2023-03-23 08:15:45'),
(282, 1, 'Measurement', 'Measurement has been created', 4, 'App\\Models\\Measurement', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 08:51:50', '2023-03-23 08:51:50'),
(283, 1, 'Measurement', 'Measurement has been created', 5, 'App\\Models\\Measurement', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 08:52:14', '2023-03-23 08:52:14'),
(284, 1, 'Measurement', 'Measurement has been created', 6, 'App\\Models\\Measurement', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 08:52:32', '2023-03-23 08:52:32'),
(285, 1, 'Order', 'Order has been created', 1, 'App\\Models\\Order', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 08:53:18', '2023-03-23 08:53:18'),
(286, 1, 'Payment', 'Payment has been created', 7, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 08:53:34', '2023-03-23 08:53:34'),
(287, 1, 'Order', 'Order has been updated', 1, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 08:53:34', '2023-03-23 08:53:34'),
(288, 1, 'Order', 'Order has been updated', 1, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 08:53:48', '2023-03-23 08:53:48'),
(289, 1, 'Salary', 'User (Aleksandar Martin) salary created 1200.0000', 2, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 08:54:02', '2023-03-23 08:54:02'),
(290, 1, 'Salary', 'User (violet_stuff) salary created 1000.0000', 3, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 08:54:02', '2023-03-23 08:54:02'),
(291, 1, 'Category', 'Category has been updated', 3, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 08:55:41', '2023-03-23 08:55:41'),
(292, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 08:59:06', '2023-03-23 08:59:06'),
(293, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 09:03:13', '2023-03-23 09:03:13'),
(294, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 12:16:33', '2023-03-23 12:16:33'),
(295, 1, 'Category', 'Category has been updated', 12, 'App\\Models\\Category', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 13:29:52', '2023-03-23 13:29:52'),
(296, 1, 'Order', 'Order has been created', 2, 'App\\Models\\Order', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 13:33:03', '2023-03-23 13:33:03'),
(297, 1, 'Payment', 'Payment has been created', 8, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 13:33:34', '2023-03-23 13:33:34'),
(298, 1, 'Order', 'Order has been updated', 2, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 13:33:34', '2023-03-23 13:33:34'),
(299, 1, 'Payment', 'Payment has been created', 9, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 13:33:49', '2023-03-23 13:33:49'),
(300, 1, 'Cart', 'Cart has been created', 1, 'App\\Models\\Cart', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-03-23 13:36:36', '2023-03-23 13:36:36'),
(301, 1, 'CustomField', 'CustomField has been updated', 5, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:08:35', '2023-03-23 14:08:35'),
(302, 1, 'CustomField', 'CustomField has been updated', 10, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:10:14', '2023-03-23 14:10:14'),
(303, 1, 'CustomField', 'CustomField has been created', 11, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:15:26', '2023-03-23 14:15:26'),
(304, 1, 'CustomField', 'CustomField has been updated', 11, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:16:41', '2023-03-23 14:16:41'),
(305, 1, 'CustomField', 'CustomField has been created', 12, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:19:40', '2023-03-23 14:19:40'),
(306, 1, 'CustomField', 'CustomField has been updated', 12, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:20:35', '2023-03-23 14:20:35'),
(307, 1, 'CustomField', 'CustomField has been created', 13, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:22:12', '2023-03-23 14:22:12'),
(308, 1, 'CustomField', 'CustomField has been created', 14, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:23:39', '2023-03-23 14:23:39'),
(309, 1, 'CustomField', 'CustomField has been created', 15, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:25:32', '2023-03-23 14:25:32'),
(310, 1, 'CustomField', 'CustomField has been updated', 5, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:31:20', '2023-03-23 14:31:20'),
(311, 1, 'CustomField', 'CustomField has been updated', 10, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:31:48', '2023-03-23 14:31:48'),
(312, 1, 'CustomField', 'CustomField has been updated', 9, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:33:20', '2023-03-23 14:33:20'),
(313, 1, 'CustomField', 'CustomField has been created', 16, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:38:16', '2023-03-23 14:38:16'),
(314, 1, 'CustomField', 'CustomField has been created', 17, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:39:59', '2023-03-23 14:39:59'),
(315, 1, 'CustomField', 'CustomField has been updated', 16, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:40:44', '2023-03-23 14:40:44'),
(316, 1, 'CustomField', 'CustomField has been created', 18, 'App\\Models\\CustomField', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:43:36', '2023-03-23 14:43:36'),
(317, 1, 'CustomField', 'CustomField has been updated', 17, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:45:28', '2023-03-23 14:45:28'),
(318, 1, 'Product', 'Product has been created', 9, 'App\\Models\\Product', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:51:14', '2023-03-23 14:51:14'),
(319, 1, 'CustomField', 'CustomField has been updated', 4, 'App\\Models\\CustomField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 14:57:48', '2023-03-23 14:57:48'),
(320, 1, 'Product', 'Product has been created', 10, 'App\\Models\\Product', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 15:03:57', '2023-03-23 15:03:57'),
(321, 1, 'Cart', 'Cart has been created', 2, 'App\\Models\\Cart', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-03-23 15:06:05', '2023-03-23 15:06:05'),
(322, 1, 'Cart', 'Cart has been created', 3, 'App\\Models\\Cart', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-03-23 15:08:05', '2023-03-23 15:08:05'),
(323, 1, 'Product', 'Product has been updated', 9, 'App\\Models\\Product', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 15:10:34', '2023-03-23 15:10:34'),
(324, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 15:27:26', '2023-03-23 15:27:26'),
(325, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-23 15:27:53', '2023-03-23 15:27:53'),
(326, 1, 'Category', 'Category has been deleted', 5, 'App\\Models\\Category', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-03-23 15:34:29', '2023-03-23 15:34:29'),
(327, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-24 00:11:05', '2023-03-24 00:11:05'),
(328, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-24 00:13:27', '2023-03-24 00:13:27'),
(329, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"5TJO2ZROjIcdBTVs2kVW1iyFe1JBoyIJCpCuhEjMN4GM9dwdtKMeG5K6bmcE\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-24 07:12:03', '2023-03-24 07:12:03'),
(330, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-24 12:23:24', '2023-03-24 12:23:24'),
(331, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-25 15:58:54', '2023-03-25 15:58:54'),
(332, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-27 12:02:18', '2023-03-27 12:02:18'),
(333, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-27 12:02:50', '2023-03-27 12:02:50'),
(334, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-27 12:08:51', '2023-03-27 12:08:51'),
(335, 1, 'Order', 'Order has been created', 3, 'App\\Models\\Order', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-03-28 03:24:33', '2023-03-28 03:24:33'),
(336, 1, 'Measurement', 'Measurement has been updated', 4, 'App\\Models\\Measurement', 'updated', 1, 'App\\Models\\Customer', '[]', NULL, '2023-03-29 03:53:37', '2023-03-29 03:53:37'),
(337, 1, 'Measurement', 'Measurement has been updated', 4, 'App\\Models\\Measurement', 'updated', 1, 'App\\Models\\Customer', '[]', NULL, '2023-03-29 03:54:15', '2023-03-29 03:54:15'),
(338, 1, 'Order', 'Order has been created', 4, 'App\\Models\\Order', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-03-29 03:55:38', '2023-03-29 03:55:38'),
(339, 1, 'Service', 'Service has been updated', 7, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-29 05:05:49', '2023-03-29 05:05:49'),
(340, 1, 'Service', 'Service has been updated', 4, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-29 05:06:18', '2023-03-29 05:06:18'),
(341, 1, 'Service', 'Service has been updated', 1, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-29 05:06:52', '2023-03-29 05:06:52'),
(342, 1, 'Service', 'Service has been updated', 5, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-29 05:07:24', '2023-03-29 05:07:24'),
(343, 1, 'Service', 'Service has been updated', 2, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-29 05:07:43', '2023-03-29 05:07:43'),
(344, 1, 'Service', 'Service has been updated', 3, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-29 05:08:09', '2023-03-29 05:08:09'),
(345, 1, 'Measurement', 'Measurement has been created', 7, 'App\\Models\\Measurement', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-03-29 05:09:27', '2023-03-29 05:09:27'),
(346, 1, 'Order', 'Order has been created', 5, 'App\\Models\\Order', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-03-29 05:09:51', '2023-03-29 05:09:51'),
(347, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-03-29 06:09:07', '2023-03-29 06:09:07'),
(348, 1, 'MeasurementField', 'MeasurementField has been updated', 9, 'App\\Models\\MeasurementField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-29 06:43:32', '2023-03-29 06:43:32'),
(349, 1, 'MeasurementField', 'MeasurementField has been updated', 8, 'App\\Models\\MeasurementField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-29 06:43:51', '2023-03-29 06:43:51'),
(350, 1, 'MeasurementField', 'MeasurementField has been updated', 5, 'App\\Models\\MeasurementField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-29 06:44:30', '2023-03-29 06:44:30'),
(351, 1, 'MeasurementField', 'MeasurementField has been updated', 2, 'App\\Models\\MeasurementField', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-29 06:46:31', '2023-03-29 06:46:31'),
(352, 1, 'Order', 'Order has been created', 6, 'App\\Models\\Order', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-03-29 06:47:20', '2023-03-29 06:47:20'),
(353, 1, 'Order', 'Order has been updated', 2, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-30 11:46:01', '2023-03-30 11:46:01'),
(354, 1, 'Order', 'Order has been updated', 4, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-30 11:46:34', '2023-03-30 11:46:34'),
(355, 1, 'Order', 'Order has been updated', 3, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-30 11:46:58', '2023-03-30 11:46:58'),
(356, 1, 'Order', 'Order has been updated', 6, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-30 11:47:10', '2023-03-30 11:47:10'),
(357, 1, 'Order', 'Order has been updated', 5, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-03-30 11:47:25', '2023-03-30 11:47:25'),
(358, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-04 04:09:15', '2023-04-04 04:09:15'),
(359, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-04 04:31:50', '2023-04-04 04:31:50'),
(360, 1, 'ProductOrder', 'ProductOrder has been created', 6, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-04-04 04:50:38', '2023-04-04 04:50:38'),
(361, 1, 'ProductOrder', 'ProductOrder has been updated', 6, 'App\\Models\\ProductOrder', 'updated', NULL, NULL, '[]', NULL, '2023-04-04 04:51:28', '2023-04-04 04:51:28'),
(362, 1, 'ProductOrder', 'ProductOrder has been created', 7, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-04-04 04:57:30', '2023-04-04 04:57:30'),
(363, 1, 'ProductOrder', 'ProductOrder has been updated', 7, 'App\\Models\\ProductOrder', 'updated', NULL, NULL, '[]', NULL, '2023-04-04 04:58:18', '2023-04-04 04:58:18');
INSERT INTO `activity_log` (`id`, `account_id`, `log_name`, `description`, `subject_id`, `subject_type`, `event`, `causer_id`, `causer_type`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(364, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-03-21T08:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-04 07:04:31', '2023-04-04 07:04:31'),
(365, 1, 'ProductOrder', 'ProductOrder has been created', 8, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-04-05 05:27:39', '2023-04-05 05:27:39'),
(366, 1, 'ProductOrder', 'ProductOrder has been updated', 8, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:28:26', '2023-04-05 07:28:26'),
(367, 1, 'ProductOrder', 'ProductOrder has been updated', 5, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:29:08', '2023-04-05 07:29:08'),
(368, 1, 'ProductOrder', 'ProductOrder has been updated', 4, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:29:27', '2023-04-05 07:29:27'),
(369, 1, 'ProductOrder', 'ProductOrder has been updated', 1, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:29:35', '2023-04-05 07:29:35'),
(370, 1, 'ProductOrder', 'ProductOrder has been updated', 2, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:29:45', '2023-04-05 07:29:45'),
(371, 1, 'Payment', 'Payment has been created', 10, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:30:12', '2023-04-05 07:30:12'),
(372, 1, 'Order', 'Order has been updated', 3, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:30:19', '2023-04-05 07:30:19'),
(373, 1, 'Order', 'Order has been updated', 4, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:30:19', '2023-04-05 07:30:19'),
(374, 1, 'Order', 'Order has been updated', 5, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:30:19', '2023-04-05 07:30:19'),
(375, 1, 'Order', 'Order has been updated', 6, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:30:36', '2023-04-05 07:30:36'),
(376, 1, 'Order', 'Order has been updated', 5, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:30:50', '2023-04-05 07:30:50'),
(377, 1, 'Salary', 'User (Aleksandar Martin) salary created 1200.0000', 4, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:31:55', '2023-04-05 07:31:55'),
(378, 1, 'Salary', 'User (violet_stuff) salary created 1000.0000', 5, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-04-05 07:31:55', '2023-04-05 07:31:55'),
(379, 1, 'ProductOrder', 'ProductOrder has been created', 9, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-04-05 07:41:41', '2023-04-05 07:41:41'),
(380, 1, 'ProductOrder', 'ProductOrder has been updated', 8, 'App\\Models\\ProductOrder', 'updated', NULL, NULL, '[]', NULL, '2023-04-05 10:03:39', '2023-04-05 10:03:39'),
(381, 1, 'ProductOrder', 'ProductOrder has been updated', 9, 'App\\Models\\ProductOrder', 'updated', NULL, NULL, '[]', NULL, '2023-04-05 10:03:59', '2023-04-05 10:03:59'),
(382, 1, 'ProductOrder', 'ProductOrder has been updated', 6, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-06 08:27:27', '2023-04-06 08:27:27'),
(383, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Aleksandar Martin\",\"phone\":\"0123456789\",\"email\":\"administrator@gmail.com\",\"username\":\"martin0618\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-03-21T06:35:10.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-10 02:46:01', '2023-04-10 02:46:01'),
(384, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits Shop\",\"phone\":\"+3381922520894\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash,Cheque,Other\",\"default_tax\":null,\"per_page\":\"10\",\"address\":\"Konatice Noname street 378\",\"header\":\"Minima voluptatem ut asperiores ducimus veritatis tempora voluptates.\",\"footer\":\"Voluptatem qui debitis voluptates error.\",\"email_enabled\":0,\"sms_enabled\":0,\"payu\":1,\"stripe\":1,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits Shop\",\"MAIL_FROM_NAME\":\"ISuits SIA\\\"\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":null,\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-10 03:24:09', '2023-04-10 03:24:09'),
(385, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-10 03:27:09', '2023-04-10 03:27:09'),
(386, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash, Wire Transfer\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Voluptatem qui debitis voluptates error.\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":1,\"stripe\":1,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null,\"logo_path\":\"https:\\/\\/isuits.lv\\/logos\\/C0bCW1VFKYA304vj8EuR42rVshl5xErWRXCj1wl8.png\"},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-10 03:34:04', '2023-04-10 03:34:04'),
(387, 1, 'Service', 'Service has been updated', 1, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-10 03:42:45', '2023-04-10 03:42:45'),
(388, 1, 'Service', 'Service has been updated', 6, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-10 03:43:09', '2023-04-10 03:43:09'),
(389, 1, 'Service', 'Service has been updated', 10, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-10 03:44:56', '2023-04-10 03:44:56'),
(390, 1, 'Service', 'Service has been updated', 2, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-10 03:47:36', '2023-04-10 03:47:36'),
(391, 1, 'Service', 'Service has been updated', 14, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-10 03:47:52', '2023-04-10 03:47:52'),
(392, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIAA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash, Wire Transfer\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":1,\"stripe\":1,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIAA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-10 03:52:27', '2023-04-10 03:52:27'),
(393, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash, Wire Transfer\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":1,\"stripe\":1,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-10 03:52:51', '2023-04-10 03:52:51'),
(394, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash, Wire Transfer\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":1,\"stripe\":1,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null,\"logo_path\":\"1681097371.png\"},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-10 04:29:31', '2023-04-10 04:29:31'),
(395, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"nVx7EatHXkXbApi1A4kcXYuNCimSCYoNQXhBkDfEd7dhpMekeU3SQAOaOnC9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-10 06:32:24', '2023-04-10 06:32:24'),
(396, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"iqvjfsvEo9fLwd4Ks16A22p7KuJ2Hfy2tezDQqTFj88n6I9TtZa1ABJjatct\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-10 06:42:42', '2023-04-10 06:42:42'),
(397, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"iqvjfsvEo9fLwd4Ks16A22p7KuJ2Hfy2tezDQqTFj88n6I9TtZa1ABJjatct\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-10 10:53:22', '2023-04-10 10:53:22'),
(398, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"iqvjfsvEo9fLwd4Ks16A22p7KuJ2Hfy2tezDQqTFj88n6I9TtZa1ABJjatct\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-10 10:54:13', '2023-04-10 10:54:13'),
(399, 1, 'Payment', 'Payment has been created', 11, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-04-10 11:00:33', '2023-04-10 11:00:33'),
(400, 1, 'Measurement', 'Measurement has been created', 8, 'App\\Models\\Measurement', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-04-10 11:02:46', '2023-04-10 11:02:46'),
(401, 1, 'Measurement', 'Measurement has been deleted', 8, 'App\\Models\\Measurement', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-04-10 11:03:05', '2023-04-10 11:03:05'),
(402, 1, 'Order', 'Order has been updated', 6, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-10 11:17:03', '2023-04-10 11:17:03'),
(403, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"iqvjfsvEo9fLwd4Ks16A22p7KuJ2Hfy2tezDQqTFj88n6I9TtZa1ABJjatct\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-10 14:02:26', '2023-04-10 14:02:26'),
(404, 1, 'Order', 'Order has been updated', 6, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-10 14:17:23', '2023-04-10 14:17:23'),
(405, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash, Wire Transfer\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":1,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-10 14:24:29', '2023-04-10 14:24:29'),
(406, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash, Wire Transfer\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-10 14:24:45', '2023-04-10 14:24:45'),
(407, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"iqvjfsvEo9fLwd4Ks16A22p7KuJ2Hfy2tezDQqTFj88n6I9TtZa1ABJjatct\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-11 02:40:28', '2023-04-11 02:40:28'),
(408, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"iqvjfsvEo9fLwd4Ks16A22p7KuJ2Hfy2tezDQqTFj88n6I9TtZa1ABJjatct\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-11 11:45:17', '2023-04-11 11:45:17'),
(409, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"iqvjfsvEo9fLwd4Ks16A22p7KuJ2Hfy2tezDQqTFj88n6I9TtZa1ABJjatct\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-11 13:41:47', '2023-04-11 13:41:47'),
(410, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"tW4SXCBQzmBKJ3Uz2Hgx9621XXHZM1VG6wVXbsGQvBAtY3BR9HUGSsY5Uj2l\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-11 13:52:06', '2023-04-11 13:52:06'),
(411, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-11 14:03:57', '2023-04-11 14:03:57'),
(412, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash,Monezium,Wire Transfer\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-11 14:27:07', '2023-04-11 14:27:07'),
(413, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash,Monezium,Wire Transfer,Paypal,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-11 15:43:39', '2023-04-11 15:43:39'),
(414, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null}}', NULL, '2023-04-11 15:44:13', '2023-04-11 15:44:13'),
(415, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-13 17:47:18', '2023-04-13 17:47:18'),
(416, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-13 17:47:52', '2023-04-13 17:47:52'),
(417, 1, 'ProductOrder', 'ProductOrder has been created', 10, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-04-17 07:11:38', '2023-04-17 07:11:38'),
(418, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-17 07:58:00', '2023-04-17 07:58:00'),
(419, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-17 09:48:38', '2023-04-17 09:48:38'),
(420, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-17 09:53:52', '2023-04-17 09:53:52'),
(421, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-17 09:55:07', '2023-04-17 09:55:07'),
(422, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-19 01:07:30', '2023-04-19 01:07:30'),
(423, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-19 01:09:02', '2023-04-19 01:09:02'),
(424, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-19 08:37:36', '2023-04-19 08:37:36'),
(425, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-19 20:11:18', '2023-04-19 20:11:18'),
(426, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null,\"logo_path\":\"1681932619.png\"},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":null,\"MIRRORSIZE_MERCHANT_ID\":null,\"MIRRORSIZE_USERNAME\":null,\"MONEZIUM_SITE_KEY\":null,\"MONEZIUM_SHOP_KEY\":null}}', NULL, '2023-04-19 20:30:19', '2023-04-19 20:30:19'),
(427, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-20 01:15:32', '2023-04-20 01:15:32'),
(428, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null,\"logo_path\":\"1681950112.png\"},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":null,\"MIRRORSIZE_MERCHANT_ID\":null,\"MIRRORSIZE_USERNAME\":null,\"MONEZIUM_SITE_KEY\":null,\"MONEZIUM_SHOP_KEY\":null}}', NULL, '2023-04-20 01:21:52', '2023-04-20 01:21:52');
INSERT INTO `activity_log` (`id`, `account_id`, `log_name`, `description`, `subject_id`, `subject_type`, `event`, `causer_id`, `causer_type`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(429, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null,\"logo_path\":\"1681950397.png\"},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":null,\"MIRRORSIZE_MERCHANT_ID\":null,\"MIRRORSIZE_USERNAME\":null,\"MONEZIUM_SITE_KEY\":null,\"MONEZIUM_SHOP_KEY\":null}}', NULL, '2023-04-20 01:26:37', '2023-04-20 01:26:37'),
(430, 1, 'ProductOrder', 'ProductOrder has been created', 11, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-04-20 01:39:51', '2023-04-20 01:39:51'),
(431, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-20 01:44:48', '2023-04-20 01:44:48'),
(432, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-20 02:25:26', '2023-04-20 02:25:26'),
(433, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\"}}', NULL, '2023-04-20 02:53:16', '2023-04-20 02:53:16'),
(434, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-20 03:30:07', '2023-04-20 03:30:07'),
(435, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"aleksandart450@gmail.com\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\"}}', NULL, '2023-04-20 16:48:38', '2023-04-20 16:48:38'),
(436, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\"}}', NULL, '2023-04-21 03:02:09', '2023-04-21 03:02:09'),
(437, 1, 'ProductOrder', 'ProductOrder has been updated', 11, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 03:03:09', '2023-04-21 03:03:09'),
(438, 1, 'Salary', 'User (Ivo Svisco) salary created 1200.0000', 6, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 03:29:43', '2023-04-21 03:29:43'),
(439, 1, 'Salary', 'User (Elvijs Mūrnieks) salary created 1000.0000', 7, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 03:29:43', '2023-04-21 03:29:43'),
(440, 1, 'Salary', 'User (Andris Berziņš) salary created 500.0000', 8, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 03:29:43', '2023-04-21 03:29:43'),
(441, 1, 'Salary', 'User (Jānis Markavs) salary created 1000.0000', 9, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 03:29:43', '2023-04-21 03:29:43'),
(442, 1, 'Payment', 'Payment has been updated', 10, 'App\\Models\\Payment', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 03:31:37', '2023-04-21 03:31:37'),
(443, 1, 'default', 'Updating payment', 1, 'App\\Models\\Customer', NULL, 1, 'App\\Models\\User', '{\"id\":10,\"account_id\":\"1\",\"date\":\"2023-04-05\",\"reference\":\"01GX8C16A84HJFD83MEAZ24MN5\",\"amount\":1000,\"file\":null,\"gateway\":\"Cash\",\"received\":true,\"description\":null,\"hash\":\"1420b3f65749670b593df920170bc48dd2cde150\",\"transaction_id\":\"25\",\"gateway_transaction_id\":null,\"user_id\":\"1\",\"customer_id\":\"1\",\"order_id\":null,\"created_at\":\"2023-04-05T06:30:12.000000Z\",\"updated_at\":\"2023-04-21T02:31:37.000000Z\",\"deleted_at\":null,\"customer\":{\"id\":1,\"name\":\"Aleksandar Todorovic\",\"email\":\"aleksandart450@gmail.com\",\"address\":\"Konatice Noname street 378\",\"phone\":\"+14402070484\"}}', NULL, '2023-04-21 03:31:37', '2023-04-21 03:31:37'),
(444, 1, 'Payment', 'Payment has been created', 12, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 03:32:36', '2023-04-21 03:32:36'),
(445, 1, 'Order', 'Order has been updated', 6, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 03:32:36', '2023-04-21 03:32:36'),
(446, 1, 'Payment', 'Payment has been updated', 12, 'App\\Models\\Payment', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 03:33:37', '2023-04-21 03:33:37'),
(447, 1, 'default', 'Updating payment', 1, 'App\\Models\\Customer', NULL, 1, 'App\\Models\\User', '{\"id\":12,\"account_id\":\"1\",\"date\":\"2023-04-21\",\"reference\":\"YP8GAQ43ZBE6Z7\",\"amount\":2500,\"file\":null,\"gateway\":\"Cash\",\"received\":true,\"description\":\"for test\",\"hash\":\"7b20ad98dc99e07f4b10f83e5bc26e39735daa38\",\"transaction_id\":\"33\",\"gateway_transaction_id\":null,\"user_id\":\"1\",\"customer_id\":\"1\",\"order_id\":null,\"created_at\":\"2023-04-21T02:32:36.000000Z\",\"updated_at\":\"2023-04-21T02:33:37.000000Z\",\"deleted_at\":null,\"customer\":{\"id\":1,\"name\":\"Aleksandar Todorovic\",\"email\":\"aleksandart450@gmail.com\",\"address\":\"Konatice Noname street 378\",\"phone\":\"+14402070484\"}}', NULL, '2023-04-21 03:33:37', '2023-04-21 03:33:37'),
(448, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-21 06:08:45', '2023-04-21 06:08:45'),
(449, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-21 06:09:13', '2023-04-21 06:09:13'),
(450, 1, 'ProductOrder', 'ProductOrder has been updated', 10, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 06:58:44', '2023-04-21 06:58:44'),
(451, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-21 06:59:35', '2023-04-21 06:59:35'),
(452, 1, 'ProductOrder', 'ProductOrder has been updated', 10, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 06:59:51', '2023-04-21 06:59:51'),
(453, 1, 'ProductOrder', 'ProductOrder has been updated', 10, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 07:00:50', '2023-04-21 07:00:50'),
(454, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-21 11:13:06', '2023-04-21 11:13:06'),
(455, 1, 'Payment', 'Payment has been created', 13, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 11:13:57', '2023-04-21 11:13:57'),
(456, 1, 'Payment', 'Payment has been updated', 12, 'App\\Models\\Payment', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 11:14:27', '2023-04-21 11:14:27'),
(457, 1, 'default', 'Updating payment', 1, 'App\\Models\\Customer', NULL, 1, 'App\\Models\\User', '{\"id\":12,\"account_id\":\"1\",\"date\":\"2023-04-21\",\"reference\":\"YP8GAQ43ZBE6Z7\",\"amount\":2500,\"file\":null,\"gateway\":\"Cash\",\"received\":true,\"description\":\"for test\",\"hash\":\"7b20ad98dc99e07f4b10f83e5bc26e39735daa38\",\"transaction_id\":\"33\",\"gateway_transaction_id\":null,\"user_id\":\"1\",\"customer_id\":\"1\",\"order_id\":null,\"created_at\":\"2023-04-21T02:32:36.000000Z\",\"updated_at\":\"2023-04-21T10:14:27.000000Z\",\"deleted_at\":null,\"customer\":{\"id\":1,\"name\":\"Aleksandar Todorovic\",\"email\":\"aleksandart450@gmail.com\",\"address\":\"Konatice Noname street 378\",\"phone\":\"+14402070484\"}}', NULL, '2023-04-21 11:14:27', '2023-04-21 11:14:27'),
(458, 1, 'Payment', 'Payment has been updated', 12, 'App\\Models\\Payment', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 11:14:33', '2023-04-21 11:14:33'),
(459, 1, 'default', 'Updating payment', 1, 'App\\Models\\Customer', NULL, 1, 'App\\Models\\User', '{\"id\":12,\"account_id\":\"1\",\"date\":\"2023-04-21\",\"reference\":\"YP8GAQ43ZBE6Z7\",\"amount\":\"25000\",\"file\":null,\"gateway\":\"Cash\",\"received\":true,\"description\":\"for test\",\"hash\":\"7b20ad98dc99e07f4b10f83e5bc26e39735daa38\",\"transaction_id\":\"33\",\"gateway_transaction_id\":null,\"user_id\":\"1\",\"customer_id\":\"1\",\"order_id\":null,\"created_at\":\"2023-04-21T02:32:36.000000Z\",\"updated_at\":\"2023-04-21T10:14:33.000000Z\",\"deleted_at\":null,\"customer\":{\"id\":1,\"name\":\"Aleksandar Todorovic\",\"email\":\"aleksandart450@gmail.com\",\"address\":\"Konatice Noname street 378\",\"phone\":\"+14402070484\"}}', NULL, '2023-04-21 11:14:33', '2023-04-21 11:14:33'),
(460, 1, 'Payment', 'Payment has been updated', 12, 'App\\Models\\Payment', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 11:15:00', '2023-04-21 11:15:00'),
(461, 1, 'default', 'Updating payment', 1, 'App\\Models\\Customer', NULL, 1, 'App\\Models\\User', '{\"id\":12,\"account_id\":\"1\",\"date\":\"2023-04-21\",\"reference\":\"YP8GAQ43ZBE6Z7\",\"amount\":\"250\",\"file\":null,\"gateway\":\"Cash\",\"received\":true,\"description\":\"for test\",\"hash\":\"7b20ad98dc99e07f4b10f83e5bc26e39735daa38\",\"transaction_id\":\"33\",\"gateway_transaction_id\":null,\"user_id\":\"1\",\"customer_id\":\"1\",\"order_id\":null,\"created_at\":\"2023-04-21T02:32:36.000000Z\",\"updated_at\":\"2023-04-21T10:15:00.000000Z\",\"deleted_at\":null,\"customer\":{\"id\":1,\"name\":\"Aleksandar Todorovic\",\"email\":\"aleksandart450@gmail.com\",\"address\":\"Konatice Noname street 378\",\"phone\":\"+14402070484\"}}', NULL, '2023-04-21 11:15:00', '2023-04-21 11:15:00'),
(462, 1, 'Payment', 'Payment has been updated', 13, 'App\\Models\\Payment', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-04-21 11:15:09', '2023-04-21 11:15:09'),
(463, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-24 10:33:24', '2023-04-24 10:33:24'),
(464, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-29 06:32:12', '2023-04-29 06:32:12'),
(465, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-30 18:26:15', '2023-04-30 18:26:15'),
(466, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\\/\"}}', NULL, '2023-04-30 18:26:44', '2023-04-30 18:26:44'),
(467, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-04-30 18:26:53', '2023-04-30 18:26:53'),
(468, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-04-30 18:44:35', '2023-04-30 18:44:35'),
(469, 1, 'ProductOrder', 'ProductOrder has been created', 12, 'App\\Models\\ProductOrder', 'created', 3, 'App\\Models\\Customer', '[]', NULL, '2023-05-03 17:06:55', '2023-05-03 17:06:55'),
(470, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"q1SvZXJO95BrTL2V01YBCvLH9prtSHRkTaB53dyTVAd4xej4E11uqU2di18N\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-05 08:10:13', '2023-05-05 08:10:13'),
(471, 1, 'Salary', 'User (Ivo Svisco) salary created 1200.0000', 10, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-05-11 01:39:58', '2023-05-11 01:39:58'),
(472, 1, 'Salary', 'User (Elvijs Mūrnieks) salary created 1000.0000', 11, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-05-11 01:39:58', '2023-05-11 01:39:58'),
(473, 1, 'Salary', 'User (Andris Berziņš) salary created 500.0000', 12, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-05-11 01:39:58', '2023-05-11 01:39:58'),
(474, 1, 'Salary', 'User (Jānis Markavs) salary created 1000.0000', 13, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-05-11 01:39:58', '2023-05-11 01:39:58'),
(475, 1, 'default', 'Update the user', 2, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":2,\"account_id\":\"1\",\"name\":\"Elvijs M\\u016brnieks\",\"phone\":\"+37125410532\",\"email\":\"melvijs@gmail.com\",\"username\":\"melvijs\",\"password\":\"$2y$10$lojWL1Y5rJ0gLqcADvj\\/2ORGkmT0FCamDPQOYD1dDLDcdPKQ6T3pi\",\"owner\":false,\"salary\":\"1000.0000\",\"photo_path\":\"users\\/grom3rO7VDL7WjxMxMUUxMeDGielUjOuIudWZySs.jpg\",\"can_sms\":\"1\",\"view_all\":\"1\",\"edit_all\":\"1\",\"remember_token\":null,\"created_at\":\"2023-03-15T14:13:09.000000Z\",\"updated_at\":\"2023-05-14T17:38:51.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-14 18:38:51', '2023-05-14 18:38:51'),
(476, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"tcTxvOdVEv12BIMyCaF1VctNguVg6eSEE3OMJNHGVtz4ZK1ApfSjCHVhkbTH\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-14 18:46:00', '2023-05-14 18:46:00'),
(477, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"AUcIQtlA2NL9uIDgrDVpohc5bIqpumn1wO0EV3r7IhlaYltcTADmXqQ2zPiY\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-14 18:46:49', '2023-05-14 18:46:49'),
(478, 1, 'default', 'Update the user', 2, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":2,\"account_id\":\"1\",\"name\":\"Elvijs M\\u016brnieks\",\"phone\":\"+37125410532\",\"email\":\"melvijs@gmail.com\",\"username\":\"melvijs\",\"password\":\"$2y$10$lojWL1Y5rJ0gLqcADvj\\/2ORGkmT0FCamDPQOYD1dDLDcdPKQ6T3pi\",\"owner\":false,\"salary\":\"1000.0000\",\"photo_path\":\"users\\/QQGRALfrJDOa85ks1WaIF4g5mwROrVbt5ss4j38I.jpg\",\"can_sms\":\"1\",\"view_all\":\"1\",\"edit_all\":\"1\",\"remember_token\":null,\"created_at\":\"2023-03-15T14:13:09.000000Z\",\"updated_at\":\"2023-05-14T17:49:18.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-14 18:49:18', '2023-05-14 18:49:18'),
(479, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"AUcIQtlA2NL9uIDgrDVpohc5bIqpumn1wO0EV3r7IhlaYltcTADmXqQ2zPiY\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-18 15:29:09', '2023-05-18 15:29:09'),
(480, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"AUcIQtlA2NL9uIDgrDVpohc5bIqpumn1wO0EV3r7IhlaYltcTADmXqQ2zPiY\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-18 18:31:02', '2023-05-18 18:31:02'),
(481, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"AUcIQtlA2NL9uIDgrDVpohc5bIqpumn1wO0EV3r7IhlaYltcTADmXqQ2zPiY\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-19 09:00:53', '2023-05-19 09:00:53'),
(482, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"info@monezium.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"nl1-ss19.a2hosting.com\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"info@monezium.eu\",\"MAIL_PASSWORD\":\"Mon@zium2018\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-05-19 09:16:25', '2023-05-19 09:16:25'),
(483, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"info@monezium.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"nl1-ss19.a2hosting.com\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"tls\",\"MAIL_USERNAME\":\"info@monezium.eu\",\"MAIL_PASSWORD\":\"Mon@zium2018\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-05-19 09:16:52', '2023-05-19 09:16:52'),
(484, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"info@monezium.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"nl1-ss19.a2hosting.com\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"tls\",\"MAIL_USERNAME\":\"info@monezium.eu\",\"MAIL_PASSWORD\":\"Mon@zium2018\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-05-19 09:19:07', '2023-05-19 09:19:07'),
(485, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"info@monezium.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"nl1-ss19.a2hosting.com\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"tls\",\"MAIL_USERNAME\":\"info@monezium.eu\",\"MAIL_PASSWORD\":\"Mon@zium2018\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-05-19 09:19:15', '2023-05-19 09:19:15'),
(486, 1, 'Payment', 'Payment has been created', 14, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-19 09:20:07', '2023-05-19 09:20:07'),
(487, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"AUcIQtlA2NL9uIDgrDVpohc5bIqpumn1wO0EV3r7IhlaYltcTADmXqQ2zPiY\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-19 12:13:54', '2023-05-19 12:13:54'),
(488, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"AUcIQtlA2NL9uIDgrDVpohc5bIqpumn1wO0EV3r7IhlaYltcTADmXqQ2zPiY\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-22 06:31:32', '2023-05-22 06:31:32'),
(489, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-22 06:32:36', '2023-05-22 06:32:36'),
(490, 1, 'ProductOrder', 'ProductOrder has been created', 13, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-22 06:52:09', '2023-05-22 06:52:09'),
(491, 1, 'ProductOrder', 'ProductOrder has been updated', 13, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 06:52:46', '2023-05-22 06:52:46'),
(492, 1, 'ProductOrder', 'ProductOrder has been updated', 13, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 06:53:07', '2023-05-22 06:53:07'),
(493, 1, 'Service', 'Service has been created', 21, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 07:10:58', '2023-05-22 07:10:58'),
(494, 1, 'Service', 'Service has been created', 22, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 07:16:56', '2023-05-22 07:16:56'),
(495, 1, 'Service', 'Service has been created', 23, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 07:28:39', '2023-05-22 07:28:39'),
(496, 1, 'Service', 'Service has been created', 24, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 07:29:11', '2023-05-22 07:29:11'),
(497, 1, 'Service', 'Service has been created', 25, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 07:32:45', '2023-05-22 07:32:45'),
(498, 1, 'Service', 'Service has been created', 26, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 07:46:06', '2023-05-22 07:46:06'),
(499, 1, 'Service', 'Service has been created', 27, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 07:46:59', '2023-05-22 07:46:59'),
(500, 1, 'Service', 'Service has been created', 28, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 07:48:18', '2023-05-22 07:48:18'),
(501, 1, 'Service', 'Service has been created', 29, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 07:51:18', '2023-05-22 07:51:18'),
(502, 1, 'Service', 'Service has been created', 30, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 07:51:39', '2023-05-22 07:51:39'),
(503, 1, 'ProductOrder', 'ProductOrder has been created', 14, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-22 08:30:21', '2023-05-22 08:30:21');
INSERT INTO `activity_log` (`id`, `account_id`, `log_name`, `description`, `subject_id`, `subject_type`, `event`, `causer_id`, `causer_type`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(504, 1, 'Service', 'Service has been created', 31, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 08:34:06', '2023-05-22 08:34:06'),
(505, 1, 'Service', 'Service has been created', 32, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 08:36:51', '2023-05-22 08:36:51'),
(506, 1, 'Service', 'Service has been created', 33, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 08:37:06', '2023-05-22 08:37:06'),
(507, 1, 'Service', 'Service has been created', 34, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 08:37:15', '2023-05-22 08:37:15'),
(508, 1, 'ProductOrder', 'ProductOrder has been created', 15, 'App\\Models\\ProductOrder', 'created', 3, 'App\\Models\\Customer', '[]', NULL, '2023-05-22 08:38:43', '2023-05-22 08:38:43'),
(509, 1, 'ProductOrder', 'ProductOrder has been created', 16, 'App\\Models\\ProductOrder', 'created', 3, 'App\\Models\\Customer', '[]', NULL, '2023-05-22 08:39:31', '2023-05-22 08:39:31'),
(510, 1, 'Service', 'Service has been created', 35, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 08:44:48', '2023-05-22 08:44:48'),
(511, 1, 'Service', 'Service has been created', 36, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 08:45:10', '2023-05-22 08:45:10'),
(512, 1, 'Service', 'Service has been deleted', 21, 'App\\Models\\Service', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 09:39:58', '2023-05-22 09:39:58'),
(513, 1, 'Service', 'Service has been deleted', 31, 'App\\Models\\Service', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 09:40:08', '2023-05-22 09:40:08'),
(514, 1, 'Service', 'Service has been deleted', 32, 'App\\Models\\Service', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 09:40:19', '2023-05-22 09:40:19'),
(515, 1, 'Service', 'Service has been deleted', 24, 'App\\Models\\Service', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 09:40:30', '2023-05-22 09:40:30'),
(516, 1, 'Salary', 'User (Ivo Svisco) salary created 1200.0000', 14, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 09:44:29', '2023-05-22 09:44:29'),
(517, 1, 'Salary', 'User (Elvijs Mūrnieks) salary created 1000.0000', 15, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 09:44:29', '2023-05-22 09:44:29'),
(518, 1, 'Salary', 'User (Andris Berziņš) salary created 500.0000', 16, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 09:44:29', '2023-05-22 09:44:29'),
(519, 1, 'Salary', 'User (Jānis Markavs) salary created 1000.0000', 17, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 09:44:29', '2023-05-22 09:44:29'),
(520, 1, 'Service', 'Service has been created', 37, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 12:13:19', '2023-05-22 12:13:19'),
(521, 1, 'Service', 'Service has been created', 38, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 12:15:55', '2023-05-22 12:15:55'),
(522, 1, 'Service', 'Service has been created', 39, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 12:27:03', '2023-05-22 12:27:03'),
(523, 1, 'Service', 'Service has been created', 40, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 12:51:07', '2023-05-22 12:51:07'),
(524, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-22 16:16:32', '2023-05-22 16:16:32'),
(525, 1, 'Service', 'Service has been created', 41, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 16:17:52', '2023-05-22 16:17:52'),
(526, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.eu\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.eu\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.eu\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-05-22 16:19:55', '2023-05-22 16:19:55'),
(527, 1, 'Service', 'Service has been created', 42, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 16:20:38', '2023-05-22 16:20:38'),
(528, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.lv\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.lv\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.lv\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-05-22 16:28:21', '2023-05-22 16:28:21'),
(529, 1, 'Service', 'Service has been created', 43, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 16:28:45', '2023-05-22 16:28:45'),
(530, 1, 'Service', 'Service has been created', 44, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 16:30:56', '2023-05-22 16:30:56'),
(531, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.lv\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.lv\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"ssl\",\"MAIL_USERNAME\":\"tavsuzvalks@isuits.lv\",\"MAIL_PASSWORD\":\"TavsUzvalks2021!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-05-22 16:36:44', '2023-05-22 16:36:44'),
(532, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.lv\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.lv\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":\"tavsuzvalks@isuits.lv\",\"MAIL_PASSWORD\":\"TavsUzvalks2023!@#\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-05-22 16:45:52', '2023-05-22 16:45:52'),
(533, 1, 'Service', 'Service has been created', 45, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 16:47:47', '2023-05-22 16:47:47'),
(534, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.lv\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.lv\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"ssl\",\"MAIL_USERNAME\":\"_mainaccount@isuits.lv\",\"MAIL_PASSWORD\":\"6-3N5tIc5SmjQ(\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-05-22 16:56:23', '2023-05-22 16:56:23'),
(535, 1, 'Service', 'Service has been created', 46, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-22 16:58:09', '2023-05-22 16:58:09'),
(536, 1, 'Service', 'Service has been updated', 14, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:37:45', '2023-05-23 00:37:45'),
(537, 1, 'Service', 'Service has been updated', 14, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:38:22', '2023-05-23 00:38:22'),
(538, 1, 'Service', 'Service has been created', 47, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:39:37', '2023-05-23 00:39:37'),
(539, 1, 'Service', 'Service has been updated', 14, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:45:38', '2023-05-23 00:45:38'),
(540, 1, 'Service', 'Service has been updated', 8, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:45:49', '2023-05-23 00:45:49'),
(541, 1, 'Service', 'Service has been updated', 12, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:46:07', '2023-05-23 00:46:07'),
(542, 1, 'Service', 'Service has been updated', 3, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:46:20', '2023-05-23 00:46:20'),
(543, 1, 'Service', 'Service has been updated', 9, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:46:33', '2023-05-23 00:46:33'),
(544, 1, 'Service', 'Service has been updated', 5, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:46:47', '2023-05-23 00:46:47'),
(545, 1, 'Service', 'Service has been updated', 14, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:46:54', '2023-05-23 00:46:54'),
(546, 1, 'Service', 'Service has been updated', 8, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 00:47:01', '2023-05-23 00:47:01'),
(547, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-23 01:19:54', '2023-05-23 01:19:54'),
(548, 1, 'Service', 'Service has been created', 48, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 01:20:31', '2023-05-23 01:20:31'),
(549, 1, 'Service', 'Service has been created', 49, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 01:23:51', '2023-05-23 01:23:51'),
(550, 1, 'Service', 'Service has been created', 50, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 01:46:21', '2023-05-23 01:46:21'),
(551, 1, 'Service', 'Service has been created', 51, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 01:49:19', '2023-05-23 01:49:19'),
(552, 1, 'Service', 'Service has been created', 52, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 02:29:34', '2023-05-23 02:29:34'),
(553, 1, 'Service', 'Service has been created', 53, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 02:38:01', '2023-05-23 02:38:01'),
(554, 1, 'ProductOrder', 'ProductOrder has been updated', 14, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 02:44:20', '2023-05-23 02:44:20'),
(555, 1, 'ProductOrder', 'ProductOrder has been updated', 14, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 02:45:15', '2023-05-23 02:45:15'),
(556, 1, 'ProductOrder', 'ProductOrder has been updated', 13, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 02:46:50', '2023-05-23 02:46:50'),
(557, 1, 'Service', 'Service has been created', 54, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 02:52:42', '2023-05-23 02:52:42'),
(558, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-23 08:40:13', '2023-05-23 08:40:13'),
(559, 1, 'Service', 'Service has been deleted', 52, 'App\\Models\\Service', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 08:40:39', '2023-05-23 08:40:39'),
(560, 1, 'Service', 'Service has been deleted', 51, 'App\\Models\\Service', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 08:49:05', '2023-05-23 08:49:05'),
(561, 1, 'Service', 'Service has been deleted', 50, 'App\\Models\\Service', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 08:49:24', '2023-05-23 08:49:24'),
(562, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-23 09:02:18', '2023-05-23 09:02:18'),
(563, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-23 14:02:14', '2023-05-23 14:02:14'),
(564, 1, 'ProductOrder', 'ProductOrder has been updated', 13, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 14:04:45', '2023-05-23 14:04:45'),
(565, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-23 14:12:06', '2023-05-23 14:12:06'),
(566, 1, 'Service', 'Service has been created', 55, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 14:53:58', '2023-05-23 14:53:58'),
(567, 1, 'Service', 'Service has been created', 56, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 15:12:33', '2023-05-23 15:12:33'),
(568, 1, 'Service', 'Service has been created', 57, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 15:36:53', '2023-05-23 15:36:53'),
(569, 1, 'Service', 'Service has been created', 58, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 16:46:32', '2023-05-23 16:46:32'),
(570, 1, 'Service', 'Service has been created', 59, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 16:47:34', '2023-05-23 16:47:34'),
(571, 1, 'ProductOrder', 'ProductOrder has been created', 17, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 16:49:01', '2023-05-23 16:49:01'),
(572, 1, 'Measurement', 'Measurement has been updated', 4, 'App\\Models\\Measurement', 'updated', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 16:50:41', '2023-05-23 16:50:41'),
(573, 1, 'Order', 'Order has been created', 7, 'App\\Models\\Order', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 16:51:03', '2023-05-23 16:51:03'),
(574, 1, 'Order', 'Order has been updated', 7, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 16:51:03', '2023-05-23 16:51:03'),
(575, 1, 'Service', 'Service has been created', 60, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 16:54:10', '2023-05-23 16:54:10'),
(576, 1, 'Service', 'Service has been created', 61, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 16:58:25', '2023-05-23 16:58:25'),
(577, 1, 'Service', 'Service has been created', 62, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 17:24:06', '2023-05-23 17:24:06'),
(578, 1, 'Service', 'Service has been created', 63, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 17:24:35', '2023-05-23 17:24:35'),
(579, 1, 'Service', 'Service has been created', 64, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 17:31:41', '2023-05-23 17:31:41'),
(580, 1, 'Service', 'Service has been created', 65, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 17:40:40', '2023-05-23 17:40:40'),
(581, 1, 'Service', 'Service has been created', 66, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 17:44:20', '2023-05-23 17:44:20'),
(582, 1, 'Service', 'Service has been created', 67, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 17:49:33', '2023-05-23 17:49:33'),
(583, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-05-23 20:05:43', '2023-05-23 20:05:43'),
(584, 1, 'Service', 'Service has been created', 68, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:07:00', '2023-05-23 20:07:00'),
(585, 1, 'Service', 'Service has been created', 69, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:13:54', '2023-05-23 20:13:54'),
(586, 1, 'Service', 'Service has been created', 70, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:16:19', '2023-05-23 20:16:19'),
(587, 1, 'Service', 'Service has been created', 71, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:19:50', '2023-05-23 20:19:50'),
(588, 1, 'Service', 'Service has been created', 72, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:21:04', '2023-05-23 20:21:04'),
(589, 1, 'Service', 'Service has been created', 73, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:25:03', '2023-05-23 20:25:03'),
(590, 1, 'Service', 'Service has been created', 74, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:26:40', '2023-05-23 20:26:40'),
(591, 1, 'Service', 'Service has been created', 75, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:28:26', '2023-05-23 20:28:26'),
(592, 1, 'Service', 'Service has been created', 76, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:28:54', '2023-05-23 20:28:54'),
(593, 1, 'Service', 'Service has been created', 77, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:35:31', '2023-05-23 20:35:31'),
(594, 1, 'Service', 'Service has been created', 78, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:37:30', '2023-05-23 20:37:30'),
(595, 1, 'ProductOrder', 'ProductOrder has been created', 18, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 20:42:08', '2023-05-23 20:42:08'),
(596, 1, 'ProductOrder', 'ProductOrder has been updated', 18, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:42:50', '2023-05-23 20:42:50'),
(597, 1, 'ProductOrder', 'ProductOrder has been updated', 18, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:43:02', '2023-05-23 20:43:02'),
(598, 1, 'ProductOrder', 'ProductOrder has been updated', 18, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:43:09', '2023-05-23 20:43:09'),
(599, 1, 'ProductOrder', 'ProductOrder has been updated', 18, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:43:26', '2023-05-23 20:43:26'),
(600, 1, 'ProductOrder', 'ProductOrder has been created', 19, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 20:45:01', '2023-05-23 20:45:01'),
(601, 1, 'ProductOrder', 'ProductOrder has been updated', 19, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:45:22', '2023-05-23 20:45:22'),
(602, 1, 'ProductOrder', 'ProductOrder has been updated', 19, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:45:30', '2023-05-23 20:45:30'),
(603, 1, 'ProductOrder', 'ProductOrder has been updated', 19, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:45:39', '2023-05-23 20:45:39'),
(604, 1, 'ProductOrder', 'ProductOrder has been updated', 19, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:45:53', '2023-05-23 20:45:53'),
(605, 1, 'ProductOrder', 'ProductOrder has been updated', 19, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:45:58', '2023-05-23 20:45:58'),
(606, 1, 'ProductOrder', 'ProductOrder has been created', 20, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 20:54:00', '2023-05-23 20:54:00'),
(607, 1, 'ProductOrder', 'ProductOrder has been updated', 20, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:54:21', '2023-05-23 20:54:21'),
(608, 1, 'Service', 'Service has been created', 79, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:55:23', '2023-05-23 20:55:23'),
(609, 1, 'Service', 'Service has been created', 80, 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 20:56:12', '2023-05-23 20:56:12'),
(610, 1, 'ProductOrder', 'ProductOrder has been created', 21, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 21:00:14', '2023-05-23 21:00:14'),
(611, 1, 'ProductOrder', 'ProductOrder has been updated', 21, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:00:45', '2023-05-23 21:00:45'),
(612, 1, 'ProductOrder', 'ProductOrder has been updated', 21, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:01:56', '2023-05-23 21:01:56'),
(613, 1, 'ProductOrder', 'ProductOrder has been updated', 21, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:03:20', '2023-05-23 21:03:20'),
(614, 1, 'ProductOrder', 'ProductOrder has been updated', 21, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:05:10', '2023-05-23 21:05:10'),
(615, 1, 'ProductOrder', 'ProductOrder has been updated', 21, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:06:43', '2023-05-23 21:06:43'),
(616, 1, 'ProductOrder', 'ProductOrder has been updated', 21, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:13:31', '2023-05-23 21:13:31'),
(617, 1, 'ProductOrder', 'ProductOrder has been updated', 21, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:27:10', '2023-05-23 21:27:10'),
(618, 1, 'ProductOrder', 'ProductOrder has been updated', 21, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:27:28', '2023-05-23 21:27:28'),
(619, 1, 'Order', 'Order has been created', 8, 'App\\Models\\Order', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 21:27:57', '2023-05-23 21:27:57'),
(620, 1, 'Order', 'Order has been updated', 8, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 21:27:58', '2023-05-23 21:27:58'),
(621, 1, 'Order', 'Order has been updated', 8, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:28:22', '2023-05-23 21:28:22'),
(622, 1, 'ProductOrder', 'ProductOrder has been created', 22, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 21:30:43', '2023-05-23 21:30:43'),
(623, 1, 'ProductOrder', 'ProductOrder has been updated', 22, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:31:16', '2023-05-23 21:31:16'),
(624, 1, 'ProductOrder', 'ProductOrder has been updated', 22, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:31:29', '2023-05-23 21:31:29'),
(625, 1, 'ProductOrder', 'ProductOrder has been updated', 22, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:31:51', '2023-05-23 21:31:51'),
(626, 1, 'ProductOrder', 'ProductOrder has been updated', 22, 'App\\Models\\ProductOrder', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:32:05', '2023-05-23 21:32:05'),
(627, 1, 'Order', 'Order has been created', 9, 'App\\Models\\Order', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 21:32:29', '2023-05-23 21:32:29'),
(628, 1, 'Order', 'Order has been updated', 9, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 21:32:29', '2023-05-23 21:32:29'),
(629, 1, 'Order', 'Order has been created', 10, 'App\\Models\\Order', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 21:32:55', '2023-05-23 21:32:55'),
(630, 1, 'Order', 'Order has been updated', 10, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 21:32:55', '2023-05-23 21:32:55'),
(631, 1, 'Order', 'Order has been updated', 10, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:33:22', '2023-05-23 21:33:22'),
(632, 1, 'Order', 'Order has been updated', 10, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:34:12', '2023-05-23 21:34:12'),
(633, 1, 'Order', 'Order has been created', 11, 'App\\Models\\Order', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 21:38:41', '2023-05-23 21:38:41'),
(634, 1, 'Order', 'Order has been updated', 11, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\Customer', '[]', NULL, '2023-05-23 21:38:41', '2023-05-23 21:38:41'),
(635, 1, 'Order', 'Order has been updated', 11, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:39:00', '2023-05-23 21:39:00'),
(636, 1, 'Order', 'Order has been updated', 11, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:39:14', '2023-05-23 21:39:14'),
(637, 1, 'Order', 'Order has been updated', 11, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:39:23', '2023-05-23 21:39:23'),
(638, 1, 'Order', 'Order has been updated', 11, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-05-23 21:39:32', '2023-05-23 21:39:32'),
(639, 1, 'Service', 'Service has been deleted', 80, 'App\\Models\\Service', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-06-02 15:18:17', '2023-06-02 15:18:17'),
(640, 1, 'Service', 'Service has been deleted', 79, 'App\\Models\\Service', 'deleted', 1, 'App\\Models\\User', '[]', NULL, '2023-06-02 15:18:31', '2023-06-02 15:18:31'),
(641, 1, 'Order', 'Order has been updated', 10, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-06-02 15:22:56', '2023-06-02 15:22:56'),
(642, 1, 'Order', 'Order has been updated', 10, 'App\\Models\\Order', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-06-02 15:23:24', '2023-06-02 15:23:24'),
(643, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-06-08 02:57:53', '2023-06-08 02:57:53'),
(644, 1, 'Salary', 'User (Ivo Svisco) salary created 1200.0000', 18, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-06-08 05:05:12', '2023-06-08 05:05:12'),
(645, 1, 'Salary', 'User (Elvijs Mūrnieks) salary created 1000.0000', 19, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-06-08 05:05:12', '2023-06-08 05:05:12'),
(646, 1, 'Salary', 'User (Andris Berziņš) salary created 500.0000', 20, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-06-08 05:05:12', '2023-06-08 05:05:12'),
(647, 1, 'Salary', 'User (Jānis Markavs) salary created 1000.0000', 21, 'App\\Models\\Salary', NULL, 1, 'App\\Models\\User', '[]', NULL, '2023-06-08 05:05:12', '2023-06-08 05:05:12'),
(648, 1, 'Service', 'Service has been updated', 6, 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', '[]', NULL, '2023-06-08 05:08:55', '2023-06-08 05:08:55'),
(649, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-06-08 05:20:07', '2023-06-08 05:20:07'),
(650, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-06-08 15:18:55', '2023-06-08 15:18:55'),
(651, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-06-09 07:44:30', '2023-06-09 07:44:30'),
(652, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-06-09 10:39:23', '2023-06-09 10:39:23'),
(653, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-06-19 12:34:47', '2023-06-19 12:34:47'),
(654, 1, 'ProductOrder', 'ProductOrder has been created', 23, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-07-04 08:07:25', '2023-07-04 08:07:25'),
(655, 1, 'ProductOrder', 'ProductOrder has been created', 24, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-07-05 04:23:21', '2023-07-05 04:23:21'),
(656, 1, 'ProductOrder', 'ProductOrder has been created', 25, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-07-05 06:41:01', '2023-07-05 06:41:01'),
(657, 1, 'ProductOrder', 'ProductOrder has been created', 26, 'App\\Models\\ProductOrder', 'created', 1, 'App\\Models\\Customer', '[]', NULL, '2023-07-07 06:44:52', '2023-07-07 06:44:52'),
(658, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"69vElmYWMRhMofG99U1rFQ9cpklRlfB4qXA0xwmwRIF1UzK3UMIQZ8mnHvg9\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-07-26 07:17:35', '2023-07-26 07:17:35'),
(659, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.lv\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.lv\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"ssl\",\"MAIL_USERNAME\":\"_mainaccount@isuits.lv\",\"MAIL_PASSWORD\":\"6-3N5tIc5SmjQ(\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-07-26 07:25:19', '2023-07-26 07:25:19');
INSERT INTO `activity_log` (`id`, `account_id`, `log_name`, `description`, `subject_id`, `subject_type`, `event`, `causer_id`, `causer_type`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(660, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null,\"logo_path\":\"1690353216.png\"},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.lv\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.lv\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"ssl\",\"MAIL_USERNAME\":\"_mainaccount@isuits.lv\",\"MAIL_PASSWORD\":\"6-3N5tIc5SmjQ(\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-07-26 07:33:36', '2023-07-26 07:33:36'),
(661, 1, 'default', 'model_updated', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null,\"logo_path\":\"1690353821.png\"},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.lv\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.lv\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"ssl\",\"MAIL_USERNAME\":\"_mainaccount@isuits.lv\",\"MAIL_PASSWORD\":\"6-3N5tIc5SmjQ(\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-07-26 07:43:41', '2023-07-26 07:43:41'),
(662, 1, 'default', 'model_updated', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null,\"logo_path\":\"1690353928.png\"},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.lv\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.lv\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"ssl\",\"MAIL_USERNAME\":\"_mainaccount@isuits.lv\",\"MAIL_PASSWORD\":\"6-3N5tIc5SmjQ(\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-07-26 07:45:28', '2023-07-26 07:45:28'),
(663, 1, 'default', 'model_updated', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null,\"logo_path\":\"1690354204.png\"},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.lv\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.lv\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"ssl\",\"MAIL_USERNAME\":\"_mainaccount@isuits.lv\",\"MAIL_PASSWORD\":\"6-3N5tIc5SmjQ(\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-07-26 07:50:04', '2023-07-26 07:50:04'),
(664, 1, 'default', 'model_updated', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null,\"logo_path\":\"1690354236.png\"},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"ISuits SIA\",\"MAIL_FROM_ADDRESS\":\"tavsuzvalks@isuits.lv\",\"APP_TIMEZONE\":\"Europe\\/Riga\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"mail.isuits.lv\",\"MAIL_PORT\":\"465\",\"MAIL_ENCRYPTION\":\"ssl\",\"MAIL_USERNAME\":\"_mainaccount@isuits.lv\",\"MAIL_PASSWORD\":\"6-3N5tIc5SmjQ(\",\"STRIPE_KEY\":\"pk_test_51Ilrh9FocpD8X0bajrqfsxAjaGWf6Fhc3KSr9K4qTWUoKZabnomP6nQdiFyJxcDKGnIDhnl1fPo0y9TwdjDvuxeg00ExwB3e1G\",\"STRIPE_SECRET\":\"sk_test_51Ilrh9FocpD8X0basGY6XqARWTPSbL9SMontucyMdL2LoLpt6ARp4TEOj2E3fa7Ip0U2WXPuNTGBrRNtd1qkBGHF000yLqcb0y\",\"STRIPE_CURRENCY\":\"EUR\",\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"test\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"test\",\"PAYU_BIZ_KEY\":\"pRRXKOl8ikMmt9u\",\"PAYU_BIZ_SALT\":\"4Vj8eK4rloUd272L48hsrarnUA\",\"SMS_FROM\":\"ISuits\",\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":\"BzIeyGTMNB4SuZRNJPrW25qjYHQSnGR5cGyGGrArSkMhMikeyuuXvhEXPTDlTmXd\",\"MIRRORSIZE_MERCHANT_ID\":\"info@isuits.lv\",\"MIRRORSIZE_USERNAME\":\"PI0U_ivo123\",\"MONEZIUM_SITE_KEY\":\"c272a3ff-463e-420c-8a2a-42005220b721\",\"MONEZIUM_SHOP_KEY\":\"MT-Hnb23DO1pCm1\",\"SOCKET_SERVER_URL\":\"https:\\/\\/node.isuits.lv\"}}', NULL, '2023-07-26 07:50:36', '2023-07-26 07:50:36'),
(665, 1, 'ProductOrder', 'ProductOrder has been created', 27, 'App\\Models\\ProductOrder', 'created', 10, 'App\\Models\\Customer', '[]', NULL, '2023-07-26 11:18:20', '2023-07-26 11:18:20'),
(666, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"OLBIXajMzKQK2kJ9B6qqxF1hvgW2mtm7ubCNlVWpFk0mH2Z7wr1mT89NG4zT\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-07-26 12:58:42', '2023-07-26 12:58:42'),
(667, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"OLBIXajMzKQK2kJ9B6qqxF1hvgW2mtm7ubCNlVWpFk0mH2Z7wr1mT89NG4zT\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-07-26 13:59:42', '2023-07-26 13:59:42'),
(668, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":\"1\",\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":\"0\",\"view_all\":\"0\",\"edit_all\":\"0\",\"remember_token\":\"OLBIXajMzKQK2kJ9B6qqxF1hvgW2mtm7ubCNlVWpFk0mH2Z7wr1mT89NG4zT\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-07-28 07:01:43', '2023-07-28 07:01:43'),
(669, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"OLBIXajMzKQK2kJ9B6qqxF1hvgW2mtm7ubCNlVWpFk0mH2Z7wr1mT89NG4zT\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-04-10T04:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-02 13:44:39', '2023-08-02 13:44:39'),
(670, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"OLBIXajMzKQK2kJ9B6qqxF1hvgW2mtm7ubCNlVWpFk0mH2Z7wr1mT89NG4zT\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-04-10T04:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-03 04:55:47', '2023-08-03 04:55:47'),
(671, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"0q9NlJrxrvZH9lHwxzMs14eRFVjlFYaWG2WLqANd02siwCgJZy1ahgkL4Dht\",\"created_at\":\"2023-03-15T15:33:09.000000Z\",\"updated_at\":\"2023-04-10T04:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-03 12:39:17', '2023-08-03 12:39:17'),
(672, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"Tailor Shop\\\"\",\"MAIL_FROM_ADDRESS\":\"noreply@testmail.com\",\"APP_TIMEZONE\":\"Europe\\/Andorra\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"smtp.mailtrap.io\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":null,\"MAIL_PASSWORD\":null,\"STRIPE_KEY\":null,\"STRIPE_SECRET\":null,\"STRIPE_CURRENCY\":null,\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"live\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"live\",\"PAYU_BIZ_KEY\":null,\"PAYU_BIZ_SALT\":null,\"SMS_FROM\":null,\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":null,\"MIRRORSIZE_MERCHANT_ID\":null,\"MIRRORSIZE_USERNAME\":null,\"MONEZIUM_SITE_KEY\":null,\"MONEZIUM_SHOP_KEY\":null,\"SOCKET_SERVER_URL\":null}}', NULL, '2023-08-03 12:45:00', '2023-08-03 12:45:00'),
(673, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"0q9NlJrxrvZH9lHwxzMs14eRFVjlFYaWG2WLqANd02siwCgJZy1ahgkL4Dht\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-07 13:07:08', '2023-08-07 13:07:08'),
(674, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"Tailor Shop\\\\\",\"MAIL_FROM_ADDRESS\":\"noreply@testmail.com\",\"APP_TIMEZONE\":\"Africa\\/Harare\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"smtp.mailtrap.io\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":null,\"MAIL_PASSWORD\":null,\"STRIPE_KEY\":null,\"STRIPE_SECRET\":null,\"STRIPE_CURRENCY\":null,\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"live\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"live\",\"PAYU_BIZ_KEY\":null,\"PAYU_BIZ_SALT\":null,\"SMS_FROM\":null,\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":null,\"MIRRORSIZE_MERCHANT_ID\":null,\"MIRRORSIZE_USERNAME\":null,\"MONEZIUM_SITE_KEY\":null,\"MONEZIUM_SHOP_KEY\":null,\"SOCKET_SERVER_URL\":null}}', NULL, '2023-08-07 13:25:58', '2023-08-07 13:25:58'),
(675, 1, 'default', 'Settings has been successfully updated.', 1, 'App\\Models\\Account', NULL, 1, 'App\\Models\\User', '{\"account\":{\"name\":\"ISuits SIA\",\"phone\":\"+37126443333\",\"email\":\"info@isuits.lv\",\"gateways\":\"Cash,Monezium,Wire Transfer,Credit Card\",\"default_tax\":\"1\",\"per_page\":\"10\",\"address\":\"Rupniec\\u012bbas iela 19 ofiss 2, R\\u012bga\",\"header\":\"Uzticiet sava st\\u0101sta veido\\u0161anu meistariem ar vair\\u0101ku paaud\\u017eu mantotu pieredzi.\",\"footer\":\"Luminor Banka AS\\r\\nSWIFT\\/BIC: RIKOLV22\\r\\nKonts: LV70RIKO0002930274173\",\"email_enabled\":1,\"sms_enabled\":0,\"payu\":0,\"stripe\":0,\"direction\":\"ltr\",\"language\":\"en\",\"fraction\":\"2\",\"default_locale\":null},\"config\":{\"APP_NAME\":\"ISuits SIA\",\"MAIL_FROM_NAME\":\"Tailor Shop\\\\\\\\\",\"MAIL_FROM_ADDRESS\":\"noreply@testmail.com\",\"APP_TIMEZONE\":\"Europe\\/Vilnius\",\"MAIL_MAILER\":\"smtp\",\"MAIL_HOST\":\"smtp.mailtrap.io\",\"MAIL_PORT\":\"2525\",\"MAIL_ENCRYPTION\":null,\"MAIL_USERNAME\":null,\"MAIL_PASSWORD\":null,\"STRIPE_KEY\":null,\"STRIPE_SECRET\":null,\"STRIPE_CURRENCY\":null,\"PAYU_DEFAULT_GATEWAY\":\"biz\",\"PAYU_MONEY_MODE\":\"live\",\"PAYU_MONEY_KEY\":null,\"PAYU_MONEY_SALT\":null,\"PAYU_MONEY_AUTH\":null,\"PAYU_BIZ_MODE\":\"live\",\"PAYU_BIZ_KEY\":null,\"PAYU_BIZ_SALT\":null,\"SMS_FROM\":null,\"VONAGE_KEY\":null,\"VONAGE_SECRET\":null,\"VONAGE_SIGNATURE_SECRET\":null,\"MAILGUN_DOMAIN\":null,\"MAILGUN_SECRET\":null,\"MAILGUN_ENDPOINT\":null,\"AWS_ACCESS_KEY_ID\":null,\"AWS_SECRET_ACCESS_KEY\":null,\"AWS_DEFAULT_REGION\":null,\"MIRRORSIZE_API_KEY\":null,\"MIRRORSIZE_MERCHANT_ID\":null,\"MIRRORSIZE_USERNAME\":null,\"MONEZIUM_SITE_KEY\":null,\"MONEZIUM_SHOP_KEY\":null,\"SOCKET_SERVER_URL\":null}}', NULL, '2023-08-07 13:36:50', '2023-08-07 13:36:50'),
(676, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"0q9NlJrxrvZH9lHwxzMs14eRFVjlFYaWG2WLqANd02siwCgJZy1ahgkL4Dht\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-07 22:13:21', '2023-08-07 22:13:21'),
(677, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"0q9NlJrxrvZH9lHwxzMs14eRFVjlFYaWG2WLqANd02siwCgJZy1ahgkL4Dht\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-08 02:00:36', '2023-08-08 02:00:36'),
(678, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"0q9NlJrxrvZH9lHwxzMs14eRFVjlFYaWG2WLqANd02siwCgJZy1ahgkL4Dht\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-08 02:29:44', '2023-08-08 02:29:44'),
(679, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"0q9NlJrxrvZH9lHwxzMs14eRFVjlFYaWG2WLqANd02siwCgJZy1ahgkL4Dht\",\"created_at\":\"2023-03-15T13:33:09.000000Z\",\"updated_at\":\"2023-04-10T01:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-08 07:55:03', '2023-08-08 07:55:03'),
(680, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"0q9NlJrxrvZH9lHwxzMs14eRFVjlFYaWG2WLqANd02siwCgJZy1ahgkL4Dht\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-17 08:51:08', '2023-08-17 08:51:08'),
(681, 1, 'Payment', 'Payment has been created', 15, 'App\\Models\\Payment', 'created', 1, 'App\\Models\\User', '[]', NULL, '2023-08-17 09:32:58', '2023-08-17 09:32:58'),
(682, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"0q9NlJrxrvZH9lHwxzMs14eRFVjlFYaWG2WLqANd02siwCgJZy1ahgkL4Dht\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-18 02:16:38', '2023-08-18 02:16:38'),
(683, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"WEUzik75JKEZcAmCst51ejvZxFMkHRm4KyC4l7GIbpbDzTpTMdjfkD9Txvu5\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-18 02:48:36', '2023-08-18 02:48:36'),
(684, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"Y2U8pXGq4jtGleiekrYqeRKf16xTyJ95M4E6B5dU3SpYBSdqCOYxRyI5OhZq\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-18 09:51:34', '2023-08-18 09:51:34'),
(685, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"Y2U8pXGq4jtGleiekrYqeRKf16xTyJ95M4E6B5dU3SpYBSdqCOYxRyI5OhZq\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-18 22:03:54', '2023-08-18 22:03:54'),
(686, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"ZCClCQEHpBHg68Z6ohjy5CAFNrJwOkmuPFnXdf5yGQ6wZZp7nXVqNvGhL8Zx\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-19 03:13:34', '2023-08-19 03:13:34'),
(687, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"ZCClCQEHpBHg68Z6ohjy5CAFNrJwOkmuPFnXdf5yGQ6wZZp7nXVqNvGhL8Zx\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-21 19:21:13', '2023-08-21 19:21:13'),
(688, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"ZCClCQEHpBHg68Z6ohjy5CAFNrJwOkmuPFnXdf5yGQ6wZZp7nXVqNvGhL8Zx\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-22 06:19:54', '2023-08-22 06:19:54'),
(689, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"ZCClCQEHpBHg68Z6ohjy5CAFNrJwOkmuPFnXdf5yGQ6wZZp7nXVqNvGhL8Zx\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-22 08:32:19', '2023-08-22 08:32:19'),
(690, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"ZCClCQEHpBHg68Z6ohjy5CAFNrJwOkmuPFnXdf5yGQ6wZZp7nXVqNvGhL8Zx\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-23 10:06:09', '2023-08-23 10:06:09'),
(691, 1, 'default', 'User has been logged in', 1, 'App\\Models\\User', NULL, 1, 'App\\Models\\User', '{\"user\":{\"id\":1,\"account_id\":1,\"name\":\"Ivo Svisco\",\"phone\":\"+37129266821\",\"email\":\"ivo@svisco.lv\",\"username\":\"isuits\",\"password\":\"$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3\\/o5sy3.B2DLeAkQqeBpb3Cq9cvda\",\"owner\":true,\"salary\":\"1200.0000\",\"photo_path\":\"avatars\\/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg\",\"can_sms\":0,\"view_all\":0,\"edit_all\":0,\"remember_token\":\"ZCClCQEHpBHg68Z6ohjy5CAFNrJwOkmuPFnXdf5yGQ6wZZp7nXVqNvGhL8Zx\",\"created_at\":\"2023-03-15T14:33:09.000000Z\",\"updated_at\":\"2023-04-10T02:48:13.000000Z\",\"deleted_at\":null,\"active\":true}}', NULL, '2023-08-23 14:26:06', '2023-08-23 14:26:06');

-- --------------------------------------------------------

--
-- Table structure for table `billing_addresses`
--

CREATE TABLE `billing_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fname` varchar(191) NOT NULL,
  `lname` varchar(191) NOT NULL,
  `country` varchar(191) NOT NULL,
  `state` varchar(191) NOT NULL,
  `address` varchar(191) NOT NULL,
  `city` varchar(191) NOT NULL,
  `zipcode` varchar(191) NOT NULL,
  `vatcode` varchar(191) NOT NULL,
  `fiscalcode` varchar(191) NOT NULL,
  `recipientcode` varchar(191) NOT NULL,
  `taxcode` varchar(191) NOT NULL,
  `certified_email` varchar(191) NOT NULL,
  `other` varchar(191) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `billing_addresses`
--

INSERT INTO `billing_addresses` (`id`, `fname`, `lname`, `country`, `state`, `address`, `city`, `zipcode`, `vatcode`, `fiscalcode`, `recipientcode`, `taxcode`, `certified_email`, `other`, `customer_id`, `deleted_at`, `created_at`, `updated_at`, `is_default`) VALUES
(1, 'Aleksandar', 'Todorovic', 'Latvia', 'Aglona Municipality', 'Konatice Noname street 378', 'Konatice', '11506', '432', '342', '42', '3234', 'aleksandart450@gmail.com', NULL, 1, NULL, '2023-04-05 07:43:52', '2023-05-22 06:51:59', 1),
(2, 'Ivo', 'Sviščo', 'Latvia (Latvija)', 'Rigas', 'Rudens 6-28, Riga, Latvia', 'Riga', 'LV-1082', 'None', 'None', 'None', 'None', 'ivo@svisco.lv', NULL, 3, NULL, '2023-05-02 08:55:41', '2023-07-26 08:26:58', 1),
(3, 'Rols', 'Rols', 'Latvia (Latvija)', 'Hamburh', '5. 40472', 'Duesseldorf', 'Franz-Rennefeld-Weg', '444444', '44444', '44444', '434343443', 'eno.eht.ais@gmail.com', NULL, 10, NULL, '2023-07-26 11:18:06', '2023-07-26 11:18:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `customization` text DEFAULT NULL,
  `unit` double NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_order_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `customer_id`, `product_id`, `customization`, `unit`, `quantity`, `deleted_at`, `created_at`, `updated_at`, `product_order_id`) VALUES
(1, 1, 6, '{\"Buttons\":\"3 Buttons\",\"Lapel\":\"Slim Peak\",\"Cuff\":\"54\"}', 24.6, 1, '2023-03-24 05:36:15', '2023-03-23 13:36:36', '2023-03-24 05:36:15', NULL),
(2, 1, 10, '{\"Vents\":\"Single Vent\",\"Buttons\":\"6 Double Breasted\",\"Lapels\":\"Slim Peak\",\"Lining\":\"Charcoal Plain Lining\",\"Pleats\":\"With Pleat\",\"Cuff\":\"With Cuff\"}', 794, 1, NULL, '2023-03-23 15:06:05', '2023-03-29 05:37:57', 1),
(3, 1, 10, 'null', 794, 3, '2023-03-24 05:36:03', '2023-03-23 15:08:05', '2023-03-24 05:36:03', NULL),
(4, 1, 1, 'null', 35.1, 1, NULL, '2023-03-29 05:42:18', '2023-03-29 05:52:11', 2),
(5, 1, 2, 'null', 24.5, 1, NULL, '2023-03-29 05:55:20', '2023-03-29 06:59:46', 3),
(6, 1, 3, 'null', 50, 1, NULL, '2023-03-29 06:56:37', '2023-03-29 06:59:46', 3),
(7, 1, 6, 'null', 24.6, 1, NULL, '2023-03-29 07:01:54', '2023-03-29 07:12:22', 4),
(8, 1, 5, 'null', 30.4, 1, NULL, '2023-03-29 07:14:39', '2023-03-29 07:15:15', 5),
(9, 1, 2, 'null', 24.5, 1, '2023-04-04 04:34:55', '2023-03-29 07:16:25', '2023-04-04 04:34:55', NULL),
(10, 1, 10, 'null', 794, 1, NULL, '2023-03-29 07:16:34', '2023-04-04 04:50:38', 6),
(11, 1, 3, 'null', 50, 1, NULL, '2023-03-29 07:46:34', '2023-04-04 04:50:38', 6),
(12, 1, 10, '{\"Customize Your Garment\":\"Slim\",\"Customize Your Blazer\":\"Slim\",\"Lapels\":\"Shawl\",\"Buttons\":\"1 Button\",\"Pockets\":\"Normal Pocket\",\"Vents\":\"Without Vent\",\"Lining\":\"Tailors Choice\",\"Pleats\":\"Without Pleat\"}', 794, 1, '2023-04-04 04:34:51', '2023-03-31 04:29:59', '2023-04-04 04:34:51', NULL),
(13, 1, 2, '{\"Lapels\":\"Slim Notch\",\"Buttons\":\"4 Double Breasted\",\"Cuff\":\"With Cuff\"}', 24.5, 1, NULL, '2023-04-02 06:39:20', '2023-04-04 04:50:38', 6),
(14, 1, 1, '{\"Customize Your Garment\":\"Classic\",\"Customize Your Blazer\":\"Classic\",\"Lapels\":\"Slim Peak\",\"Buttons\":\"4 Double Breasted\",\"Pockets\":\"Normal With Ticket Pocket\",\"Vents\":\"Double Vent\",\"Lining\":\"Charcoal Plain Lining\",\"Pleats\":\"With Pleat\"}', 35.1, 2, '2023-04-04 04:34:44', '2023-04-04 04:23:37', '2023-04-04 04:34:44', NULL),
(15, 1, 1, '{\"Customize Your Garment\":\"Classic\",\"Customize Your Blazer\":\"Slim\",\"Lapels\":\"Slim Peak\",\"Buttons\":\"6 Double Breasted (2 Unfasten)\",\"Pockets\":\"Normal With Ticket Pocket\",\"Vents\":\"Single Vent\",\"Lining\":\"Salmon Plain Lining\",\"Pleats\":\"With Pleat\"}', 35.1, 1, NULL, '2023-04-04 04:34:36', '2023-04-04 04:50:38', 6),
(16, 1, 1, '{\"Customize Your Garment\":\"Classic\",\"Customize Your Blazer\":\"Classic\",\"Lapels\":\"Slim Peak\",\"Buttons\":\"6 Double Breasted (2 Unfasten)\",\"Pockets\":\"Slanted Pocket\",\"Vents\":\"Single Vent\",\"Lining\":\"Salmon Plain Lining\",\"Pleats\":\"With Pleat\"}', 35.1, 1, NULL, '2023-04-04 04:56:38', '2023-04-04 04:57:30', 7),
(17, 1, 4, 'null', 21.5, 1, NULL, '2023-04-05 05:23:00', '2023-04-05 05:27:39', 8),
(18, 1, 5, '{\"Customize Your Shirt\":\"Slim\",\"Collar\":\"Standard\",\"Buttons\":\"Button Style 3\",\"Pocket\":\"Single Pocket\",\"Facing\":\"Facing\"}', 30.4, 1, NULL, '2023-04-05 07:36:30', '2023-04-05 07:41:41', 9),
(19, 1, 10, '{\"Customize Your Garment\":\"Classic\",\"Customize Your Blazer\":\"Slim\",\"Lapels\":\"Notch\",\"Buttons\":\"3 Buttons\",\"Pockets\":\"Slanted Pocket\",\"Vents\":\"Single Vent\",\"Lining\":\"Light Purple Lining\",\"Pleats\":\"With Pleat\"}', 794, 1, NULL, '2023-04-05 07:38:42', '2023-04-05 07:41:41', 9),
(20, 3, 1, 'null', 35.1, 1, NULL, '2023-04-10 10:35:32', '2023-05-03 17:06:55', 12),
(21, 3, 1, '{\"Customize Your Garment\":\"Classic\",\"Customize Your Blazer\":\"Slim\",\"Lapels\":\"Shawl\",\"Buttons\":\"1 Button\",\"Pockets\":\"Normal Pocket\",\"Vents\":\"Without Vent\",\"Lining\":\"Tailors Choice\",\"Pleats\":\"Without Pleat\"}', 35.1, 1, NULL, '2023-04-10 11:20:01', '2023-05-03 17:06:55', 12),
(22, 3, 2, '{\"Lapels\":\"Shawl\",\"Buttons\":\"1 Button\",\"Cuff\":\"Without Cuff\"}', 24.5, 1, NULL, '2023-04-10 13:47:52', '2023-05-03 17:06:55', 12),
(23, 1, 1, 'null', 35.1, 1, NULL, '2023-04-13 18:02:36', '2023-04-17 07:11:38', 10),
(24, 1, 1, 'null', 35.1, 1, NULL, '2023-04-15 04:02:30', '2023-04-17 07:11:38', 10),
(25, 1, 9, '{\"Customize Your Garment\":\"Classic\",\"Customize Your Blazer\":\"Classic\",\"Lapels\":\"Slim Notch\",\"Buttons\":\"1 Button\",\"Pockets\":\"Normal Pocket\",\"Vents\":\"Without Vent\",\"Lining\":\"Light Purple Lining\",\"Pleats\":\"Without Pleat\"}', 499, 1, NULL, '2023-04-17 07:09:44', '2023-04-17 07:11:38', 10),
(26, 1, 9, 'null', 499, 1, NULL, '2023-04-17 07:12:27', '2023-04-20 01:39:51', 11),
(27, 1, 1, '{\"Customize Your Garment\":\"Slim\",\"Customize Your Blazer\":\"Slim\",\"Lapels\":\"Notch\",\"Buttons\":\"1 Button\",\"Pockets\":\"Normal Pocket\",\"Vents\":\"Without Vent\",\"Lining\":\"Light Purple Lining\",\"Pleats\":\"Without Pleat\"}', 35.1, 1, NULL, '2023-04-20 01:39:21', '2023-04-20 01:39:51', 11),
(28, 1, 7, 'null', 40, 1, NULL, '2023-04-20 03:28:56', '2023-05-22 06:52:09', 13),
(29, 3, 1, '{\"Customize Your Garment\":\"Classic\",\"Customize Your Blazer\":\"Classic\",\"Lapels\":\"Shawl\",\"Buttons\":\"2 Buttons\",\"Pockets\":\"Slanted Pocket Without Flaps\",\"Vents\":\"Single Vent\",\"Lining\":\"Light Purple Lining\",\"Pleats\":\"With Pleat\"}', 35.1, 1, NULL, '2023-05-02 07:34:45', '2023-05-03 17:06:55', 12),
(30, 3, 1, 'null', 35.1, 1, NULL, '2023-05-03 17:04:36', '2023-05-03 17:06:55', 12),
(31, 1, 2, 'null', 24.5, 1, NULL, '2023-05-11 00:41:02', '2023-05-22 06:52:09', 13),
(32, 3, 1, '{\"Customize Your Garment\":\"Slim\",\"Customize Your Blazer\":\"Slim\",\"Lapels\":\"Shawl\",\"Buttons\":\"1 Button\",\"Pockets\":\"Normal Pocket\",\"Vents\":\"Without Vent\",\"Lining\":\"Tailors Choice\",\"Pleats\":\"Without Pleat\"}', 35.1, 1, NULL, '2023-05-11 06:45:55', '2023-05-22 08:38:43', 15),
(33, 3, 1, '{\"Customize Your Garment\":\"Slim\",\"Customize Your Blazer\":\"Slim\",\"Lapels\":\"Shawl\",\"Buttons\":\"1 Button\",\"Pockets\":\"Normal Pocket\",\"Vents\":\"Without Vent\",\"Lining\":\"Tailors Choice\",\"Pleats\":\"Without Pleat\"}', 35.1, 1, NULL, '2023-05-11 08:36:21', '2023-05-22 08:38:43', 15),
(34, 1, 2, 'null', 24.5, 1, NULL, '2023-05-22 06:51:49', '2023-05-22 06:52:09', 13),
(35, 1, 6, '{\"Lapels\":\"Shawl\",\"Buttons\":\"1 Button\",\"Cuff\":\"Without Cuff\"}', 24.6, 1, NULL, '2023-05-22 08:30:06', '2023-05-22 08:30:21', 14),
(36, 3, 7, 'null', 40, 1, NULL, '2023-05-22 08:38:27', '2023-05-22 08:38:43', 15),
(37, 3, 2, 'null', 24.5, 1, NULL, '2023-05-22 08:39:13', '2023-05-22 08:39:31', 16),
(38, 1, 1, 'null', 35.1, 1, NULL, '2023-05-23 16:48:50', '2023-05-23 16:49:01', 17),
(39, 1, 1, 'null', 35.1, 1, NULL, '2023-05-23 20:42:00', '2023-05-23 20:42:08', 18),
(40, 1, 1, 'null', 35.1, 1, NULL, '2023-05-23 20:44:54', '2023-05-23 20:45:01', 19),
(41, 1, 1, 'null', 35.1, 1, NULL, '2023-05-23 20:53:52', '2023-05-23 20:54:00', 20),
(42, 1, 1, 'null', 35.1, 1, NULL, '2023-05-23 21:00:07', '2023-05-23 21:00:14', 21),
(43, 1, 1, 'null', 35.1, 1, NULL, '2023-05-23 21:30:34', '2023-05-23 21:30:43', 22),
(44, 1, 3, 'null', 50, 1, NULL, '2023-07-04 06:05:21', '2023-07-04 08:07:26', 23),
(45, 1, 2, 'null', 24.5, 1, NULL, '2023-07-04 15:49:20', '2023-07-05 04:23:21', 24),
(46, 1, 1, 'null', 35.1, 1, NULL, '2023-07-05 06:37:22', '2023-07-05 06:41:01', 25),
(47, 1, 4, 'null', 21.5, 1, NULL, '2023-07-05 06:41:58', '2023-07-07 06:44:52', 26),
(48, 3, 4, '{\"Customize Your Shirt\":\"Slim\",\"Collar\":\"Windsor\",\"Buttons\":\"Button Style 4\",\"Pocket\":\"No Pockets\",\"Facing\":\"Facing\"}', 21.5, 1, NULL, '2023-07-26 08:20:21', '2023-07-26 08:20:21', NULL),
(49, 10, 7, 'null', 40, 1, NULL, '2023-07-26 11:12:13', '2023-07-26 11:18:20', 27),
(50, 10, 3, 'null', 50, 1, NULL, '2023-07-26 11:19:06', '2023-07-26 11:19:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `photo` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `photo`, `deleted_at`, `created_at`, `updated_at`) VALUES
(2, 'Jeans', 'Jeans are a type of pants traditionally made from denim (a kind of cotton fabric).', '1679463807.png', NULL, '2023-03-20 19:57:32', '2023-03-22 04:43:27'),
(3, 'Shirt', 'A long- or short-sleeved garment for the upper part of the body', '1679565341.jpg', NULL, '2023-03-20 20:02:22', '2023-03-23 08:55:41'),
(4, 'Trousers', 'Trousers', '1679384261.png', NULL, '2023-03-21 00:18:35', '2023-03-21 06:37:41'),
(5, 'Watch', 'Note that enums are not supported by all database systems, so it\'s important to check if your database supports enums before using them in your migrations. In addition, some database systems may require additional configuration or syntax to work with enums.', '1679384311.png', '2023-03-23 15:34:29', '2023-03-21 06:38:31', '2023-03-23 15:34:29'),
(12, 'Suit', 'These suits are usually made from high-quality fabrics such as wool, silk, or linen and are hand-sewn to achieve a perfect fit.', '1681721841.jpg', NULL, '2023-03-22 08:07:03', '2023-04-17 09:57:21'),
(13, 'Sport Suit', 'Sport Suit', '1681721918.jpg', NULL, '2023-04-17 09:58:38', '2023-04-17 09:58:38');

-- --------------------------------------------------------

--
-- Table structure for table `category_custom_field`
--

CREATE TABLE `category_custom_field` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `custom_field_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `category_custom_field`
--

INSERT INTO `category_custom_field` (`category_id`, `custom_field_id`) VALUES
(2, 3),
(2, 9),
(2, 10),
(3, 11),
(3, 12),
(3, 13),
(3, 14),
(3, 15),
(4, 5),
(4, 10),
(12, 2),
(12, 3),
(12, 4),
(12, 5),
(12, 9),
(12, 16),
(12, 17),
(12, 18),
(13, 3),
(13, 5),
(13, 9),
(13, 15),
(13, 16);

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `from_user` tinyint(1) NOT NULL DEFAULT 0,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `is_accepted` tinyint(1) NOT NULL DEFAULT 0,
  `attachment` varchar(191) DEFAULT NULL,
  `reaction` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `chats`
--

INSERT INTO `chats` (`id`, `customer_id`, `user_id`, `text`, `from_user`, `is_read`, `is_accepted`, `attachment`, `reaction`, `deleted_at`, `created_at`, `updated_at`) VALUES
(13, 1, 1, 'Hi.', 0, 1, 1, NULL, NULL, NULL, '2023-05-05 08:44:02', '2023-05-18 18:32:37'),
(14, 1, 1, 'Hello, Ivo', 0, 1, 1, NULL, NULL, NULL, '2023-05-05 08:44:15', '2023-05-18 18:32:37'),
(15, 1, 1, 'Hi', 1, 1, 1, NULL, NULL, NULL, '2023-05-05 08:44:26', '2023-05-18 18:32:37'),
(16, 1, 1, 'Nice to meet you', 1, 1, 1, NULL, NULL, NULL, '2023-05-05 08:44:28', '2023-05-18 18:32:37'),
(17, 1, 1, 'How are you doing?', 0, 1, 1, NULL, NULL, NULL, '2023-05-05 08:44:38', '2023-05-18 18:32:37'),
(18, 1, 1, 'Hello\nHow are you?', 0, 1, 1, NULL, NULL, NULL, '2023-05-11 00:30:34', '2023-05-18 18:32:37'),
(19, 3, 1, 'Hi.', 0, 1, 1, NULL, NULL, NULL, '2023-05-14 18:51:37', '2023-05-18 18:31:25'),
(20, 1, 1, 'hello', 1, 1, 1, NULL, NULL, NULL, '2023-05-18 18:31:41', '2023-05-18 18:32:37'),
(21, 1, 1, 'How are you?', 1, 1, 1, NULL, NULL, NULL, '2023-05-18 18:31:49', '2023-05-18 18:32:37');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(25) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `account_id`, `name`, `phone`, `email`, `address`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Andris Berziņš', '+37125252770', 'omaticpl@gmail.com', 'Rudens 6-28', NULL, '2020-10-14 06:13:37', '2020-10-14 06:13:37', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `state` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `opening_balance` decimal(15,5) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `mirrorsize_id` varchar(191) DEFAULT NULL,
  `gender` enum('male','female') NOT NULL DEFAULT 'male'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `account_id`, `name`, `email`, `password`, `phone`, `address`, `state`, `description`, `opening_balance`, `created_at`, `updated_at`, `deleted_at`, `photo`, `mirrorsize_id`, `gender`) VALUES
(1, 1, 'Aleksandar Todorovic', 'aleksandart450@gmail.com', '$2y$10$uyhsp4r1lOGwE8SqNVP0vO5opvZjr750Sd50tiRqwiXHU7jK1R0GG', '+14402070484', 'Konatice Noname street 378', 'California', 'Dolore quia neque eos quia iste temporibus inventore dolor quia quas in maxime velit enim.', 1000.00000, '2023-03-15 14:46:11', '2023-04-20 16:49:28', NULL, '1679666879.jpg', '03068070_2004202315490028', 'male'),
(2, 1, 'Violet Focus', 'violetfocus0618@gmail.com', '$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3/o5sy3.B2DLeAkQqeBpb3Cq9cvda', '+4456454645', 'Konatice Nonama', NULL, 'ppp', NULL, '2023-03-16 04:17:02', '2023-05-19 09:18:12', NULL, NULL, NULL, 'male'),
(3, 1, 'Ivo Svisco', 'ivo@svisco.lv', '$2y$10$uyhsp4r1lOGwE8SqNVP0vO5opvZjr750Sd50tiRqwiXHU7jK1R0GG', '+37129266821', 'Rudens 6-28, Rīga,LV-1082', NULL, NULL, 0.00000, '2020-10-14 01:21:47', '2023-04-20 02:53:35', NULL, NULL, '03068070_2004202301530035', 'male'),
(4, 1, 'Elvijs Mūrnieks', 'melvijs@gmail.com', '$2y$10$uyhsp4r1lOGwE8SqNVP0vO5opvZjr750Sd50tiRqwiXHU7jK1R0GG', '+37122332233', 'Ausekļa 5-1, Rīga, LV-1010', NULL, NULL, 0.00000, '2020-10-14 01:28:45', '2023-05-14 18:38:31', NULL, '1684085911.jpg', NULL, 'male'),
(5, 1, 'Jānis Markavs', 'janis.markavs@gmail.com', '$2y$10$uyhsp4r1lOGwE8SqNVP0vO5opvZjr750Sd50tiRqwiXHU7jK1R0GG', '+37129294972', 'Enerģetiķu iela 3-98, Salaspils, LV-2121', NULL, NULL, 0.00000, '2020-10-14 12:22:57', '2020-10-14 12:23:29', NULL, NULL, NULL, 'male'),
(6, 1, 'Kristaps Veikerts', 'kristaps.veikerts@gmail.com', '$2y$10$uyhsp4r1lOGwE8SqNVP0vO5opvZjr750Sd50tiRqwiXHU7jK1R0GG', '+37126564847', 'Liepāja', NULL, 'Facebook', 0.00000, '2021-04-30 05:44:16', '2021-04-30 05:44:16', NULL, NULL, NULL, 'male'),
(10, NULL, 'rols123', 'eno.eht.ais@gmail.com', '$2y$10$YQbk7wV93qA2RlxrrvGkNuF4XAOeKu/Qbs1eF1T8muKLBbnE9TYbm', NULL, NULL, NULL, NULL, NULL, '2023-07-26 11:11:41', '2023-07-26 11:12:31', NULL, NULL, '03068070_2607202310120031', 'male');

-- --------------------------------------------------------

--
-- Table structure for table `customer_measures`
--

CREATE TABLE `customer_measures` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `dob` date NOT NULL,
  `height` double NOT NULL,
  `weight` double NOT NULL,
  `chest` double NOT NULL,
  `neck` double NOT NULL,
  `shoulder` double NOT NULL,
  `back_length` double NOT NULL,
  `arm_length` double NOT NULL,
  `biceps` double NOT NULL,
  `wrist` double NOT NULL,
  `stomach` double NOT NULL,
  `waistline` double NOT NULL,
  `hip` double NOT NULL,
  `inside_length` double NOT NULL,
  `thigh` double NOT NULL,
  `shoulder_type` enum('high','regular','low') NOT NULL DEFAULT 'regular',
  `chest_type` enum('chiselled','regular','robust') NOT NULL DEFAULT 'regular',
  `stomach_type` enum('flat','regular','protruding') NOT NULL DEFAULT 'regular',
  `back_type` enum('straight','regular','curved') NOT NULL DEFAULT 'regular',
  `rear_type` enum('flat','regular','protruding') NOT NULL DEFAULT 'regular',
  `fit` enum('comfort','regular','slim') NOT NULL DEFAULT 'slim',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `customer_measures`
--

INSERT INTO `customer_measures` (`id`, `customer_id`, `dob`, `height`, `weight`, `chest`, `neck`, `shoulder`, `back_length`, `arm_length`, `biceps`, `wrist`, `stomach`, `waistline`, `hip`, `inside_length`, `thigh`, `shoulder_type`, `chest_type`, `stomach_type`, `back_type`, `rear_type`, `fit`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, '1988-06-18', 175, 75, 93.9, 37.8, 45.6, 73, 54.9, 60, 20, 90, 120, 97.3, 90, 80, 'low', 'chiselled', 'flat', 'straight', 'flat', 'comfort', NULL, '2023-03-25 16:08:49', '2023-05-11 00:34:43'),
(2, 3, '1977-05-12', 199, 127, 128.2, 45.4, 53.9, 79.3, 60.2, 25, 24, 110, 110, 127.3, 110, 43, 'regular', 'regular', 'protruding', 'regular', 'regular', 'comfort', NULL, '2023-04-10 10:40:24', '2023-05-12 09:47:57'),
(3, 10, '2223-02-12', 190, 100, 100, 50, 90, 120, 90, 45, 30, 100, 100, 110, 120, 70, 'high', 'chiselled', 'flat', 'straight', 'flat', 'comfort', NULL, '2023-07-26 11:16:31', '2023-07-26 11:16:31');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `tag` varchar(191) DEFAULT NULL,
  `type` enum('Text','Number','ImageRadio','Radio','TextArea') NOT NULL DEFAULT 'Text',
  `options` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `custom_fields`
--

INSERT INTO `custom_fields` (`id`, `name`, `tag`, `type`, `options`, `description`, `deleted_at`, `created_at`, `updated_at`, `order`) VALUES
(2, 'Vents', 'Vent', 'ImageRadio', '[{\"name\":\"Without Vent\",\"description\":\"Without Vent\",\"file\":\"16795494500.png\",\"preview\":\"168058881502.png\"},{\"name\":\"Double Vent\",\"description\":\"Double Vent\",\"file\":\"16795494501.png\",\"preview\":\"168058881512.png\"},{\"name\":\"Single Vent\",\"description\":\"Single Vent\",\"file\":\"16795494502.png\",\"preview\":\"168058881522.png\"}]', 'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore dolore magna aliqua minim veniam quis nostrud exercitation ullamco laboris nisi aliquip commodo consequat auis aute irure dolor in reprehenderit velit esse cillum dolore eu fugiat nulla', NULL, '2023-03-22 02:01:27', '2023-04-04 04:13:35', 7),
(3, 'Buttons', 'Coat', 'ImageRadio', '[{\"name\":\"1 Button\",\"description\":\"1 Button\",\"file\":\"16795492530.png\",\"preview\":\"168058872002.png\"},{\"name\":\"2 Buttons\",\"description\":\"2 Buttons\",\"file\":\"16795492531.png\",\"preview\":\"168058872012.png\"},{\"name\":\"3 Buttons\",\"description\":\"3 Buttons\",\"file\":\"16795492532.png\",\"preview\":\"168058872022.png\"},{\"name\":\"4 Double Breasted\",\"description\":\"4 Double Breasted\",\"file\":\"16795492533.png\",\"preview\":\"168058872032.png\"},{\"name\":\"6 Double Breasted\",\"description\":\"6 Double Breasted\",\"file\":\"16795492534.png\",\"preview\":\"168058872042.png\"},{\"name\":\"6 Double Breasted (2 Unfasten)\",\"description\":\"6 Double Breasted (2 Unfasten)\",\"file\":\"16795492535.png\",\"preview\":\"168058872052.png\"}]', 'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore dolore magna aliqua minim veniam quis nostrud exercitation ullamco laboris nisi aliquip commodo consequat auis aute irure dolor in reprehenderit velit esse cillum dolore eu fugiat nulla', NULL, '2023-03-22 02:05:54', '2023-04-04 04:12:00', 5),
(4, 'Lining', 'Lining', 'ImageRadio', '[{\"name\":\"Tailors Choice\",\"description\":\"Tailors Choice\",\"file\":\"16795870680.jpg\",\"preview\":\"168058489502.jpg\"},{\"name\":\"Deep White Lining\",\"description\":\"Deep White Lining\",\"file\":\"16795870681.jpg\",\"preview\":\"168058489512.jpg\"},{\"name\":\"Light Purple Lining\",\"description\":\"Light Purple Lining\",\"file\":\"16795870682.jpg\",\"preview\":\"168058489522.jpg\"},{\"name\":\"Salmon Plain Lining\",\"description\":\"Salmon Plain Lining\",\"file\":\"16795870683.jpg\",\"preview\":\"168058489532.jpg\"},{\"name\":\"Red Plain Lining\",\"description\":\"Red Plain Lining\",\"file\":\"16795870684.jpg\",\"preview\":\"168058489542.jpg\"},{\"name\":\"Silver Plain Lining\",\"description\":\"Silver Plain Lining\",\"file\":\"16795870685.jpg\",\"preview\":\"168058489552.jpg\"},{\"name\":\"Charcoal Plain Lining\",\"description\":\"Charcoal Plain Lining\",\"file\":\"16795870686.jpg\",\"preview\":\"168058489562.jpg\"},{\"name\":\"Ivory Plain Lining\",\"description\":\"Ivory Plain Lining\",\"file\":\"16795870687.jpg\",\"preview\":\"168058489572.jpg\"}]', 'Select Your Lining.', NULL, '2023-03-22 02:07:16', '2023-04-04 03:08:15', 8),
(5, 'Pleats', 'Pent', 'ImageRadio', '[{\"name\":\"Without Pleat\",\"description\":\"Without Pleat\",\"file\":\"16795841130.png\",\"preview\":\"168058988602.png\"},{\"name\":\"With Pleat\",\"description\":\"With Pleat\",\"file\":\"16795841141.png\",\"preview\":\"168058988612.png\"}]', 'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore dolore magna aliqua minim veniam quis nostrud exercitation ullamco laboris nisi aliquip commodo consequat auis aute irure dolor in reprehenderit velit esse cillum dolore eu fugiat nulla', NULL, '2023-03-22 04:21:18', '2023-04-04 04:31:26', 9),
(9, 'Lapels', 'Coat', 'ImageRadio', '[{\"name\":\"Shawl\",\"description\":\"Shawl\",\"file\":\"16795489850.png\",\"preview\":\"168058866802.png\"},{\"name\":\"Slim Notch\",\"description\":\"Slim Notch\",\"file\":\"16795489851.png\",\"preview\":\"168058866812.png\"},{\"name\":\"Slim Peak\",\"description\":\"Slim Peak\",\"file\":\"16795489852.png\",\"preview\":\"168058866822.png\"},{\"name\":\"Notch\",\"description\":\"Notch\",\"file\":\"16795489853.png\",\"preview\":\"168058866832.png\"},{\"name\":\"Peak\",\"description\":\"Peak\",\"file\":\"16795489854.png\",\"preview\":\"168058866842.png\"}]', 'Coat lapels are the folded flaps of cloth on the front of a coat that form a continuation of the collar. There are three basic types of lapels: notched, peaked and shawl.', NULL, '2023-03-22 04:57:34', '2023-04-04 04:11:08', 4),
(10, 'Cuff', 'Pent', 'ImageRadio', '[{\"name\":\"Without Cuff\",\"description\":\"Without Cuff\",\"file\":\"16795842140.png\",\"preview\":\"168058996202.png\"},{\"name\":\"With Cuff\",\"description\":\"With Cuff\",\"file\":\"16795842141.png\",\"preview\":\"168058996212.png\"}]', 'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore dolore magna aliqua minim veniam quis nostrud exercitation ullamco laboris nisi aliquip commodo consequat auis aute irure dolor in reprehenderit velit esse cillum dolore eu fugiat nulla', NULL, '2023-03-22 18:44:59', '2023-04-04 04:32:42', 10),
(11, 'Collar', 'Shirt', 'ImageRadio', '[{\"name\":\"Standard\",\"description\":\"Standard\",\"file\":\"16795845260.png\",\"preview\":\"168121085902.png\"},{\"name\":\"Buttons Own\",\"description\":\"Buttons Own\",\"file\":\"16795845261.png\",\"preview\":\"168121085912.png\"},{\"name\":\"Windsor\",\"description\":\"Windsor\",\"file\":\"16795845262.png\",\"preview\":\"168121085922.png\"}]', 'A tailor-made shirt collar is a vital part of the shirt that rests around the neck.', NULL, '2023-03-23 14:15:26', '2023-04-11 12:01:19', 11),
(12, 'Buttons', 'Shirt', 'ImageRadio', '[{\"name\":\"Button Style 1\",\"description\":\"Button Style 1\",\"file\":\"16795847800.png\",\"preview\":\"168121093702.png\"},{\"name\":\"Button Style 2\",\"description\":\"Button Style 2\",\"file\":\"16795847801.png\",\"preview\":\"168121093712.png\"},{\"name\":\"Button Style 3\",\"description\":\"Button Style 3\",\"file\":\"16795847802.png\",\"preview\":\"168121093722.png\"},{\"name\":\"Button Style 4\",\"description\":\"Button Style 4\",\"file\":\"16795847803.png\",\"preview\":\"168121093732.png\"}]', 'Tailors usually use different types of buttons for shirts such as plastic, pearl, horn or mother-of-pearl.', NULL, '2023-03-23 14:19:40', '2023-04-11 12:02:17', 12),
(13, 'Pocket', 'Shirt', 'ImageRadio', '[{\"name\":\"Single Pocket\",\"description\":\"Single Pocket\",\"file\":\"16795849320.png\",\"preview\":\"168121096702.png\"},{\"name\":\"Two Pockets\",\"description\":\"Two Pockets\",\"file\":\"16795849321.png\",\"preview\":\"168121096712.png\"},{\"name\":\"No Pockets\",\"description\":\"No Pockets\",\"file\":\"16795849322.png\",\"preview\":\"168121096722.png\"}]', 'A tailor-made shirt can include a pocket on the front either on the left or right side. It can be designed in various shapes and sizes such as rounded or square-shaped.', NULL, '2023-03-23 14:22:12', '2023-04-11 12:02:47', 13),
(14, 'Facing', 'Shirt', 'ImageRadio', '[{\"name\":\"Facing\",\"description\":\"Facing\",\"file\":\"16795850190.png\",\"preview\":\"168121099302.png\"},{\"name\":\"No Facing\",\"description\":\"No Facing\",\"file\":\"16795850191.png\",\"preview\":\"168121099312.png\"}]', 'Tailor Shirt Facing is the piece of fabric used for lining or finishing the inside of a shirt. It is sewn to the garment\'s edge to cover the raw edge, thus adding durability and professional look to the shirt.', NULL, '2023-03-23 14:23:39', '2023-04-11 12:03:13', 14),
(15, 'Customize Your Shirt', 'Style', 'ImageRadio', '[{\"name\":\"Classic\",\"description\":\"Classic\",\"file\":\"16801075030.png\"},{\"name\":\"Slim\",\"description\":\"Slim\",\"file\":\"16801075031.png\"}]', 'Customize Your Shirt', NULL, '2023-03-23 14:25:32', '2023-03-29 14:31:43', 1),
(16, 'Pockets', 'Coat', 'ImageRadio', '[{\"name\":\"Normal Pocket\",\"description\":\"Normal Pocket\",\"file\":\"16795858950.png\",\"preview\":\"168058876802.png\"},{\"name\":\"Normal With Ticket Pocket\",\"description\":\"Normal With Ticket Pocket\",\"file\":\"16795858961.png\",\"preview\":\"168058876812.png\"},{\"name\":\"Without Pocket\",\"description\":\"Without Pocket\",\"file\":\"16795858962.png\",\"preview\":\"168058876822.png\"},{\"name\":\"Normal Pocket Without Flaps\",\"description\":\"Normal Pocket Without Flaps\",\"file\":\"16795858963.png\",\"preview\":\"168058876832.png\"},{\"name\":\"Slanted Pocket\",\"description\":\"Slanted Pocket\",\"file\":\"16795858964.png\",\"preview\":\"168058876842.png\"},{\"name\":\"Slanted Pocket Without Flaps\",\"description\":\"Slanted Pocket Without Flaps\",\"file\":\"16795858965.png\",\"preview\":\"168058876852.png\"}]', 'Tailor-made coats come with different types of pockets such as patch pockets, flap pockets, breast pockets, jetted pockets, besom pockets, and ticket pockets.', NULL, '2023-03-23 14:38:16', '2023-04-04 04:12:48', 6),
(17, 'Customize Your Garment', 'Style', 'ImageRadio', '[{\"name\":\"Slim\",\"description\":\"Slim\",\"file\":\"16801075330.png\"},{\"name\":\"Classic\",\"description\":\"Classic\",\"file\":\"16801075331.png\"}]', 'Tailor Suit Style Garments are made up of two main parts: jackets and trousers. These clothes are designed to fit the wearer\'s body perfectly, and they come in various styles. Here are some common style options for tailor suits:', NULL, '2023-03-23 14:39:59', '2023-03-29 14:49:29', 2),
(18, 'Customize Your Blazer', 'Style', 'ImageRadio', '[{\"name\":\"Slim\",\"description\":\"Slim\",\"file\":\"16801075600.png\"},{\"name\":\"Classic\",\"description\":\"Classic\",\"file\":\"16801075601.png\"}]', 'Customize Your Blazer', NULL, '2023-03-23 14:43:35', '2023-03-29 14:49:29', 3);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `amount` decimal(25,4) NOT NULL,
  `description` text DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `account_id`, `name`, `amount`, `description`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Elvijs Murnieks Solary', 1000.0000, NULL, 1, '2020-10-14 06:12:31', '2020-10-14 06:12:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `customer_id`, `product_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 10, NULL, NULL, NULL),
(2, 1, 9, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `frontend_settings`
--

CREATE TABLE `frontend_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slides` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `galleries` text DEFAULT NULL,
  `limited` text DEFAULT NULL,
  `discount` text DEFAULT NULL,
  `embrace` text DEFAULT NULL,
  `testimonial` text DEFAULT NULL,
  `service` text DEFAULT NULL,
  `subscribe` text DEFAULT NULL,
  `instagram` text DEFAULT NULL,
  `faq` text DEFAULT NULL,
  `story` text DEFAULT NULL,
  `about_service` text DEFAULT NULL,
  `footer` text DEFAULT NULL,
  `terms` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `frontend_settings`
--

INSERT INTO `frontend_settings` (`id`, `slides`, `deleted_at`, `created_at`, `updated_at`, `galleries`, `limited`, `discount`, `embrace`, `testimonial`, `service`, `subscribe`, `instagram`, `faq`, `story`, `about_service`, `footer`, `terms`) VALUES
(1, '[{\"main_title\":\"Discover New Suits\",\"sub_title\":\"Autumn Collection 2023\",\"description\":\"Tailoring services involve the process of making customized clothing, alterations or repairs to existing garments, and creating new garments from scratch. Tailoring services are usually offered by skilled professionals called tailors, who are trained in cutting, fitting, and sewing clothes.\",\"sub_image\":\"168172146302.png\",\"main_image\":\"168624215110.webp\",\"name\":\"aaaa\",\"url\":\"bbb.ccc\"},{\"main_title\":\"Discover New Arrivals\",\"sub_title\":\"Summer collection2019\",\"description\":\"Tailoring services involve the process of making customized clothing, alterations or repairs to existing garments, and creating new garments from scratch. Tailoring services are usually offered by skilled professionals called tailors, who are trained in cutting, fitting, and sewing clothes.\",\"main_image\":\"168172146311.jpg\",\"sub_image\":\"168172146312.png\",\"name\":\"name2\",\"url\":\"name2.url\"},{\"main_title\":\"AAAAAA\",\"sub_title\":\"AAAAAA sub title\",\"description\":\"description\",\"name\":\"AAAAAA\",\"url\":\"aaa.bbb\",\"main_image\":\"169280086012.jpg\",\"sub_image\":\"169280086122.png\"}]', NULL, '2023-04-17 09:51:03', '2023-08-23 16:17:47', '[{\"main_title\":\"Green Styling\",\"sub_title\":\"green\",\"images\":[\"16927854470.jpg\",\"16927854471.png\"]},{\"main_title\":\"Blue Styling\",\"sub_title\":\"blue\",\"images\":[\"16927854470.png\",\"16927854471.jpg\",\"16927854472.jpg\"]},{\"main_title\":\"White Styling\",\"sub_title\":\"white\",\"images\":[\"16927854470.jpg\",\"16927854471.jpg\"]}]', '[{\"description\":\"Tailoring services refer to the professional services provided by a tailor or seamstress to alter, repair, or customize clothing to fit a person\'s body and preferences. The tailor or seamstress typically takes measurements and makes adjustments to the garment\'s length, width, and shape to ensure a perfect fit. In nisl nisi celerisque eu ultrices. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In rhoncusaugue nibh.\",\"image\":\"168193203070.png\",\"name\":\"1234\",\"url\":\"asdfg.lkjhgh\"},{\"description\":\"limited2 description\\r\\nTailoring services refer to the professional services provided by a tailor or seamstress to alter, repair, or customize clothing to fit a person\'s body and preferences. The tailor or seamstress typically takes measurements and makes adjustments to the garment\'s length, width, and shape to ensure a perfect fit. In nisl nisi celerisque eu ultrices. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In rhoncusaugue nibh.\",\"name\":\"limited 2 name\",\"url\":\"limited2.name\",\"image\":\"169232505071.png\"}]', '{\"title\":\"20% Discount On Summer Collection\",\"description\":\"Tailoring services are essential for individuals who want their clothing to fit correctly and look their best. They are commonly used by people of all ages, professions, and styles, from those who need a suit for a special occasion to those who want to update their wardrobe with customized clothing.\",\"image1\":\"168193203080.png\",\"image2\":\"168193203081.png\",\"image3\":\"168193203082.png\"}', '{\"description\":\"Tailoring services are essential for individuals who want their clothing to fit correctly and look their best. They are commonly used by people of all ages, professions, and styles, from those who need a suit for a special occasion to those who want to update their wardrobe with customized clothing.\",\"image\":\"168193203090.png\"}', '[{\"name\":\"Annaa Edouard\",\"position\":\"Fashion Stylist\",\"description\":\"Tailoring services are essential for individuals who want their clothing to fit correctly and look their best. They are commonly used by people of all ages, professions, and styles, from those who need a suit for a special occasion to those who want to update their wardrobe with customized clothing.\",\"photo\":\"168193203040.png\"},{\"name\":\"Annaa Edouard\",\"position\":\"Fashion Stylist\",\"description\":\"Tailoring services are essential for individuals who want their clothing to fit correctly and look their best. They are commonly used by people of all ages, professions, and styles, from those who need a suit for a special occasion to those who want to update their wardrobe with customized clothing.\",\"photo\":\"168193203041.png\"}]', '[{\"title\":\"International Shipping\",\"description\":\"Tailoring services are essential for individuals who want their clothing to fit correctly and look their best. They are commonly used by people of all ages, professions, and styles, from those who need a suit for a special occasion to those who want to update their wardrobe with customized clothing.\",\"icon\":\"169280746750.jpg\"},{\"title\":\"Customer Care\",\"description\":\"Tailoring services are essential for individuals who want their clothing to fit correctly and look their best. They are commonly used by people of all ages, professions, and styles, from those who need a suit for a special occasion to those who want to update their wardrobe with customized clothing.\",\"icon\":\"168193203051.png\"},{\"title\":\"Secured Payment\",\"description\":\"Tailoring services are essential for individuals who want their clothing to fit correctly and look their best. They are commonly used by people of all ages, professions, and styles, from those who need a suit for a special occasion to those who want to update their wardrobe with customized clothing.\",\"icon\":\"168193203052.png\"},{\"title\":\"24\\/7 Support\",\"description\":\"Tailoring services are essential for individuals who want their clothing to fit correctly and look their best. They are commonly used by people of all ages, professions, and styles, from those who need a suit for a special occasion to those who want to update their wardrobe with customized clothing.\",\"icon\":\"168193203053.png\"}]', '{\"description\":\"Receive 10% off on your first order and be among the first to receive our exclusive emails about discounts and new arrivals.\",\"image\":\"168193203000.png\"}', '[{\"image\":\"168193203060.png\"},{\"image\":\"168193203061.png\"},{\"image\":\"168193203062.png\"},{\"image\":\"168193203063.png\"}]', '[{\"title\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In rhoncus augue nibh, at ullamcorper orci ullamcorper ut.\",\"description\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In rhoncus augue nibh, at ullamcorper orci ullamcorper ut. Nisl tincidunt eget nullam non nisi est. Pharetra et ultrices neque ornare. Ac felis donec et odio pellentesque diam volutpat commodo sed. Dolor sed viverra ipsum nunc aliquet. Pharetra massa massa ultricies mi quis hendrerit dolor. In nisl nisi.\"},{\"title\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In rhoncus augue nibh, at ullamcorper orci ullamcorper ut.\",\"description\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In rhoncus augue nibh, at ullamcorper orci ullamcorper ut. Nisl tincidunt eget nullam non nisi est. Pharetra et ultrices neque ornare. Ac felis donec et odio pellentesque diam volutpat commodo sed. Dolor sed viverra ipsum nunc aliquet. Pharetra massa massa ultricies mi quis hendrerit dolor. In nisl nisi.\"}]', '{\"description\":\"Tailoring services refer to the professional services provided by a tailor or seamstress to alter, repair, or customize clothing to fit a person\'s body and preferences. The tailor or seamstress typically takes measurements and makes adjustments to the garment\'s length, width, and shape to ensure a perfect fit.\\r\\n\\r\\nTailoring services refer to the professional services provided by a tailor or seamstress to alter, repair, or customize clothing to fit a person\'s body and preferences. The tailor or seamstress typically takes measurements and makes adjustments to the garment\'s length, width, and shape to ensure a perfect fit. In nisl nisi celerisque eu ultrices. Lorem ipsum dolor sit amet, consectetur adipiscing elit. rhoncusaugue nibh, at ullamcorper orci ullamcorper ut. Nisl tincidunt eget nullam non nisi est. Pharetra et ultrices neque ornare. Ac felis donec et odio pellentesqued diam volutpat commodo sed. Dolor sed viverra ipsum nunc aliquet. Pharetra massa massa ultricies mi quis hendrerit dolor. In nisl nisi scelerisque eu.\",\"image\":\"1681932030a0.png\"}', '{\"list\":[{\"title\":\"Online Customer Service\",\"description\":\"Tailoring services refer to the professional services provided by a tailor or seamstress to alter, repair, or customize clothing to fit a person\'s body and preferences.\",\"icon\":\"1681932030b0.png\"},{\"title\":\"International Delivery\",\"description\":\"Tailoring services refer to the professional services provided by a tailor or seamstress to alter, repair, or customize clothing to fit a person\'s body and preferences.\",\"icon\":\"1681932030b1.png\"},{\"title\":\"Free Gift\",\"description\":\"Tailoring services refer to the professional services provided by a tailor or seamstress to alter, repair, or customize clothing to fit a person\'s body and preferences.\",\"icon\":\"1681932030b2.png\"}],\"description\":\"Tailoring services refer to the professional services provided by a tailor or seamstress to alter, repair, or customize clothing to fit a person\'s body and preferences. The tailor or seamstress typically takes measurements and makes adjustments to the garment\'s length, width, and shape to ensure a perfect fit.\"}', '{\"text\":\"COPYRIGHT \\u00a9 2020-2023. All Rights Reserved By ISuits SIA\",\"facebook\":\"http:\\/\\/isuits.lv\\/\",\"instagram\":\"http:\\/\\/isuits.lv\\/\",\"twitter\":\"http:\\/\\/isuits.lv\\/\"}', '<p>Here is terms….</p>');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `journals`
--

CREATE TABLE `journals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `balance` bigint(20) NOT NULL,
  `currency` char(5) NOT NULL,
  `morphed_id` bigint(20) UNSIGNED NOT NULL,
  `morphed_type` char(32) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `journals`
--

INSERT INTO `journals` (`id`, `balance`, `currency`, `morphed_id`, `morphed_type`, `created_at`, `updated_at`) VALUES
(1, -1963750, 'USD', 1, 'App\\Models\\Customer', '2023-03-15 14:46:11', '2023-08-17 09:32:58'),
(2, 4000000, 'USD', 2, 'App\\Models\\Customer', '2023-03-16 04:17:02', '2023-03-16 04:22:21'),
(3, -40000, 'USD', 3, 'App\\Models\\Customer', '2023-03-18 00:04:01', '2023-04-10 11:00:33'),
(4, 0, 'USD', 4, 'App\\Models\\Customer', '2023-03-18 00:05:53', '2023-03-18 00:05:53'),
(5, 0, 'USD', 5, 'App\\Models\\Customer', '2023-03-18 00:14:28', '2023-03-18 00:14:28'),
(6, 11100, 'USD', 6, 'App\\Models\\Customer', '2023-03-19 13:44:47', '2023-03-19 13:44:47'),
(7, 0, 'USD', 7, 'App\\Models\\Customer', '2023-03-19 13:49:10', '2023-03-19 13:49:10'),
(8, 12300, 'USD', 8, 'App\\Models\\Customer', '2023-03-19 13:49:54', '2023-03-19 13:49:54'),
(9, 0, 'USD', 9, 'App\\Models\\Customer', '2023-03-19 14:35:42', '2023-03-19 14:35:42'),
(11, -78220, 'USD', 1, 'App\\Models\\Customer', '2020-10-14 01:21:47', '2020-10-14 12:10:58'),
(12, 0, 'USD', 2, 'App\\Models\\Customer', '2020-10-14 01:28:45', '2020-10-14 01:28:45'),
(13, 12645, 'USD', 3, 'App\\Models\\Customer', '2020-10-14 12:22:57', '2020-10-14 12:26:55'),
(14, 67155, 'USD', 4, 'App\\Models\\Customer', '2021-04-30 05:44:16', '2021-04-30 06:12:54'),
(15, 0, 'USD', 10, 'App\\Models\\Customer', '2023-07-26 11:11:41', '2023-07-26 11:11:41');

-- --------------------------------------------------------

--
-- Table structure for table `journal_transactions`
--

CREATE TABLE `journal_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `journal_id` bigint(20) UNSIGNED NOT NULL,
  `debit` bigint(20) DEFAULT NULL,
  `credit` bigint(20) DEFAULT NULL,
  `currency` char(5) NOT NULL,
  `memo` text DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `subject_type` varchar(191) DEFAULT NULL,
  `post_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `journal_transactions`
--

INSERT INTO `journal_transactions` (`id`, `journal_id`, `debit`, `credit`, `currency`, `memo`, `type`, `subject_id`, `subject_type`, `post_date`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, NULL, 100000, 'USD', NULL, 'opening_balance', NULL, NULL, '2023-03-15 14:46:11', '2023-03-15 14:46:11', '2023-03-15 14:46:11', NULL),
(2, 2, NULL, 0, 'USD', NULL, 'opening_balance', NULL, NULL, '2023-03-16 04:17:03', '2023-03-16 04:17:03', '2023-03-16 04:17:03', NULL),
(3, 2, 500000, NULL, 'USD', NULL, 'payment_received', 1, 'App\\Models\\Payment', '2023-03-16 05:17:53', '2023-03-16 04:17:53', '2023-03-16 04:17:53', NULL),
(4, 2, 500000, NULL, 'USD', NULL, 'payment_received', 2, 'App\\Models\\Payment', '2023-03-16 05:18:12', '2023-03-16 04:18:12', '2023-03-16 04:18:12', NULL),
(5, 2, 500000, NULL, 'USD', NULL, 'payment_received', 4, 'App\\Models\\Payment', '2023-03-16 05:20:50', '2023-03-16 04:20:50', '2023-03-16 04:20:50', NULL),
(6, 2, -200000, NULL, 'USD', NULL, 'payment_received', 3, 'App\\Models\\Payment', '2023-03-16 05:21:13', '2023-03-16 04:21:13', '2023-03-16 04:21:13', NULL),
(7, 2, -300000, NULL, 'USD', NULL, 'payment_received', 5, 'App\\Models\\Payment', '2023-03-16 05:21:31', '2023-03-16 04:21:30', '2023-03-16 04:21:31', NULL),
(8, 2, -5000000, NULL, 'USD', NULL, 'payment_received', 6, 'App\\Models\\Payment', '2023-03-16 05:22:21', '2023-03-16 04:22:20', '2023-03-16 04:22:21', NULL),
(9, 3, NULL, 0, 'USD', NULL, 'opening_balance', NULL, NULL, '2023-03-18 00:04:01', '2023-03-18 00:04:01', '2023-03-18 00:04:01', NULL),
(10, 4, NULL, 0, 'USD', NULL, 'opening_balance', NULL, NULL, '2023-03-18 00:05:53', '2023-03-18 00:05:53', '2023-03-18 00:05:53', NULL),
(11, 5, NULL, 0, 'USD', NULL, 'opening_balance', NULL, NULL, '2023-03-18 00:14:28', '2023-03-18 00:14:28', '2023-03-18 00:14:28', NULL),
(12, 6, NULL, 11100, 'USD', NULL, 'opening_balance', NULL, NULL, '2023-03-19 13:44:47', '2023-03-19 13:44:47', '2023-03-19 13:44:47', NULL),
(13, 7, NULL, 0, 'USD', NULL, 'opening_balance', NULL, NULL, '2023-03-19 13:49:10', '2023-03-19 13:49:10', '2023-03-19 13:49:10', NULL),
(14, 8, NULL, 12300, 'USD', NULL, 'opening_balance', NULL, NULL, '2023-03-19 13:49:54', '2023-03-19 13:49:54', '2023-03-19 13:49:54', NULL),
(15, 9, NULL, 0, 'USD', NULL, 'opening_balance', NULL, NULL, '2023-03-19 14:35:42', '2023-03-19 14:35:42', '2023-03-19 14:35:42', NULL),
(16, 1, NULL, 54500, 'USD', NULL, 'order_created', 1, 'App\\Models\\Order', '2023-03-23 09:53:18', '2023-03-23 08:53:18', '2023-03-23 08:53:18', NULL),
(17, 1, 54500, NULL, 'USD', NULL, 'payment_received', 7, 'App\\Models\\Payment', '2023-03-23 09:53:34', '2023-03-23 08:53:34', '2023-03-23 08:53:34', NULL),
(18, 1, NULL, 2725, 'USD', NULL, 'order_created', 2, 'App\\Models\\Order', '2023-03-23 14:33:03', '2023-03-23 13:33:03', '2023-03-23 13:33:03', NULL),
(19, 1, 20000, NULL, 'USD', NULL, 'payment_received', 8, 'App\\Models\\Payment', '2023-03-23 14:33:34', '2023-03-23 13:33:34', '2023-03-23 13:33:34', NULL),
(20, 1, 25000, NULL, 'USD', NULL, 'payment_received', 9, 'App\\Models\\Payment', '2023-03-23 14:33:49', '2023-03-23 13:33:49', '2023-03-23 13:33:49', NULL),
(21, 1, NULL, 2725, 'USD', NULL, 'order_created', 3, 'App\\Models\\Order', '2023-03-28 05:24:34', '2023-03-28 03:24:34', '2023-03-28 03:24:34', NULL),
(22, 1, NULL, 2500, 'USD', NULL, 'order_created', 4, 'App\\Models\\Order', '2023-03-29 05:55:38', '2023-03-29 03:55:38', '2023-03-29 03:55:38', NULL),
(23, 1, NULL, 10000, 'USD', NULL, 'order_created', 5, 'App\\Models\\Order', '2023-03-29 07:09:51', '2023-03-29 05:09:51', '2023-03-29 05:09:51', NULL),
(24, 1, NULL, 100000, 'USD', NULL, 'order_created', 6, 'App\\Models\\Order', '2023-03-29 08:47:20', '2023-03-29 06:47:20', '2023-03-29 06:47:20', NULL),
(25, 1, 100000, NULL, 'USD', NULL, 'payment_received', 10, 'App\\Models\\Payment', '2023-04-05 09:30:12', '2023-04-05 07:30:12', '2023-04-05 07:30:12', NULL),
(26, 3, 40000, NULL, 'USD', NULL, 'payment_received', 11, 'App\\Models\\Payment', '2023-04-10 10:00:33', '2023-04-10 11:00:33', '2023-04-10 11:00:33', NULL),
(27, 1, 100000, NULL, 'USD', NULL, 'order_editing', 6, 'App\\Models\\Order', '2023-04-10 10:17:03', '2023-04-10 11:17:03', '2023-04-10 11:17:03', NULL),
(28, 1, NULL, 121000, 'USD', NULL, 'order_updated', 6, 'App\\Models\\Order', '2023-04-10 10:17:03', '2023-04-10 11:17:03', '2023-04-10 11:17:03', NULL),
(29, 1, 121000, NULL, 'USD', NULL, 'order_editing', 6, 'App\\Models\\Order', '2023-04-10 13:17:23', '2023-04-10 14:17:23', '2023-04-10 14:17:23', NULL),
(30, 1, NULL, 121000, 'USD', NULL, 'order_updated', 6, 'App\\Models\\Order', '2023-04-10 13:17:23', '2023-04-10 14:17:23', '2023-04-10 14:17:23', NULL),
(31, 1, NULL, 100000, 'USD', NULL, 'payment_editing', 10, 'App\\Models\\Payment', '2023-04-21 02:31:37', '2023-04-21 03:31:37', '2023-04-21 03:31:37', NULL),
(32, 1, 100000, NULL, 'USD', NULL, 'payment_updated', 10, 'App\\Models\\Payment', '2023-04-21 02:31:37', '2023-04-21 03:31:37', '2023-04-21 03:31:37', NULL),
(33, 1, 250000, NULL, 'USD', NULL, 'payment_received', 12, 'App\\Models\\Payment', '2023-04-21 02:32:36', '2023-04-21 03:32:36', '2023-04-21 03:32:36', NULL),
(34, 1, NULL, 250000, 'USD', NULL, 'payment_editing', 12, 'App\\Models\\Payment', '2023-04-21 02:33:37', '2023-04-21 03:33:37', '2023-04-21 03:33:37', NULL),
(35, 1, 250000, NULL, 'USD', NULL, 'payment_updated', 12, 'App\\Models\\Payment', '2023-04-21 02:33:37', '2023-04-21 03:33:37', '2023-04-21 03:33:37', NULL),
(36, 1, NULL, 250000, 'USD', NULL, 'payment_editing', 12, 'App\\Models\\Payment', '2023-04-21 10:14:27', '2023-04-21 11:14:27', '2023-04-21 11:14:27', NULL),
(37, 1, 250000, NULL, 'USD', NULL, 'payment_updated', 12, 'App\\Models\\Payment', '2023-04-21 10:14:27', '2023-04-21 11:14:27', '2023-04-21 11:14:27', NULL),
(38, 1, NULL, 250000, 'USD', NULL, 'payment_editing', 12, 'App\\Models\\Payment', '2023-04-21 10:14:33', '2023-04-21 11:14:33', '2023-04-21 11:14:33', NULL),
(39, 1, 2500000, NULL, 'USD', NULL, 'payment_updated', 12, 'App\\Models\\Payment', '2023-04-21 10:14:33', '2023-04-21 11:14:33', '2023-04-21 11:14:33', NULL),
(40, 1, NULL, 2500000, 'USD', NULL, 'payment_editing', 12, 'App\\Models\\Payment', '2023-04-21 10:15:00', '2023-04-21 11:15:00', '2023-04-21 11:15:00', NULL),
(41, 1, 25000, NULL, 'USD', NULL, 'payment_updated', 12, 'App\\Models\\Payment', '2023-04-21 10:15:00', '2023-04-21 11:15:00', '2023-04-21 11:15:00', NULL),
(42, 1, 2000000, NULL, 'USD', NULL, 'payment_received', 13, 'App\\Models\\Payment', '2023-04-21 10:15:10', '2023-04-21 11:15:10', '2023-04-21 11:15:10', NULL),
(43, 1, NULL, 9000, 'USD', NULL, 'order_created', 7, 'App\\Models\\Order', '2023-05-23 15:51:03', '2023-05-23 16:51:03', '2023-05-23 16:51:03', NULL),
(44, 1, NULL, 9000, 'USD', NULL, 'order_created', 8, 'App\\Models\\Order', '2023-05-23 20:27:57', '2023-05-23 21:27:57', '2023-05-23 21:27:57', NULL),
(45, 1, NULL, 9000, 'USD', NULL, 'order_created', 9, 'App\\Models\\Order', '2023-05-23 20:32:29', '2023-05-23 21:32:29', '2023-05-23 21:32:29', NULL),
(46, 1, NULL, 9000, 'USD', NULL, 'order_created', 10, 'App\\Models\\Order', '2023-05-23 20:32:55', '2023-05-23 21:32:55', '2023-05-23 21:32:55', NULL),
(47, 1, NULL, 9000, 'USD', NULL, 'order_created', 11, 'App\\Models\\Order', '2023-05-23 20:38:41', '2023-05-23 21:38:41', '2023-05-23 21:38:41', NULL),
(48, 15, NULL, 0, 'USD', NULL, 'opening_balance', NULL, NULL, '2023-07-26 11:11:41', '2023-07-26 11:11:41', '2023-07-26 11:11:41', NULL),
(49, 1, 77700, NULL, 'USD', NULL, 'payment_received', 15, 'App\\Models\\Payment', '2023-08-17 09:32:58', '2023-08-17 09:32:58', '2023-08-17 09:32:58', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `measurements`
--

CREATE TABLE `measurements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `measurement` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `extra_attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `measurements`
--

INSERT INTO `measurements` (`id`, `account_id`, `name`, `service_id`, `customer_id`, `measurement`, `created_at`, `updated_at`, `deleted_at`, `extra_attributes`, `user_id`) VALUES
(4, 1, 'Aleksandar Todorovic\'s Custom-made clothing', 1, 1, NULL, '2023-03-23 08:51:50', '2023-05-23 16:50:41', NULL, '[{\"Collar\":\"4444\"},{\"Chest\":\"444\"},{\"Sleeve length\":\"4444\"},{\"Shoulder\":\"444\"},{\"Front Length\":\"444\"},{\"Hem\":\"444\"},{\"Sleeve cuff\":\"44\"},{\"Muguras garums\":\"444\"},{\"V\\u0113dera apk\\u0101rtm\\u0113rs\":\"44\"},{\"Gurnu apk\\u0101rtm\\u0113rs\":\"44\"},{\"Plecu platums\":\"444\"},{\"Biceps\":\"44\"},{\"Piedurknes garums\":\"444\"},{\"Piedurknes atv\\u0113rums\":\"44\"}]', 1),
(5, 1, 'Violet Focus\'s Custom-made clothing', 1, 2, NULL, '2023-03-23 08:52:14', '2023-03-23 08:52:14', NULL, '[{\"Select your Collar\":\"Straight Point\"},{\"Select your Cuff\":\"Two Buttons Angled\"},{\"Select your Length\":\"Untucked\"},{\"Would you like a pocket?\":\"Left Chest\"},{\"Where do you wear your watch?\":\"Rith Wrist\"},{\"What color buttons would you like?\":\"Black\"},{\"Select\":\"Option2\"},{\"Color\":\"Blue Horn\"}]', 1),
(6, 1, 'Aleksandar Todorovic\'s Shorten dress with an invisible hem', 2, 1, NULL, '2023-03-23 08:52:32', '2023-03-23 08:52:32', NULL, '[{\"Color\":\"Black\"}]', 1),
(7, 1, 'Aleksandar Todorovic\'s Alterations and repairs', 7, 1, NULL, '2023-03-29 05:09:27', '2023-03-29 05:09:27', NULL, '[{\"Color\":\"Black\"}]', 1),
(8, 1, 'Ivo Svisco\'s ExTx - Divdaļīgs Uzvalks', 6, 3, NULL, '2023-04-10 11:02:46', '2023-04-10 11:03:05', '2023-04-10 11:03:05', '[]', 1);

-- --------------------------------------------------------

--
-- Table structure for table `measurement_fields`
--

CREATE TABLE `measurement_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `order` smallint(6) DEFAULT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `required` tinyint(1) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `measurement_fields`
--

INSERT INTO `measurement_fields` (`id`, `type`, `name`, `order`, `options`, `required`, `description`, `account_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Text', 'Collar', NULL, '[{\"value\":null}]', 1, 'Place one end of the measuring tape at the center of the button where the button stitching comes through to the inside of the collar band and measure along the collar up to the button.', 1, '2020-10-14 01:09:20', '2021-04-30 06:04:35', NULL),
(2, 'Text', 'Chest', NULL, '[{\"value\":null}]', 1, 'Place the tape close under the arms and make sure the tape is flat across the back.', 1, '2020-10-14 01:12:15', '2021-04-30 06:06:05', NULL),
(3, 'Text', 'Sleeve length', NULL, '[{\"value\":null}]', 1, 'Measure from the shoulder to the wrist.', 1, '2020-10-14 01:14:22', '2020-10-14 01:14:22', NULL),
(4, 'Text', 'Shoulder', NULL, '[{\"value\":null}]', 1, 'Measure this length from one shoulder to another.', 1, '2020-10-14 01:15:32', '2020-10-14 01:15:32', NULL),
(5, 'Text', 'Front Length', NULL, '[{\"value\":null}]', 1, 'Measure from the highest point of the shoulder to the desired hemline.', 1, '2020-10-14 01:17:20', '2020-10-14 01:17:20', NULL),
(6, 'Text', 'Hem', NULL, '[{\"value\":null}]', 1, 'Measure from one side to another.', 1, '2020-10-14 01:18:07', '2020-10-14 01:18:07', NULL),
(7, 'Text', 'Sleeve cuff', NULL, '[{\"value\":null}]', 1, 'At the widest point of the wrist, measure its circumference. Leave enough room for watches or jewelry worn often.', 1, '2020-10-14 01:20:21', '2020-10-14 01:20:21', NULL),
(8, 'Text', 'Suņa kakls', NULL, '[{\"value\":null}]', 1, 'Suņa kakla izmērs +1cm.', 1, '2020-10-15 06:05:14', '2020-10-15 06:05:14', NULL),
(9, 'Text', 'Suņa viduklis', NULL, '[{\"value\":null}]', 1, 'Suņa vidukļa apmērs +1 cm', 1, '2020-10-15 06:06:15', '2020-10-15 06:06:15', NULL),
(10, 'Text', 'Mugura', NULL, '[{\"value\":null}]', 1, 'Suņa muguras izmērs no kakla siksnas līdz astei', 1, '2020-10-15 06:08:20', '2020-10-15 06:08:20', NULL),
(11, 'Text', 'Audums', NULL, '[{\"value\":null}]', 1, 'Auduma kods', 1, '2020-10-15 06:08:56', '2020-10-15 06:09:12', NULL),
(12, 'Text', 'Pogas', NULL, '[{\"value\":null}]', 1, 'Suņa tērpa pogas kods', 1, '2020-10-15 06:09:46', '2020-10-15 06:09:46', NULL),
(13, 'Text', 'Diegs', NULL, '[{\"value\":null}]', 1, 'Diega kods', 1, '2020-10-15 06:10:35', '2020-10-15 06:10:35', NULL),
(14, 'Text', 'Odere', NULL, '[{\"value\":null}]', 1, 'Oderes kods', 1, '2020-10-15 06:11:45', '2020-10-15 06:11:45', NULL),
(15, 'Text', 'Krūšu apkārtmērs', NULL, '[{\"value\":null},{\"value\":null},{\"value\":null}]', 1, 'Krūšu apkārtmērs', 1, '2020-10-19 06:23:44', '2020-10-19 06:23:44', NULL),
(16, 'Text', 'Muguras garums', NULL, '[{\"value\":null}]', 1, 'Muguras garums', 1, '2020-10-19 06:46:45', '2020-10-19 06:46:45', NULL),
(17, 'Text', 'Vēdera apkārtmērs', NULL, '[{\"value\":null}]', 0, NULL, 1, '2020-10-19 06:50:12', '2020-10-19 06:50:12', NULL),
(18, 'Text', 'Gurnu apkārtmērs', NULL, '[{\"value\":null}]', 1, 'Gurnu apkārtmērs', 1, '2020-10-19 10:38:47', '2020-10-19 10:38:47', NULL),
(19, 'Text', 'Muguras platums', NULL, '[{\"value\":null}]', 1, NULL, 1, '2020-10-19 10:41:04', '2020-10-19 10:41:04', NULL),
(20, 'Text', 'Plecu platums', NULL, '[{\"value\":null}]', 1, 'No pleca kaula līdz otram pleca kaulam', 1, '2020-10-19 10:42:59', '2020-10-19 10:42:59', NULL),
(21, 'Text', 'Biceps', NULL, '[{\"value\":null}]', 1, 'Bicepsa apkārtmērs', 1, '2020-10-19 10:49:18', '2020-10-19 10:49:18', NULL),
(22, 'Text', 'Piedurknes garums', NULL, '[{\"value\":null}]', 1, 'Jāmēra no pleca kaula līdz vēlamajam garumam', 1, '2020-10-19 10:51:26', '2020-10-19 10:51:26', NULL),
(23, 'Text', 'Piedurknes atvērums', NULL, '[{\"value\":null}]', 1, 'Mērīt attiecīgi īsajam/garajam variantam', 1, '2020-10-19 10:56:56', '2020-10-19 10:56:56', NULL),
(24, 'Text', 'Kakla aizmugures izmērs', NULL, '[{\"value\":null}]', 1, 'Mērāma pati kakla aizmugure nevis apkārtmērs', 1, '2020-10-20 05:50:16', '2020-10-20 05:50:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `measurement_field_service`
--

CREATE TABLE `measurement_field_service` (
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `measurement_field_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `measurement_field_service`
--

INSERT INTO `measurement_field_service` (`service_id`, `measurement_field_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 16),
(1, 17),
(1, 18),
(1, 20),
(1, 21),
(1, 22),
(1, 23),
(2, 16),
(2, 17),
(2, 18),
(2, 20),
(2, 21),
(2, 22),
(2, 23),
(3, 15),
(3, 16),
(3, 17),
(3, 18),
(3, 19),
(3, 20),
(3, 21),
(3, 22),
(3, 23),
(4, 15),
(4, 16),
(4, 17),
(4, 18),
(4, 19),
(4, 20),
(4, 21),
(4, 22),
(4, 23),
(4, 24),
(9, 18),
(10, 18),
(13, 16),
(13, 18),
(13, 19),
(13, 20),
(13, 21),
(13, 22),
(13, 23),
(14, 15),
(14, 16),
(14, 18),
(14, 19),
(14, 20),
(14, 21),
(14, 22),
(14, 23),
(15, 8),
(15, 9),
(15, 10),
(15, 11),
(15, 12),
(15, 13),
(15, 14),
(16, 15),
(16, 16),
(16, 17),
(16, 18),
(16, 19),
(16, 20),
(16, 21),
(16, 22),
(16, 23),
(16, 24),
(17, 18),
(17, 19),
(17, 20),
(17, 21),
(17, 22),
(17, 23),
(17, 24),
(18, 18),
(18, 19),
(18, 20),
(18, 21),
(18, 22),
(18, 23),
(18, 24),
(19, 18),
(19, 19),
(19, 20),
(19, 21),
(19, 22),
(19, 23),
(19, 24),
(20, 1);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(13, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(14, '2023_03_19_192206_create_categories_table', 1),
(15, '2023_03_19_192736_create_products_table', 1),
(16, '2023_03_20_010022_create_accounts_table', 1),
(17, '2023_03_20_010022_create_activity_log_table', 1),
(18, '2023_03_20_010022_create_contacts_table', 1),
(19, '2023_03_20_010022_create_customers_table', 1),
(20, '2023_03_20_010022_create_expenses_table', 1),
(21, '2023_03_20_010022_create_failed_jobs_table', 1),
(22, '2023_03_20_010022_create_jobs_table', 1),
(23, '2023_03_20_010022_create_journal_transactions_table', 1),
(24, '2023_03_20_010022_create_journals_table', 1),
(25, '2023_03_20_010022_create_measurement_field_service_table', 2),
(26, '2023_03_20_010022_create_measurement_fields_table', 2),
(27, '2023_03_20_010022_create_measurements_table', 2),
(28, '2023_03_20_010022_create_order_payment_table', 2),
(29, '2023_03_20_010022_create_order_services_table', 2),
(30, '2023_03_20_010022_create_order_tax_table', 2),
(31, '2023_03_20_010022_create_orders_table', 2),
(32, '2023_03_20_010022_create_password_resets_table', 2),
(33, '2023_03_20_010022_create_payments_table', 2),
(34, '2023_03_20_010022_create_payu_transactions_table', 2),
(35, '2023_03_20_010022_create_personal_access_tokens_table', 3),
(36, '2023_03_20_010022_create_salaries_table', 3),
(37, '2023_03_20_010022_create_services_table', 3),
(38, '2023_03_20_010022_create_sessions_table', 3),
(39, '2023_03_20_010022_create_taxes_table', 3),
(40, '2023_03_20_010022_create_users_table', 3),
(41, '2023_03_20_010023_add_foreign_keys_to_contacts_table', 3),
(42, '2023_03_20_010023_add_foreign_keys_to_customers_table', 3),
(43, '2023_03_20_010023_add_foreign_keys_to_expenses_table', 3),
(44, '2023_03_20_010023_add_foreign_keys_to_measurement_field_service_table', 3),
(45, '2023_03_20_010023_add_foreign_keys_to_measurements_table', 3),
(46, '2023_03_20_010023_add_foreign_keys_to_order_payment_table', 3),
(47, '2023_03_20_010023_add_foreign_keys_to_order_services_table', 3),
(48, '2023_03_20_010023_add_foreign_keys_to_orders_table', 3),
(49, '2023_03_20_010023_add_foreign_keys_to_payments_table', 3),
(50, '2023_03_20_010023_add_foreign_keys_to_salaries_table', 3),
(51, '2023_03_20_010023_add_foreign_keys_to_services_table', 3),
(52, '2023_03_20_010023_add_foreign_keys_to_taxes_table', 3),
(53, '2023_03_20_010023_add_foreign_keys_to_users_table', 3),
(55, '2023_03_21_000208_change_description_to_categories_table', 4),
(56, '2023_03_21_002531_add_account_to_product_table', 5),
(57, '2023_03_21_002632_add_account_to_category_table', 5),
(58, '2023_03_21_002936_change_price_in_products_table', 6),
(63, '2023_03_21_051846_add_type_to_products_table', 7),
(64, '2023_03_21_220801_create_customize_fields', 8),
(66, '2023_03_22_082502_create_category_custom_field_table', 9),
(67, '2023_03_23_065042_create_carts_table', 10),
(68, '2023_03_24_210310_create_billing_addresses_table', 11),
(69, '2023_03_24_204921_create_shipping_addresses_table', 12),
(70, '2023_03_25_080621_create_customer_measures_table', 13),
(71, '2023_03_25_141417_add_is_default_to_billing_addresses_table', 14),
(72, '2023_03_25_141311_add_is_default_to_shipping_addresses_table', 15),
(73, '2023_03_27_050345_add_photo_to_service_table', 16),
(74, '2023_03_27_202520_create_favorites_table', 17),
(75, '2023_03_28_075127_create_product_orders_table', 18),
(76, '2023_03_28_075831_add_order_id_to_carts_table', 19),
(77, '2023_03_27_004232_remove_account_id_from_tables', 20),
(78, '2023_03_29_133804_add_order_to_custom_fields_table', 21),
(79, '2023_03_30_151939_add_account_id_to_product_orders_table', 22),
(80, '2023_04_03_011642_create_tag_backgrounds_table', 23),
(81, '2023_04_03_094257_add_reference_to_product_orders_table', 24),
(82, '2023_04_03_100110_change_is_paid_in_product_orders_table', 25),
(83, '2023_04_11_200740_add_payment_system_to_orders_table', 26),
(84, '2023_04_12_064833_add_mirrorsize_id_to_customers_table', 27),
(85, '2023_04_14_144131_create_frontend_settings_table', 28),
(86, '2023_04_16_071300_add_order_status_to_account', 29),
(87, '2023_04_16_184729_change_paid_status_in_product_orders', 30),
(88, '2023_04_16_192900_add_galleries_to_frontend_settings_table', 31),
(89, '2023_04_18_174212_add_fields_to_frontend_settings_table', 32),
(90, '2023_04_19_175928_add_fields_to_frontend_settings_table', 32),
(91, '2023_04_21_083901_add_footer_to_frontend_settings_table', 33),
(92, '2023_04_21_181216_add_billing_address_to_product_orders_table', 34),
(93, '2023_04_24_124828_create_product_reviews_table', 34),
(94, '2023_04_25_180904_add_terms_to_frontend_settings_table', 34),
(95, '2023_04_26_205659_create_chats_table', 34),
(96, '2023_05_18_161554_create_subscribers_table', 35),
(97, '2023_05_21_153107_create_notifications_table', 35),
(98, '2023_05_22_184729_change_id_type_in_notifications', 36),
(99, '2023_06_07_074552_create_service_reviews_table', 37),
(100, '2023_06_08_034810_add_unique_to_name_field_in_services_table', 38),
(101, '2023_06_08_035000_add_unique_to_name_field_in_products_table', 38);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `notifiable_type` varchar(191) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('00f26031-dfb1-42b2-9612-cf260f007ddf', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 4543643\"}', '2023-05-23 20:28:05', '2023-05-23 20:26:40', '2023-05-23 20:28:05'),
('0461d8bf-cdfc-49be-8913-3580eb53e7d1', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 23423\"}', '2023-05-22 08:35:22', '2023-05-22 08:34:06', '2023-05-22 08:35:22'),
('069ca128-d100-4f57-841b-5f1d9e189be5', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: TTT\"}', NULL, '2023-05-23 00:39:38', '2023-05-23 00:39:38'),
('06d347eb-5365-4980-9a40-acfddc006c09', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 14343\"}', '2023-05-23 20:41:24', '2023-05-23 20:21:04', '2023-05-23 20:41:24'),
('0761ff96-15e1-48f4-8d4b-1f6943c1c44f', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 2543643543\"}', NULL, '2023-05-23 01:20:31', '2023-05-23 01:20:31'),
('07d5c30f-8d67-4618-bbec-c47af969a6d8', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New product created. Name: New Product\"}', NULL, '2023-08-07 15:44:38', '2023-08-07 15:44:38'),
('099a02c6-1085-4877-a4bc-165d62817074', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/112.0.0.0 Safari\\/537.36, TIME: 2023-05-22 19:01:07)\"}', '2023-05-22 17:04:09', '2023-05-22 17:01:07', '2023-05-22 17:04:09'),
('0a589be1-d96d-48fa-8924-201ea3d9a089', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New product created. Name: t4\"}', '2023-05-23 20:32:41', '2023-05-23 20:29:17', '2023-05-23 20:32:41'),
('0bc0ed28-36dc-4528-8ab8-0fae3a3b9d6b', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-06-05 18:45:21)\"}', '2023-07-26 08:03:28', '2023-06-05 16:45:21', '2023-07-26 08:03:28'),
('0becd25f-0a36-4d32-bb83-3661f3a7a8e6', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 23423424\"}', NULL, '2023-05-22 07:46:59', '2023-05-22 07:46:59'),
('0c20f239-24b8-479c-bc9a-3610860821e5', 'App\\Notifications\\OrderStatusUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"Your order number 10 has been updated, new order status is Preparing\"}', '2023-05-23 21:34:40', '2023-05-23 21:34:12', '2023-05-23 21:34:40'),
('0dde8d9f-87bd-4af5-a051-e42812a78711', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: New Fashion Jeans\"}', NULL, '2023-05-23 20:37:30', '2023-05-23 20:37:30'),
('0de6cc82-0cc7-4109-a162-9e0dfc4e6d97', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: White Trousers\"}', '2023-05-23 14:05:17', '2023-05-23 02:52:42', '2023-05-23 14:05:17'),
('0e2ba719-3c15-4060-8a21-cc302cd2de4d', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 342342\"}', NULL, '2023-05-22 08:37:06', '2023-05-22 08:37:06'),
('11ccdf8d-8f62-4c9b-8706-89baa4286b2b', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36, TIME: 2023-08-08 10:22:45)\"}', NULL, '2023-08-08 08:22:45', '2023-08-08 08:22:45'),
('12c94702-05d2-4cd0-b7b8-c4b60e3d2ce2', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 343243243\"}', '2023-05-23 17:49:10', '2023-05-23 17:40:40', '2023-05-23 17:49:10'),
('13e59df7-af81-4730-92d4-014533e709ad', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 242414\"}', NULL, '2023-05-23 20:56:12', '2023-05-23 20:56:12'),
('14433024-6aae-4d68-b9fc-1183c6d29245', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 4543643\"}', '2023-05-23 20:41:24', '2023-05-23 20:26:40', '2023-05-23 20:41:24'),
('144f25ea-1395-439d-bdfe-1f183fee0b74', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 343243243\"}', NULL, '2023-05-23 17:40:41', '2023-05-23 17:40:41'),
('171a1694-dfd3-4d9d-bace-ece21c5d3683', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 19:44:00)\"}', '2023-05-23 17:49:10', '2023-05-23 17:44:00', '2023-05-23 17:49:10'),
('18397c0d-b5fa-4cea-997f-5c437d1fa8f2', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: gdfgdfg\"}', NULL, '2023-05-22 16:58:09', '2023-05-22 16:58:09'),
('186eada3-659b-4451-849e-e102d3654e85', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 4234234324\"}', '2023-05-23 17:24:21', '2023-05-22 07:48:19', '2023-05-23 17:24:21'),
('18f0bd58-5d96-48fc-ac40-96193cd4bdd8', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 6546546\"}', '2023-05-22 12:11:47', '2023-05-22 08:45:10', '2023-05-22 12:11:47'),
('18fbf31e-86de-43d6-bd56-157ce1fada83', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-22 11:08:39)\"}', NULL, '2023-08-22 08:08:39', '2023-08-22 08:08:39'),
('19b12c5b-b7e3-4206-b984-5d101c550543', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 2543643543\"}', NULL, '2023-05-23 01:20:31', '2023-05-23 01:20:31'),
('1a0277c2-f513-473b-ad80-bc167bb4f64b', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New product created. Name: New Product\"}', NULL, '2023-08-07 15:44:37', '2023-08-07 15:44:37'),
('1a89ff4d-367a-4d25-93e0-9a80cf8dae40', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 423423\"}', '2023-05-23 17:49:10', '2023-05-23 17:31:41', '2023-05-23 17:49:10'),
('1a8fb968-2339-4492-9384-7bc268bbe3d1', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 4543643\"}', NULL, '2023-05-23 20:26:40', '2023-05-23 20:26:40'),
('1bd50c34-2ff5-4ee2-89f4-b1f3d7825676', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-17 23:29:03)\"}', NULL, '2023-08-17 20:29:03', '2023-08-17 20:29:03'),
('1cb8b949-c996-477e-b232-124f089d810e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 4234234324\"}', NULL, '2023-05-22 07:48:19', '2023-05-22 07:48:19'),
('1eca7dc3-eab6-4be6-bbe8-94c306e60d8d', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 22:56:49)\"}', '2023-05-23 20:56:56', '2023-05-23 20:56:49', '2023-05-23 20:56:56'),
('1f3e0f57-00b7-429f-914f-e7c68251277b', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-06-09 12:39:02)\"}', NULL, '2023-06-09 10:39:02', '2023-06-09 10:39:02'),
('1f5e343a-4dc5-4bd3-9f40-ac4997e265ad', 'App\\Notifications\\OrderStatusUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"Your order number 11 has been updated, new order status is Received\"}', '2023-05-23 21:39:40', '2023-05-23 21:39:24', '2023-05-23 21:39:40'),
('1fc4bc3e-5253-453e-9151-5eaf34108b47', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-07-05 08:37:16)\"}', NULL, '2023-07-05 06:37:16', '2023-07-05 06:37:16'),
('201c0d29-fff3-4556-bac8-21c60776c9cb', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36, TIME: 2023-08-03 07:01:02)\"}', NULL, '2023-08-03 05:01:02', '2023-08-03 05:01:02'),
('20d6739e-c4ba-49d7-aa57-fa8863b183cf', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: fdghdf\"}', NULL, '2023-05-23 01:23:52', '2023-05-23 01:23:52'),
('20e7189d-89b7-41c3-8913-23c79a6598af', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 242414\"}', NULL, '2023-05-23 20:56:12', '2023-05-23 20:56:12'),
('22613da0-374d-49b5-a13e-81db7e66a2de', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 23423\"}', NULL, '2023-05-22 08:34:06', '2023-05-22 08:34:06'),
('2325bcba-4698-48b3-ab29-a74049dddcda', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 342342\"}', '2023-05-23 17:24:21', '2023-05-22 08:37:06', '2023-05-23 17:24:21'),
('23f74f9e-d92a-4b8c-8ab1-fa96d00ca15c', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 543534\"}', NULL, '2023-05-23 02:29:35', '2023-05-23 02:29:35'),
('265edc31-9f64-454d-9012-425b5844a23e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 234234\"}', NULL, '2023-05-22 08:36:51', '2023-05-22 08:36:51'),
('2694115b-730f-41bd-8ed7-586914d5e54a', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36, TIME: 2023-08-07 04:58:52)\"}', NULL, '2023-08-07 02:58:52', '2023-08-07 02:58:52'),
('27d384a1-cc98-45ba-8a9d-3161f2abd1d3', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New product created. Name: ddddddddddd\"}', NULL, '2023-05-23 16:48:21', '2023-05-23 16:48:21'),
('2821cf80-9c5a-4fd6-a919-9451cccd2b5e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: fdghdf\"}', '2023-05-23 02:44:33', '2023-05-23 01:23:52', '2023-05-23 02:44:33'),
('28484b54-1069-4668-bd95-b400ee63e12b', 'App\\Notifications\\ProductCreated', 'App\\Models\\Subscriber', 2, '{\"data\":\"New product created. Name: ddddddddddd\"}', NULL, '2023-05-23 16:48:21', '2023-05-23 16:48:21'),
('29c7155c-e826-4064-bb27-07ba803e3572', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-19 05:56:14)\"}', NULL, '2023-08-19 02:56:14', '2023-08-19 02:56:14'),
('2a450424-62a6-4397-985b-b30278e142f9', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-18 12:50:16)\"}', NULL, '2023-08-18 09:50:16', '2023-08-18 09:50:16'),
('2ab0cd1d-7ee6-496a-be00-596501368b79', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: White Trousers\"}', NULL, '2023-05-23 02:52:43', '2023-05-23 02:52:43'),
('2af59fe7-a76b-4a2b-91f9-ba9a22f72c52', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New product created. Name: t4\"}', '2023-07-26 08:03:28', '2023-05-23 20:29:17', '2023-07-26 08:03:28'),
('2da880d0-be27-439d-a163-e007f31ceee3', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product created. Name: New Product1\"}', '2023-05-23 20:41:24', '2023-05-23 20:39:39', '2023-05-23 20:41:24'),
('2db4d865-ba78-4589-bc71-903a13972b7c', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit\\/605.1.15 (KHTML, like Gecko) Version\\/13.0.3 Mobile\\/15E148 Safari\\/604.1, TIME: 2023-05-23 11:36:21)\"}', '2023-05-23 09:44:16', '2023-05-23 09:36:21', '2023-05-23 09:44:16'),
('2dbde7e8-df8b-4963-addd-6dfc991c1367', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 343423\"}', '2023-07-26 08:03:28', '2023-05-23 20:28:54', '2023-07-26 08:03:28'),
('32ccf7e5-4680-4457-b7a5-603991c7d223', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product created. Name: New Product\"}', NULL, '2023-08-07 15:44:36', '2023-08-07 15:44:36'),
('3301e35a-a027-440f-a0e6-b2e67a7074bf', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Subscriber', 3, '{\"data\":\"New service created. Name: 343243243\"}', NULL, '2023-05-23 17:40:41', '2023-05-23 17:40:41'),
('33358142-1cc0-4839-8f4b-1f577ddb8775', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 234234\"}', NULL, '2023-05-22 08:36:51', '2023-05-22 08:36:51'),
('3373691a-bcbd-43ab-8945-26f22617ba28', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: sdfsf\"}', '2023-05-23 20:28:05', '2023-05-23 20:16:19', '2023-05-23 20:28:05'),
('36488ed2-a208-4349-b084-7b471dc52f1f', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 142.147.99.57, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 16:59:57)\"}', '2023-05-23 15:11:08', '2023-05-23 14:59:57', '2023-05-23 15:11:08'),
('36de9180-c041-4013-8f49-ec38f3091ad8', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 242424323\"}', NULL, '2023-05-22 07:46:08', '2023-05-22 07:46:08'),
('36ea2f48-991e-45f2-84d1-aa2a2c56fb6b', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New product created. Name: New Product1\"}', '2023-07-26 08:03:28', '2023-05-23 20:39:39', '2023-07-26 08:03:28'),
('37537c00-c6d3-4f71-820f-ddc28481968e', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into complete at 2023-05-23 22:45:39\"}', '2023-05-23 20:48:46', '2023-05-23 20:45:39', '2023-05-23 20:48:46'),
('382e80a0-3479-4025-ad12-1eae737cd94c', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit\\/605.1.15 (KHTML, like Gecko) Version\\/13.0.3 Mobile\\/15E148 Safari\\/604.1, TIME: 2023-05-23 17:02:17)\"}', '2023-05-23 15:11:07', '2023-05-23 15:02:17', '2023-05-23 15:11:07'),
('394619d4-8835-46be-b39f-d2a0943a9381', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 1313213\"}', '2023-05-23 20:28:05', '2023-05-23 20:13:54', '2023-05-23 20:28:05'),
('3b4f8b9c-4ef3-428c-917d-80599561eae6', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: TTT\"}', NULL, '2023-05-23 00:39:38', '2023-05-23 00:39:38'),
('3b5ebc4b-e521-49a7-9bf6-97376bfe3b3e', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-22 03:44:20)\"}', NULL, '2023-08-22 00:44:20', '2023-08-22 00:44:20'),
('3d5380be-08bb-4dad-b4dc-7ae455333323', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 2342342\"}', '2023-05-23 17:24:21', '2023-05-22 08:37:15', '2023-05-23 17:24:21'),
('3f603bb0-0fce-4a48-80a4-4fecdadf3cac', 'App\\Notifications\\OrderStatusUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"Your order number 11 has been updated, new order status is Ready\"}', '2023-05-23 21:39:17', '2023-05-23 21:39:00', '2023-05-23 21:39:17'),
('400cc339-c941-4586-85fc-2123b6ffdee2', 'App\\Notifications\\ProductCreated', 'App\\Models\\Subscriber', 4, '{\"data\":\"New product created. Name: ddddddddddd\"}', NULL, '2023-05-23 16:48:21', '2023-05-23 16:48:21'),
('4038c9c2-15e8-4b39-b8c5-434463dbe372', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.45, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-07-28 09:04:08)\"}', NULL, '2023-07-28 07:04:08', '2023-07-28 07:04:08'),
('40bd5a3c-0ff2-4b76-bc94-7b2282e523aa', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 4234234324\"}', NULL, '2023-05-22 07:48:19', '2023-05-22 07:48:19'),
('4273ce6f-0455-4cbf-b2ee-ce606c579393', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s status changed into Received at 2023-05-23 22:43:26\"}', '2023-05-23 20:44:36', '2023-05-23 20:43:26', '2023-05-23 20:44:36'),
('42b23875-f7ff-42c1-8b84-81cb7e2dd960', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into reject at 2023-05-23 22:42:50\"}', '2023-05-23 20:44:36', '2023-05-23 20:42:50', '2023-05-23 20:44:36'),
('44e5dbd0-919b-42d4-955d-95ab203e6c11', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/112.0.0.0 Safari\\/537.36, TIME: 2023-05-23 11:50:33)\"}', '2023-05-23 14:05:22', '2023-05-23 09:50:33', '2023-05-23 14:05:22'),
('4548bd77-b0a0-46e0-84ed-39224b9e3b26', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 10:33:05)\"}', '2023-05-23 08:50:35', '2023-05-23 08:33:05', '2023-05-23 08:50:35'),
('4579a6e7-1288-4a33-a896-0f166c80a5a8', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-07-04 08:04:02)\"}', NULL, '2023-07-04 06:04:02', '2023-07-04 06:04:02'),
('464202a2-177c-4996-9ebe-942ebbc47885', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 564564\"}', NULL, '2023-05-22 07:51:39', '2023-05-22 07:51:39'),
('4695891b-3071-4c9a-b89d-397a857f5503', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-19 08:29:16)\"}', NULL, '2023-08-19 05:29:16', '2023-08-19 05:29:16'),
('46f57ceb-40d7-4fd5-ba4a-125b137b6daa', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 4234234324\"}', '2023-05-22 07:50:33', '2023-05-22 07:48:19', '2023-05-22 07:50:33'),
('47c64d25-ed5c-4939-8a10-913d8a615c2f', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 23423424\"}', NULL, '2023-05-22 07:46:59', '2023-05-22 07:46:59'),
('47f8db72-919f-4e17-9bd4-11b153b55de3', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into pending at 2023-05-23 23:01:56\"}', '2023-05-23 21:05:28', '2023-05-23 21:01:56', '2023-05-23 21:05:28'),
('491b76a7-ec98-4d6c-9ca6-eef7f325ccdc', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 2342342\"}', NULL, '2023-05-22 08:37:15', '2023-05-22 08:37:15'),
('49db5997-2b8d-449e-ace7-b3542cd44078', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: werwerwe\"}', NULL, '2023-05-23 16:58:25', '2023-05-23 16:58:25'),
('49f05afa-4b49-4359-9d53-7609b2736937', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 242424323\"}', NULL, '2023-05-22 07:46:08', '2023-05-22 07:46:08'),
('4a20525b-9a32-44dc-9f0f-b0c1a1f67791', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: New Fashion Jeans\"}', '2023-05-23 20:41:24', '2023-05-23 20:37:30', '2023-05-23 20:41:24'),
('4a324be3-623e-417c-9bc6-2256a982e292', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product order created. Reference: QFj9NSYwy8Bs\"}', '2023-05-23 20:48:46', '2023-05-23 20:45:01', '2023-05-23 20:48:46'),
('4af007dc-cda2-4883-8cdf-41b7b35089eb', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-23 11:21:10)\"}', NULL, '2023-08-23 08:21:10', '2023-08-23 08:21:10'),
('4c576f20-3ea2-4249-afd3-835024c1b38b', 'App\\Notifications\\ProductCreated', 'App\\Models\\Subscriber', 3, '{\"data\":\"New product created. Name: ddddddddddd\"}', NULL, '2023-05-23 16:48:21', '2023-05-23 16:48:21'),
('4d61e307-9619-42cc-b5ad-7cac04b61ee3', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: sdfsf\"}', NULL, '2023-05-23 20:16:19', '2023-05-23 20:16:19'),
('4e985e33-40dc-41e0-a8d2-33f1b14ecdd4', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Subscriber', 2, '{\"data\":\"New service created. Name: 343243243\"}', NULL, '2023-05-23 17:40:41', '2023-05-23 17:40:41'),
('5', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/112.0.0.0 Safari\\/537.36, TIME: 2023-05-22 08:30:19)\"}', '2023-05-22 06:30:34', '2023-05-22 06:30:19', '2023-05-22 06:30:34'),
('509e4f6b-81db-4141-9fa5-6e11bbbb00c5', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 345\"}', '2023-05-23 16:55:35', '2023-05-23 16:54:10', '2023-05-23 16:55:35'),
('50fa2dec-1372-473e-aea7-b92489544fe9', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 6546546\"}', NULL, '2023-05-22 08:45:10', '2023-05-22 08:45:10'),
('51dd270d-f79e-4bd7-8551-50abdf0a0f2c', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 545435\"}', '2023-05-23 17:24:21', '2023-05-22 08:44:48', '2023-05-23 17:24:21'),
('5214c115-6df3-4716-9761-423c181c2015', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: fdghdf\"}', '2023-05-23 17:24:20', '2023-05-23 01:23:52', '2023-05-23 17:24:20'),
('5279c392-656f-46c0-b934-8be31f7454ab', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 23423424\"}', NULL, '2023-05-22 07:46:59', '2023-05-22 07:46:59'),
('52f7f917-d717-4af4-b8b8-60616470f536', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 22:41:16)\"}', '2023-05-23 20:41:24', '2023-05-23 20:41:16', '2023-05-23 20:41:24'),
('53ee00ff-b30b-400e-ad1d-789dc371b209', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 14343\"}', '2023-05-23 20:28:05', '2023-05-23 20:21:04', '2023-05-23 20:28:05'),
('54129edc-166e-4298-bc50-627ec5d2cd3b', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: New Fashion Jeans\"}', NULL, '2023-05-23 20:35:32', '2023-05-23 20:35:32'),
('54c35379-53c6-4b3e-8644-e85a713391c5', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-18 22:52:49)\"}', NULL, '2023-08-18 19:52:49', '2023-08-18 19:52:49'),
('5765a66a-10af-4ddb-a3e9-fb61a92f7387', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 22:44:30)\"}', '2023-05-23 20:44:36', '2023-05-23 20:44:30', '2023-05-23 20:44:36'),
('58557e98-71e1-45e7-8aa5-55dcd34b0913', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: New Fashion Jeans\"}', NULL, '2023-05-23 20:35:31', '2023-05-23 20:35:31'),
('58e200f7-c23a-49ba-bfc5-c0595be0d664', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into complete at 2023-05-23 23:06:43\"}', '2023-05-23 21:13:24', '2023-05-23 21:06:43', '2023-05-23 21:13:24'),
('5a1bde35-e3e5-440d-8fb1-cf9cdb31debc', 'App\\Notifications\\OrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service order created. Reference: 01H15515MXXYPVR1FWFWTYC1P1\"}', '2023-05-23 21:34:40', '2023-05-23 21:32:55', '2023-05-23 21:34:40'),
('5baa6aca-f442-43c5-ab48-9ff3374d7151', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Subscriber', 2, '{\"data\":\"New service created. Name: 55555555555555\"}', NULL, '2023-05-23 17:44:20', '2023-05-23 17:44:20'),
('5bb8c4fd-e580-47fd-a22f-7680167c4c69', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 23:00:00)\"}', '2023-05-23 21:05:28', '2023-05-23 21:00:00', '2023-05-23 21:05:28'),
('5bba7c29-65e9-4839-82c4-e13abd889b55', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: fdghdf\"}', NULL, '2023-05-23 01:23:52', '2023-05-23 01:23:52'),
('5c072b4f-189a-4bbe-ba3a-7e8597023f15', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 55555555555555\"}', NULL, '2023-05-23 17:44:20', '2023-05-23 17:44:20'),
('5c9b6605-7250-47bf-85f8-3e22434fea78', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 2543643543\"}', NULL, '2023-05-23 01:20:32', '2023-05-23 01:20:32'),
('5cca9e33-45e3-45ab-aad6-a112e1ec0030', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 242414\"}', NULL, '2023-05-23 20:56:12', '2023-05-23 20:56:12'),
('5cd0ac1f-c560-42fe-a614-b84617583a79', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 2342342\"}', NULL, '2023-05-22 08:37:15', '2023-05-22 08:37:15'),
('5e325dd4-3e2c-42bd-a18f-1ab00a01ce28', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 434234\"}', '2023-07-26 08:03:28', '2023-05-23 20:19:50', '2023-07-26 08:03:28'),
('609dafb6-034b-4b61-b26c-55d329b06062', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 545435\"}', NULL, '2023-05-22 08:44:48', '2023-05-22 08:44:48'),
('60e977de-7fd4-458e-8138-7c012c944eb0', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New product created. Name: New Product1\"}', NULL, '2023-05-23 20:39:39', '2023-05-23 20:39:39'),
('6205ab03-bb55-496c-a8e1-d93f953d1b35', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-23 10:06:28)\"}', NULL, '2023-08-23 07:06:28', '2023-08-23 07:06:28'),
('622f8d74-b370-4d1b-947a-9899fc1e8b45', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product created. Name: ddddddddddd\"}', '2023-05-23 17:49:10', '2023-05-23 16:48:21', '2023-05-23 17:49:10'),
('63213650-f6de-4a3c-b96c-0097e55caade', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 545435\"}', NULL, '2023-05-22 08:44:48', '2023-05-22 08:44:48'),
('63438113-abcd-4e42-8857-828350202f7e', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product order created. Reference: PwDpgRZlPGUr\"}', '2023-05-23 16:55:44', '2023-05-23 16:49:01', '2023-05-23 16:55:44'),
('63aaa918-5c0f-4007-9bcc-f1407f0d11c8', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 434234\"}', '2023-05-23 20:41:24', '2023-05-23 20:19:50', '2023-05-23 20:41:24'),
('65be23ef-2c00-4d29-84ec-6d546e1fffad', 'App\\Notifications\\PaymentReceived', 'App\\Models\\Customer', 1, '{\"data\":\"Aleksandar Todorovic, We have received payment (No. 15) of 777.0000.\"}', NULL, '2023-08-17 09:33:07', '2023-08-17 09:33:07'),
('65ef7804-7022-4b42-a858-70acd7c76eb6', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: TTT\"}', '2023-07-26 08:03:28', '2023-05-23 00:39:38', '2023-07-26 08:03:28'),
('664279a3-2a61-4dbf-b6c6-958786c939b1', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 2, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 18:58:09)\"}', '2023-05-23 17:24:20', '2023-05-23 16:58:09', '2023-05-23 17:24:20'),
('68e41a72-d4bf-4c43-b091-6eeadf2704be', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: New Fashion Jeans\"}', NULL, '2023-05-23 20:37:30', '2023-05-23 20:37:30'),
('68f5b42f-bbcd-4087-aba8-5129f6183623', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 10, '{\"data\":\"New product order created. Reference: Lvi42shzymmB\"}', '2023-07-26 11:18:31', '2023-07-26 11:18:20', '2023-07-26 11:18:31'),
('6999cf26-e1af-407e-b96c-7a47b8b465ea', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 23423\"}', NULL, '2023-05-22 08:34:06', '2023-05-22 08:34:06'),
('6b6d2434-6eca-42d0-ba0c-09c4039f255e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 6546546\"}', '2023-05-23 17:24:21', '2023-05-22 08:45:10', '2023-05-23 17:24:21'),
('6c0396f6-552d-4e76-a485-6ec36f2f8046', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New product created. Name: New Product\"}', NULL, '2023-08-07 15:44:40', '2023-08-07 15:44:40'),
('6c6062af-7520-4237-9e98-dd080e920b28', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New product created. Name: New Product1\"}', NULL, '2023-05-23 20:39:39', '2023-05-23 20:39:39'),
('6d3ab9fa-77dd-42d2-862c-e471bf3a75d5', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: New Smart Fashion Suit\"}', '2023-05-23 02:44:33', '2023-05-23 02:38:01', '2023-05-23 02:44:33'),
('6d61bcf6-cdc9-455c-a6f7-91b268ccd304', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: fdghdf\"}', '2023-07-26 08:03:28', '2023-05-23 01:23:52', '2023-07-26 08:03:28'),
('6d7a0f65-2e8a-49d6-abe7-824eb661c98c', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 435345\"}', NULL, '2023-05-23 17:24:07', '2023-05-23 17:24:07'),
('6de68dbc-6092-4cc8-8b68-2e4a2fce63cd', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New product created. Name: t4\"}', NULL, '2023-05-23 20:29:17', '2023-05-23 20:29:17'),
('6f689fc3-ab04-48ed-a06f-7318ad2fc193', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 2342342\"}', '2023-05-22 08:37:26', '2023-05-22 08:37:15', '2023-05-22 08:37:26'),
('6fcff214-3317-4271-9b2f-c32ac1018fc6', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-22 09:41:40)\"}', NULL, '2023-08-22 06:41:40', '2023-08-22 06:41:40'),
('70004928-b5fb-4974-8a07-17e6e24f869c', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into complete at 2023-05-23 22:43:09\"}', '2023-05-23 20:44:36', '2023-05-23 20:43:10', '2023-05-23 20:44:36'),
('7193ecca-35a1-49bd-845f-8d708ae55002', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Subscriber', 5, '{\"data\":\"New service created. Name: 55555555555555\"}', NULL, '2023-05-23 17:44:20', '2023-05-23 17:44:20'),
('720df84b-cb18-4f2e-9258-579929d1bcb9', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 434234\"}', '2023-05-23 20:28:05', '2023-05-23 20:19:50', '2023-05-23 20:28:05'),
('72900d88-dff0-4e1b-b70d-1d57c1328a9f', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 23423424\"}', '2023-05-23 17:24:21', '2023-05-22 07:46:59', '2023-05-23 17:24:21'),
('72e50104-7c12-476d-a638-11d783b3f45f', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 545435\"}', NULL, '2023-05-22 08:44:48', '2023-05-22 08:44:48'),
('7357aa17-d554-49bc-93e7-db9e898acb80', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 23423\"}', NULL, '2023-05-22 08:34:06', '2023-05-22 08:34:06'),
('75824611-05b2-4dee-b905-d66d8c3a16e9', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: gdfgdfg\"}', '2023-07-26 08:03:28', '2023-05-22 16:58:09', '2023-07-26 08:03:28'),
('76d7080c-8485-495f-97e6-c041342b232c', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 16:15:15)\"}', '2023-05-23 14:17:43', '2023-05-23 14:15:15', '2023-05-23 14:17:43'),
('7705e220-159b-4d53-849a-cb3fa86ae70e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: ewrwerwe\"}', NULL, '2023-05-22 07:51:19', '2023-05-22 07:51:19'),
('775b0bd3-df96-45d3-8cb7-c7600542122b', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Mobile Safari\\/537.36, TIME: 2023-08-07 11:27:44)\"}', NULL, '2023-08-07 09:27:44', '2023-08-07 09:27:44'),
('77ca4063-e0ba-49c2-9144-ff6ab9887b1e', 'App\\Notifications\\OrderStatusUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"Your order number 10 has been updated, new order status is Ready\"}', '2023-05-23 21:34:40', '2023-05-23 21:33:22', '2023-05-23 21:34:40'),
('77f4cca1-cc04-4f9c-b192-143c334df072', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 343423\"}', NULL, '2023-05-23 20:28:54', '2023-05-23 20:28:54'),
('786fb6d0-d605-4e7a-a09e-3a2af803b7a0', 'App\\Notifications\\ProductCreated', 'App\\Models\\Subscriber', 5, '{\"data\":\"New product created. Name: ddddddddddd\"}', NULL, '2023-05-23 16:48:21', '2023-05-23 16:48:21'),
('792e30b0-7d3d-4d7d-88b3-1593c47b630e', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-06-08 07:14:50)\"}', NULL, '2023-06-08 05:14:50', '2023-06-08 05:14:50'),
('79e199e3-c175-4733-86a1-1f9c365207ce', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: fr3\"}', '2023-05-23 20:55:58', '2023-05-23 20:55:23', '2023-05-23 20:55:58'),
('7b8ec169-b599-4b57-ad14-9d0080224452', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: sdfsf\"}', '2023-07-26 08:03:28', '2023-05-23 20:16:19', '2023-07-26 08:03:28'),
('7de51940-2a97-4a6e-a1c7-0a338d9e73a4', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product created. Name: t4\"}', '2023-05-23 20:41:24', '2023-05-23 20:29:17', '2023-05-23 20:41:24'),
('7f2cd904-0f59-496c-9c00-77952781dd22', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product order created. Reference: x4vKETfLewRv\"}', '2023-05-23 20:55:58', '2023-05-23 20:54:00', '2023-05-23 20:55:58'),
('7f4a9175-4509-4dd0-80ac-b54d61912321', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-07-04 17:48:43)\"}', NULL, '2023-07-04 15:48:43', '2023-07-04 15:48:43'),
('7f715fd0-e2b2-40b7-a98d-4cea158cf62b', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 23423424\"}', '2023-05-22 07:50:34', '2023-05-22 07:46:59', '2023-05-22 07:50:34'),
('7f9c2418-bc89-4349-b130-28dab3efbd14', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: werwerw\"}', NULL, '2023-05-23 16:47:34', '2023-05-23 16:47:34'),
('800ace63-8357-4a89-99ae-f14751557711', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 242424323\"}', NULL, '2023-05-22 07:46:08', '2023-05-22 07:46:08'),
('821da514-7470-47d3-b7d9-4e23a3c1cd84', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s status changed into Completed at 2023-05-23 23:32:05\"}', '2023-05-23 21:32:47', '2023-05-23 21:32:05', '2023-05-23 21:32:47'),
('8221b2da-8a79-484c-b72e-d7c7662e5e2d', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 2543643543\"}', '2023-05-23 02:44:33', '2023-05-23 01:20:31', '2023-05-23 02:44:33'),
('82bd5859-5594-4701-b772-bfbf556ea7e9', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 6546546\"}', NULL, '2023-05-22 08:45:10', '2023-05-22 08:45:10'),
('82f6f2ab-6974-4518-b54c-c9e205169b8a', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 4543643\"}', NULL, '2023-05-23 20:26:40', '2023-05-23 20:26:40'),
('84c9bea5-36a7-47a3-acfd-aeea368dcab6', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-18 05:50:24)\"}', NULL, '2023-08-18 02:50:24', '2023-08-18 02:50:24'),
('85541f3c-414e-47c4-b5d2-016f26105b28', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 342342\"}', '2023-05-22 08:37:19', '2023-05-22 08:37:06', '2023-05-22 08:37:19'),
('85949d2c-12c4-4649-b6c0-e35e628c7d1c', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: sdfsf\"}', NULL, '2023-05-23 20:16:19', '2023-05-23 20:16:19'),
('880243', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/112.0.0.0 Safari\\/537.36, TIME: 2023-05-22 08:30:51)\"}', '2023-05-22 06:30:56', '2023-05-22 06:30:51', '2023-05-22 06:30:56'),
('880244', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/112.0.0.0 Safari\\/537.36, TIME: 2023-05-22 08:51:04)\"}', '2023-05-22 06:51:13', '2023-05-22 06:51:04', '2023-05-22 06:51:13'),
('880245', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-22 09:08:13)\"}', '2023-05-22 07:08:26', '2023-05-22 07:08:13', '2023-05-22 07:08:26'),
('888a26e8-55cc-47d5-b16a-bb820f2cedba', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 345\"}', NULL, '2023-05-23 16:54:10', '2023-05-23 16:54:10'),
('89213abf-f891-4976-bb39-9c0330543c4e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: fr3\"}', NULL, '2023-05-23 20:55:23', '2023-05-23 20:55:23'),
('8a3919df-c5e3-4ae5-a3ff-2425f2aacae7', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: rwerwe\"}', '2023-05-23 16:46:50', '2023-05-23 16:46:32', '2023-05-23 16:46:50'),
('8a3f8ae0-7e42-4044-926a-50b554e04e95', 'App\\Notifications\\OrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service order created. Reference: 01H155BQ3RHP77XFC69WAYA0R1\"}', '2023-05-23 21:39:04', '2023-05-23 21:38:41', '2023-05-23 21:39:04'),
('8b09dd50-5d95-4d99-a7f5-b877cb562dca', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New product created. Name: werwer\"}', '2023-07-26 08:03:28', '2023-05-22 16:57:09', '2023-07-26 08:03:28'),
('8b9cbcb5-6ca1-4a44-bfec-739765e21e83', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New product created. Name: werwer\"}', NULL, '2023-05-22 16:57:09', '2023-05-22 16:57:09'),
('8c5cd685-6f5b-4976-888e-c111b9cf80a2', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product order created. Reference: HQ0wQzsRGeRm\"}', NULL, '2023-07-05 06:41:01', '2023-07-05 06:41:01'),
('8cca54a0-467f-4a6a-a21d-e5d1b8e2b944', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 234234\"}', '2023-05-22 08:37:28', '2023-05-22 08:36:51', '2023-05-22 08:37:28'),
('8e6b7f14-7eb2-45d4-8d41-05a1b6dda277', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 1313213\"}', '2023-05-23 20:16:03', '2023-05-23 20:13:54', '2023-05-23 20:16:03'),
('8e8318c8-9d17-4d47-b070-f2f3869b643c', 'App\\Notifications\\OrderStatusUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"Your order number 11 has been updated, new order status is Preparing\"}', '2023-05-23 21:39:40', '2023-05-23 21:39:14', '2023-05-23 21:39:40'),
('8f087ee9-9e35-49c4-a192-7d53998d69c4', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 543534\"}', NULL, '2023-05-23 02:29:35', '2023-05-23 02:29:35'),
('90ae8195-64c9-492c-8b5c-c41c02a66200', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36, TIME: 2023-08-03 00:53:46)\"}', NULL, '2023-08-02 22:53:46', '2023-08-02 22:53:46'),
('9117d5aa-ab66-4ed1-b599-17db25506900', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product order created. Reference: SwCESHBbPJuF\"}', '2023-05-23 21:30:50', '2023-05-23 21:30:43', '2023-05-23 21:30:50'),
('91eda8ac-7f15-44da-883d-85435db16a81', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 343423\"}', '2023-05-23 20:32:41', '2023-05-23 20:28:54', '2023-05-23 20:32:41'),
('9330f319-95c2-4be5-aacf-4ff3db96ab5c', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into reject at 2023-05-23 23:00:45\"}', '2023-05-23 21:05:28', '2023-05-23 21:00:45', '2023-05-23 21:05:28'),
('93b06a2d-a4c3-463f-b887-209c618e2f70', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: fr3\"}', '2023-07-26 08:03:28', '2023-05-23 20:55:23', '2023-07-26 08:03:28'),
('95950780-737b-4148-9d57-5a5309b683f1', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New product created. Name: New Product1\"}', NULL, '2023-05-23 20:39:39', '2023-05-23 20:39:39'),
('962139e4-5b28-4afe-9bfd-ab2a139fa039', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into pending at 2023-05-23 23:27:10\"}', '2023-05-23 21:27:21', '2023-05-23 21:27:10', '2023-05-23 21:27:21'),
('9868fc22-b921-420d-a05f-74d53dcbac84', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 10, '{\"data\":\"New product created. Name: New Product\"}', NULL, '2023-08-07 15:44:40', '2023-08-07 15:44:40'),
('9a52bf8d-ddd5-422a-8f1d-428dc9c6f7e9', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 343423\"}', NULL, '2023-05-23 20:28:54', '2023-05-23 20:28:54'),
('a300e49b-5cf4-444a-8f97-2e868ddabc05', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-06-08 05:12:38)\"}', NULL, '2023-06-08 03:12:38', '2023-06-08 03:12:38'),
('a33d280f-d359-42b4-9eef-d17453c64172', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: fr3\"}', NULL, '2023-05-23 20:55:23', '2023-05-23 20:55:23'),
('a59d84c3-99c3-4c55-826f-8f8838373622', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-18 05:37:38)\"}', NULL, '2023-08-18 02:37:38', '2023-08-18 02:37:38'),
('a5ba800d-c88c-478c-b18c-0202612cc814', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product order created. Reference: 0MmAuCVxd4xt\"}', '2023-05-23 20:42:18', '2023-05-23 20:42:08', '2023-05-23 20:42:18'),
('a5d9a3da-7581-41e0-9eba-7ed7e3bc9da5', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 43543543\"}', NULL, '2023-05-23 17:24:35', '2023-05-23 17:24:35'),
('a6161938-4d93-4f04-a264-ac656de0bb29', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New product created. Name: t4\"}', NULL, '2023-05-23 20:29:17', '2023-05-23 20:29:17'),
('a684579d-0bc5-42f9-9ab9-04f9f173477d', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: ewrwerwe\"}', '2023-05-22 07:51:29', '2023-05-22 07:51:18', '2023-05-22 07:51:29'),
('a6a5b00d-d805-420f-88f2-a05d5d83c7ce', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New product created. Name: werwer\"}', '2023-05-23 17:24:21', '2023-05-22 16:57:09', '2023-05-23 17:24:21'),
('a6b6ac0a-a90c-4148-8bcc-04240db91668', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 22:55:51)\"}', '2023-05-23 20:55:58', '2023-05-23 20:55:51', '2023-05-23 20:55:58'),
('a8315843-2719-4ea4-a5fe-57eb246d12c0', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into reject at 2023-05-23 23:31:16\"}', '2023-05-23 21:31:36', '2023-05-23 21:31:16', '2023-05-23 21:31:36');
INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('a8440516-fb26-4d19-b9ae-9eeae9116bd8', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into pending at 2023-05-23 22:45:30\"}', '2023-05-23 20:48:46', '2023-05-23 20:45:30', '2023-05-23 20:48:46'),
('a90ef4d3-70e2-42a1-9ad0-d8bdfc0ae71e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 2342342\"}', NULL, '2023-05-22 08:37:15', '2023-05-22 08:37:15'),
('a9463a95-3135-41c4-b034-6813111a4e02', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into reject at 2023-05-23 23:27:28\"}', '2023-05-23 21:27:36', '2023-05-23 21:27:29', '2023-05-23 21:27:36'),
('a9d14210-1d55-4e9d-b120-11bf278bd297', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.42, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-07-07 08:40:36)\"}', NULL, '2023-07-07 06:40:36', '2023-07-07 06:40:36'),
('aa6af31d-2ae9-4676-ab02-3657eb49b9e7', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New product created. Name: t4\"}', NULL, '2023-05-23 20:29:17', '2023-05-23 20:29:17'),
('ac43b69e-a2d2-4042-82b8-a12e25d968a0', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 1313213\"}', '2023-07-26 08:03:28', '2023-05-23 20:13:54', '2023-07-26 08:03:28'),
('acbd3dc7-4adc-4c36-b041-1a6169cd07f6', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: ewrwerwe\"}', NULL, '2023-05-22 07:51:19', '2023-05-22 07:51:19'),
('ad979df7-e4a9-40c7-b2ab-bcdc08fef4d4', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 10, '{\"data\":\"Logged in (IP: 78.84.128.251, AGENT: Mozilla\\/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-07-26 13:11:55)\"}', NULL, '2023-07-26 11:11:55', '2023-07-26 11:11:55'),
('aec022b6-f37f-45c9-8c78-705fa042235c', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 22:13:30)\"}', '2023-05-23 20:13:37', '2023-05-23 20:13:30', '2023-05-23 20:13:37'),
('affc3d03-8aa8-470b-a3f8-c38933eb193e', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s status changed into Received at 2023-05-23 22:45:53\"}', '2023-05-23 20:48:46', '2023-05-23 20:45:53', '2023-05-23 20:48:46'),
('b0538419-8954-4a33-aed0-cbe3ff0561c3', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 434234\"}', NULL, '2023-05-23 20:19:50', '2023-05-23 20:19:50'),
('b09cccf0-cc25-40bb-9de9-ad0c9a8dbc73', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 1313213\"}', NULL, '2023-05-23 20:13:55', '2023-05-23 20:13:55'),
('b0d21bb3-af9b-4d62-810f-098cb472c139', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into reject at 2023-05-23 23:13:31\"}', '2023-05-23 21:14:27', '2023-05-23 21:13:31', '2023-05-23 21:14:27'),
('b1a1919a-681d-4010-a0e2-05d182f72da0', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product order created. Reference: nGI7Sq8qVd5H\"}', NULL, '2023-07-04 08:07:26', '2023-07-04 08:07:26'),
('b22e3a79-14e5-43f7-b6a3-ce4a8e848060', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: New Smart Fashion Suit\"}', NULL, '2023-05-23 02:38:02', '2023-05-23 02:38:02'),
('b23739c4-6923-400b-bfac-8fe0b2c2c117', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 151.236.8.124, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 04:03:53)\"}', '2023-05-23 02:44:33', '2023-05-23 02:03:53', '2023-05-23 02:44:33'),
('b2533853-e321-4c32-bae6-65cea0e4f10f', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into complete at 2023-05-23 23:03:20\"}', '2023-05-23 21:05:28', '2023-05-23 21:03:20', '2023-05-23 21:05:28'),
('b25d002a-fcda-42de-a827-4e106d3e0945', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: sdfsf\"}', '2023-05-23 20:41:24', '2023-05-23 20:16:19', '2023-05-23 20:41:24'),
('b3f77dd7-6fcb-4c10-89f2-16e9acc460aa', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: New Fashion Jeans\"}', '2023-07-26 08:03:28', '2023-05-23 20:37:30', '2023-07-26 08:03:28'),
('b5712b2c-0aa4-4e2a-acf2-2d10fbc2b623', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-07-04 09:21:47)\"}', NULL, '2023-07-04 07:21:47', '2023-07-04 07:21:47'),
('b8b6b489-7aaf-45cc-a34b-357901de888b', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New product created. Name: New Product1\"}', '2023-05-23 20:39:46', '2023-05-23 20:39:39', '2023-05-23 20:39:46'),
('b970b95c-0056-4aa2-8a9a-3c2ddd81bb4c', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 14343\"}', NULL, '2023-05-23 20:21:04', '2023-05-23 20:21:04'),
('ba620b92-b9cd-4e6b-ab24-09b4367572e9', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: New Smart Fashion Suit\"}', NULL, '2023-05-23 02:38:02', '2023-05-23 02:38:02'),
('baa76da1-1808-4524-95c7-348efad7afce', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: ewrwerwe\"}', NULL, '2023-05-22 07:51:19', '2023-05-22 07:51:19'),
('bc90e1c9-2a81-4d7c-9627-f5e5b82f311a', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: werwerwe\"}', '2023-05-23 17:49:10', '2023-05-23 16:58:25', '2023-05-23 17:49:10'),
('bf45b03f-efc0-4a9b-95e6-7a71eb00a460', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 6546546\"}', NULL, '2023-05-22 08:45:10', '2023-05-22 08:45:10'),
('bf71411e-4968-44f8-9c94-30a383e2c239', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: gdfgdfg\"}', NULL, '2023-05-22 16:58:09', '2023-05-22 16:58:09'),
('bfbf1782-cb5b-4530-929f-2d55d8797d17', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 435345\"}', '2023-05-23 17:49:10', '2023-05-23 17:24:06', '2023-05-23 17:49:10'),
('c150fa6f-0f75-4753-804d-2141e96dc3b6', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 342342\"}', NULL, '2023-05-22 08:37:06', '2023-05-22 08:37:06'),
('c1e7a4d3-7e0d-4107-b5ff-2f5bfa283840', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Mobile Safari\\/537.36, TIME: 2023-08-03 09:58:34)\"}', NULL, '2023-08-03 07:58:34', '2023-08-03 07:58:34'),
('c24d9647-304a-48a5-b0ad-5f5ebfe40fd3', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 151.236.8.124, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 04:30:14)\"}', '2023-05-23 02:44:33', '2023-05-23 02:30:14', '2023-05-23 02:44:33'),
('c2d0c8a0-53de-455a-9685-07a24f8389a7', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: rter\"}', '2023-05-23 20:41:24', '2023-05-23 20:28:26', '2023-05-23 20:41:24'),
('c410418a-5be1-4282-91bc-15bcbcdf2026', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New product created. Name: werwer\"}', NULL, '2023-05-22 16:57:09', '2023-05-22 16:57:09'),
('c4190909-de37-4ba4-b582-0674b9efa94a', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into pending at 2023-05-23 22:43:02\"}', '2023-05-23 20:44:36', '2023-05-23 20:43:02', '2023-05-23 20:44:36'),
('c4c4457e-7778-4791-b5d9-7ef3211dd5ae', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 343423\"}', '2023-05-23 20:41:24', '2023-05-23 20:28:54', '2023-05-23 20:41:24'),
('c5834a36-92f3-414e-a93e-098fc2c44e0a', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 564564\"}', '2023-05-22 07:52:47', '2023-05-22 07:51:39', '2023-05-22 07:52:47'),
('c5d4ce39-bdd2-4f21-b479-0d0e5f6bd132', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 14343\"}', NULL, '2023-05-23 20:21:04', '2023-05-23 20:21:04'),
('c6834261-ece7-468b-a96e-bfdb63589379', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Subscriber', 3, '{\"data\":\"New service created. Name: 55555555555555\"}', NULL, '2023-05-23 17:44:20', '2023-05-23 17:44:20'),
('c6dad428-334f-43fd-af4e-b771d10699de', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 3, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-23 16:47:30)\"}', NULL, '2023-08-23 13:47:30', '2023-08-23 13:47:30'),
('c70f3a7d-fc8a-4e90-834c-51c586b44174', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: New Fashion Jeans\"}', '2023-07-26 08:03:28', '2023-05-23 20:35:31', '2023-07-26 08:03:28'),
('c75a8156-8e89-4a05-8b3a-e8471a0f2670', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: TTT\"}', '2023-05-23 17:24:20', '2023-05-23 00:39:38', '2023-05-23 17:24:20'),
('c7f8015b-1660-45bb-b337-5ed978e39d38', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: fr3\"}', NULL, '2023-05-23 20:55:23', '2023-05-23 20:55:23'),
('c9b55527-0d12-44e7-b296-b6c85e2d3375', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 342342\"}', NULL, '2023-05-22 08:37:06', '2023-05-22 08:37:06'),
('ca4f3aeb-34da-4a04-a041-37f6664c9ecf', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: sdfsf\"}', NULL, '2023-05-23 20:16:19', '2023-05-23 20:16:19'),
('caa9c374-aa74-41a5-8e32-0c49c0786380', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 23423\"}', '2023-05-23 17:24:21', '2023-05-22 08:34:06', '2023-05-23 17:24:21'),
('cb12b683-a30c-42ad-9a26-7600d09ec4f6', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 234234\"}', '2023-05-23 17:24:21', '2023-05-22 08:36:51', '2023-05-23 17:24:21'),
('cc946f75-4b3f-43f6-903a-a3477fc2054a', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-07-05 06:22:15)\"}', NULL, '2023-07-05 04:22:15', '2023-07-05 04:22:15'),
('cd499292-0ca0-4d5b-b53d-39a512816a4f', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 43543543\"}', '2023-05-23 17:49:10', '2023-05-23 17:24:35', '2023-05-23 17:49:10'),
('cda19fdf-3b6e-4e2f-8d08-63cf0c15dc1e', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product order created. Reference: rRz7rogIZMGV\"}', '2023-05-23 21:05:28', '2023-05-23 21:00:14', '2023-05-23 21:05:28'),
('cee2cf5b-04e3-4b4b-a545-9b02f22bcd51', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: ewrwerwe\"}', '2023-05-23 17:24:21', '2023-05-22 07:51:18', '2023-05-23 17:24:21'),
('cf13f309-2372-4b4c-9b58-e69ebce2a76a', 'App\\Notifications\\OrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service order created. Reference: 01H14MX1ZGGB9ZXG42X1A13Z8R\"}', '2023-05-23 17:49:10', '2023-05-23 16:51:03', '2023-05-23 17:49:10'),
('d0246854-3cf7-4f4a-8575-c284998e7791', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into reject at 2023-05-23 23:05:10\"}', '2023-05-23 21:05:28', '2023-05-23 21:05:10', '2023-05-23 21:05:28'),
('d0458d94-f09c-4248-83cc-bde699182e1f', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: rter\"}', NULL, '2023-05-23 20:28:26', '2023-05-23 20:28:26'),
('d1ae65f4-7c79-4f04-9032-a1b48f1339bb', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New product created. Name: New Product\"}', NULL, '2023-08-07 15:44:38', '2023-08-07 15:44:38'),
('d1dfa7ed-8dce-480a-a32c-aaffc23fa480', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 242424323\"}', '2023-05-23 17:24:21', '2023-05-22 07:46:08', '2023-05-23 17:24:21'),
('d1f491e2-6b68-4ea9-a009-58cc3a37f811', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/112.0.0.0 Safari\\/537.36, TIME: 2023-05-23 16:04:56)\"}', '2023-05-23 14:05:20', '2023-05-23 14:04:56', '2023-05-23 14:05:20'),
('d1fd357f-1d4c-4747-a076-7729e39ff02c', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 242414\"}', '2023-07-26 08:03:28', '2023-05-23 20:56:12', '2023-07-26 08:03:28'),
('d29f8b38-b4bb-41b7-bbf4-b6e36df4925b', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 1313213\"}', NULL, '2023-05-23 20:13:55', '2023-05-23 20:13:55'),
('d2d20083-86b2-4d77-821c-8920c1ab4c1b', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: gdfgdfg\"}', NULL, '2023-05-22 16:58:09', '2023-05-22 16:58:09'),
('d4ce13ce-d900-4094-9809-08c35b892257', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: fdghdf\"}', NULL, '2023-05-23 01:23:52', '2023-05-23 01:23:52'),
('d5142669-5b6d-463c-bba9-c5164df4bb8e', 'App\\Notifications\\OrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service order created. Reference: 01H1550CA88V0MQMZERD8WP2EB\"}', '2023-05-23 21:34:40', '2023-05-23 21:32:29', '2023-05-23 21:34:40'),
('d64467ef-3b27-4ad4-97cf-fd4c212d1b61', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 564564\"}', '2023-05-23 17:24:21', '2023-05-22 07:51:39', '2023-05-23 17:24:21'),
('d80485f7-1c53-49d6-955c-aa6b1a799ece', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: rter\"}', '2023-05-23 20:28:43', '2023-05-23 20:28:26', '2023-05-23 20:28:43'),
('d8ce623e-d808-4d57-af9b-dad76662f80c', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 4234234324\"}', NULL, '2023-05-22 07:48:19', '2023-05-22 07:48:19'),
('d8e14b1b-76ef-40c9-a1c9-98e8148500fe', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/116.0.0.0 Safari\\/537.36, TIME: 2023-08-23 12:03:58)\"}', NULL, '2023-08-23 09:03:58', '2023-08-23 09:03:58'),
('d8f6ee9b-b0e2-4daf-a5d0-e1be4ab5badc', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Subscriber', 5, '{\"data\":\"New service created. Name: 343243243\"}', NULL, '2023-05-23 17:40:41', '2023-05-23 17:40:41'),
('d92bcc93-58d2-4551-bdd9-e88c0d4d924d', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: 2543643543\"}', '2023-05-23 17:24:20', '2023-05-23 01:20:31', '2023-05-23 17:24:20'),
('d982260c-670b-4364-8280-341e90725b2a', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36, TIME: 2023-06-08 06:56:17)\"}', NULL, '2023-06-08 04:56:17', '2023-06-08 04:56:17'),
('d9c6498e-d5e7-414f-a2ef-5570280f994e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 423423\"}', NULL, '2023-05-23 17:31:42', '2023-05-23 17:31:42'),
('d9eaf10d-3918-4a20-a061-58eae9a67b9c', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 242414\"}', NULL, '2023-05-23 20:56:12', '2023-05-23 20:56:12'),
('db67afdb-88dd-409a-a180-26cb04fba10b', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: rter\"}', '2023-07-26 08:03:28', '2023-05-23 20:28:26', '2023-07-26 08:03:28'),
('db99ed59-34fc-4101-a4d2-c3373dd82c23', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into complete at 2023-05-23 23:31:29\"}', '2023-05-23 21:32:00', '2023-05-23 21:31:29', '2023-05-23 21:32:00'),
('dbdcb0e1-8879-4c7d-9e82-67b54dd2ddbb', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Mobile Safari\\/537.36, TIME: 2023-08-07 03:47:43)\"}', NULL, '2023-08-07 01:47:43', '2023-08-07 01:47:43'),
('dc268e87-165a-46e3-88d2-552ac1c5d8af', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 545435\"}', '2023-05-22 12:11:47', '2023-05-22 08:44:48', '2023-05-22 12:11:47'),
('dc439282-4d1a-4380-82ba-333dbcba2c53', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 564564\"}', NULL, '2023-05-22 07:51:40', '2023-05-22 07:51:40'),
('dee2301e-254e-470d-bbdb-309cb330cc97', 'App\\Notifications\\OrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service order created. Reference: 01H154R34TV4J6FBR72NGSMYRP\"}', '2023-05-23 21:28:31', '2023-05-23 21:27:58', '2023-05-23 21:28:31'),
('dfbd4b9e-4724-40df-b157-3b9310ecb4a5', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: rter\"}', NULL, '2023-05-23 20:28:26', '2023-05-23 20:28:26'),
('e451283a-9fcc-4c81-9fbd-3553fd442822', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 234234\"}', NULL, '2023-05-22 08:36:51', '2023-05-22 08:36:51'),
('e588c096-ca25-43aa-8ab0-58d5ff7ac633', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Subscriber', 4, '{\"data\":\"New service created. Name: 343243243\"}', NULL, '2023-05-23 17:40:41', '2023-05-23 17:40:41'),
('e9c9a64b-f487-453f-ba90-b3305ae5144c', 'App\\Notifications\\OrderStatusUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"Your order number 11 has been updated, new order status is Completed\"}', '2023-05-23 21:39:40', '2023-05-23 21:39:32', '2023-05-23 21:39:40'),
('e9e1f6c8-ab53-4350-8826-fb148caac5eb', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product order created. Reference: dRvvg4vjAAyL\"}', NULL, '2023-07-07 06:44:52', '2023-07-07 06:44:52'),
('ea00d2ba-9d7c-474f-8b68-17a9139d6a79', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: 343423\"}', NULL, '2023-05-23 20:28:54', '2023-05-23 20:28:54'),
('ea5a1818-ee98-49db-b081-6ea3bef51faf', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: 434234\"}', NULL, '2023-05-23 20:19:50', '2023-05-23 20:19:50'),
('eb69d14e-5a94-4744-aa2b-cdd6a5ae3fce', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s paid_status changed into reject at 2023-05-23 22:45:22\"}', '2023-05-23 20:48:46', '2023-05-23 20:45:22', '2023-05-23 20:48:46'),
('ed0cce6a-4969-4c5d-b727-b622f577f499', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: New Fashion Jeans\"}', '2023-05-23 20:41:24', '2023-05-23 20:35:31', '2023-05-23 20:41:24'),
('ee24fe6a-fd2f-4dc6-8b95-c0ac061a2aab', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 242424323\"}', '2023-05-22 07:46:30', '2023-05-22 07:46:08', '2023-05-22 07:46:30'),
('ee7d9d9b-e03a-4c95-9daf-38db640582af', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: rwerwe\"}', NULL, '2023-05-23 16:46:32', '2023-05-23 16:46:32'),
('ee9fac84-afdd-4f85-ac28-64e610198c71', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 2, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/113.0.0.0 Safari\\/537.36, TIME: 2023-05-23 22:27:59)\"}', '2023-05-23 20:28:05', '2023-05-23 20:27:59', '2023-05-23 20:28:05'),
('f0da8f42-7275-447b-b3e0-27ca31eebc01', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 4543643\"}', '2023-07-26 08:03:28', '2023-05-23 20:26:40', '2023-07-26 08:03:28'),
('f1271694-f36c-4951-906f-4119eaf8f266', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: werwerw\"}', '2023-05-23 17:49:10', '2023-05-23 16:47:34', '2023-05-23 17:49:10'),
('f167c356-026a-4c80-94a8-a33c2bf3fba9', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.41, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/112.0.0.0 Safari\\/537.36, TIME: 2023-05-23 09:12:34)\"}', '2023-05-23 14:05:18', '2023-05-23 07:12:34', '2023-05-23 14:05:18'),
('f20a0070-87f5-4eca-8d22-76ba9bc29f22', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s status changed into Completed at 2023-05-23 22:54:21\"}', '2023-05-23 20:55:58', '2023-05-23 20:54:21', '2023-05-23 20:55:58'),
('f2711dfe-cb49-423c-b909-2bf18ff9da11', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 4543643\"}', NULL, '2023-05-23 20:26:40', '2023-05-23 20:26:40'),
('f2740fd9-98d3-4f27-a54b-7f4e01cb8571', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 242414\"}', '2023-05-23 20:56:56', '2023-05-23 20:56:12', '2023-05-23 20:56:56'),
('f29fb2a4-08aa-431b-b7b7-32eb4c985fdd', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New product created. Name: werwer\"}', NULL, '2023-05-22 16:57:09', '2023-05-22 16:57:09'),
('f38f51c0-1d59-4b88-8073-ad8bf244f917', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: White Trousers\"}', NULL, '2023-05-23 02:52:43', '2023-05-23 02:52:43'),
('f3a3fe2e-210b-4bfa-a5a4-486f4b137c72', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 55555555555555\"}', '2023-05-23 17:49:10', '2023-05-23 17:44:20', '2023-05-23 17:49:10'),
('f3b42708-31a4-4236-b133-9d24fdef134e', 'App\\Notifications\\ProductOrderCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New product order created. Reference: Db4DIVJNZUFS\"}', NULL, '2023-07-05 04:23:21', '2023-07-05 04:23:21'),
('f50b8865-6cf5-46b7-b42a-e5bd36c2e92b', 'App\\Notifications\\OrderStatusUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"Your order number 8 has been updated, new order status is Preparing\"}', '2023-05-23 21:28:39', '2023-05-23 21:28:22', '2023-05-23 21:28:39'),
('f58b9205-0072-44ff-b8b5-b296744ca820', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 2, '{\"data\":\"New service created. Name: gdfgdfg\"}', '2023-05-23 17:24:21', '2023-05-22 16:58:09', '2023-05-23 17:24:21'),
('f6529afa-8f19-4d0d-b192-24be71ae184b', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 6, '{\"data\":\"New service created. Name: TTT\"}', NULL, '2023-05-23 00:39:38', '2023-05-23 00:39:38'),
('f6b463a8-4a83-4eb6-85ee-51c904094300', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: New Fashion Jeans\"}', NULL, '2023-05-23 20:37:30', '2023-05-23 20:37:30'),
('f6bd1f8e-c70b-49ea-b98f-c7157dc70631', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 14343\"}', NULL, '2023-05-23 20:21:04', '2023-05-23 20:21:04'),
('f75e5d6d-9053-41fb-a3d1-c0abc8655d8e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New service created. Name: New Fashion Jeans\"}', NULL, '2023-05-23 20:35:32', '2023-05-23 20:35:32'),
('f7f9a60c-5a4f-41a3-a80e-94f80d305ff5', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 3, '{\"data\":\"New service created. Name: 14343\"}', '2023-07-26 08:03:28', '2023-05-23 20:21:04', '2023-07-26 08:03:28'),
('f83b9807-0bb2-4888-866e-2102fdc0df31', 'App\\Notifications\\ProductCreated', 'App\\Models\\Customer', 5, '{\"data\":\"New product created. Name: New Product\"}', NULL, '2023-08-07 15:44:39', '2023-08-07 15:44:39'),
('f8c91f43-7c69-488d-aa2b-c03cd73135e5', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 1313213\"}', NULL, '2023-05-23 20:13:54', '2023-05-23 20:13:54'),
('f8d6c20a-06cf-4562-a78b-d47ff5e939fb', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: rter\"}', NULL, '2023-05-23 20:28:26', '2023-05-23 20:28:26'),
('fa3e5b09-ec40-4dae-88b9-4d816cb573a0', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 564564\"}', NULL, '2023-05-22 07:51:39', '2023-05-22 07:51:39'),
('fa63b70c-213d-487e-8401-2221e21e99e0', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s status changed into Completed at 2023-05-23 22:45:58\"}', '2023-05-23 20:48:17', '2023-05-23 20:45:58', '2023-05-23 20:48:17'),
('fb313c31-de04-4be1-a57f-a4ecf3c0a492', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 188.43.136.46, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/112.0.0.0 Safari\\/537.36, TIME: 2023-06-05 09:36:14)\"}', NULL, '2023-06-05 07:36:14', '2023-06-05 07:36:14'),
('fb8209b3-90e8-42fa-b954-821357ff577e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 1, '{\"data\":\"New service created. Name: 543534\"}', '2023-05-23 02:44:33', '2023-05-23 02:29:34', '2023-05-23 02:44:33'),
('fd8ba3c2-3ff0-4345-9da2-bf3cc5899ebc', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Subscriber', 4, '{\"data\":\"New service created. Name: 55555555555555\"}', NULL, '2023-05-23 17:44:20', '2023-05-23 17:44:20'),
('fe02fd64-48b2-4ff7-94a2-d2642d41da99', 'App\\Notifications\\ProductOrderUpdated', 'App\\Models\\Customer', 1, '{\"data\":\"ProductOrder\'s status changed into Received at 2023-05-23 23:31:51\"}', '2023-05-23 21:32:09', '2023-05-23 21:31:51', '2023-05-23 21:32:09'),
('fe2a23fe-95fa-4d0e-84f5-b4a59998029c', 'App\\Notifications\\CustomerLogged', 'App\\Models\\Customer', 1, '{\"data\":\"Logged in (IP: 127.0.0.1, AGENT: Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36, TIME: 2023-08-06 21:38:42)\"}', NULL, '2023-08-06 19:38:42', '2023-08-06 19:38:42'),
('fea5eb5f-2fbc-4166-8bd1-421a8e98994e', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: 434234\"}', NULL, '2023-05-23 20:19:50', '2023-05-23 20:19:50'),
('febb8fc3-17a7-4565-81bf-12b2c70acf17', 'App\\Notifications\\ServiceCreated', 'App\\Models\\Customer', 4, '{\"data\":\"New service created. Name: fr3\"}', NULL, '2023-05-23 20:55:23', '2023-05-23 20:55:23');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(191) NOT NULL,
  `delivery_date` date NOT NULL,
  `total` decimal(25,4) NOT NULL,
  `discount` varchar(191) DEFAULT NULL,
  `discount_amount` decimal(25,4) DEFAULT NULL,
  `tax_amount` decimal(25,4) DEFAULT NULL,
  `grand_total` decimal(25,4) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Received',
  `priority` tinyint(4) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `hash` varchar(191) DEFAULT NULL,
  `paid` tinyint(1) DEFAULT 0,
  `photo_path` varchar(191) DEFAULT NULL,
  `transaction_id` varchar(191) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `assigned_to` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `account_id`, `reference`, `delivery_date`, `total`, `discount`, `discount_amount`, `tax_amount`, `grand_total`, `status`, `priority`, `note`, `hash`, `paid`, `photo_path`, `transaction_id`, `user_id`, `customer_id`, `assigned_to`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '01GW6Y64MDMKPC94K87074PED7', '2023-03-23', 500.0000, NULL, NULL, 45.0000, 545.0000, 'Completed', 2, NULL, '1cb4478552a3fec356fac358f7826b9d1eab5b3d', 1, 'orders/drZyTpJWb86GCfl8WAe9OBC7rVxLChEgLtAJJ6Yr.jpg', NULL, 1, 1, 2, '2023-03-23 08:53:17', '2023-03-23 08:53:48', NULL),
(2, 1, '01GW7E6CNTRWXWBQRDXYZZ3CPS', '2023-03-24', 25.0000, NULL, NULL, 2.2500, 27.2500, 'Completed', 3, NULL, '0ec0e7ab396abb7e52426470a3d4fd4c6ec2d704', 1, 'orders/pXdqeT0FRhZZieout7j3kL5kIjqhubETjbG5p1Zd.png', NULL, 1, 1, 2, '2023-03-23 13:33:03', '2023-03-30 11:46:00', NULL),
(3, 1, '01GWKASMTMZF35S5SKYPZHM03T', '2023-03-28', 25.0000, NULL, NULL, 2.2500, 27.2500, 'Completed', 2, NULL, '24556e6423a5ccfe6933e357daaa0223f85a894d', 1, 'orders/nPNvnkC0cVIZetXLRdTnOISJCilkyLcNv2ZwDR0I.png', NULL, 1, 1, 2, '2023-03-28 03:24:33', '2023-04-05 07:30:19', NULL),
(4, 1, '01GWNYZ8ZXCT2JVH7BSV8JH3BG', '2023-03-30', 25.0000, NULL, NULL, 0.0000, 25.0000, 'Completed', 1, NULL, '5476b8ffb4ca99a98518e378a6e6ce56dc07e8d7', 1, NULL, NULL, 1, 1, NULL, '2023-03-29 03:55:38', '2023-04-05 07:30:19', NULL),
(5, 1, '01GWP375QQWVY84N4S7SVRDPDN', '2023-03-30', 100.0000, NULL, NULL, 0.0000, 100.0000, 'Completed', 1, NULL, 'c09f5d28cd0631a62ed936c3b8eec4dfd5cda797', 1, NULL, NULL, 1, 1, NULL, '2023-03-29 05:09:51', '2023-04-05 07:30:50', NULL),
(6, 1, '01GWP8SNX4BRYP8GAQ43ZBE6Z7', '2023-03-30', 1000.0000, NULL, NULL, 210.0000, 1210.0000, 'Received', 1, '99', '92dde5d9f60a78d068084ae15c966d7cebf35832', 1, NULL, NULL, 1, 1, NULL, '2023-03-29 06:47:20', '2023-04-21 03:32:36', NULL),
(7, 1, '01H14MX1ZGGB9ZXG42X1A13Z8R', '2023-05-30', 90.0000, NULL, NULL, 0.0000, 90.0000, 'Pending', 2, '444', '4a72b685dec8752ec3dcb368c81a8a815cc41273', 1, NULL, NULL, 1, 1, NULL, '2023-05-23 16:51:03', '2023-05-23 16:51:03', NULL),
(8, 1, '01H154R34TV4J6FBR72NGSMYRP', '2023-05-31', 90.0000, NULL, NULL, 0.0000, 90.0000, 'Preparing', 2, 'fdfdsf', '83190abca64396e7e27cc0ad9543e482f93efbc3', 1, NULL, NULL, 1, 1, NULL, '2023-05-23 21:27:57', '2023-05-23 21:28:22', NULL),
(9, 1, '01H1550CA88V0MQMZERD8WP2EB', '2023-05-31', 90.0000, NULL, NULL, 0.0000, 90.0000, 'Pending', 1, 'qwe', '9c9d8f755a122a07ec65fe98046dece935814650', 1, NULL, NULL, 1, 1, NULL, '2023-05-23 21:32:29', '2023-05-23 21:32:29', NULL),
(10, 1, '01H15515MXXYPVR1FWFWTYC1P1', '2023-05-31', 90.0000, NULL, NULL, 0.0000, 90.0000, 'Completed', 1, 'qwe', '7fef0bfa5d2799c4d1fdb4cb1ce026bfabe669df', 1, NULL, NULL, 1, 1, NULL, '2023-05-23 21:32:55', '2023-06-02 15:23:24', NULL),
(11, 1, '01H155BQ3RHP77XFC69WAYA0R1', '2023-05-30', 90.0000, NULL, NULL, 0.0000, 90.0000, 'Completed', 1, 'rtt', '480482e76f9655af060b4ea7e290727dabca8b25', 1, NULL, NULL, 1, 1, NULL, '2023-05-23 21:38:41', '2023-05-23 21:39:32', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_payment`
--

CREATE TABLE `order_payment` (
  `amount` decimal(25,4) NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `order_payment`
--

INSERT INTO `order_payment` (`amount`, `order_id`, `payment_id`) VALUES
(545.0000, 1, 7),
(27.2500, 2, 8),
(1000.0000, 6, 10),
(90.0000, 7, 13),
(90.0000, 8, 13),
(90.0000, 9, 13),
(90.0000, 10, 13),
(90.0000, 11, 13);

-- --------------------------------------------------------

--
-- Table structure for table `order_services`
--

CREATE TABLE `order_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `qty` decimal(15,4) NOT NULL,
  `price` decimal(25,4) NOT NULL,
  `amount` decimal(25,4) NOT NULL,
  `measurement_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `order_services`
--

INSERT INTO `order_services` (`id`, `code`, `name`, `qty`, `price`, `amount`, `measurement_id`, `order_id`, `service_id`, `created_at`, `updated_at`) VALUES
(1, 'Custom-made clothing', 'Custom-made clothing', 1.0000, 500.0000, 500.0000, 4, 1, 1, '2023-03-23 08:53:18', '2023-03-23 08:53:18'),
(2, 'Tailored dresses', 'Shorten dress with an invisible hem', 1.0000, 25.0000, 25.0000, 6, 2, 2, '2023-03-23 13:33:03', '2023-03-23 13:33:03'),
(3, 'Tailored dresses', 'Shorten dress with an invisible hem', 1.0000, 25.0000, 25.0000, 6, 3, 2, '2023-03-28 03:24:37', '2023-03-28 03:24:37'),
(4, 'Tailored dresses', 'Shorten dress with an invisible hem', 1.0000, 25.0000, 25.0000, 6, 4, 2, '2023-03-29 03:55:41', '2023-03-29 03:55:41'),
(5, 'Alterations and repairs', 'Alterations and repairs', 1.0000, 100.0000, 100.0000, 7, 5, 7, '2023-03-29 05:09:51', '2023-03-29 05:09:51'),
(8, 'Custom-made clothing', 'Custom-made clothing', 2.0000, 500.0000, 1000.0000, 4, 6, 1, '2023-04-10 14:17:23', '2023-04-10 14:17:23'),
(9, 'TRSH', 'CRV Krekls', 1.0000, 90.0000, 90.0000, 4, 7, 1, '2023-05-23 16:51:03', '2023-05-23 16:51:03'),
(10, 'TRSH', 'CRV Krekls', 1.0000, 90.0000, 90.0000, 4, 8, 1, '2023-05-23 21:27:58', '2023-05-23 21:27:58'),
(11, 'TRSH', 'CRV Krekls', 1.0000, 90.0000, 90.0000, 4, 9, 1, '2023-05-23 21:32:29', '2023-05-23 21:32:29'),
(12, 'TRSH', 'CRV Krekls', 1.0000, 90.0000, 90.0000, 4, 10, 1, '2023-05-23 21:32:55', '2023-05-23 21:32:55'),
(13, 'TRSH', 'CRV Krekls', 1.0000, 90.0000, 90.0000, 4, 11, 1, '2023-05-23 21:38:41', '2023-05-23 21:38:41');

-- --------------------------------------------------------

--
-- Table structure for table `order_tax`
--

CREATE TABLE `order_tax` (
  `tax_id` int(10) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(15,4) DEFAULT NULL,
  `total_amount` decimal(15,4) DEFAULT NULL,
  `calculated_on` decimal(15,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `order_tax`
--

INSERT INTO `order_tax` (`tax_id`, `order_id`, `amount`, `total_amount`, `calculated_on`) VALUES
(1, 1, 45.0000, 45.0000, 500.0000),
(1, 2, 2.2500, 2.2500, 25.0000),
(1, 3, 2.2500, 2.2500, 25.0000),
(1, 6, 210.0000, 210.0000, 1000.0000);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(191) NOT NULL,
  `amount` decimal(25,4) NOT NULL,
  `file` varchar(191) DEFAULT NULL,
  `gateway` varchar(191) DEFAULT NULL,
  `received` tinyint(1) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `hash` varchar(191) DEFAULT NULL,
  `transaction_id` varchar(191) DEFAULT NULL,
  `gateway_transaction_id` varchar(191) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `account_id`, `date`, `reference`, `amount`, `file`, `gateway`, `received`, `description`, `hash`, `transaction_id`, `gateway_transaction_id`, `user_id`, `customer_id`, `order_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '2023-03-16', '01GVMDMSSMF3H1E8VGVHPG300D', 5000.0000, NULL, NULL, 1, NULL, '61141ede27555d5dca6d99806b116bd9a0708cd7', '3', NULL, 1, 2, NULL, '2023-03-16 04:17:52', '2023-03-16 04:17:52', NULL),
(2, 1, '2023-03-16', 'rert', 5000.0000, NULL, 'Cash', 1, NULL, 'ce7403e7a49150d1d52ab8cb753aef42ce5249ef', '4', NULL, 1, 2, NULL, '2023-03-16 04:18:12', '2023-03-16 04:18:12', NULL),
(3, 1, '2023-03-16', '01GVMDR51SJ5GJRCS2E77K5FG1', -2000.0000, NULL, NULL, 1, NULL, 'a70a8c90169de227de530a8ea6e6804d542fa0d2', '6', NULL, 1, 2, NULL, '2023-03-16 04:19:42', '2023-03-16 04:21:13', NULL),
(4, 1, '2023-03-16', '01GVMDRX8516BTJSDS1NVQBWBB', 5000.0000, NULL, 'Cash', 1, NULL, '5bf7c27e9fb6e76ec0a24d137f678b6841e493cc', '5', NULL, 1, 2, NULL, '2023-03-16 04:20:07', '2023-03-16 04:20:50', NULL),
(5, 1, '2023-03-16', '01GVMDVEM40QYS557EAFVTXYPR', -3000.0000, NULL, NULL, 1, NULL, 'a02030fdb42ec804d45d06ce4c4bfa3ea75fcbc4', '7', NULL, 1, 2, NULL, '2023-03-16 04:21:30', '2023-03-16 04:21:30', NULL),
(6, 1, '2023-03-16', '01GVMDWZGHD9CPC6015CNWA05T', -50000.0000, NULL, NULL, 1, NULL, 'b478d7710768c081b34a2168073a8a12b3ec7d76', '8', NULL, 1, 2, NULL, '2023-03-16 04:22:20', '2023-03-16 04:22:20', NULL),
(7, 1, '2023-03-23', '01GW6Y6MDCWB8QD26094C6CY20', 545.0000, NULL, 'Cash', 1, NULL, '612226099a0856a9ba8e8ea9100d48cec69a0bf1', '17', NULL, 1, 1, NULL, '2023-03-23 08:53:34', '2023-03-23 08:53:34', NULL),
(8, 1, '2023-03-23', '01GW7E7AVP19Y2WMYY3YNN188Q', 200.0000, NULL, NULL, 1, NULL, 'cfd348dad84384b487391cfcacd7508f888aba26', '19', NULL, 1, 1, NULL, '2023-03-23 13:33:34', '2023-03-23 13:33:34', NULL),
(9, 1, '2023-03-23', '01GW7E7SCZES3M64SDD0JTW9PY', 250.0000, NULL, 'Cash', 1, NULL, '6dae5685518d6264488168b4e68d6beeb58a8594', '20', NULL, 1, 1, NULL, '2023-03-23 13:33:49', '2023-03-23 13:33:49', NULL),
(10, 1, '2023-04-05', '01GX8C16A84HJFD83MEAZ24MN5', 1000.0000, NULL, 'Cash', 1, NULL, '1420b3f65749670b593df920170bc48dd2cde150', '25', NULL, 1, 1, NULL, '2023-04-05 07:30:12', '2023-04-21 03:31:37', NULL),
(11, 1, '2023-04-10', '01GXN9RBVMW5YYJ8ES3ESVGES3', 400.0000, NULL, 'Wire Transfer', 1, NULL, 'd9656992d13f8b2e8582f2ff8f25834088376e26', '26', NULL, 1, 3, NULL, '2023-04-10 11:00:33', '2023-04-10 11:00:33', NULL),
(12, 1, '2023-04-21', 'YP8GAQ43ZBE6Z7', 250.0000, NULL, 'Cash', 1, 'for test', '7b20ad98dc99e07f4b10f83e5bc26e39735daa38', '33', NULL, 1, 1, NULL, '2023-04-21 03:32:36', '2023-04-21 11:15:00', NULL),
(13, 1, '2023-04-21', '01GYHMWSTQKADQA46F07B46K2W', 20000.0000, NULL, 'Cash', 1, 'for test', '12ce882a1b1be1c234b2e14ee6e14c72889e1949', '42', NULL, 1, 1, NULL, '2023-04-21 11:13:57', '2023-04-21 11:15:09', NULL),
(14, 1, '2023-05-19', '01H0SHGGDPYETMBAE6Q2FD60SY', 200.0000, NULL, NULL, NULL, NULL, '89df810a82965483401c03277df9beb57a962a43', NULL, NULL, 1, 1, NULL, '2023-05-19 09:20:07', '2023-05-19 09:20:07', NULL),
(15, 1, '2023-08-17', 'kkh', 777.0000, NULL, 'Monezium', 1, 'hghf', '4a3f0887fab413bb3bf1ad55d5a346c4c9d905b3', '49', NULL, 1, 1, NULL, '2023-08-17 09:32:57', '2023-08-17 09:32:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payu_transactions`
--

CREATE TABLE `payu_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `paid_for_id` bigint(20) UNSIGNED DEFAULT NULL,
  `paid_for_type` varchar(191) DEFAULT NULL,
  `transaction_id` varchar(191) NOT NULL,
  `gateway` text NOT NULL,
  `body` text NOT NULL,
  `destination` varchar(191) NOT NULL,
  `hash` text NOT NULL,
  `response` text DEFAULT NULL,
  `status` enum('pending','failed','successful','invalid') NOT NULL DEFAULT 'pending',
  `verified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `main_photo` varchar(191) DEFAULT NULL,
  `sub_photos` text DEFAULT NULL,
  `price` double NOT NULL DEFAULT 0,
  `small_burst` varchar(15) DEFAULT NULL,
  `small_waist` varchar(15) DEFAULT NULL,
  `small_hips` varchar(15) DEFAULT NULL,
  `medium_burst` varchar(15) DEFAULT NULL,
  `medium_waist` varchar(15) DEFAULT NULL,
  `medium_hips` varchar(15) DEFAULT NULL,
  `large_burst` varchar(15) DEFAULT NULL,
  `large_waist` varchar(15) DEFAULT NULL,
  `large_hips` varchar(15) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` enum('men','women') NOT NULL DEFAULT 'men'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category_id`, `description`, `main_photo`, `sub_photos`, `price`, `small_burst`, `small_waist`, `small_hips`, `medium_burst`, `medium_waist`, `medium_hips`, `large_burst`, `large_waist`, `large_hips`, `deleted_at`, `created_at`, `updated_at`, `type`) VALUES
(1, 'Fashion Suit', 12, 'A blue shirt is a type of clothing that typically features a solid, plain or patterned blue-colored fabric. It can be long-sleeved or short-sleeved, and may have buttons or other types of closures at the front. \r\nBlue shirts are often made from materials such as cotton, polyester, or a blend of fibers, and they come in a variety of styles and fits, ranging from casual to formal wear. \r\nThey are versatile and can be paired with various pants, shorts, skirts or jackets to create different outfits suitable for different occasions.', '1679548004.jpg', '16794766760.png,16794766761.png,16794766762.jpg', 35.1, '33/80', '33/80', '33/80', '33/82', '33/82', '33/82', '33/84', '33/84', '33/84', NULL, NULL, '2023-08-08 08:19:48', 'men'),
(2, 'New Jeans', 2, 'Blue jeans are a type of durable pants that are typically made from denim fabric. They were originally designed for miners and cowboys in the late 1800s, but have since become a popular fashion item around the world. Blue jeans are characterized by their blue color and distinctive stitching, which often includes reinforced seams and rivets. They come in various styles such as straight leg, skinny, or bootcut, and can be worn casually or dressed up with a jacket or dress shirt. Blue jeans are versatile and practical, suitable for everyday wear, work, or outdoor activities.', '1679360176.jpg', '16794697321.png,16794699351.jpg', 24.5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-08 16:29:59', 'men'),
(3, 'White Trousers', 4, 'White trousers are a type of pants that are made from a light-colored fabric, typically white or off-white. They can be made from a variety of materials, such as cotton, linen, or synthetic blends. White trousers are often associated with warm weather and summer fashion, but they can also be worn year-round as part of a formal or casual outfit. They come in various styles and fits, ranging from slim to wide-leg, and can be paired with a variety of tops and footwear, depending on the occasion. White trousers can be dressed up with a blazer and dress shoes for a formal event, or dressed down with a t-shirt and sneakers for a more casual look.', '1679390656.jpg', '16794697321.png,16794699351.jpg', 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-08 16:29:59', 'men'),
(4, 'Women shirt', 3, 'This is new women shirt', '1679383179.png', '16794697321.png,16794699351.jpg', 21.5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-08 16:29:59', 'women'),
(5, 'Suit', 3, 'Fashion Clothes', '1679384174.jpg', '16794697321.png,16794699351.jpg', 30.4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-08 16:29:59', 'women'),
(6, 'Women Jeans', 2, 'This is new clothes.', '1679384205.jpg', '16794697321.png,16794699351.jpg', 24.6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-08 16:29:59', 'women'),
(7, 'Sports Suit', 3, '123123', '1679468725.png', '16794697321.png,16794699351.jpg', 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-08 16:29:59', 'men'),
(8, 'Sandstone', 12, 'Feel and look your best in this natural sand-colored suit. 100% Wool Super 90\'s', '1679587834.png', '16795878340.png,16795878341.png,16795878342.png', 499, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-08 16:29:59', 'men'),
(9, 'Premium Hazy Blue Windowpane', 12, 'Light blue windowpane checks contrast expertly against a hazy blue fabric. Now in merino wool! 100% Merino Wool', '1679587437.png', '16795874370.png,16795874371.png,16795874372.png', 794, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-08 16:29:59', 'men'),
(10, 'New Fashion Jeans', 2, 'Blue jeans are a type of durable pants that are typically made from denim fabric.', '1684847853.jpg', '', 2322, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-08 16:29:59', 'men'),
(22, 'New Product', 13, 'description', '1691419471.png', '16927073690.jpg,16927073691.jpg', 67.99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-07 15:44:31', '2023-08-22 12:29:29', 'men');

-- --------------------------------------------------------

--
-- Table structure for table `product_comments`
--

CREATE TABLE `product_comments` (
  `id` bigint(20) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_comments`
--

INSERT INTO `product_comments` (`id`, `product_id`, `customer_id`, `comment`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 'test comment', '2023-08-07 18:20:37', '2023-08-07 09:57:36', '2023-08-07 18:20:37'),
(2, 1, 3, 'hhhh', NULL, '2023-08-23 07:30:45', '2023-08-23 07:30:45'),
(3, 1, 1, 'qqqq', NULL, '2023-08-23 08:21:37', '2023-08-23 08:21:37');

-- --------------------------------------------------------

--
-- Table structure for table `product_orders`
--

CREATE TABLE `product_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `shipping_address_id` int(11) NOT NULL,
  `status` enum('Pending','Received','Completed') NOT NULL DEFAULT 'Pending',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(191) NOT NULL,
  `paid_status` varchar(191) DEFAULT 'pending',
  `gateway` varchar(191) NOT NULL,
  `billing_address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `product_orders`
--

INSERT INTO `product_orders` (`id`, `customer_id`, `shipping_address_id`, `status`, `deleted_at`, `created_at`, `updated_at`, `account_id`, `reference`, `paid_status`, `gateway`, `billing_address_id`) VALUES
(1, 1, 1, 'Completed', NULL, '2023-03-29 05:37:57', '2023-04-05 07:29:35', 1, 'lvJmBgqU2FO2', 'pending', '', 0),
(2, 1, 1, 'Completed', NULL, '2023-03-29 05:52:11', '2023-04-05 07:29:45', 1, 'lvJmBgqU2FO3', 'pending', '', 0),
(3, 1, 1, 'Pending', NULL, '2023-03-29 06:59:46', '2023-03-29 06:59:46', 1, 'lvJmBgqU2FO4', 'pending', '', 0),
(4, 1, 1, 'Completed', NULL, '2023-03-29 07:12:22', '2023-04-05 07:29:27', 1, 'lvJmBgqU2FO5', 'pending', '', 0),
(5, 1, 1, 'Received', NULL, '2023-03-29 07:15:15', '2023-04-05 07:29:08', 1, 'lvJmBgqU2FO6', 'pending', '', 0),
(6, 1, 1, 'Completed', NULL, '2023-04-04 04:50:38', '2023-04-06 08:27:26', 1, 'lvJmBgqU2FO1', 'complete', '', 0),
(7, 1, 1, 'Pending', NULL, '2023-04-04 04:57:30', '2023-04-04 04:58:18', 1, 'ITQTJOAwyGyy', 'complete', '', 0),
(8, 1, 1, 'Completed', NULL, '2023-04-05 05:27:38', '2023-04-05 10:03:39', 1, 'nR2tizVK06Zt', 'complete', '', 0),
(9, 1, 1, 'Pending', NULL, '2023-04-05 07:41:41', '2023-04-05 10:03:59', 1, '2jMqZJiFZszo', 'complete', '', 0),
(10, 1, 1, 'Completed', NULL, '2023-04-17 07:11:38', '2023-04-21 07:00:50', 1, 'b21aMQV5xGYh', 'complete', 'Wire Transfer', 0),
(11, 1, 1, 'Received', NULL, '2023-04-20 01:39:51', '2023-04-21 03:03:09', 1, 'EXTIofxPJhfJ', 'pending', 'Wire Transfer', 0),
(12, 3, 2, 'Pending', NULL, '2023-05-03 17:06:55', '2023-05-03 17:06:55', 1, 'PQW2apbFhT93', 'pending', 'Monezium', 2),
(13, 1, 1, 'Completed', NULL, '2023-05-22 06:52:09', '2023-05-23 14:04:45', 1, 'I6eqlVocMED7', 'complete', 'Wire Transfer', 1),
(14, 1, 1, 'Received', NULL, '2023-05-22 08:30:21', '2023-05-23 02:45:15', 1, '94FnhfSTH4cM', 'complete', 'Wire Transfer', 1),
(15, 3, 2, 'Pending', NULL, '2023-05-22 08:38:43', '2023-05-22 08:38:43', 1, 'fW0ClaN8UyCy', 'pending', 'Wire Transfer', 2),
(16, 3, 2, 'Pending', NULL, '2023-05-22 08:39:31', '2023-05-22 08:39:31', 1, 'PeYd7oycZgWL', 'pending', 'Wire Transfer', 2),
(17, 1, 1, 'Pending', NULL, '2023-05-23 16:49:01', '2023-05-23 16:49:01', 1, 'PwDpgRZlPGUr', 'pending', 'Wire Transfer', 1),
(18, 1, 1, 'Received', NULL, '2023-05-23 20:42:08', '2023-05-23 20:43:26', 1, '0MmAuCVxd4xt', 'complete', 'Wire Transfer', 1),
(19, 1, 1, 'Completed', NULL, '2023-05-23 20:45:01', '2023-05-23 20:45:58', 1, 'QFj9NSYwy8Bs', 'complete', 'Wire Transfer', 1),
(20, 1, 1, 'Completed', NULL, '2023-05-23 20:54:00', '2023-05-23 20:54:21', 1, 'x4vKETfLewRv', 'pending', 'Wire Transfer', 1),
(21, 1, 1, 'Pending', NULL, '2023-05-23 21:00:14', '2023-05-23 21:27:28', 1, 'rRz7rogIZMGV', 'reject', 'Wire Transfer', 1),
(22, 1, 1, 'Completed', NULL, '2023-05-23 21:30:43', '2023-05-23 21:32:05', 1, 'SwCESHBbPJuF', 'complete', 'Wire Transfer', 1),
(23, 1, 1, 'Pending', NULL, '2023-07-04 08:07:25', '2023-07-04 08:07:25', 1, 'nGI7Sq8qVd5H', 'pending', 'Monezium', 1),
(24, 1, 1, 'Pending', NULL, '2023-07-05 04:23:21', '2023-07-05 04:23:21', 1, 'Db4DIVJNZUFS', 'pending', 'Monezium', 1),
(25, 1, 1, 'Pending', NULL, '2023-07-05 06:41:01', '2023-07-05 06:41:01', 1, 'HQ0wQzsRGeRm', 'pending', 'Monezium', 1),
(26, 1, 1, 'Pending', NULL, '2023-07-07 06:44:52', '2023-07-07 06:44:52', 1, 'dRvvg4vjAAyL', 'pending', 'Monezium', 1),
(27, 10, 3, 'Pending', NULL, '2023-07-26 11:18:20', '2023-07-26 11:18:20', 0, 'Lvi42shzymmB', 'pending', 'Wire Transfer', 3);

-- --------------------------------------------------------

--
-- Table structure for table `product_reviews`
--

CREATE TABLE `product_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `title` varchar(191) NOT NULL,
  `content` text NOT NULL,
  `rate` double NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `product_reviews`
--

INSERT INTO `product_reviews` (`id`, `product_id`, `customer_id`, `title`, `content`, `rate`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'Good Jeans', 'This Jeans is good product for me.', 4, NULL, '2023-05-11 00:40:01', '2023-05-11 00:51:18'),
(2, 3, 1, 'Good Product', 'This is good trousers for me.', 5, NULL, '2023-05-11 00:43:36', '2023-05-11 00:43:36'),
(3, 4, 3, 'It was fantastic', 'The staff was great. The receptionists were very helpful and answered all our questions. The room was clean and bright, and the room service was always on time. Will be coming back! Thank you so much.', 5, NULL, '2023-05-14 18:35:02', '2023-05-14 18:36:39'),
(4, 1, 3, 'Good suit', 'I am very happy', 5, NULL, '2023-05-23 00:55:01', '2023-06-08 04:05:18'),
(5, 5, 1, 'Good Clothes', 'I love this clothes', 5, NULL, '2023-05-23 07:14:19', '2023-05-23 07:14:19'),
(6, 1, 3, 'Good Product for me', 'Thank you for your help', 4, NULL, '2023-06-05 16:46:48', '2023-06-08 04:05:50');

-- --------------------------------------------------------

--
-- Table structure for table `salaries`
--

CREATE TABLE `salaries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(25,4) NOT NULL,
  `staff_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `advance` tinyint(1) DEFAULT NULL,
  `settled_on` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `salaries`
--

INSERT INTO `salaries` (`id`, `account_id`, `date`, `amount`, `staff_id`, `user_id`, `advance`, `settled_on`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '2023-03-16', 1000.0000, 2, 2, NULL, NULL, 'Generating salaries with command.', '2023-03-16 04:22:40', '2023-03-16 04:22:40', NULL),
(2, 1, '2023-03-23', 1200.0000, 1, 1, NULL, NULL, 'Generating salaries with command.', '2023-03-23 08:54:02', '2023-03-23 08:54:02', NULL),
(3, 1, '2023-03-23', 1000.0000, 2, 2, NULL, NULL, 'Generating salaries with command.', '2023-03-23 08:54:02', '2023-03-23 08:54:02', NULL),
(4, 1, '2023-04-05', 1200.0000, 1, 1, NULL, NULL, 'Generating salaries with command.', '2023-04-05 07:31:55', '2023-04-05 07:31:55', NULL),
(5, 1, '2023-04-05', 1000.0000, 2, 2, NULL, NULL, 'Generating salaries with command.', '2023-04-05 07:31:55', '2023-04-05 07:31:55', NULL),
(6, 1, '2023-04-21', 1200.0000, 1, 1, NULL, NULL, 'Generating salaries with command.', '2023-04-21 03:29:43', '2023-04-21 03:29:43', NULL),
(7, 1, '2023-04-21', 1000.0000, 2, 2, NULL, NULL, 'Generating salaries with command.', '2023-04-21 03:29:43', '2023-04-21 03:29:43', NULL),
(8, 1, '2023-04-21', 500.0000, 4, 4, NULL, NULL, 'Generating salaries with command.', '2023-04-21 03:29:43', '2023-04-21 03:29:43', NULL),
(9, 1, '2023-04-21', 1000.0000, 5, 5, NULL, NULL, 'Generating salaries with command.', '2023-04-21 03:29:43', '2023-04-21 03:29:43', NULL),
(10, 1, '2023-05-11', 1200.0000, 1, 1, NULL, NULL, 'Generating salaries with command.', '2023-05-11 01:39:58', '2023-05-11 01:39:58', NULL),
(11, 1, '2023-05-11', 1000.0000, 2, 2, NULL, NULL, 'Generating salaries with command.', '2023-05-11 01:39:58', '2023-05-11 01:39:58', NULL),
(12, 1, '2023-05-11', 500.0000, 4, 4, NULL, NULL, 'Generating salaries with command.', '2023-05-11 01:39:58', '2023-05-11 01:39:58', NULL),
(13, 1, '2023-05-11', 1000.0000, 5, 5, NULL, NULL, 'Generating salaries with command.', '2023-05-11 01:39:58', '2023-05-11 01:39:58', NULL),
(14, 1, '2023-05-22', 1200.0000, 1, 1, NULL, NULL, 'Generating salaries with command.', '2023-05-22 09:44:29', '2023-05-22 09:44:29', NULL),
(15, 1, '2023-05-22', 1000.0000, 2, 2, NULL, NULL, 'Generating salaries with command.', '2023-05-22 09:44:29', '2023-05-22 09:44:29', NULL),
(16, 1, '2023-05-22', 500.0000, 4, 4, NULL, NULL, 'Generating salaries with command.', '2023-05-22 09:44:29', '2023-05-22 09:44:29', NULL),
(17, 1, '2023-05-22', 1000.0000, 5, 5, NULL, NULL, 'Generating salaries with command.', '2023-05-22 09:44:29', '2023-05-22 09:44:29', NULL),
(18, 1, '2023-06-08', 1200.0000, 1, 1, NULL, NULL, 'Generating salaries with command.', '2023-06-08 05:05:12', '2023-06-08 05:05:12', NULL),
(19, 1, '2023-06-08', 1000.0000, 2, 2, NULL, NULL, 'Generating salaries with command.', '2023-06-08 05:05:12', '2023-06-08 05:05:12', NULL),
(20, 1, '2023-06-08', 500.0000, 4, 4, NULL, NULL, 'Generating salaries with command.', '2023-06-08 05:05:12', '2023-06-08 05:05:12', NULL),
(21, 1, '2023-06-08', 1000.0000, 5, 5, NULL, NULL, 'Generating salaries with command.', '2023-06-08 05:05:12', '2023-06-08 05:05:12', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `price` decimal(25,4) NOT NULL,
  `description` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `photo` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `account_id`, `code`, `name`, `price`, `description`, `active`, `created_at`, `updated_at`, `deleted_at`, `photo`) VALUES
(1, 1, 'TRSH', 'CRV Krekls', 90.0000, 'Turcijā šūtie krekli', 1, NULL, '2023-06-08 16:30:46', NULL, '1681094564.png'),
(2, 1, 'THSH', 'ExTx Krekls', 90.0000, 'Taizemes šūtie krekli', 1, NULL, '2023-06-08 16:30:46', NULL, '1681094856.png'),
(3, 1, 'THJC', 'ExTx Žakete', 350.0000, 'Taizemē šūta žakete', 1, NULL, '2023-06-08 16:30:46', NULL, '1684799180.jpg'),
(4, 1, 'TRJC', 'MTM Žakete', 350.0000, 'Turcijā šūta žakete', 0, NULL, '2023-06-08 16:30:46', NULL, ''),
(5, 1, 'TR2S', 'MTM Divdaļīgs Uzvalks', 450.0000, 'Divdaļīgs Uzvalks šūts Turcijā', 1, NULL, '2023-06-08 16:30:46', NULL, '1684799207.jpg'),
(6, 1, 'TH2S', 'ExTx - Divdaļīgs Uzvalks', 380.0000, 'Divdaļīgs Uzvalks šūts Taizeme', 0, NULL, '2023-06-08 16:30:46', NULL, '1681094589.png'),
(7, 1, 'TR3S1', 'MTM Trīsdaļīgs uzvalks', 580.0000, 'Turcijā šūts trīdaļīgs uzvalks', 0, NULL, '2023-06-08 16:30:46', NULL, ''),
(8, 1, 'TH3S', 'ExTx Trīsdaļīgs Uzvalks', 450.0000, 'Trīsdaļīgs Uzvalks šūts Taizemē', 1, NULL, '2023-06-08 16:30:46', NULL, '1684799149.jpg'),
(9, 1, 'TRTR', 'MTM Bikses', 100.0000, 'Turcijā šūtas bikses', 1, NULL, '2023-06-08 16:30:46', NULL, '1684799193.jpg'),
(10, 1, 'THTR', 'ExTX Bikses', 100.0000, 'Taizemē šūtas bikses', 1, NULL, '2023-06-08 16:30:46', NULL, '1681094696.png'),
(11, 1, 'TRVS', 'MTM Veste', 100.0000, 'Turcijā šūta veste', 0, NULL, '2023-06-08 16:30:46', NULL, ''),
(12, 1, 'THVS', 'ExTx Veste', 100.0000, 'Taizemē šūta veste', 0, NULL, '2023-06-08 16:30:46', NULL, '1684799167.jpg'),
(13, 1, 'TRCO', 'MTM Mētelis', 450.0000, 'Turcijā šuts mētelis', 0, NULL, '2023-06-08 16:30:46', NULL, ''),
(14, 1, 'THCO', 'ExTx Mētelis', 450.0000, 'Taizemē šūts mētelis', 1, NULL, '2023-06-08 16:30:46', NULL, '1684799138.jpg'),
(15, 1, 'TRDOG', 'MTM suna tērps', 100.0000, 'Turcijā šuti suņu tērpi', 0, NULL, '2023-06-08 16:30:46', NULL, ''),
(16, 1, 'TRZR', 'MTM Regulāra Žakete', 350.0000, 'MTM Regulāra Žakete', 0, NULL, '2023-06-08 16:30:46', NULL, ''),
(17, 1, 'TRPZ', 'MTM Pieguļoša žakete', 350.0000, 'Slim Fit modelis', 0, NULL, '2023-06-08 16:30:46', NULL, ''),
(18, 1, 'TRD4', 'MTM Platā žakete', 350.0000, 'Drop 4', 0, NULL, '2023-06-08 16:30:46', NULL, ''),
(19, 1, 'TRD8', 'MTM Platā x2 žakete', 350.0000, 'Drop 8', 0, NULL, '2023-06-08 16:30:46', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `service_reviews`
--

CREATE TABLE `service_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `service_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `title` varchar(191) NOT NULL,
  `content` text NOT NULL,
  `rate` double NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `service_reviews`
--

INSERT INTO `service_reviews` (`id`, `service_id`, `customer_id`, `title`, `content`, `rate`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 'Awesome!', 'I have never seen like this service!\r\nReally impressive!', 0, '2023-06-08 03:17:57', '2023-06-08 03:16:33', '2023-06-08 03:17:57'),
(2, 3, 2, 'Awesome!', 'Really impressive!', 4, NULL, '2023-06-08 03:18:23', '2023-06-08 04:38:32'),
(3, 8, 1, 'Very fast, high quality', 'Thank you for your service!', 5, NULL, '2023-06-08 04:40:27', '2023-06-08 04:47:44');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2IwYeWCJ2OD1vMZoyuyQ8mg9EGUfP6EgU0Ne5xBW', NULL, '167.94.146.58', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGdXZkVuOTRSTlRSVDU4bGRvQ2Voa1RUOUdKaFkxSVZvUGJuMUFXcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680870443),
('2MWpKVAb6Sg9hPhDCNmuiEqlMchwo7J7yUe852vv', NULL, '152.89.196.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieWhZNGNCUGtGWjdtczU5MkN2a1Q2aXZjQWZNYzUyS0dJa2FNU1oyaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680847969),
('2NdcoGOZ1W19NGVKlS1e4VSKfkgCiRFh0aSo8S5t', NULL, '193.118.53.210', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYlJGc1BBOHVNRlA0dlFGOTFlbmp3cVpzODhDcmZQRVdMVVpoNFprTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680846698),
('2YzHsbBIfq6YyxQS5OwhZ4IkUx4uMZ5HyUPBQtx7', NULL, '198.235.24.181', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicjZ3M09KbVkyQXFKdG5mNGJnNDdtUGVYZmpyczJ3OEp4Tjl1ME8zUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTY6Imh0dHA6Ly9sb2NhbGhvc3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680846037),
('4hc5HVQpHFQdlfRTmozfO8xgbv8NsjJSi0fDl6mS', NULL, '170.64.130.193', 'Mozilla/5.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSkI5SGM2NEgxdm5hZWJ6UFdHdUNLU3FXQ0NBWjVxeWlVN1BFYW9reCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L3VwbC5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680846015),
('62tkuF4jVS0bLtqgBST6XZrnYdTl3fXu52YHdNFp', NULL, '170.64.130.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNlJpSWFvTUJMMmNXV1duVnRIb3hRM0pSMDBCTkZVWFVUNUZtaHRrdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680846011),
('7QjKfZiZiFPlMqg0nm7kwWylWQcvhhcc6a4V6SKQ', NULL, '185.180.143.137', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieUNMZEJaUVp1MDNjeWJyd2tJeUVHdXBlUmJWczhmT29pNnZhUkZONyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680848761),
('bPjj5KKd0ksUEW2JU9TD2YHotcx207tPDphfxRV1', 1, '188.43.136.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYXJ4dE5qNHJlTzJaeTR0ZW5heTVWdE9QRHV2SDlLRnV0cUtId3F3cSI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMjoiaHR0cDovLzE0Mi4xNDcuOTkuNDgvYWRtaW4vdXNlcnMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680862321),
('BwoM8WCXUzS59IAzEfD7jcuGk91GMAyqCewqOoSG', NULL, '170.64.130.193', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.5 Mobile/15E148 Snapchat/10.77.0.54 (like Safari/604.1)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWU1JbUNEOTNQZEdLYVFCa2lzN005emwxbjZtM20zQVAzdno5TXE2TyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680846017),
('DwRb7DvMR25ThjYkJW1ZH9FZHSJ58LElOdArgLbt', NULL, '193.32.162.159', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36 Edg/90.0.818.46', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiR0tLcHhURDhXRXNMMm5jaHZqNWx1VUhxNldobExHZlFZVGQ1U1FybiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680865873),
('GBSMAjUXDWkdYJQBn64ZWYiyAR7TpDE6vPwPF7il', NULL, '170.64.130.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiblNOaG5mb2VUZnBQS1lZUDQ1ZGVUTUxyRTVkTU1rNzdSVEw5cHQ4NCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680846009),
('gfY1ymGRMRbdusr9WLJXawtBFGhvbWOVQ54KidXJ', NULL, '193.118.53.210', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicVBiYUtXOU53T0UwTWJ2bGVCbHJQenh6Vm1EWHpERm9oUkZkREJFUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680846700),
('hBl5S2y6LxrSi9dkpzx9UwqDZfqzTuJ5Tod9PBRG', 1, '188.43.136.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibEVsRVhHZnVIbGI5V3FjY1pQSGFoNENkQVo4cW9YbWlHSk9IVHBIMyI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyNToiaHR0cDovLzE0Mi4xNDcuOTkuNDgvaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1680862321),
('Hn9AHLoJ1qTJTdMkVz3kb9eUWc1dd5W0LtkRJfyP', NULL, '152.89.196.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYnRMWjZoTk9Nd2tZWDZtR0ZDNmNOSVRlejZyeWs3VmhwemxkQXBnTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTE6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Lz9YREVCVUdfU0VTU0lPTl9TVEFSVD1waHBzdG9ybSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1680847955),
('hucXCHGMa6J4IXSQZTq2feULzuFK0Dy9sHvam8eh', NULL, '178.79.141.124', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20100101 Firefox/8.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieEM0SUZlSDRlR1ladVpLc1JGMlNGNWhDYTJ3bW5uQTZCRm5LUVZjOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680858083),
('ilXCKENl4oUYcPokCFumFShwb5KWwdcylvuy6KNx', NULL, '170.64.130.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSDFpY09JUkVCdDNBT1RZdFFqOFRsbkRvWnFDeGpuR092cjl6Q2YyNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2NsaWVudC9nZXRfdGFyZ2V0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1680846013),
('iNp7C4QN5IxW0FJjaGgi0Kk9R1Th2LgMumsqp70O', 1, '188.43.136.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidWxsVFpSWHJMVEF4cjJsVHM2bU5POG5qcllKVExzSDlLSkZFb3hLQyI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMToiaHR0cDovLzE0Mi4xNDcuOTkuNDgvYWRtaW4vbG9ncyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1680853243),
('JsJHiW5YtDnbhinWdto1Z8bSLsGLbze1K95uxeHV', NULL, '193.118.53.210', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ1JqU05pOVFhaGNzdHEwQmN6ZWIyVkFKZk54a1ZqZVdKUUYzaGVlVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680846704),
('KX0IdLaAvMtkrT8Lu7A8oCPw0R0I3wHXSCUdtT2q', NULL, '152.89.196.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibUhGV2lISnRZS2VOUTl6MUtnaERWMFRxTnBvczhocXBvWEdJZGljdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680852420),
('KyLl6lDEgzvk0B0nkhEShDElv1knw1o5AWJIaCMU', NULL, '167.94.146.58', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY1BabDRwTGVlTGZ5dWxsOGdVdnlIa2d3ZW9iSkNQM1BDVHA1c0hHOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680870440),
('Ma6x6z4ql9ewXOAT0EgwPPTvxY1q9UBptVhdbHoi', NULL, '193.32.162.159', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36 Edg/90.0.818.46', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiQUI0OWFiRngwRDFJQlJ2NjZHR3c5TjZvRW0yaUJVZWtGUVhENEJDQSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680854779),
('N3JtlUsDxIfX4zdVVLhHj7jXh7YPTU1g6S4ljuDm', NULL, '109.237.98.226', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSGduaGxiTEhkcVE1UHU0bU9YenljNTg2VFFtQ0cxWmVybkp1QWtWWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ly5lbnYiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680859015),
('PCCLuYjxywMlSQJ2GEOFaneKZ84Ll5wFjDHj4bXt', NULL, '167.94.146.58', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUVM4NmRaR2lIWkNVY3VKQ3Z0VXRNTWxxZkJIWTdJSzJrTXFLY3psSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680870441),
('qC2blQh7NVnP9wfkqHYhUHYqerZcWo4wpMuplWZQ', NULL, '193.118.53.210', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT2tub0RiRnZEdUI3R2RlQ1Y3ckZ4R3dzMndYTFdic2dVTWplTXhabyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L3Nob3dMb2dpbi5jYyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1680846703),
('TEgaBlJJP35OGQt5XVnF7I6OT2Yn7NeXt2EQwVYO', 1, '188.43.136.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidjBibzA2Q0tCdnBnRzUzNWtuVEJsZVlpSERxdEV5STFGc2ZMWmRxYSI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMToiaHR0cDovLzE0Mi4xNDcuOTkuNDgvYWRtaW4vbG9ncyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1680853012),
('tJgBpjU8whX0LDBnrk6A0sz8NvCSuPTGYECoCm3k', NULL, '85.217.145.45', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicjZ2b0FpSW11eENXdUd0bll0SWF5Q29TY0tPZG85NG9GZldQZ3VGZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680866004),
('TNIeUxaOrbpocn2Jsr6cLOdgHNyWOryvHDLQw8Sd', NULL, '208.38.246.36', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM2ZVZTJCVk5pUkJOdE05TnJ6U3Y2MnliZGhTaElEM21RRlB4MXVaSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680847320),
('tvDfszVEbAVIl8fnDThvdDhH6yh1Ghqaj3cW3xy1', 1, '188.43.136.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQUFKYmczM0JDb3JyMm1Jb0ZjemVFMTYyTzJYOEkyNTJOUWNHUktsaiI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyNToiaHR0cDovLzE0Mi4xNDcuOTkuNDgvaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1680853000),
('VjZ9P3EleZKGGbftbWh4xnQKVEnUOAWuORGeiej9', NULL, '178.18.242.213', 'Java/1.6.0_13', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUURuZWs2S3NReDV5NWZadnJ0MEY5VUdTRjFlMjYzVVFhNHFPSldLOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680867558),
('x8RAu3fNq6PaXEDuOhLXqvZhr8qzeBWzURYOw75T', NULL, '185.180.143.137', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQWdrc0RmNU9XSGVtUWc2VmtKTlduZkU4eFh5dGFSSjBzUUZkWmxIUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680848763),
('xBpEw8fb8yXsvd7WntVM1Zmvidd3PVBFa8I5MMz2', NULL, '2.188.83.230', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.7 (KHTML, like Gecko) Version/9.1.2 Safari/601.7.7', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVWtVVmY0bE9MY21VYnpIcDRwQ0toclI0dUpoeG5KZzAzblBOYXlYaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680866918),
('XZv9D0RHYc5Bp0tTdpTe7H2PhFojeuEW3bhg3g56', NULL, '85.217.145.45', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYUVMTUxnTnFIeHVSWTVqb1hjaG4yM3hoaTVvb2tTcU9LQkU1bHRrVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1680866006),
('y4EUowTSzVZHNyLPubIF0THHanIQZ2Y7t6l9kXDB', NULL, '192.241.236.45', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZXdkNWloR1VxMFFqNmw2T1ZaU2ZUYWl4Z04ySHpIZUJvazNzelZ3MSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680855386),
('ZBddvpJ5iBBkJPzXBao1DgAfs0rIvzr2yUmyLKuq', NULL, '152.89.196.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib2NRSms2cXpRd1M3bWZKSDRNcjEyTHlRMmg2VUtkMmp6ekQxR0VLTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDQ6Imh0dHA6Ly8xNDIuMTQ3Ljk5LjQ4L2FjdHVhdG9yL2dhdGV3YXkvcm91dGVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680852411),
('ZsaFSVddFBYpd3AD3ZPHC0lS7H9s1w8dc8LBh3ce', NULL, '193.32.162.159', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36 Edg/90.0.818.46', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUG1YNUZqbEZmTHAyMU5Ec1BDdnY5RXJsUGRaTWJpVXN6dE83NTBydCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1680857904);

-- --------------------------------------------------------

--
-- Table structure for table `shipping_addresses`
--

CREATE TABLE `shipping_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fname` varchar(191) NOT NULL,
  `lname` varchar(191) NOT NULL,
  `country` varchar(191) NOT NULL,
  `state` varchar(191) NOT NULL,
  `address` varchar(191) NOT NULL,
  `city` varchar(191) NOT NULL,
  `zipcode` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `other` varchar(191) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `shipping_addresses`
--

INSERT INTO `shipping_addresses` (`id`, `fname`, `lname`, `country`, `state`, `address`, `city`, `zipcode`, `phone`, `other`, `customer_id`, `deleted_at`, `created_at`, `updated_at`, `is_default`) VALUES
(1, 'Aleksandar', 'Todorovic', 'Latvia (Latvija)', '', 'Konatice Noname street 378', 'Konatice', '11506', '4402070484', NULL, 1, NULL, '2023-03-28 03:18:58', '2023-05-22 06:52:02', 1),
(2, 'Ivo', 'Svisco', 'Latvia', 'Riga', 'Rupniecibas street 19 office 2', 'Riga', 'LV-1010', '+37129266821', NULL, 3, NULL, '2023-04-10 10:44:22', '2023-07-26 08:26:54', 1),
(3, 'Rols', 'Rols', 'Latvia (Latvija)', 'Hamburh', '5. 40472', 'Duesseldorf', 'Franz-Rennefeld-Weg', '492838392929', NULL, 10, NULL, '2023-07-26 11:17:10', '2023-07-26 11:18:13', 1);

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `subscribers`
--

INSERT INTO `subscribers` (`id`, `email`, `created_at`, `updated_at`) VALUES
(2, 'aleksandart450@gmail.com', '2023-05-22 08:39:30', '2023-05-22 08:39:30'),
(3, 'violetfocus0618@gmail.com', '2023-05-22 08:43:01', '2023-05-22 08:43:01'),
(5, 'hello@gmail.com', '2023-05-23 14:14:53', '2023-05-23 14:14:53'),
(7, 'java.super.dev@gmail.com', '2023-05-23 20:38:45', '2023-05-23 20:38:45'),
(8, 'et.edgars@gmail.com', '2023-07-26 13:05:20', '2023-07-26 13:05:20');

-- --------------------------------------------------------

--
-- Table structure for table `tag_backgrounds`
--

CREATE TABLE `tag_backgrounds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `background` varchar(191) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tag_backgrounds`
--

INSERT INTO `tag_backgrounds` (`id`, `name`, `background`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Coat', '1680584797.png', NULL, '2023-04-04 03:06:38', '2023-04-04 03:06:38'),
(2, 'Vent', '1680584818.png', NULL, '2023-04-04 03:06:58', '2023-04-04 03:06:58'),
(3, 'Lining', '1680589646.png', NULL, '2023-04-04 03:07:39', '2023-04-04 04:27:26'),
(4, 'Pent', '1680589946.png', NULL, '2023-04-04 04:32:26', '2023-04-04 04:32:26'),
(5, 'Shirt', '1681210352.png', NULL, '2023-04-11 11:52:32', '2023-04-11 11:52:32');

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `code` varchar(20) NOT NULL,
  `rate` decimal(8,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `same` tinyint(1) DEFAULT NULL,
  `compound` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `account_id`, `name`, `code`, `rate`, `description`, `state`, `same`, `compound`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'PVN 21%', 'PVN', 21.00, 'Pievienotās vērtības nodoklis', 1, 1, 1, '2020-10-14 00:04:03', '2020-10-14 06:17:28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(191) DEFAULT NULL,
  `owner` tinyint(1) NOT NULL DEFAULT 0,
  `salary` decimal(25,4) DEFAULT NULL,
  `photo_path` varchar(191) DEFAULT NULL,
  `can_sms` tinyint(1) DEFAULT 0,
  `view_all` tinyint(1) DEFAULT 0,
  `edit_all` tinyint(1) DEFAULT 0,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `account_id`, `name`, `phone`, `email`, `username`, `password`, `owner`, `salary`, `photo_path`, `can_sms`, `view_all`, `edit_all`, `remember_token`, `created_at`, `updated_at`, `deleted_at`, `active`) VALUES
(1, 1, 'Ivo Svisco', '+37129266821', 'ivo@svisco.lv', 'isuits', '$2y$10$YIpzpE.pdrUuo.FVdMvaROLv3/o5sy3.B2DLeAkQqeBpb3Cq9cvda', 1, 1200.0000, 'avatars/HZWLJcFPEnV0vOLfkbLt9RuGWLnmZmr0CgY4ZZDe.jpg', 0, 0, 0, 'ZCClCQEHpBHg68Z6ohjy5CAFNrJwOkmuPFnXdf5yGQ6wZZp7nXVqNvGhL8Zx', '2023-03-15 14:33:09', '2023-04-10 02:48:13', NULL, 1),
(2, 1, 'Elvijs Mūrnieks', '+37125410532', 'melvijs@gmail.com', 'melvijs', '$2y$10$lojWL1Y5rJ0gLqcADvj/2ORGkmT0FCamDPQOYD1dDLDcdPKQ6T3pi', 0, 1000.0000, 'users/QQGRALfrJDOa85ks1WaIF4g5mwROrVbt5ss4j38I.jpg', 1, 1, 1, NULL, '2023-03-15 15:13:09', '2023-05-14 18:49:18', NULL, 1),
(4, 1, 'Andris Berziņš', '+37125252525', 'fx.argent@gmail.com', 'fx.argent', '$2y$10$Q.mUTOyfMcyXZ0DbAZQR1.n1VOp418YhvEjU58eKb.XzPYqSVv9B6', 0, 500.0000, NULL, 1, 0, 1, NULL, '2020-10-14 06:14:50', '2020-10-14 06:14:50', NULL, 1),
(5, 1, 'Jānis Markavs', '+37129494972', 'janis.markavs@gmail.com', 'janis.markava', '$2y$10$2LfzqZWKGuPfkAoekHuNhu2ZvjwlKL269PQzVtuM9c4tr/y/MXSWS', 0, 1000.0000, NULL, 1, 1, 1, NULL, '2021-04-30 05:46:58', '2021-04-30 05:46:58', NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `accounts_phone_index` (`phone`) USING BTREE;

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `activity_log_log_name_index` (`log_name`) USING BTREE,
  ADD KEY `subject` (`subject_id`,`subject_type`) USING BTREE,
  ADD KEY `causer` (`causer_id`,`causer_type`) USING BTREE,
  ADD KEY `activity_log_account_id_index` (`account_id`) USING BTREE;

--
-- Indexes for table `billing_addresses`
--
ALTER TABLE `billing_addresses`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `category_custom_field`
--
ALTER TABLE `category_custom_field`
  ADD PRIMARY KEY (`category_id`,`custom_field_id`) USING BTREE,
  ADD KEY `category_custom_field_category_id_index` (`category_id`) USING BTREE,
  ADD KEY `category_custom_field_custom_field_id_index` (`custom_field_id`) USING BTREE;

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `contacts_account_id_index` (`account_id`) USING BTREE,
  ADD KEY `contacts_phone_index` (`phone`) USING BTREE;

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `customers_account_id_index` (`account_id`) USING BTREE,
  ADD KEY `customers_name_index` (`name`) USING BTREE,
  ADD KEY `customers_phone_index` (`phone`) USING BTREE;

--
-- Indexes for table `customer_measures`
--
ALTER TABLE `customer_measures`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `expenses_account_id_index` (`account_id`) USING BTREE,
  ADD KEY `expenses_user_id_index` (`user_id`) USING BTREE;

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `frontend_settings`
--
ALTER TABLE `frontend_settings`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `jobs_queue_index` (`queue`) USING BTREE;

--
-- Indexes for table `journals`
--
ALTER TABLE `journals`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `journals_morphed_id_morphed_type_index` (`morphed_id`,`morphed_type`) USING BTREE;

--
-- Indexes for table `journal_transactions`
--
ALTER TABLE `journal_transactions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `journal_transactions_journal_id_index` (`journal_id`) USING BTREE,
  ADD KEY `journal_transactions_subject_id_subject_type_index` (`subject_id`,`subject_type`) USING BTREE,
  ADD KEY `journal_transactions_type_index` (`type`) USING BTREE;

--
-- Indexes for table `measurements`
--
ALTER TABLE `measurements`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `measurements_account_id_index` (`account_id`) USING BTREE,
  ADD KEY `measurements_service_id_index` (`service_id`) USING BTREE,
  ADD KEY `measurements_customer_id_index` (`customer_id`) USING BTREE,
  ADD KEY `measurements_user_id_index` (`user_id`) USING BTREE;

--
-- Indexes for table `measurement_fields`
--
ALTER TABLE `measurement_fields`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `measurement_fields_name_unique` (`name`) USING BTREE,
  ADD KEY `measurement_fields_account_id_index` (`account_id`) USING BTREE;

--
-- Indexes for table `measurement_field_service`
--
ALTER TABLE `measurement_field_service`
  ADD PRIMARY KEY (`service_id`,`measurement_field_id`) USING BTREE,
  ADD UNIQUE KEY `measurement_field_service_sid_mfid_unique` (`service_id`,`measurement_field_id`) USING BTREE,
  ADD KEY `measurement_field_service_service_id_index` (`service_id`) USING BTREE,
  ADD KEY `measurement_field_service_measurement_field_id_index` (`measurement_field_id`) USING BTREE;

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`) USING BTREE;

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `orders_account_id_index` (`account_id`) USING BTREE,
  ADD KEY `orders_hash_index` (`hash`) USING BTREE,
  ADD KEY `orders_user_id_index` (`user_id`) USING BTREE,
  ADD KEY `orders_customer_id_index` (`customer_id`) USING BTREE,
  ADD KEY `orders_assigned_to_index` (`assigned_to`) USING BTREE;

--
-- Indexes for table `order_payment`
--
ALTER TABLE `order_payment`
  ADD UNIQUE KEY `order_payment_order_id_payment_id_unique` (`order_id`,`payment_id`) USING BTREE,
  ADD KEY `order_payment_order_id_payment_id_index` (`order_id`,`payment_id`) USING BTREE,
  ADD KEY `order_payment_order_id_index` (`order_id`) USING BTREE,
  ADD KEY `order_payment_payment_id_index` (`payment_id`) USING BTREE;

--
-- Indexes for table `order_services`
--
ALTER TABLE `order_services`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `order_services_measurement_id_foreign` (`measurement_id`) USING BTREE,
  ADD KEY `order_services_order_id_index` (`order_id`) USING BTREE,
  ADD KEY `order_services_service_id_index` (`service_id`) USING BTREE;

--
-- Indexes for table `order_tax`
--
ALTER TABLE `order_tax`
  ADD KEY `order_tax_tax_id_order_id_index` (`tax_id`,`order_id`) USING BTREE,
  ADD KEY `order_tax_order_id_index` (`order_id`) USING BTREE;

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`) USING BTREE;

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `payments_account_id_index` (`account_id`) USING BTREE,
  ADD KEY `payments_hash_index` (`hash`) USING BTREE,
  ADD KEY `payments_user_id_index` (`user_id`) USING BTREE,
  ADD KEY `payments_customer_id_index` (`customer_id`) USING BTREE,
  ADD KEY `payments_order_id_index` (`order_id`) USING BTREE;

--
-- Indexes for table `payu_transactions`
--
ALTER TABLE `payu_transactions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `payu_transactions_transaction_id_unique` (`transaction_id`) USING BTREE,
  ADD KEY `payu_transactions_status_index` (`status`) USING BTREE,
  ADD KEY `payu_transactions_verified_at_index` (`verified_at`) USING BTREE;

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`) USING BTREE,
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`) USING BTREE;

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `products_name_unique` (`name`) USING BTREE;

--
-- Indexes for table `product_comments`
--
ALTER TABLE `product_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_orders`
--
ALTER TABLE `product_orders`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `product_orders_account_id_index` (`account_id`) USING BTREE;

--
-- Indexes for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `salaries`
--
ALTER TABLE `salaries`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `salaries_account_id_index` (`account_id`) USING BTREE,
  ADD KEY `salaries_staff_id_index` (`staff_id`) USING BTREE,
  ADD KEY `salaries_user_id_index` (`user_id`) USING BTREE;

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `services_name_unique` (`name`) USING BTREE,
  ADD KEY `services_account_id_index` (`account_id`) USING BTREE;

--
-- Indexes for table `service_reviews`
--
ALTER TABLE `service_reviews`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `sessions_user_id_index` (`user_id`) USING BTREE,
  ADD KEY `sessions_last_activity_index` (`last_activity`) USING BTREE;

--
-- Indexes for table `shipping_addresses`
--
ALTER TABLE `shipping_addresses`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `subscribers_email_unique` (`email`) USING BTREE;

--
-- Indexes for table `tag_backgrounds`
--
ALTER TABLE `tag_backgrounds`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `taxes_code_unique` (`code`) USING BTREE,
  ADD KEY `taxes_account_id_index` (`account_id`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `users_email_unique` (`email`) USING BTREE,
  ADD UNIQUE KEY `users_username_unique` (`username`) USING BTREE,
  ADD KEY `users_account_id_index` (`account_id`) USING BTREE,
  ADD KEY `users_phone_index` (`phone`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=692;

--
-- AUTO_INCREMENT for table `billing_addresses`
--
ALTER TABLE `billing_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `customer_measures`
--
ALTER TABLE `customer_measures`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `frontend_settings`
--
ALTER TABLE `frontend_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `journals`
--
ALTER TABLE `journals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `journal_transactions`
--
ALTER TABLE `journal_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `measurements`
--
ALTER TABLE `measurements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `measurement_fields`
--
ALTER TABLE `measurement_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_services`
--
ALTER TABLE `order_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `payu_transactions`
--
ALTER TABLE `payu_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `product_comments`
--
ALTER TABLE `product_comments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_orders`
--
ALTER TABLE `product_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `salaries`
--
ALTER TABLE `salaries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `service_reviews`
--
ALTER TABLE `service_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shipping_addresses`
--
ALTER TABLE `shipping_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tag_backgrounds`
--
ALTER TABLE `tag_backgrounds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `expenses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `measurements`
--
ALTER TABLE `measurements`
  ADD CONSTRAINT `measurements_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `measurements_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `measurements_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
