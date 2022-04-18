-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2022 at 08:42 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fitria`
--

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `idobat` varchar(8) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `harga` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`idobat`, `nama`, `harga`) VALUES
('H0020', 'Herba Sambung', 22500),
('H0030', 'Honey Moon', 70000);

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `idpasien` varchar(8) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `tgllahir` date NOT NULL,
  `telepon` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`idpasien`, `nama`, `alamat`, `tgllahir`, `telepon`) VALUES
('RM003', 'Waluyo Suroboyo', 'Surabaya, Jawa Timur', '2002-11-29', '085747768629');

-- --------------------------------------------------------

--
-- Table structure for table `rawat`
--

CREATE TABLE `rawat` (
  `idrawat` varchar(8) NOT NULL,
  `tglrawat` date NOT NULL,
  `totaltindakan` double NOT NULL,
  `totalobat` double NOT NULL,
  `totalharga` double NOT NULL,
  `uangmuka` double NOT NULL,
  `kurang` double NOT NULL,
  `idpasien` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rawat`
--

INSERT INTO `rawat` (`idrawat`, `tglrawat`, `totaltindakan`, `totalobat`, `totalharga`, `uangmuka`, `kurang`, `idpasien`) VALUES
('RP00003', '2022-04-14', 250000, 160000, 410000, 100000, 310000, 'RM003');

-- --------------------------------------------------------

--
-- Table structure for table `rawatobat`
--

CREATE TABLE `rawatobat` (
  `idrawatobat` varchar(8) NOT NULL,
  `idrawat` varchar(8) NOT NULL,
  `idobat` varchar(8) NOT NULL,
  `jumlah` int(8) NOT NULL,
  `harga` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rawatobat`
--

INSERT INTO `rawatobat` (`idrawatobat`, `idrawat`, `idobat`, `jumlah`, `harga`) VALUES
('1', 'RP00003', 'H0020', 2, 45000),
('2', 'RP00003', 'H0030', 1, 70000);

-- --------------------------------------------------------

--
-- Table structure for table `rawattindakan`
--

CREATE TABLE `rawattindakan` (
  `idrawattindakan` varchar(8) NOT NULL,
  `idrawat` varchar(8) NOT NULL,
  `idtindakan` varchar(8) NOT NULL,
  `namadokter` varchar(255) NOT NULL,
  `harga` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rawattindakan`
--

INSERT INTO `rawattindakan` (`idrawattindakan`, `idrawat`, `idtindakan`, `namadokter`, `harga`) VALUES
('1', 'RP00003', '1', 'Dr. Sulis Tiyowati', 100000),
('2', 'RP00003', '2', 'Dr. Sulis Tiyowati', 150000);

-- --------------------------------------------------------

--
-- Table structure for table `tindakan`
--

CREATE TABLE `tindakan` (
  `idtindakan` varchar(8) NOT NULL,
  `namatindakan` varchar(255) NOT NULL,
  `biaya` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tindakan`
--

INSERT INTO `tindakan` (`idtindakan`, `namatindakan`, `biaya`) VALUES
('1', 'PENAMBALAN', 100000),
('2', 'PENCABUTAN GIGI', 150000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`idobat`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`idpasien`);

--
-- Indexes for table `rawat`
--
ALTER TABLE `rawat`
  ADD PRIMARY KEY (`idrawat`),
  ADD KEY `rawat_FK` (`idpasien`);

--
-- Indexes for table `rawatobat`
--
ALTER TABLE `rawatobat`
  ADD PRIMARY KEY (`idrawatobat`),
  ADD KEY `rawatobat_FK` (`idrawat`),
  ADD KEY `rawatobat_FK_1` (`idobat`);

--
-- Indexes for table `rawattindakan`
--
ALTER TABLE `rawattindakan`
  ADD PRIMARY KEY (`idrawattindakan`),
  ADD KEY `rawattindakan_FK` (`idrawat`),
  ADD KEY `rawattindakan_FK_1` (`idtindakan`);

--
-- Indexes for table `tindakan`
--
ALTER TABLE `tindakan`
  ADD PRIMARY KEY (`idtindakan`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `rawat`
--
ALTER TABLE `rawat`
  ADD CONSTRAINT `rawat_FK` FOREIGN KEY (`idpasien`) REFERENCES `pasien` (`idpasien`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rawatobat`
--
ALTER TABLE `rawatobat`
  ADD CONSTRAINT `rawatobat_FK` FOREIGN KEY (`idrawat`) REFERENCES `rawat` (`idrawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rawatobat_FK_1` FOREIGN KEY (`idobat`) REFERENCES `obat` (`idobat`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rawattindakan`
--
ALTER TABLE `rawattindakan`
  ADD CONSTRAINT `rawattindakan_FK` FOREIGN KEY (`idrawat`) REFERENCES `rawat` (`idrawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rawattindakan_FK_1` FOREIGN KEY (`idtindakan`) REFERENCES `tindakan` (`idtindakan`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
