-- CREATING DATABASE
CREATE DATABASE IF NOT EXISTS `Order processing System`;
USE `Order processing System`;

-- CREATING TABLES
CREATE TABLE IF NOT EXISTS customer
(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(25) NOT NULL,
	city VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS item
(
	item_id INT PRIMARY KEY,
	unit_price INT NOT NULL
);

CREATE TABLE IF NOT EXISTS `order`
(
	order_id INT PRIMARY KEY,
	order_date DATE NOT NULL,
	customer_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE IF NOT EXISTS order_item
(
	order_id INT NOT NULL,
	item_id INT NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES `order`(order_id),
	FOREIGN KEY (item_id) REFERENCES item(item_id),
	PRIMARY KEY (order_id, item_id)
);

CREATE TABLE IF NOT EXISTS warehouse
(
	warehouse_id INT PRIMARY KEY,
	warehouse_city VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS shipment
(
	order_id INT NOT NULL,
	warehouse_id INT NOT NULL,
	ship_date DATE NOT NULL,
	PRIMARY KEY (order_id, warehouse_id),
	FOREIGN KEY (order_id) REFERENCES `order`(order_id),
	FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id)
);






