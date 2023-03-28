CREATE DATABASE IF NOT EXISTS lesson_5;
USE lesson_5;

CREATE TABLE IF NOT EXISTS cars
(
    id   INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT IGNORE cars
VALUES (1, "Audi", 52642),
       (2, "Mercedes", 57127),
       (3, "Skoda", 9000),
       (4, "Volvo", 29000),
       (5, "Bentley", 350000),
       (6, "Citroen ", 21000),
       (7, "Hummer", 41400),
       (8, "Volkswagen ", 21600);

SELECT *
FROM cars;

# 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
CREATE OR REPLACE VIEW inexpensive_cars AS
SELECT *
FROM cars
WHERE cost <= 25000;

SELECT *
FROM inexpensive_cars;


# 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
ALTER VIEW inexpensive_cars AS
SELECT *
FROM cars
WHERE cost <= 30000;

SELECT *
FROM inexpensive_cars;


# Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE OR REPLACE VIEW audi_skoda AS
SELECT *
FROM cars
WHERE name IN ('Audi', 'Skoda');

SELECT *
FROM audi_skoda;
