-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 16, 2021 at 08:45 PM
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `book_now_rel_log`
--
ALTER TABLE `book_now_rel_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `people`
--
ALTER TABLE `people`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rel_people`
--
ALTER TABLE `rel_people`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `travel`
--
ALTER TABLE `travel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
