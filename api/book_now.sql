-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 29, 2021 at 09:02 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

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
(38, 1, 'updated', 'rooms', '2021-07-29 18:40:06');

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
(10, 10, 'inserted', 'rel_people', '2021-07-29 15:35:34');

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
(2, 'House 2', 1);

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
(10, 'People 10', 128770446, 'Alex');

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
(1, 'Project', 150, 1, '2021-07-30 22:46:00');

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
(1, 1, 1, 50, 0, 1, 0, 1, 1),
(2, 2, 1, 120, 20, 1, 1, 1, 9),
(3, 3, 1, 140, 0, 1, 0, 1, 1),
(4, 4, 1, 75, 0, 1, 1, 1, 5),
(5, 5, 1, 50, 50, 1, 0, 1, 9),
(6, 6, 1, 150, 0, 2, 0, 1, 9),
(7, 7, 1, 150, 0, 3, 0, 1, 11),
(8, 8, 1, 100, 50, 1, 0, 1, 10),
(9, 9, 1, 50, 0, 2, 1, 1, 10),
(10, 10, 1, 75, 25, 2, 0, 1, 3);

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
(15, 4, 2, 1, 3, 0);

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
  ADD UNIQUE KEY `tel` (`tel`),
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `book_now_rel_log`
--
ALTER TABLE `book_now_rel_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `people`
--
ALTER TABLE `people`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rel_people`
--
ALTER TABLE `rel_people`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `travel`
--
ALTER TABLE `travel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
