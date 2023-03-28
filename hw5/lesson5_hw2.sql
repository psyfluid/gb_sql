CREATE DATABASE IF NOT EXISTS lesson_5;
USE lesson_5;

DROP TABLE IF EXISTS trains;
CREATE TABLE trains
(
    id           INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    train_id     INT NOT NULL,
    station      VARCHAR(20),
    station_time TIME
);

INSERT trains (train_id, station, station_time)
VALUES (110, 'San Francisco', '10:00:00'),
       (110, 'Redwood City', '10:54:00'),
       (110, 'Palo Alto', '11:02:00'),
       (110, 'San Jose', '12:35:00'),
       (120, 'San Francisco', '11:00:00'),
       (120, 'Palo Alto', '12:49:00'),
       (120, 'San Jose', '13:30:00');


# Добавьте новый столбец под названием «время до следующей станции».
# Чтобы получить это значение, мы вычитаем время станций для пар смежных станций.

SELECT train_id,
       station,
       station_time,
       IFNULL(TIMEDIFF(LEAD(station_time) OVER (PARTITION BY train_id), station_time), '') AS time_to_next_station
FROM trains;
