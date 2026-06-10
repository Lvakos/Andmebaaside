-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Jun 10, 2026 at 11:30 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `arvestuspuhtejev`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `leiaLennudLinnaJargi` (IN `linnNimi` VARCHAR(100))   BEGIN
    SELECT 
        Lend.LendID,
        Lend.LennuNumber,
        Lend.Valjumisaeg,
        Lennujaam.Linn
    FROM Lend
    JOIN Lennujaam ON Lend.LennujaamID = Lennujaam.LennujaamID
    WHERE Lennujaam.Linn = linnNimi;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `leiaReisijadLennuJargi` (IN `lennuNr` VARCHAR(20))   BEGIN
    SELECT 
        Reisija.Nimi,
        Reisija.Piletinumber,
        Lend.LennuNumber
    FROM Reisija
    JOIN Lend ON Reisija.LendID = Lend.LendID
    WHERE Lend.LennuNumber = lennuNr;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaReisija` (IN `reisijaNimi` VARCHAR(100), IN `piletiNr` VARCHAR(30), IN `lend_id` INT)   BEGIN
    INSERT INTO Reisija(Nimi, Piletinumber, LendID)
    VALUES (reisijaNimi, piletiNr, lend_id);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `lend`
--

CREATE TABLE `lend` (
  `LendID` int(11) NOT NULL,
  `LennuNumber` varchar(20) NOT NULL,
  `Valjumisaeg` datetime NOT NULL,
  `LennujaamID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lend`
--

INSERT INTO `lend` (`LendID`, `LennuNumber`, `Valjumisaeg`, `LennujaamID`) VALUES
(3, 'EE101', '2026-01-15 10:30:00', 1);

--
-- Triggers `lend`
--
DELIMITER $$
CREATE TRIGGER `lendDelete` AFTER DELETE ON `lend` FOR EACH ROW BEGIN
    INSERT INTO logi(kasutaja, kuupaev, sisestatudAndmed)
    VALUES (
        USER(),
        NOW(),
        CONCAT('Kustutati lend: ID=', OLD.LendID,
               ', LennuNumber=', OLD.LennuNumber,
               ', Valjumisaeg=', OLD.Valjumisaeg)
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `lendInsert` AFTER INSERT ON `lend` FOR EACH ROW BEGIN
    INSERT INTO logi(kasutaja, kuupaev, sisestatudAndmed)
    VALUES (
        USER(),
        NOW(),
        CONCAT('Lisati lend: ID=', NEW.LendID,
               ', LennuNumber=', NEW.LennuNumber,
               ', Valjumisaeg=', NEW.Valjumisaeg,
               ', LennujaamID=', NEW.LennujaamID)
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `lennujaam`
--

CREATE TABLE `lennujaam` (
  `LennujaamID` int(11) NOT NULL,
  `LennujaamaNimi` varchar(100) NOT NULL,
  `Linn` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lennujaam`
--

INSERT INTO `lennujaam` (`LennujaamID`, `LennujaamaNimi`, `Linn`) VALUES
(1, 'Tallinna Lennujaam', 'Tallinn');

