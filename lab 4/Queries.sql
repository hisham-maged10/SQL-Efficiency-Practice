--1.Write a SQL query to retrieve names of customers whose name starts with ‘Ma’.
SELECT customer_name
FROM customer
WHERE customer_name LIKE 'Ma%';

--2.Write a SQL query to retrieve count of items and total price of each order.
SELECT o.order_id, COUNT(o.item_id) AS 'Count of Items', SUM(i.unit_price*o.quantity) AS 'Total Price'
FROM order_item o, item i
WHERE o.item_id = i.item_id
GROUP BY o.order_id;

--3.Write a SQL query to retrieve order number for each order that have been shipped from warehouse in ‘Avennes’;
SELECT order_id
FROM shipment s, warehouse w
WHERE s.warehouse_id = w.warehouse_id
AND w.warehouse_city = 'Avennes';

--4.Write a SQL query to retrieve total price of orders that have been shipped from warehouse #3.
SELECT o.order_id, SUM(i.unit_price*o.quantity) as 'Total Price'
FROM order_item o, item i, (SELECT order_id
                            FROM shipment s, warehouse w
                            WHERE s.warehouse_id = w.warehouse_id
                            AND w.warehouse_city = 'Avennes') as avorders
WHERE avorders.order_id = o.order_id 
AND o.item_id = i.item_id
GROUP BY o.order_id;

--5.Write a SQLquery to retrieve warehouse number and city for each warehouse and orders’ numbers for orders that have been shipped from this warehouse even if there are no orders have been shipped from this warehouse.
SELECT w.warehouse_id, w.warehouse_city, s.order_id
FROM warehouse w LEFT JOIN shipment s ON w.warehouse_id = s.warehouse_id;
--6.Write a SQLquery to retrieve customer name, count of orders for each customer even if the customer didn’t make any orders.
SELECT c.customer_name, count(o.order_id) AS "Order Count"
FROM customer c LEFT JOIN `order` o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

--7.Write a SQLquery to retrieve all items thathaven’t been ordered
SELECT i.item_id, i.unit_price
FROM item i LEFT JOIN order_item o ON i.item_id = o.item_id
WHERE order_id IS NULL;