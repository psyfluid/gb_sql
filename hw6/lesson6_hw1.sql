# Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
# Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS convert_seconds;
DELIMITER $$
CREATE FUNCTION convert_seconds(input_time INT)
    RETURNS VARCHAR(45)
    DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(45) DEFAULT "";

    SET @seconds = input_time % 60;
    SET result = CONCAT(@seconds, ' seconds');

    SET input_time = input_time DIV 60;
    IF input_time = 0 THEN
        RETURN result;
    END IF;
    SET @minutes = input_time % 60;
    SET result = CONCAT(@minutes, ' minutes ', result);

    SET input_time = input_time DIV 60;
    IF input_time = 0 THEN
        RETURN result;
    END IF;
    SET @hours = input_time % 24;
    SET result = CONCAT(@hours, ' hours ', result);

    SET input_time = input_time DIV 24;
    IF input_time = 0 THEN
        RETURN result;
    END IF;
    SET result = CONCAT(input_time, ' days ', result);
    RETURN result;
END $$

SELECT convert_seconds(123456);
