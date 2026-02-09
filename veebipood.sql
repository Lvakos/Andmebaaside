CREATE DATABASE veebipoodPuhtejev;
USE veebipoodPuhtejev;

-- Production
-- table Categories
CREATE TABLE categories(
	category_id int PRIMARY KEY identity(1,1),
	category_name varchar(30) UNIQUE
);

INSERT INTO categories(category_name)
VALUES ('T-särgid'), ('Tossud'), ('Kingad'), ('Mantel'), ('Pusad');
SELECT * FROM categories;

--table brands
CREATE TABLE brands(
	brand_id int PRIMARY KEY identity(1,1),
	brand_name varchar(30) UNIQUE
);

INSERT INTO brands(brand_name)
VALUES ('Adidas'), ('Nike'), ('Calvin Klein'), ('Gucci'), ('Hugo boss');
SELECT * FROM brands;

--table products
CREATE TABLE products(
	product_id int PRIMARY KEY identity(1,1),
	product_name varchar(50),
	brand_id int,
	FOREIGN KEY (brand_id) references brands(brand_id),
	category_id int,
	FOREIGN KEY (category_id) references categories(category_id),
	model_year int CHECK(model_year<2027),
	list_price decimal(7,2)
);
INSERT INTO products(product_name, brand_id, category_id, model_year, list_price)
VALUES ('Adidas tossud', 1, 2, 2019, 60),
('Nike t-särk', 2, 1, 2025, 45.59),
('Calvin Klein pusa', 3, 5, 2018, 100.99),
('Gucci Mantel', 4, 4, 2020, 159.99),
('Hugo boss Kingad', 5, 3, 2026, 25.99);
SELECT * FROM products;

--Sales
--table customers
CREATE TABLE customers(
	customer_id int PRIMARY KEY identity(1,1),
	first_name varchar(20),
	last_name varchar(30),
	phone int,
	email TEXT,
	street TEXT,
	city TEXT,
	state_ TEXT,
	zip_code char(5)
);

INSERT INTO customers(first_name, last_name, phone, email, street, city, state_, zip_code)
VALUES ('Konstantin', 'Guakamole', '52123456', 'kguakomol@mail.ee', 'Ümera 8', 'Tallinn', 'Harjumaa', '11093'),
('Dmitro', 'Gusenko', '5312345', 'DGusen@mail.ee', 'Seli 2', 'Tallinn', 'Harjumaa', '13112'),
('Danil', 'Kolbasenko', '5412345', 'DanilKolbas@mail.ee', 'Kivila 2', 'Tallinn', 'Harjumaa', '12121');
SELECT * FROM customers;


-- stores table
CREATE TABLE stores(
	store_id int PRIMARY KEY identity(1,1),
	store_name varchar(20),
	phone int,
	email TEXT,
	street TEXT ,
	city TEXT,
	state_ TEXT,
	zip_code char(5)
);

INSERT INTO stores(store_name, phone, email, street, city, state_, zip_code)
VALUES ('Indian Shop', 52123456, 'indianstore@mail.ee', 'Ümera 15', 'Tallinn', 'Harjumaa', 11090),
('Mania Clothes', 5312345, 'ManiaClothes@mail.ee', 'Seli 2', 'Tallinn', 'Harjumaa', 13112),
('Clothes And More', 5412211, 'candm@mail.ee', 'Kivila 2', 'Tallinn', 'Harjumaa', 12123);
SELECT * FROM stores;

--staff table

CREATE TABLE staffs(
	staff_id int PRIMARY KEY identity(1,1),
	first_name varchar(20),
	last_name varchar(30),
	email TEXT,
	phone int,
	active TEXT,
	store_id int,
	FOREIGN KEY (store_id) references stores(store_id),
	manager_id int,
	FOREIGN KEY (manager_id) references staffs(staff_id)
);

INSERT INTO staffs(first_name, last_name, email, phone, active, store_id, manager_id)
VALUES ('Maksimilian','Puhtejev', 'manag.maks@indianshop.ee', 52123456, 'true', 1, 1),
('Sergei','Puhtejev', 'SergeiP@indianshop.ee', 54123567, 'true', 1, 1),
('Andrey','Visel', 'AndreyV@indianshop.ee', 52123456, 'false', 2, 3);
SELECT * FROM staffs;

--Table Orders
CREATE TABLE orders(
	order_id int PRIMARY KEY identity(1,1),
	customer_id int,
	FOREIGN KEY (customer_id) references customers(customer_id),
	order_status varchar(30) check(order_status='valmis' or order_status='töötlemisel' or order_status='makstud'),
	order_date DATE,
	required_date DATE,
	shipped_date DATE,
	store_id int,
	FOREIGN KEY (store_id) references stores(store_id),
	staff_id int
	FOREIGN KEY (staff_id) references staffs(staff_id),
);

SELECT * FROM orders;

--stocks table
CREATE TABLE stocks(
	store_id int,
	FOREIGN KEY (store_id) references stores(store_id),
	product_id int
	FOREIGN KEY (product_id) references products(product_id),
	quantity int
)

-- Order_items Table
CREATE TABLE order_items(
	order_id int,
	FOREIGN KEY (order_id) references orders(order_id),
	item_id int PRIMARY KEY identity(1,1),
	product_id int,
	FOREIGN KEY (product_id) references products(product_id),
	quanity int,
	list_price decimal(7,2),
	discount int
);
