-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 23, 2022 at 04:25 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_invoice`
--

DROP TABLE IF EXISTS `tbl_invoice`;
CREATE TABLE IF NOT EXISTS `tbl_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `client_name` varchar(120) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `start_point` varchar(150) NOT NULL,
  `end_point` varchar(150) NOT NULL,
  `qdate` date DEFAULT NULL,
  `branch` int(11) NOT NULL,
  `address` varchar(250) NOT NULL,
  `gst_type` int(11) NOT NULL,
  `gst_val` double NOT NULL,
  `gst_amt` double NOT NULL,
  `subtotal` double NOT NULL,
  `total` double NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_invoice`
--

INSERT INTO `tbl_invoice` (`id`, `code`, `client_name`, `contact_no`, `email`, `start_point`, `end_point`, `qdate`, `branch`, `address`, `gst_type`, `gst_val`, `gst_amt`, `subtotal`, `total`, `created`) VALUES
(11, '', 'Mohan', '9198494978', 'mohan@gmail.com', 'Lucknow', 'Kanpur', '2022-01-31', 2, 'Aliganj Sector - L Lucknow  Uttar Pradesh', 1, 12, 480, 4000, 4480, '2022-01-31 09:04:42');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
