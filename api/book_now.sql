-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 12, 2021 at 01:15 AM
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
-- Table structure for table `project_name`
--

CREATE TABLE `project_name` (
  `id` int(11) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `end_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `project_name`
--
DELIMITER $$
CREATE TRIGGER `deleted_project_name` BEFORE DELETE ON `project_name` FOR EACH ROW INSERT INTO book_now_log VALUES(null, OLD.id , "inserted" , "houses",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_project_name` AFTER INSERT ON `project_name` FOR EACH ROW INSERT INTO book_now_log VALUES(null,NEW.id , "inserted", "project_name",NOW() )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_project_name` AFTER UPDATE ON `project_name` FOR EACH ROW INSERT INTO book_now_log VALUES(null,NEW.id,"updated" ,"project_name",NOW() )
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rel_house`
--

CREATE TABLE `rel_house` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `houses_id` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `name` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `floor` int(11) NOT NULL,
  `numbers_of_bed` int(11) NOT NULL
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
CREATE TRIGGER `update_rooms` AFTER UPDATE ON `rooms` FOR EACH ROW INSERT INTO book_now_log VALUES(null, NEW.id , "updated" , "rooms")
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
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_name`
--
ALTER TABLE `project_name`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rel_house`
--
ALTER TABLE `rel_house`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
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
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_name`
--
ALTER TABLE `project_name`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rel_house`
--
ALTER TABLE `rel_house`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
