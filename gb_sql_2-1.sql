# create db
CREATE DATABASE IF NOT EXISTS gb_sql_trade;
USE gb_sql_trade;

# create table sales
CREATE TABLE IF NOT EXISTS sales
(
    id            INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    order_date    DATE            NOT NULL,
    count_product INT3            NOT NULL
);

# insert
INSERT IGNORE INTO sales
VALUES (1, '2022-01-01', 156),
       (2, '2022-01-02', 180),
       (3, '2022-01-03', 21),
       (4, '2022-01-04', 124),
       (5, '2022-01-05', 341);

/* select 1:
Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва :
меньше 100      -   Маленький заказ
от 100 до 300   -   Средний заказ
больше 300      -   Большой заказ
 */

SELECT *,
       CASE
           WHEN count_product < 100 THEN 'Маленький заказ'
           WHEN count_product BETWEEN 100 AND 300 THEN 'Средний заказ'
           ELSE 'Большой заказ' END AS 'Тип заказа'
FROM sales;

# create table orders
CREATE TABLE IF NOT EXISTS orders
(
    id           INT PRIMARY KEY                      NOT NULL AUTO_INCREMENT,
    employee_id  VARCHAR(10)                          NOT NULL,
    amount       DECIMAL(15, 2)                       NOT NULL,
    order_status ENUM ('open', 'closed', 'cancelled') NOT NULL
);

# insert
INSERT IGNORE INTO orders
VALUES (1, 'e03', 15.00, 'open'),
       (2, 'e01', 25.50, 'open'),
       (3, 'e05', 100.70, 'closed'),
       (4, 'e02', 22.18, 'open'),
       (5, 'e04', 9.50, 'cancelled');

/* select 2:
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – "Order is in open state"; CLOSED - "Order is closed"; CANCELLED - "Order is cancelled"
 */

SELECT *,
       IF(order_status = 'open', 'Order is in open state', CONCAT('Order is ', order_status)) AS full_order_status
FROM orders;
