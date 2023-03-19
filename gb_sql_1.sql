# create db
CREATE DATABASE IF NOT EXISTS gb_sql_phones;
USE gb_sql_phones;

# create table
CREATE TABLE IF NOT EXISTS phones
(
    id            INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    product_name  VARCHAR(45)     NOT NULL,
    manufacturer  VARCHAR(45)     NOT NULL,
    product_count INT3            NOT NULL,
    price         INT3            NOT NULL
);

# insert
INSERT IGNORE INTO phones (product_name, manufacturer, product_count, price)
VALUES ('iPhone X', 'Apple', 3, 76000),
       ('iPhone 8', 'Apple', 2, 51000),
       ('Galaxy S9', 'Samsung', 2, 56000),
       ('Galaxy S8', 'Samsung', 1, 41000),
       ('P20 Pro', 'Huawei', 5, 36000);

# select 1: Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT manufacturer,
       product_name,
       price
FROM phones
WHERE product_count > 2
ORDER BY manufacturer,
         product_name;

# select 2: Выведите весь ассортимент товаров марки “Samsung”
SELECT *
FROM phones
WHERE manufacturer = 'Samsung';

# select 3: Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000
SELECT *
FROM phones
WHERE price * product_count > 100000
  AND price * product_count < 145000;

# select 4.1: Товары, в которых есть упоминание "Iphone"
SELECT *
FROM phones
WHERE product_name LIKE '%iphone%';

# select 4.2: "Galaxy"
SELECT *
FROM phones
WHERE product_name LIKE '%galaxy%';

# select 4.3: Товары, в которых есть ЦИФРЫ
SELECT *
FROM phones
WHERE product_name RLIKE '\\d';

# select 4.4: Товары, в которых есть ЦИФРА "8"
SELECT *
FROM phones
WHERE product_name LIKE '%8%';
