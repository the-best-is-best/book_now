-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 16, 2021 at 08:44 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 7.4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `book_now`
--

-- --------------------------------------------------------

--
-- Table structure for table `book_now_log`
--

CREATE TABLE `book_now_log` (
  `id` int(11) NOT NULL,
  `record_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book_now_log`
--

INSERT INTO `book_now_log` (`id`, `record_id`, `action`, `table_name`, `date`) VALUES
(1, 1, 'inserted', 'houses', '2021-07-28 22:40:42'),
(2, 1, 'inserted', 'rooms', '2021-07-28 22:40:58'),
(3, 2, 'inserted', 'rooms', '2021-07-28 22:40:58'),
(4, 5, 'inserted', 'rooms', '2021-07-28 22:40:58'),
(5, 3, 'inserted', 'rooms', '2021-07-28 22:40:58'),
(6, 4, 'inserted', 'rooms', '2021-07-28 22:40:58'),
(7, 2, 'inserted', 'houses', '2021-07-28 22:41:21'),
(8, 6, 'inserted', 'rooms', '2021-07-28 22:41:37'),
(9, 8, 'inserted', 'rooms', '2021-07-28 22:41:37'),
(10, 7, 'inserted', 'rooms', '2021-07-28 22:41:37'),
(11, 1, 'inserted', 'project', '2021-07-28 22:42:04'),
(12, 9, 'inserted', 'rooms', '2021-07-28 22:52:47'),
(13, 10, 'inserted', 'rooms', '2021-07-28 22:52:47'),
(14, 11, 'inserted', 'rooms', '2021-07-28 22:52:47'),
(15, 1, 'inserted', 'travel', '2021-07-29 13:09:12'),
(16, 1, 'inserted', 'people', '2021-07-29 13:53:23'),
(17, 2, 'inserted', 'people', '2021-07-29 13:53:38'),
(18, 3, 'inserted', 'people', '2021-07-29 13:53:53'),
(19, 4, 'inserted', 'people', '2021-07-29 13:54:08'),
(20, 5, 'inserted', 'people', '2021-07-29 13:54:43'),
(21, 6, 'inserted', 'people', '2021-07-29 13:56:46'),
(22, 7, 'inserted', 'people', '2021-07-29 13:57:09'),
(23, 8, 'inserted', 'people', '2021-07-29 13:57:33'),
(24, 9, 'inserted', 'people', '2021-07-29 13:57:59'),
(25, 10, 'inserted', 'people', '2021-07-29 13:58:54'),
(26, 12, 'inserted', 'rooms', '2021-07-29 13:59:37'),
(27, 14, 'inserted', 'rooms', '2021-07-29 13:59:37'),
(28, 13, 'inserted', 'rooms', '2021-07-29 13:59:37'),
(29, 2, 'inserted', 'travel', '2021-07-29 15:33:18'),
(30, 3, 'inserted', 'travel', '2021-07-29 15:33:25'),
(31, 15, 'inserted', 'rooms', '2021-07-29 16:12:55'),
(32, 15, 'updated', 'rooms', '2021-07-29 16:13:04'),
(33, 15, 'updated', 'rooms', '2021-07-29 16:13:10'),
(34, 15, 'updated', 'rooms', '2021-07-29 16:13:16'),
(35, 1, 'updated', 'rooms', '2021-07-29 18:31:07'),
(36, 1, 'updated', 'rooms', '2021-07-29 18:32:58'),
(37, 1, 'updated', 'rooms', '2021-07-29 18:33:37'),
(38, 1, 'updated', 'rooms', '2021-07-29 18:40:06'),
(39, 11, 'inserted', 'people', '2021-07-30 13:11:06'),
(40, 17, 'inserted', 'people', '2021-07-30 13:14:05'),
(41, 2, 'inserted', 'project', '2021-07-30 14:51:00'),
(42, 18, 'inserted', 'people', '2021-07-30 19:20:09'),
(43, 17, 'deleted', 'people', '2021-07-30 19:33:23'),
(44, 18, 'deleted', 'people', '2021-07-30 19:33:23'),
(45, 12, 'inserted', 'people', '2021-07-30 19:34:50'),
(46, 3, 'inserted', 'houses', '2021-07-31 11:57:01'),
(47, 4, 'inserted', 'houses', '2021-07-31 11:57:11'),
(48, 5, 'inserted', 'houses', '2021-07-31 11:57:23'),
(49, 6, 'inserted', 'houses', '2021-07-31 11:57:41'),
(50, 3, 'updated', 'houses', '2021-08-15 15:20:43'),
(51, 16, 'inserted', 'rooms', '2021-08-15 15:21:02'),
(52, 17, 'inserted', 'rooms', '2021-08-15 15:21:02'),
(53, 18, 'inserted', 'rooms', '2021-08-15 15:21:02'),
(54, 19, 'inserted', 'rooms', '2021-08-15 15:21:02'),
(55, 20, 'inserted', 'rooms', '2021-08-15 15:21:02'),
(56, 21, 'inserted', 'rooms', '2021-08-15 15:21:02'),
(57, 4, 'updated', 'houses', '2021-08-15 16:24:42'),
(58, 22, 'inserted', 'rooms', '2021-08-15 16:24:52'),
(59, 23, 'inserted', 'rooms', '2021-08-15 16:24:52'),
(60, 24, 'inserted', 'rooms', '2021-08-15 16:24:53'),
(61, 25, 'inserted', 'rooms', '2021-08-15 16:27:50'),
(62, 26, 'inserted', 'rooms', '2021-08-15 16:27:50'),
(63, 27, 'inserted', 'rooms', '2021-08-15 16:27:51'),
(64, 4, 'updated', 'houses', '2021-08-15 16:38:21'),
(65, 4, 'updated', 'houses', '2021-08-15 16:38:41'),
(66, 28, 'inserted', 'rooms', '2021-08-15 16:39:38'),
(67, 30, 'inserted', 'rooms', '2021-08-15 16:39:38'),
(68, 29, 'inserted', 'rooms', '2021-08-15 16:39:38'),
(69, 31, 'inserted', 'rooms', '2021-08-16 12:34:19'),
(70, 32, 'inserted', 'rooms', '2021-08-16 12:34:19'),
(71, 33, 'inserted', 'rooms', '2021-08-16 12:34:46'),
(72, 34, 'inserted', 'rooms', '2021-08-16 12:34:46'),
(73, 35, 'inserted', 'rooms', '2021-08-16 12:53:10'),
(74, 36, 'inserted', 'rooms', '2021-08-16 12:53:10'),
(75, 37, 'inserted', 'rooms', '2021-08-16 12:55:08'),
(76, 38, 'inserted', 'rooms', '2021-08-16 12:55:08'),
(77, 5, 'updated', 'houses', '2021-08-16 13:00:56'),
(78, 5, 'updated', 'houses', '2021-08-16 13:01:30'),
(79, 39, 'inserted', 'rooms', '2021-08-16 13:01:53'),
(80, 40, 'inserted', 'rooms', '2021-08-16 13:01:53'),
(81, 41, 'inserted', 'rooms', '2021-08-16 13:02:04'),
(82, 42, 'inserted', 'rooms', '2021-08-16 13:02:04'),
(83, 43, 'inserted', 'rooms', '2021-08-16 13:02:05'),
(84, 44, 'inserted', 'rooms', '2021-08-16 13:02:05');

-- --------------------------------------------------------

--
-- Table structure for table `book_now_rel_log`
--

CREATE TABLE `book_now_rel_log` (
  `id` int(11) NOT NULL,
  `record_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book_now_rel_log`
--

INSERT INTO `book_now_rel_log` (`id`, `record_id`, `action`, `table_name`, `date`) VALUES
(1, 1, 'inserted', 'rel_people', '2021-07-29 15:29:58'),
(2, 2, 'inserted', 'rel_people', '2021-07-29 15:30:20'),
(3, 3, 'inserted', 'rel_people', '2021-07-29 15:30:37'),
(4, 4, 'inserted', 'rel_people', '2021-07-29 15:32:37'),
(5, 5, 'inserted', 'rel_people', '2021-07-29 15:33:01'),
(6, 6, 'inserted', 'rel_people', '2021-07-29 15:33:46'),
(7, 7, 'inserted', 'rel_people', '2021-07-29 15:34:08'),
(8, 8, 'inserted', 'rel_people', '2021-07-29 15:34:51'),
(9, 9, 'inserted', 'rel_people', '2021-07-29 15:35:12'),
(10, 10, 'inserted', 'rel_people', '2021-07-29 15:35:34'),
(11, 11, 'inserted', 'rel_people', '2021-07-30 13:24:53'),
(12, 12, 'inserted', 'rel_people', '2021-07-30 19:35:21'),
(13, 1, 'updated', 'rel_people', '2021-08-09 18:42:02'),
(14, 1, 'updated', 'rel_people', '2021-08-09 18:55:17'),
(15, 1, 'updated', 'rel_people', '2021-08-09 18:56:40'),
(16, 1, 'updated', 'rel_people', '2021-08-09 20:14:44'),
(17, 1, 'updated', 'rel_people', '2021-08-09 20:18:56'),
(18, 1, 'updated', 'rel_people', '2021-08-09 20:19:09'),
(19, 1, 'updated', 'rel_people', '2021-08-09 20:21:25'),
(20, 1, 'updated', 'rel_people', '2021-08-09 20:22:25'),
(21, 1, 'updated', 'rel_people', '2021-08-09 20:24:05'),
(22, 1, 'updated', 'rel_people', '2021-08-09 20:24:12'),
(23, 1, 'updated', 'rel_people', '2021-08-09 20:24:16'),
(24, 1, 'updated', 'rel_people', '2021-08-09 20:25:33'),
(25, 1, 'updated', 'rel_people', '2021-08-09 20:26:32'),
(26, 1, 'updated', 'rel_people', '2021-08-09 20:28:44'),
(27, 1, 'updated', 'rel_people', '2021-08-09 20:31:44'),
(28, 1, 'updated', 'rel_people', '2021-08-09 20:31:53'),
(29, 1, 'updated', 'rel_people', '2021-08-09 20:32:05'),
(30, 1, 'updated', 'rel_people', '2021-08-09 20:33:56'),
(31, 1, 'updated', 'rel_people', '2021-08-09 20:34:20'),
(32, 1, 'updated', 'rel_people', '2021-08-09 20:34:28'),
(33, 1, 'updated', 'rel_people', '2021-08-11 18:04:26'),
(34, 1, 'updated', 'rel_people', '2021-08-11 18:04:41'),
(35, 1, 'updated', 'rel_people', '2021-08-11 18:04:46'),
(36, 10, 'updated', 'rel_people', '2021-08-11 18:28:34'),
(37, 3, 'updated', 'rel_people', '2021-08-11 18:33:12'),
(38, 1, 'updated', 'rel_people', '2021-08-12 19:22:38'),
(39, 3, 'updated', 'rel_people', '2021-08-12 19:22:38'),
(40, 1, 'updated', 'rel_people', '2021-08-12 19:23:12'),
(41, 3, 'updated', 'rel_people', '2021-08-12 19:23:12'),
(42, 1, 'updated', 'rel_people', '2021-08-12 19:25:07'),
(43, 3, 'updated', 'rel_people', '2021-08-12 19:25:07'),
(44, 1, 'updated', 'rel_people', '2021-08-12 19:25:21'),
(45, 3, 'updated', 'rel_people', '2021-08-12 19:25:21'),
(46, 1, 'updated', 'rel_people', '2021-08-12 19:25:37'),
(47, 3, 'updated', 'rel_people', '2021-08-12 19:25:37'),
(48, 1, 'updated', 'rel_people', '2021-08-12 19:26:59'),
(49, 3, 'updated', 'rel_people', '2021-08-12 19:26:59'),
(50, 3, 'updated', 'rel_people', '2021-08-12 19:30:05'),
(51, 1, 'updated', 'rel_people', '2021-08-12 19:30:05'),
(52, 1, 'updated', 'rel_people', '2021-08-12 19:30:28'),
(53, 1, 'updated', 'rel_people', '2021-08-12 19:32:05'),
(54, 1, 'updated', 'rel_people', '2021-08-12 19:32:40'),
(55, 1, 'updated', 'rel_people', '2021-08-12 19:32:58'),
(56, 1, 'updated', 'rel_people', '2021-08-12 19:40:46'),
(57, 1, 'updated', 'rel_people', '2021-08-12 19:42:01'),
(58, 2, 'updated', 'rel_people', '2021-08-12 19:42:01'),
(59, 1, 'updated', 'rel_people', '2021-08-12 19:42:11'),
(60, 1, 'updated', 'rel_people', '2021-08-12 19:42:19'),
(61, 2, 'updated', 'rel_people', '2021-08-12 19:42:19'),
(62, 1, 'updated', 'rel_people', '2021-08-15 13:24:47'),
(63, 1, 'updated', 'rel_people', '2021-08-15 13:24:58'),
(64, 1, 'updated', 'rel_people', '2021-08-15 13:32:24'),
(65, 1, 'updated', 'rel_people', '2021-08-15 13:33:39'),
(66, 1, 'updated', 'rel_people', '2021-08-15 13:34:33'),
(67, 1, 'updated', 'rel_people', '2021-08-15 13:37:29'),
(68, 1, 'updated', 'rel_people', '2021-08-15 13:37:33'),
(69, 1, 'updated', 'rel_people', '2021-08-15 13:38:16'),
(70, 1, 'updated', 'rel_people', '2021-08-15 13:51:58'),
(71, 1, 'updated', 'rel_people', '2021-08-15 13:52:18'),
(72, 2, 'updated', 'rel_people', '2021-08-16 14:10:45'),
(73, 2, 'updated', 'rel_people', '2021-08-16 14:12:01'),
(74, 2, 'updated', 'rel_people', '2021-08-16 14:12:46'),
(75, 2, 'updated', 'rel_people', '2021-08-16 14:12:57'),
(76, 2, 'updated', 'rel_people', '2021-08-16 14:13:07'),
(77, 2, 'updated', 'rel_people', '2021-08-16 14:15:21'),
(78, 2, 'updated', 'rel_people', '2021-08-16 14:15:28'),
(79, 2, 'updated', 'rel_people', '2021-08-16 14:15:32'),
(80, 2, 'updated', 'rel_people', '2021-08-16 14:15:56'),
(81, 3, 'updated', 'rel_people', '2021-08-16 14:16:23'),
(82, 3, 'updated', 'rel_people', '2021-08-16 14:16:31'),
(83, 2, 'updated', 'rel_people', '2021-08-16 14:17:02'),
(84, 3, 'updated', 'rel_people', '2021-08-16 14:17:10'),
(85, 3, 'updated', 'rel_people', '2021-08-16 14:17:14'),
(86, 3, 'updated', 'rel_people', '2021-08-16 14:17:24'),
(87, 2, 'updated', 'rel_people', '2021-08-16 14:22:08'),
(88, 2, 'updated', 'rel_people', '2021-08-16 14:22:47'),
(89, 2, 'updated', 'rel_people', '2021-08-16 14:23:30'),
(90, 2, 'updated', 'rel_people', '2021-08-16 14:24:11'),
(91, 2, 'updated', 'rel_people', '2021-08-16 14:24:17'),
(92, 2, 'updated', 'rel_people', '2021-08-16 14:25:56'),
(93, 2, 'updated', 'rel_people', '2021-08-16 14:26:01'),
(94, 2, 'updated', 'rel_people', '2021-08-16 14:26:21'),
(95, 2, 'updated', 'rel_people', '2021-08-16 14:27:58'),
(96, 2, 'updated', 'rel_people', '2021-08-16 14:28:02'),
(97, 2, 'updated', 'rel_people', '2021-08-16 14:28:56'),
(98, 2, 'updated', 'rel_people', '2021-08-16 14:29:07'),
(99, 2, 'updated', 'rel_people', '2021-08-16 14:29:21'),
(100, 1, 'updated', 'rel_people', '2021-08-16 14:33:29'),
(101, 4, 'updated', 'rel_people', '2021-08-16 14:33:47'),
(102, 1, 'updated', 'rel_people', '2021-08-16 14:39:31'),
(103, 2, 'updated', 'rel_people', '2021-08-16 14:40:51'),
(104, 2, 'updated', 'rel_people', '2021-08-16 14:41:04'),
(105, 5, 'updated', 'rel_people', '2021-08-16 14:41:19'),
(106, 6, 'updated', 'rel_people', '2021-08-16 14:42:03'),
(107, 11, 'updated', 'rel_people', '2021-08-16 17:59:48'),
(108, 10, 'updated', 'rel_people', '2021-08-16 18:02:00');

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `floor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`id`, `name`, `floor`) VALUES
(1, 'House 1', 2),
(2, 'House 2', 1),
(3, 'House 3', 1),
(4, 'House 4', 3),
(5, 'House 5', 2),
(6, 'House 6', 0);

--
-- Triggers `houses`
--
DELIMITER $$
CREATE TRIGGER `deleted_houses` BEFORE DELETE ON `houses` FOR EACH ROW INSERT INTO book_now_log VALUES(null, OLD.id , "deleted" , "houses",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_houses` AFTER INSERT ON `houses` FOR EACH ROW INSERT INTO book_now_log VALUES(null, NEW.id , "inserted" , "houses",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_houses` AFTER UPDATE ON `houses` FOR EACH ROW INSERT INTO book_now_log VALUES(null , NEW.id , "updated" ,"houses" , NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE `people` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `tel` bigint(20) NOT NULL,
  `city` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `people`
--

INSERT INTO `people` (`id`, `name`, `tel`, `city`) VALUES
(1, 'People 1', 12, 'Cairo'),
(2, 'People 2', 12877, 'Alex'),
(3, 'People 3', 128770, 'Cairo'),
(4, 'People 4', 1287, 'Minia'),
(5, 'People 5', 128, 'Cairo'),
(6, 'People 6', 1287704424, 'Alex'),
(7, 'People 7', 12874, 'Minia'),
(8, 'People 8', 128742, 'Minia'),
(9, 'People 9', 128770445, 'Alex'),
(10, 'People 10', 128770446, 'Alex'),
(11, 'People 11', 0, 'Alex'),
(12, 'People 12', 0, 'Alex');

--
-- Triggers `people`
--
DELIMITER $$
CREATE TRIGGER `deleted_people` BEFORE DELETE ON `people` FOR EACH ROW INSERT INTO book_now_log VALUES(null, OLD.id , "deleted" , "people" ,NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_people` AFTER INSERT ON `people` FOR EACH ROW INSERT INTO book_now_log VALUES(null, NEW.id , "inserted" , "people",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_people` AFTER UPDATE ON `people` FOR EACH ROW INSERT INTO book_now_log VALUES(null, NEW.id , "updated" , "people" , NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `id` int(11) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `end_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `project_name`, `price`, `house_id`, `end_date`) VALUES
(1, 'Project', 150, 1, '2021-07-30 22:46:00'),
(2, 'Project 2', 450, 2, '2021-08-10 14:53:00');

--
-- Triggers `project`
--
DELIMITER $$
CREATE TRIGGER `deleted_project` BEFORE DELETE ON `project` FOR EACH ROW INSERT INTO book_now_log VALUES(null, OLD.id , "deleted" , "ptoject",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_project` AFTER INSERT ON `project` FOR EACH ROW INSERT INTO book_now_log VALUES(null,NEW.id , "inserted", "project",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_project` AFTER UPDATE ON `project` FOR EACH ROW INSERT INTO book_now_log VALUES(null,NEW.id,"updated" ,"project",NOW() )
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rel_people`
--

CREATE TABLE `rel_people` (
  `id` int(11) NOT NULL,
  `people_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `paid` int(11) NOT NULL,
  `support` int(11) NOT NULL,
  `travel_id` int(11) NOT NULL,
  `coupons` tinyint(1) NOT NULL,
  `house_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rel_people`
--

INSERT INTO `rel_people` (`id`, `people_id`, `project_id`, `paid`, `support`, `travel_id`, `coupons`, `house_id`, `room_id`) VALUES
(1, 1, 1, 150, 0, 1, 1, 1, 12),
(2, 2, 1, 150, 0, 3, 1, 1, 14),
(3, 3, 1, 150, 0, 1, 1, 1, 12),
(4, 4, 1, 100, 0, 1, 1, 1, 5),
(5, 5, 1, 50, 50, 1, 1, 1, 9),
(6, 6, 1, 150, 0, 2, 1, 1, 9),
(7, 7, 1, 150, 0, 3, 0, 1, 11),
(8, 8, 1, 100, 50, 1, 0, 1, 10),
(9, 9, 1, 50, 0, 2, 1, 1, 10),
(10, 10, 1, 125, 25, 2, 1, 1, 13),
(11, 11, 1, 150, 0, 3, 1, 1, 11),
(12, 12, 1, 125, 0, 2, 1, 1, 2);

--
-- Triggers `rel_people`
--
DELIMITER $$
CREATE TRIGGER `deleted_rel_person` BEFORE DELETE ON `rel_people` FOR EACH ROW INSERT INTO book_now_rel_log VALUES(null, OLD.id , "deleted" , "rel_people",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_rel_person` AFTER INSERT ON `rel_people` FOR EACH ROW INSERT INTO book_now_rel_log VALUES(null, NEW.id , "inserted" , "rel_people",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_rel_person` AFTER UPDATE ON `rel_people` FOR EACH ROW INSERT INTO book_now_rel_log VALUES(null , NEW.id , "updated" ,"rel_people" , NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `name` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `floor` int(11) NOT NULL,
  `numbers_of_bed` int(11) NOT NULL,
  `bunk_bed` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`, `house_id`, `floor`, `numbers_of_bed`, `bunk_bed`) VALUES
(1, 1, 1, 1, 3, 1),
(2, 3, 1, 1, 3, 0),
(3, 4, 1, 1, 3, 0),
(4, 5, 1, 1, 3, 0),
(5, 2, 1, 1, 3, 0),
(6, 1, 2, 1, 3, 0),
(7, 2, 2, 1, 3, 0),
(8, 3, 2, 1, 3, 0),
(9, 1, 1, 2, 3, 0),
(10, 3, 1, 2, 3, 0),
(11, 2, 1, 2, 3, 0),
(12, 5, 1, 2, 5, 0),
(13, 4, 1, 2, 5, 0),
(14, 6, 1, 2, 5, 0),
(15, 4, 2, 1, 3, 0),
(16, 1, 3, 1, 3, 0),
(17, 5, 3, 1, 3, 0),
(18, 4, 3, 1, 3, 0),
(19, 6, 3, 1, 3, 0),
(20, 2, 3, 1, 3, 0),
(21, 3, 3, 1, 3, 0),
(22, 1, 4, 1, 4, 0),
(23, 2, 4, 1, 4, 0),
(24, 3, 4, 1, 4, 0),
(25, 4, 4, 1, 3, 0),
(26, 6, 4, 1, 3, 0),
(27, 5, 4, 1, 3, 0),
(28, 2, 4, 2, 2, 0),
(29, 3, 4, 2, 2, 0),
(30, 1, 4, 2, 2, 0),
(31, 1, 4, 3, 2, 0),
(32, 2, 4, 3, 2, 0),
(33, 4, 4, 2, 2, 0),
(34, 5, 4, 2, 2, 0),
(35, 4, 4, 3, 3, 0),
(36, 3, 4, 3, 3, 0),
(37, 5, 4, 3, 3, 0),
(38, 6, 4, 3, 3, 0),
(39, 2, 5, 1, 2, 0),
(40, 1, 5, 1, 2, 0),
(41, 3, 5, 1, 3, 0),
(42, 4, 5, 1, 3, 0),
(43, 6, 5, 1, 3, 0),
(44, 5, 5, 1, 3, 0);

--
-- Triggers `rooms`
--
DELIMITER $$
CREATE TRIGGER `deleted_rooms` BEFORE DELETE ON `rooms` FOR EACH ROW INSERT INTO book_now_log VALUES(null, OLD.id , "deleted" , "rooms",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_rooms` AFTER INSERT ON `rooms` FOR EACH ROW INSERT INTO book_now_log VALUES(null, NEW.id , "inserted" , "rooms",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_rooms` AFTER UPDATE ON `rooms` FOR EACH ROW INSERT INTO book_now_log VALUES(null, NEW.id , "updated" , "rooms" , NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `travel`
--

CREATE TABLE `travel` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `travel`
--

INSERT INTO `travel` (`id`, `name`) VALUES
(1, 'Private'),
(2, 'Cairo'),
(3, 'Minia');

--
-- Triggers `travel`
--
DELIMITER $$
CREATE TRIGGER `deleted_travel` BEFORE DELETE ON `travel` FOR EACH ROW INSERT INTO book_now_log VALUES(null, OLD.id , "deleted" , "travel",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_travel` AFTER INSERT ON `travel` FOR EACH ROW INSERT INTO book_now_log VALUES(null, NEW.id , "inserted" , "travel",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_travel` AFTER UPDATE ON `travel` FOR EACH ROW INSERT INTO book_now_log VALUES(null, NEW.id , "updated" , "travel" , NOW())
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book_now_log`
--
ALTER TABLE `book_now_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_now_rel_log`
--
ALTER TABLE `book_now_rel_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rel_people`
--
ALTER TABLE `rel_people`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `travel`
--
ALTER TABLE `travel`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book_now_log`
--
ALTER TABLE `book_now_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `book_now_rel_log`
--
ALTER TABLE `book_now_rel_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `people`
--
ALTER TABLE `people`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rel_people`
--
ALTER TABLE `rel_people`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `travel`
--
ALTER TABLE `travel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
