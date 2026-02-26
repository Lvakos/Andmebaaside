-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 26, 2026 kell 02:58 PL
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
-- Andmebaas: `puhtejev2`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `customer`
--

CREATE TABLE `customer` (
  `idCustomer` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `contact` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `customer`
--

INSERT INTO `customer` (`idCustomer`, `name`, `contact`) VALUES
(1, 'Jüri', '5551234'),
(2, 'Liinak', '5555678'),
(3, 'Mati', '5558765');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kaup`
--

CREATE TABLE `kaup` (
  `kauba_kood` int(11) NOT NULL,
  `nimetus` varchar(255) NOT NULL,
  `liigi_kood` int(11) NOT NULL,
  `hind` decimal(10,2) NOT NULL
) ;

--
-- Andmete tõmmistamine tabelile `kaup`
--

INSERT INTO `kaup` (`kauba_kood`, `nimetus`, `liigi_kood`, `hind`) VALUES
(101, 'Piim 1L', 1, 1.20),
(102, 'Juust 200g', 1, 2.50),
(103, 'Täisteraleib', 2, 1.50),
(104, 'Vesi 0.5L', 3, 0.80),
(105, 'Šokolaad 100g', 4, 1.80);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `liik`
--

CREATE TABLE `liik` (
  `liigi_kood` int(11) NOT NULL,
  `nimetus` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `liik`
--

INSERT INTO `liik` (`liigi_kood`, `nimetus`) VALUES
(1, 'Piimatooted'),
(2, 'Leib ja sai'),
(3, 'Jook'),
(4, 'Maiustused');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `muuk`
--

CREATE TABLE `muuk` (
  `muugi_kood` int(11) NOT NULL,
  `kauba_kood` int(11) NOT NULL,
  `ostja_kood` int(11) NOT NULL,
  `arv` int(11) NOT NULL,
  `kuupaev` date NOT NULL,
  `units` varchar(20) NOT NULL
) ;

--
-- Andmete tõmmistamine tabelile `muuk`
--

INSERT INTO `muuk` (`muugi_kood`, `kauba_kood`, `ostja_kood`, `arv`, `kuupaev`, `units`) VALUES
(1, 101, 1, 2, '2026-02-01', ''),
(2, 103, 2, 1, '2026-02-02', ''),
(3, 105, 3, 3, '2026-02-03', ''),
(4, 102, 1, 1, '2026-02-04', ''),
(5, 104, 2, 5, '2026-02-05', '');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`idCustomer`);

--
-- Indeksid tabelile `kaup`
--
ALTER TABLE `kaup`
  ADD PRIMARY KEY (`kauba_kood`),
  ADD UNIQUE KEY `uq_kaup_nimetus` (`nimetus`),
  ADD KEY `fk_kaup_liik` (`liigi_kood`);

--
-- Indeksid tabelile `liik`
--
ALTER TABLE `liik`
  ADD PRIMARY KEY (`liigi_kood`);

--
-- Indeksid tabelile `muuk`
--
ALTER TABLE `muuk`
  ADD PRIMARY KEY (`muugi_kood`),
  ADD KEY `fk_muuk_kaup` (`kauba_kood`),
  ADD KEY `fk_muuk_customer` (`ostja_kood`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `customer`
--
ALTER TABLE `customer`
  MODIFY `idCustomer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `kaup`
--
ALTER TABLE `kaup`
  ADD CONSTRAINT `fk_kaup_liik` FOREIGN KEY (`liigi_kood`) REFERENCES `liik` (`liigi_kood`);

--
-- Piirangud tabelile `muuk`
--
ALTER TABLE `muuk`
  ADD CONSTRAINT `fk_muuk_customer` FOREIGN KEY (`ostja_kood`) REFERENCES `customer` (`idCustomer`),
  ADD CONSTRAINT `fk_muuk_kaup` FOREIGN KEY (`kauba_kood`) REFERENCES `kaup` (`kauba_kood`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
