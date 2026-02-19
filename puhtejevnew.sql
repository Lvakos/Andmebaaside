-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 19, 2026 kell 02:14 PL
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutastore` (IN `id` INT)   BEGIN
SELECT * FROM stores;
DELETE FROM stores WHERE store_id=id;
SELECT * FROM stores;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaBrand` (IN `brandNimi` VARCHAR(30))   BEGIN
INSERT INTO brands(brand_name) VALUES(brandNimi);
SELECT * FROM brands;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisastore` (IN `storeNimi` VARCHAR(30), IN `linn` VARCHAR(30), IN `tel` VARCHAR(13))   BEGIN
INSERT INTO stores(store_name, city, phone)
VALUES(storeNimi, linn, tel);
SELECT * FROM stores;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `muudabrandnimi` (IN `uus_nimi` VARCHAR(30), IN `id` INT)   BEGIN
SELECT * FROM brands;
UPDATE brands
SET brand_name = uus_nimi
WHERE brand_id = id;
SELECT * FROM brands;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `otsing1taht` (IN `taht` VARCHAR(1))   BEGIN
SELECT * FROM brands WHERE brand_name LIKE CONCAT(taht,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uuendaStore` (IN `id` INT, IN `uusTelefon` VARCHAR(13), IN `uusLinn` VARCHAR(25))   BEGIN
SELECT * FROM stores;
UPDATE stores SET phone = uusTelefon, city = uusLinn WHERE store_id = id;
SELECT * FROM stores;
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
-- Tabeli struktuur tabelile `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_status` varchar(30) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `required_date` date DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `order_status`, `order_date`, `required_date`, `shipped_date`, `store_id`, `staff_id`) VALUES
(1, 1, 'Pending', '2026-01-10', '2026-01-15', NULL, 1, 1),
(2, 2, 'Shipped', '2026-01-05', '2026-01-12', '2026-01-08', 1, 2),
(3, 3, 'Completed', '2026-01-01', '2026-01-07', '2026-01-04', 2, 3),
(4, 4, 'Cancelled', '2026-01-12', '2026-01-18', NULL, 2, 3),
(5, 5, 'Pending', '2026-02-01', '2026-02-07', NULL, 3, 2);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `order_items`
--

CREATE TABLE `order_items` (
  `order_id` int(11) DEFAULT NULL,
  `item_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quanity` int(11) DEFAULT NULL,
  `list_price` decimal(7,2) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `order_items`
--

INSERT INTO `order_items` (`order_id`, `item_id`, `product_id`, `quanity`, `list_price`, `discount`) VALUES
(2, 1, 1, 2, 900.00, 10),
(1, 2, 2, 1, 850.99, NULL),
(3, 3, 5, 2, 138.98, NULL),
(4, 4, 4, 1, 2099.99, NULL),
(5, 5, 3, 2, 158.98, NULL);

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
-- Tabeli struktuur tabelile `staffs`
--

CREATE TABLE `staffs` (
  `staff_id` int(11) NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `email` text DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `active` text DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `staffs`
--

INSERT INTO `staffs` (`staff_id`, `first_name`, `last_name`, `email`, `phone`, `active`, `store_id`, `manager_id`) VALUES
(1, 'Maksimilian', 'Puhtejev', 'manag.maks@indianshop.ee', 52123456, 'true', 1, 1),
(2, 'Sergei', 'Puhtejev', 'SergeiP@indianshop.ee', 54123567, 'true', 1, 1),
(3, 'Andrey', 'Visel', 'AndreyV@indianshop.ee', 52123456, 'false', 2, 3);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stocks`
--

CREATE TABLE `stocks` (
  `store_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `stocks`
--

INSERT INTO `stocks` (`store_id`, `product_id`, `quantity`) VALUES
(1, 1, 15),
(1, 2, 8),
(1, 3, 25),
(1, 4, 3),
(1, 5, 18),
(2, 1, 10),
(2, 2, 5),
(2, 3, 30),
(2, 4, 2),
(2, 5, 20),
(3, 1, 7),
(3, 2, 4),
(3, 3, 12),
(3, 4, 1),
(3, 5, 9);

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
(1, 'Klick', 5000111, 'klick@mail.ee', 'Ümera 15', 'Tartu', 'Harjumaa', '11090'),
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
-- Indeksid tabelile `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indeksid tabelile `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indeksid tabelile `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `brand_id` (`brand_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indeksid tabelile `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `manager_id` (`manager_id`);

--
-- Indeksid tabelile `stocks`
--
ALTER TABLE `stocks`
  ADD KEY `store_id` (`store_id`),
  ADD KEY `product_id` (`product_id`);

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
-- AUTO_INCREMENT tabelile `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `order_items`
--
ALTER TABLE `order_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `staffs`
--
ALTER TABLE `staffs`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `stores`
--
ALTER TABLE `stores`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`staff_id`);

--
-- Piirangud tabelile `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Piirangud tabelile `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`brand_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Piirangud tabelile `staffs`
--
ALTER TABLE `staffs`
  ADD CONSTRAINT `staffs_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`),
  ADD CONSTRAINT `staffs_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `staffs` (`staff_id`);

--
-- Piirangud tabelile `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`),
  ADD CONSTRAINT `stocks_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
