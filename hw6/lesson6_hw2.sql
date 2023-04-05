# Выведите только четные числа от 1 до 10 включительно. (Через функцию / процедуру)
# Пример: 2,4,6,8,10 (можно сделать через шаг + 2: х = 2, х+=2)

DROP PROCEDURE IF EXISTS print_even_numbers;
DELIMITER $$
CREATE PROCEDURE print_even_numbers(
    IN input_number INT
)
BEGIN
    DECLARE i INT;
    DECLARE result VARCHAR(45) DEFAULT "";
    SET i = 2;
    WHILE i < input_number
        DO
            SET result = CONCAT(result, i, ",");
            SET i = i + 2;
        END WHILE;
    SET result = CONCAT(result, input_number);
    SELECT result;
END $$

CALL print_even_numbers(10);