--
-- Triggers `lennujaam`
--
DELIMITER $$
CREATE TRIGGER `lennujaamDelete` AFTER DELETE ON `lennujaam` FOR EACH ROW BEGIN
    INSERT INTO logi(kasutaja, kuupaev, sisestatudAndmed)
    VALUES (
        USER(),
        NOW(),
        CONCAT('Kustutati lennujaam: ID=', OLD.LennujaamaNimi,
               ', LennujaamID=', OLD.LennujaamID,
               ', Linn=', OLD.Linn)
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `lennujaamInsert` AFTER INSERT ON `lennujaam` FOR EACH ROW BEGIN
    INSERT INTO logi(kasutaja, kuupaev, sisestatudAndmed)
    VALUES (
        USER(),
        NOW(),
        CONCAT('Lisati lennujaam: ID=', NEW.LennujaamID,
               ', Nimi=', NEW.LennujaamaNimi,
               ', Linn=', NEW.Linn)
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `logi`
--

CREATE TABLE `logi` (
  `id` int(11) NOT NULL,
  `kasutaja` varchar(100) DEFAULT NULL,
  `kuupaev` datetime DEFAULT NULL,
  `sisestatudAndmed` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logi`
--

INSERT INTO `logi` (`id`, `kasutaja`, `kuupaev`, `sisestatudAndmed`) VALUES
(1, 'root@localhost', '2026-06-10 16:31:24', 'Lisati lennujaam: ID=1, Nimi=Tallinna Lennujaam, Linn=Tallinn'),
(2, 'root@localhost', '2026-06-10 16:31:29', 'Lisati lend: ID=1, LennuNumber=EE101, Valjumisaeg=2026-01-15 10:30:00, LennujaamID=1'),
(3, 'root@localhost', '2026-06-10 16:31:36', 'Kustutati lend: ID=1, LennuNumber=EE101, Valjumisaeg=2026-01-15 10:30:00'),
(4, 'root@localhost', '2026-06-10 16:34:15', 'Lisati lend: ID=2, LennuNumber=EE101, Valjumisaeg=2026-01-15 10:30:00, LennujaamID=1'),
(5, 'root@localhost', '2026-06-10 16:34:23', 'Lisati lend: ID=3, LennuNumber=EE101, Valjumisaeg=2026-01-15 10:30:00, LennujaamID=1'),
(6, 'root@localhost', '2026-06-10 16:34:51', 'Kustutati lend: ID=2, LennuNumber=EE101, Valjumisaeg=2026-01-15 10:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `reisija`
--

CREATE TABLE `reisija` (
  `ReisijaID` int(11) NOT NULL,
  `Nimi` varchar(100) NOT NULL,
  `Piletinumber` varchar(30) NOT NULL,
  `LendID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reisija`
--

INSERT INTO `reisija` (`ReisijaID`, `Nimi`, `Piletinumber`, `LendID`) VALUES
(2, 'Maks', 'EE101', 3);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vaade_lennud_lennujaamad`
-- (See below for the actual view)
--
CREATE TABLE `vaade_lennud_lennujaamad` (
`LennuNumber` varchar(20)
,`Valjumisaeg` datetime
,`LennujaamaNimi` varchar(100)
,`Linn` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vaade_reisijad_lennud`
-- (See below for the actual view)
--
CREATE TABLE `vaade_reisijad_lennud` (
`Nimi` varchar(100)
,`Piletinumber` varchar(30)
,`LennuNumber` varchar(20)
,`Valjumisaeg` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vaade_tallinna_reisijad`
-- (See below for the actual view)
--
CREATE TABLE `vaade_tallinna_reisijad` (
`Nimi` varchar(100)
,`Piletinumber` varchar(30)
,`LennuNumber` varchar(20)
,`Linn` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure for view `vaade_lennud_lennujaamad`
--
DROP TABLE IF EXISTS `vaade_lennud_lennujaamad`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vaade_lennud_lennujaamad`  AS SELECT `lend`.`LennuNumber` AS `LennuNumber`, `lend`.`Valjumisaeg` AS `Valjumisaeg`, `lennujaam`.`LennujaamaNimi` AS `LennujaamaNimi`, `lennujaam`.`Linn` AS `Linn` FROM (`lend` join `lennujaam` on(`lend`.`LennujaamID` = `lennujaam`.`LennujaamID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vaade_reisijad_lennud`
--
DROP TABLE IF EXISTS `vaade_reisijad_lennud`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vaade_reisijad_lennud`  AS SELECT `reisija`.`Nimi` AS `Nimi`, `reisija`.`Piletinumber` AS `Piletinumber`, `lend`.`LennuNumber` AS `LennuNumber`, `lend`.`Valjumisaeg` AS `Valjumisaeg` FROM (`reisija` join `lend` on(`reisija`.`LendID` = `lend`.`LendID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vaade_tallinna_reisijad`
--
DROP TABLE IF EXISTS `vaade_tallinna_reisijad`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vaade_tallinna_reisijad`  AS SELECT `reisija`.`Nimi` AS `Nimi`, `reisija`.`Piletinumber` AS `Piletinumber`, `lend`.`LennuNumber` AS `LennuNumber`, `lennujaam`.`Linn` AS `Linn` FROM ((`reisija` join `lend` on(`reisija`.`LendID` = `lend`.`LendID`)) join `lennujaam` on(`lend`.`LennujaamID` = `lennujaam`.`LennujaamID`)) WHERE `lennujaam`.`Linn` = 'Tallinn' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `lend`
--
ALTER TABLE `lend`
  ADD PRIMARY KEY (`LendID`),
  ADD KEY `fk_lend_lennujaam` (`LennujaamID`);

--
-- Indexes for table `lennujaam`
--
ALTER TABLE `lennujaam`
  ADD PRIMARY KEY (`LennujaamID`);

--
-- Indexes for table `logi`
--
ALTER TABLE `logi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reisija`
--
ALTER TABLE `reisija`
  ADD PRIMARY KEY (`ReisijaID`),
  ADD KEY `fk_reisija_lend` (`LendID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `lend`
--
ALTER TABLE `lend`
  MODIFY `LendID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lennujaam`
--
ALTER TABLE `lennujaam`
  MODIFY `LennujaamID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `logi`
--
ALTER TABLE `logi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reisija`
--
ALTER TABLE `reisija`
  MODIFY `ReisijaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lend`
--
ALTER TABLE `lend`
  ADD CONSTRAINT `fk_lend_lennujaam` FOREIGN KEY (`LennujaamID`) REFERENCES `lennujaam` (`LennujaamID`);

--
-- Constraints for table `reisija`
--
ALTER TABLE `reisija`
  ADD CONSTRAINT `fk_reisija_lend` FOREIGN KEY (`LendID`) REFERENCES `lend` (`LendID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
