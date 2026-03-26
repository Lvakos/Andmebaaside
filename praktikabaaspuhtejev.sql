-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Märts 26, 2026 kell 02:49 PL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `praktikabaaspuhtejev`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `keskminePalk` ()   BEGIN
    SELECT avg(praktikajuhendaja.palk) as keskminePalk
	FROM praktikajuhendaja;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaKirje` (IN `uusFirmaNimi` VARCHAR(100), IN `uusAddress` VARCHAR(100), IN `uusTelefon` VARCHAR(20))   BEGIN
    INSERT INTO Firma (firmanimi, aadress, telefon)
    VALUES (uusFirmaNimi, uusFirmaNimi, uusTelefon);
    SELECT * FROM firma;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `muudaTabeli` (IN `tegevus` VARCHAR(15), IN `tabelinimi` VARCHAR(50), IN `veerunimi` VARCHAR(50), IN `andmetyyp` VARCHAR(50))   BEGIN
    DECLARE sqltegevus TEXT;

    IF tegevus = 'add' THEN
        SET sqltegevus = CONCAT('ALTER TABLE ', tabelinimi, ' ADD COLUMN ', veerunimi, ' ', andmetyyp, ';');
    ELSEIF tegevus = 'drop' THEN
        SET sqltegevus = CONCAT('ALTER TABLE ', tabelinimi, ' DROP COLUMN ', veerunimi, ';');
    END IF;

    PREPARE stmt FROM sqltegevus;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SELECT * FROM praktikajuhendaja;
END$$

--
-- Funktsioonid
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateAge` (`DOB` DATE) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE Age INT;

    SET Age = TIMESTAMPDIFF(YEAR, DOB, CURDATE());

    -- уменьшаем на 1, если день и месяц ещё не прошли в текущем году
    IF MONTH(DOB) > MONTH(CURDATE()) OR 
       (MONTH(DOB) = MONTH(CURDATE()) AND DAY(DOB) > DAY(CURDATE())) THEN
        SET Age = Age - 1;
    END IF;

    RETURN Age;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fnComputeAge` (`DOB` DATE) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC BEGIN
    DECLARE years INT;
    DECLARE months INT;
    DECLARE days INT;
    DECLARE tempdate DATE;
    DECLARE Age VARCHAR(50);

    SET tempdate = DOB;

    -- вычисляем полные годы
    SET years = TIMESTAMPDIFF(YEAR, tempdate, CURDATE());
    IF (MONTH(DOB) > MONTH(CURDATE())) OR (MONTH(DOB) = MONTH(CURDATE()) AND DAY(DOB) > DAY(CURDATE())) THEN
        SET years = years - 1;
    END IF;
    SET tempdate = DATE_ADD(tempdate, INTERVAL years YEAR);

    -- вычисляем полные месяцы
    SET months = TIMESTAMPDIFF(MONTH, tempdate, CURDATE());
    IF DAY(DOB) > DAY(CURDATE()) THEN
        SET months = months - 1;
    END IF;
    SET tempdate = DATE_ADD(tempdate, INTERVAL months MONTH);

    -- вычисляем дни
    SET days = DATEDIFF(CURDATE(), tempdate);

    -- формируем строку
    SET Age = CONCAT(years, ' Years ', months, ' Months ', days, ' Days old');

    RETURN Age;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `firma`
--

CREATE TABLE `firma` (
  `firmaID` int(11) NOT NULL,
  `firmanimi` varchar(20) DEFAULT NULL,
  `aadress` varchar(20) DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `firma`
--

INSERT INTO `firma` (`firmaID`, `firmanimi`, `aadress`, `telefon`) VALUES
(1, 'TechSoft', 'Tallinn', '5551111'),
(2, 'DataPro', 'Tartu', '5552222'),
(3, 'NetGroup', 'Narva', '5553333'),
(4, 'CodeLab', 'Parnu', '5554444'),
(5, 'SoftSys', 'Viljandi', '5555555'),
(6, 'Test Firma', 'Test Firma', '1234567');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `praktikabaas`
--

CREATE TABLE `praktikabaas` (
  `praktikabaasID` int(11) NOT NULL,
  `firmaID` int(11) DEFAULT NULL,
  `praktikatingimused` varchar(20) DEFAULT NULL,
  `arvutiprogramm` varchar(20) DEFAULT NULL,
  `juhendajaID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `praktikabaas`
--

INSERT INTO `praktikabaas` (`praktikabaasID`, `firmaID`, `praktikatingimused`, `arvutiprogramm`, `juhendajaID`) VALUES
(1, 1, 'Hea', 'Java', 1),
(2, 2, 'Vaga hea', 'Python', 2),
(3, 3, 'Keskmine', 'C++', 3),
(4, 4, 'Hea', 'C#', 4),
(5, 5, 'Vaga hea', 'JavaScript', 5);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `praktikajuhendaja`
--

