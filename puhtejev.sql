-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 18, 2026 kell 08:57 EL
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
-- Andmebaas: `puhtejev`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `kustuta` (IN `id` INT)   BEGIN
SELECT * FROM brands;
DELETE FROM brands WHERE brand_id=id;
SELECT * FROM brands;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaBrand` (IN `brandNimi` VARCHAR(30))   BEGIN
INSERT INTO brands(brand_name) VALUES(brandNimi);
SELECT * FROM brands;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `muuda` (IN `uus_nimi` VARCHAR(30), IN `id` INT)   BEGIN
SELECT * FROM brands;
UPDATE brands
SET brand_name = uus_nimi
WHERE brand_id = id;
SELECT * FROM brands;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `otsing1taht` (IN `taht` VARCHAR(1))   BEGIN
SELECT * FROM brands WHERE brand_name LIKE CONCAT(taht,'%');
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `brands`
--

CREATE TABLE `brands` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_name`) VALUES
(4, 'lenovo'),
(5, 'HP'),
(6, 'MSI'),
(7, 'Acer'),
(8, 'Razer');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(4, 'hiired'),
(3, 'klaviaaturid'),
(2, 'lauaarvutid'),
(1, 'sülearvutid'),
(5, 'videokaardid');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `email` text DEFAULT NULL,
  `street` text DEFAULT NULL,
  `city` text DEFAULT NULL,
  `state_` text DEFAULT NULL,
  `zip_code` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `phone`, `email`, `street`, `city`, `state_`, `zip_code`) VALUES
(1, 'Konstantin', 'Guakamole', 52123456, 'kguakomol@mail.ee', 'Ümera 8', 'Tallinn', 'Harjumaa', '11093'),
(2, 'Dmitro', 'Gusenko', 5312345, 'DGusen@mail.ee', 'Seli 2', 'Tallinn', 'Harjumaa', '13112'),
(3, 'Danil', 'Kolbasenko', 5412345, 'DanilKolbas@mail.ee', 'Kivila 2', 'Tallinn', 'Harjumaa', '12121'),
(4, 'Dmitriy', 'Sokolov', 51231234, 'dmitsok@mail.ee', 'Laagna 10', 'Tallinn', 'Harjumaa', '12311'),
(5, 'Maksim', 'Gorodskoy', 5321321, 'maksgor@mail.ee', 'Mahtra 7', 'Tallinn', 'Harjumaa', '12211');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(20) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `model_year` int(11) DEFAULT NULL CHECK (`model_year` < 2027),
  `list_price` decimal(7,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `brand_id`, `category_id`, `model_year`, `list_price`) VALUES
(1, 'Arvuti HP1', 5, 2, 2024, 999.99),
(2, 'Acer Nitro 5', 7, 1, 2025, 850.99),
(3, 'Razer Hiir', 8, 4, 2026, 69.99),
(4, 'MSI Videokaart 5090', 6, 5, 2025, 2099.99),
(5, 'Lenovo Klaviatuur', 4, 3, 2026, 79.99);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stores`
--

CREATE TABLE `stores` (
  `store_id` int(11) NOT NULL,
  `store_name` varchar(20) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `email` text DEFAULT NULL,
  `street` text DEFAULT NULL,
  `city` text DEFAULT NULL,
  `state_` text DEFAULT NULL,
  `zip_code` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `stores`
--

INSERT INTO `stores` (`store_id`, `store_name`, `phone`, `email`, `street`, `city`, `state_`, `zip_code`) VALUES
(1, 'Klick', 52123456, 'klick@mail.ee', 'Ümera 15', 'Tallinn', 'Harjumaa', '11090'),
(2, 'Euronics', 5312345, 'euronics@mail.ee', 'Seli 2', 'Tallinn', 'Harjumaa', '13112'),
(3, 'ArvutiTark', 5412211, 'arvutitark@mail.ee', 'Kivila 2', 'Tallinn', 'Harjumaa', '12123');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indeksid tabelile `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indeksid tabelile `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indeksid tabelile `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `brand_id` (`brand_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indeksid tabelile `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`store_id`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT tabelile `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `stores`
--
ALTER TABLE `stores`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`brand_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
