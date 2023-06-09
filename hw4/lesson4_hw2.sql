DROP DATABASE IF EXISTS lesson_4;
CREATE DATABASE lesson_4;
USE lesson_4;

-- Собеседования
CREATE TABLE AUTO
(
    REGNUM    VARCHAR(10) PRIMARY KEY,
    MARK      VARCHAR(10),
    COLOR     VARCHAR(15),
    RELEASEDT DATE,
    PHONENUM  VARCHAR(15)
);

-- AUTO
INSERT INTO AUTO (REGNUM, MARK, COLOR, RELEASEDT, PHONENUM)
VALUES (111114, 'LADA', 'КРАСНЫЙ', DATE'2008-01-01', '9152222221');


INSERT INTO AUTO (REGNUM, MARK, COLOR, RELEASEDT, PHONENUM)
VALUES (111115, 'VOLVO', 'КРАСНЫЙ', DATE'2013-01-01', '9173333334');


INSERT INTO AUTO (REGNUM, MARK, COLOR, RELEASEDT, PHONENUM)
VALUES (111116, 'BMW', 'СИНИЙ', DATE'2015-01-01', '9173333334');


INSERT INTO AUTO (REGNUM, MARK, COLOR, RELEASEDT, PHONENUM)
VALUES (111121, 'AUDI', 'СИНИЙ', DATE'2009-01-01', '9173333332');


INSERT INTO AUTO (REGNUM, MARK, COLOR, RELEASEDT, PHONENUM)
VALUES (111122, 'AUDI', 'СИНИЙ', DATE'2011-01-01', '9213333336');


INSERT INTO AUTO (REGNUM, MARK, COLOR, RELEASEDT, PHONENUM)
VALUES (111113, 'BMW', 'ЗЕЛЕНЫЙ', DATE'2007-01-01', '9214444444');


INSERT INTO AUTO (REGNUM, MARK, COLOR, RELEASEDT, PHONENUM)
VALUES (111126, 'LADA', 'ЗЕЛЕНЫЙ', DATE'2005-01-01', NULL);


INSERT INTO AUTO (REGNUM, MARK, COLOR, RELEASEDT, PHONENUM)
VALUES (111117, 'BMW', 'СИНИЙ', DATE'2005-01-01', NULL);


INSERT INTO AUTO (REGNUM, MARK, COLOR, RELEASEDT, PHONENUM)
VALUES (111119, 'LADA', 'СИНИЙ', DATE'2017-01-01', 9213333331);


# 1. Вывести на экран сколько машин каждого цвета для машин марок BMW и LADA
SELECT MARK,
       COLOR,
       COUNT(*) AS cars_count
FROM AUTO
WHERE MARK IN ('BMW', 'LADA')
GROUP BY MARK, COLOR
ORDER BY MARK, COLOR;

# 2. Вывести на экран марку авто и количество AUTO не этой марки
SELECT MARK,
       mark_count,
       all_count - mark_count AS others_count
FROM (SELECT MARK,
             COUNT(*) AS mark_count
      FROM AUTO
      GROUP BY MARK) AM,
     (SELECT COUNT(*) AS all_count FROM AUTO) A
ORDER BY MARK;
