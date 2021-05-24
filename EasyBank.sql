-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 23, 2021 at 08:38 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `EasyBank`
--
CREATE DATABASE IF NOT EXISTS `EasyBank` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `EasyBank`;

-- --------------------------------------------------------

--
-- Table structure for table `Account`
--

CREATE TABLE `Account` (
  `Account_ID` int(11) NOT NULL,
  `Fee` float NOT NULL,
  `Balance` int(11) NOT NULL DEFAULT 0,
  `Type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Account`
--

INSERT INTO `Account` (`Account_ID`, `Fee`, `Balance`, `Type`) VALUES
(3, 7.5, 13249, 'Pro');

-- --------------------------------------------------------

--
-- Table structure for table `Branch`
--

CREATE TABLE `Branch` (
  `Branch_ID` int(11) NOT NULL,
  `City` varchar(40) NOT NULL,
  `Address` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Branch`
--

INSERT INTO `Branch` (`Branch_ID`, `City`, `Address`) VALUES
(1, 'Roma', 'Via dei cerchi 92'),
(2, 'Roma', 'Via del casaletto 200'),
(3, 'Roma', 'Via Arno 36'),
(4, 'Firenze', 'Via Toselli 99'),
(5, 'Firenze', 'Via Traversari 81'),
(6, 'Napoli', 'Via Loffredi 2'),
(7, 'Napoli', 'Via Duomo 81'),
(8, 'Aosta', 'Via Chambery 5'),
(9, 'Verona', 'Via Pontida 22'),
(10, 'Torino', 'Via Perrone 10'),
(11, 'Torino', 'Via Guastalla 33'),
(12, 'Milano', 'Viale Montenero 44'),
(13, 'Milano', 'Via Vignola 2');

-- --------------------------------------------------------

--
-- Table structure for table `Card`
--

CREATE TABLE `Card` (
  `Status` varchar(20) NOT NULL,
  `Number` varchar(16) NOT NULL,
  `Month` varchar(2) NOT NULL,
  `Year` varchar(4) NOT NULL,
  `CVV` varchar(4) NOT NULL,
  `PIN` varchar(6) NOT NULL,
  `Balance` int(11) DEFAULT NULL,
  `Payment_Date` varchar(2) DEFAULT NULL,
  `Card_ID` int(11) NOT NULL,
  `Account_ID` int(11) NOT NULL,
  `ActivationDate` date NOT NULL,
  `Favorite` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Card`
--

INSERT INTO `Card` (`Status`, `Number`, `Month`, `Year`, `CVV`, `PIN`, `Balance`, `Payment_Date`, `Card_ID`, `Account_ID`, `ActivationDate`, `Favorite`) VALUES
('Active', '4031755065335678', '03', '24', '378', '1445', NULL, NULL, 6, 3, '2020-03-04', 1),
('Active', '4115162610577789', '04', '25', '568', '25663', NULL, '03', 5, 3, '2020-10-10', 0),
('Active', '5291974827221441', '01', '22', '366', '8871', 546, NULL, 4, 3, '2021-02-01', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Card_Type`
--

CREATE TABLE `Card_Type` (
  `ID` int(11) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Type` varchar(30) NOT NULL,
  `Vendor` varchar(20) NOT NULL,
  `Monthly_Max` int(11) NOT NULL,
  `Daily_Max` int(11) NOT NULL,
  `Tax` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Card_Type`
--

INSERT INTO `Card_Type` (`ID`, `Name`, `Type`, `Vendor`, `Monthly_Max`, `Daily_Max`, `Tax`) VALUES
(4, 'Easy Debit', 'Debit', 'Visa', 1000, 600, 0),
(5, 'Easy Credit', 'Credit', 'Mastercard', 5500, 2500, 3),
(6, 'Easy Bancomat', 'Bancomat', 'Visa', 3600, 1200, 0);

-- --------------------------------------------------------

--
-- Table structure for table `History`
--

CREATE TABLE `History` (
  `Account_ID` int(11) NOT NULL,
  `Month` varchar(2) NOT NULL,
  `Year` year(4) NOT NULL,
  `Balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `History`
--

INSERT INTO `History` (`Account_ID`, `Month`, `Year`, `Balance`) VALUES
(3, '01', 2021, 8894),
(3, '02', 2021, 12193),
(3, '03', 2021, 13879),
(3, '04', 2021, 17762),
(3, '05', 2021, 15185),
(3, '12', 2020, 10733);

-- --------------------------------------------------------

--
-- Table structure for table `Loan`
--

CREATE TABLE `Loan` (
  `Loan_ID` int(11) NOT NULL,
  `Amount` mediumint(9) NOT NULL,
  `Tax` tinyint(4) NOT NULL,
  `StartDate` date NOT NULL,
  `Returned` mediumint(9) NOT NULL DEFAULT 0,
  `Total` mediumint(9) NOT NULL,
  `Fee` int(11) NOT NULL DEFAULT 150,
  `Account_ID` int(11) NOT NULL,
  `Favorite` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Loan`
--

INSERT INTO `Loan` (`Loan_ID`, `Amount`, `Tax`, `StartDate`, `Returned`, `Total`, `Fee`, `Account_ID`, `Favorite`) VALUES
(1, 5600, 3, '2020-12-20', 450, 5150, 150, 3, 1),
(2, 500, 5, '2021-03-01', 0, 525, 150, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `SafeDepositBox`
--

CREATE TABLE `SafeDepositBox` (
  `Branch_ID` int(11) NOT NULL,
  `Sector` varchar(4) NOT NULL,
  `Fee` smallint(6) NOT NULL,
  `Level` tinyint(4) NOT NULL,
  `StartDate` date DEFAULT NULL,
  `Account_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `SafeDepositBox`
--

INSERT INTO `SafeDepositBox` (`Branch_ID`, `Sector`, `Fee`, `Level`, `StartDate`, `Account_ID`) VALUES
(5, '3C', 30, 3, '2020-01-01', 3),
(8, '3B', 10, 2, '2021-05-17', 3);

-- --------------------------------------------------------

--
-- Table structure for table `Subscription`
--

CREATE TABLE `Subscription` (
  `CF` varchar(16) NOT NULL,
  `Account_ID` int(11) NOT NULL,
  `StartDate` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Subscription`
--

INSERT INTO `Subscription` (`CF`, `Account_ID`, `StartDate`) VALUES
('DOEJHN72A01H501F', 3, '2020-03-04');

-- --------------------------------------------------------

--
-- Table structure for table `Transaction`
--

CREATE TABLE `Transaction` (
  `Transaction_ID` int(11) NOT NULL,
  `InOut` varchar(4) NOT NULL,
  `Agent` varchar(60) NOT NULL,
  `Type` varchar(30) NOT NULL,
  `Amount` float NOT NULL,
  `Date` date NOT NULL,
  `Number` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Transaction`
--

INSERT INTO `Transaction` (`Transaction_ID`, `InOut`, `Agent`, `Type`, `Amount`, `Date`, `Number`) VALUES
(1, 'in', 'Leonard Hoffmann', 'Receiving', 120.5, '2021-03-19', '4031755065335678'),
(2, 'out', 'Martin Appleseed', 'Sending', 88.15, '2021-03-19', '5291974827221441'),
(3, 'out', 'Starbucks Coffee', 'Payment', 7.5, '2021-03-17', '5291974827221441'),
(4, 'out', 'Nike Inc.', 'Payment', 254.22, '2021-03-18', '4115162610577789'),
(5, 'in', 'Albert Austin', 'Receiving', 12.5, '2021-03-18', '4031755065335678'),
(6, 'out', 'Apple Inc.', 'Payment', 499.15, '2021-03-19', '4031755065335678'),
(7, 'in', 'Amazon', 'Refund', 55.22, '2021-03-18', '5291974827221441'),
(8, 'out', 'Amazon', 'Payment', 55.22, '2021-03-14', '5291974827221441'),
(9, 'in', 'Leonard Hoffmann', 'Receiving', 22.5, '2021-03-19', '5291974827221441'),
(10, 'out', 'Netflix', 'Subscription', 17.99, '2021-03-19', '4031755065335678'),
(11, 'out', 'McDonald\'s', 'Payment', 14.22, '2021-03-18', '4031755065335678'),
(12, 'in', 'Albert Austin', 'Receiving', 5.5, '2021-03-13', '4031755065335678');

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `CF` varchar(20) NOT NULL,
  `Email` varchar(40) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Surname` varchar(50) NOT NULL,
  `Residence` varchar(40) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Passwd` varchar(120) NOT NULL,
  `Profile_Img` varchar(30) DEFAULT 'default.jpg',
  `Dob` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`CF`, `Email`, `Name`, `Surname`, `Residence`, `Phone`, `Passwd`, `Profile_Img`, `Dob`) VALUES
('DOEJHN72A01H501F', 'johndoe@gmail.com', 'John', 'Doe', 'Rome', '3342589710', '$2y$10$2aXANJjLASKf9fjR5W/qAu9B8Op9qL9jClDKRQ4GCoO1YXaANJfj.', 'profile.png', '1972-01-01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Account`
--
ALTER TABLE `Account`
  ADD PRIMARY KEY (`Account_ID`);

--
-- Indexes for table `Branch`
--
ALTER TABLE `Branch`
  ADD PRIMARY KEY (`Branch_ID`);

--
-- Indexes for table `Card`
--
ALTER TABLE `Card`
  ADD PRIMARY KEY (`Number`),
  ADD KEY `idx_9` (`Account_ID`),
  ADD KEY `idx_10` (`Card_ID`);

--
-- Indexes for table `Card_Type`
--
ALTER TABLE `Card_Type`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `History`
--
ALTER TABLE `History`
  ADD PRIMARY KEY (`Account_ID`,`Month`,`Year`),
  ADD KEY `idx_8` (`Account_ID`);

--
-- Indexes for table `Loan`
--
ALTER TABLE `Loan`
  ADD PRIMARY KEY (`Loan_ID`),
  ADD KEY `idx_3` (`Account_ID`);

--
-- Indexes for table `SafeDepositBox`
--
ALTER TABLE `SafeDepositBox`
  ADD PRIMARY KEY (`Branch_ID`,`Sector`),
  ADD KEY `idx_4` (`Account_ID`),
  ADD KEY `idx_5` (`Branch_ID`);

--
-- Indexes for table `Subscription`
--
ALTER TABLE `Subscription`
  ADD PRIMARY KEY (`CF`,`Account_ID`),
  ADD KEY `idx_1` (`Account_ID`),
  ADD KEY `idx_2` (`CF`);

--
-- Indexes for table `Transaction`
--
ALTER TABLE `Transaction`
  ADD PRIMARY KEY (`Transaction_ID`),
  ADD KEY `idx_11` (`Number`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`CF`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Account`
--
ALTER TABLE `Account`
  MODIFY `Account_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Branch`
--
ALTER TABLE `Branch`
  MODIFY `Branch_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `Card_Type`
--
ALTER TABLE `Card_Type`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Loan`
--
ALTER TABLE `Loan`
  MODIFY `Loan_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Transaction`
--
ALTER TABLE `Transaction`
  MODIFY `Transaction_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Card`
--
ALTER TABLE `Card`
  ADD CONSTRAINT `Card_ibfk_1` FOREIGN KEY (`Card_ID`) REFERENCES `Card_Type` (`ID`),
  ADD CONSTRAINT `Card_ibfk_2` FOREIGN KEY (`Account_ID`) REFERENCES `Account` (`Account_ID`);

--
-- Constraints for table `History`
--
ALTER TABLE `History`
  ADD CONSTRAINT `History_ibfk_1` FOREIGN KEY (`Account_ID`) REFERENCES `Account` (`Account_ID`);

--
-- Constraints for table `Loan`
--
ALTER TABLE `Loan`
  ADD CONSTRAINT `Loan_ibfk_1` FOREIGN KEY (`Account_ID`) REFERENCES `Account` (`Account_ID`);

--
-- Constraints for table `SafeDepositBox`
--
ALTER TABLE `SafeDepositBox`
  ADD CONSTRAINT `SafeDepositBox_ibfk_1` FOREIGN KEY (`Branch_ID`) REFERENCES `Branch` (`Branch_ID`),
  ADD CONSTRAINT `SafeDepositBox_ibfk_2` FOREIGN KEY (`Account_ID`) REFERENCES `Account` (`Account_ID`);

--
-- Constraints for table `Subscription`
--
ALTER TABLE `Subscription`
  ADD CONSTRAINT `Subscription_ibfk_1` FOREIGN KEY (`Account_ID`) REFERENCES `Account` (`Account_ID`),
  ADD CONSTRAINT `Subscription_ibfk_2` FOREIGN KEY (`CF`) REFERENCES `User` (`CF`);

--
-- Constraints for table `Transaction`
--
ALTER TABLE `Transaction`
  ADD CONSTRAINT `Transaction_ibfk_1` FOREIGN KEY (`Number`) REFERENCES `Card` (`Number`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
