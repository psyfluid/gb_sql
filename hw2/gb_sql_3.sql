-- 1. Создаем БД
DROP DATABASE IF EXISTS lesson3;
CREATE DATABASE IF NOT EXISTS `lesson3`;

-- 2. Выбираем конкретную БД для работы
USE lesson3;

-- 3. Создание таблицы
DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff`
(
    `id`         INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(45),
    `last_name`  VARCHAR(45),
    `post`       VARCHAR(45),
    `seniority`  INT,
    `salary`     DECIMAL(8, 2), -- -999999.99 до 999999.99
    `age`        INT
);

INSERT staff (first_name, last_name, post, seniority, salary, age)
VALUES ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
       ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
       ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
       ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
       ('Иван', 'Иванов', 'Рабочий', 40, 30000, 59),
       ('Петр', 'Петров', 'Рабочий', 20, 25000, 40),
       ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
       ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
       ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
       ('Максим', 'Максимов', 'Рабочий', 2, 11000, 22),
       ('Юрий', 'Галкин', 'Рабочий', 3, 12000, 24),
       ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

# 1. Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания
SELECT *
FROM staff
ORDER BY salary DESC;

SELECT *
FROM staff
ORDER BY salary;

# 2. Выведите 5 максимальных заработных плат (salary)
SELECT DISTINCT salary
FROM staff
ORDER BY salary DESC
LIMIT 5;

# 3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT post,
       SUM(salary)
FROM staff
GROUP BY post;

# 3'. TOP-2
SELECT post,
       salary
FROM (SELECT post,
             salary,
             ROW_NUMBER() OVER (PARTITION BY post ORDER BY salary DESC) AS n
      FROM staff) top_salaries
WHERE n <= 2
ORDER BY post, salary DESC;

# 4. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT COUNT(*)
FROM staff
WHERE post = 'Рабочий'
  AND age BETWEEN 24 AND 49;

# 5. Найдите количество специальностей
SELECT COUNT(DISTINCT post)
FROM staff;

# 6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
# Меньше 30 — ни одной. У инженеров ровно 30, у рабочих ~33.
SELECT post,
       AVG(age) AS avg_age
FROM staff
GROUP BY post
HAVING avg_age < 30;