CREATE TABLE `praktikajuhendaja` (
  `praktikajuhendajaID` int(11) NOT NULL,
  `eesnimi` varchar(30) DEFAULT NULL,
  `perekonnanimi` varchar(30) DEFAULT NULL,
  `synniaeg` date DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `palk` decimal(7,2) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `praktikajuhendaja`
--

INSERT INTO `praktikajuhendaja` (`praktikajuhendajaID`, `eesnimi`, `perekonnanimi`, `synniaeg`, `telefon`, `palk`, `email`) VALUES
(1, 'Jaan', 'Tamm', '1980-05-12', '6001111', 1500.50, NULL),
(2, 'Mari', 'Kask', '1985-07-23', '6002222', 1800.75, NULL),
(3, 'Peeter', 'Saar', '1978-03-15', '6003333', 1700.25, NULL),
(4, 'Kati', 'Lepp', '1990-11-30', '6004444', 1600.00, NULL),
(5, 'Andres', 'Mets', '1982-09-08', '6005555', 1900.90, NULL);

-- --------------------------------------------------------

--
-- Sise-vaate struktuur `vaade_firma_praktikad`
-- (Tegelik vaade on allpool)
--
CREATE TABLE `vaade_firma_praktikad` (
`firmanimi` varchar(20)
,`praktikakohtade_arv` bigint(21)
);

-- --------------------------------------------------------

--
-- Sise-vaate struktuur `vaade_sugis_juhendajad`
-- (Tegelik vaade on allpool)
--
CREATE TABLE `vaade_sugis_juhendajad` (
`eesnimi` varchar(30)
,`perekonnanimi` varchar(30)
,`synniaeg` date
,`telefon` varchar(20)
,`palk` decimal(7,2)
);

-- --------------------------------------------------------

--
-- Vaate struktuur `vaade_firma_praktikad`
--
DROP TABLE IF EXISTS `vaade_firma_praktikad`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vaade_firma_praktikad`  AS SELECT `f`.`firmanimi` AS `firmanimi`, count(`p`.`praktikabaasID`) AS `praktikakohtade_arv` FROM (`firma` `f` left join `praktikabaas` `p` on(`f`.`firmaID` = `p`.`firmaID`)) GROUP BY `f`.`firmanimi` ;

-- --------------------------------------------------------

--
-- Vaate struktuur `vaade_sugis_juhendajad`
--
DROP TABLE IF EXISTS `vaade_sugis_juhendajad`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vaade_sugis_juhendajad`  AS SELECT `praktikajuhendaja`.`eesnimi` AS `eesnimi`, `praktikajuhendaja`.`perekonnanimi` AS `perekonnanimi`, `praktikajuhendaja`.`synniaeg` AS `synniaeg`, `praktikajuhendaja`.`telefon` AS `telefon`, `praktikajuhendaja`.`palk` AS `palk` FROM `praktikajuhendaja` WHERE month(`praktikajuhendaja`.`synniaeg`) in (9,10,11) ;

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `firma`
--
ALTER TABLE `firma`
  ADD PRIMARY KEY (`firmaID`),
  ADD UNIQUE KEY `aadress` (`aadress`),
  ADD UNIQUE KEY `telefon` (`telefon`);

--
-- Indeksid tabelile `praktikabaas`
--
ALTER TABLE `praktikabaas`
  ADD PRIMARY KEY (`praktikabaasID`),
  ADD KEY `firmaID` (`firmaID`),
  ADD KEY `juhendajaID` (`juhendajaID`);

--
-- Indeksid tabelile `praktikajuhendaja`
--
ALTER TABLE `praktikajuhendaja`
  ADD PRIMARY KEY (`praktikajuhendajaID`),
  ADD UNIQUE KEY `telefon` (`telefon`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `firma`
--
ALTER TABLE `firma`
  MODIFY `firmaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT tabelile `praktikabaas`
--
ALTER TABLE `praktikabaas`
  MODIFY `praktikabaasID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `praktikajuhendaja`
--
ALTER TABLE `praktikajuhendaja`
  MODIFY `praktikajuhendajaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `praktikabaas`
--
ALTER TABLE `praktikabaas`
  ADD CONSTRAINT `praktikabaas_ibfk_1` FOREIGN KEY (`firmaID`) REFERENCES `firma` (`firmaID`),
  ADD CONSTRAINT `praktikabaas_ibfk_2` FOREIGN KEY (`juhendajaID`) REFERENCES `praktikajuhendaja` (`praktikajuhendajaID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
