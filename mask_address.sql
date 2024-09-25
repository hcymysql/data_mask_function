-- 地址脱敏函数
DELIMITER //
CREATE FUNCTION mask_address(input_address VARCHAR(255))
RETURNS VARCHAR(255)
BEGIN
    DECLARE city_end INT;
    DECLARE district_end INT;
    DECLARE masked_address VARCHAR(255);
    
    -- 找到第一个市字的位置
    SET city_end = LOCATE('市', input_address);
    
    -- 找到第一个区字的位置
    SET district_end = LOCATE('区', input_address);
    
    IF city_end > 0 OR district_end > 0 THEN
        IF district_end > 0 THEN
            -- 如果找到区字，保留到区，之后用星号替换
            SET masked_address = CONCAT(
                SUBSTRING(input_address, 1, district_end),
                REPEAT('*', CHAR_LENGTH(input_address) - district_end)
            );
        ELSE
            -- 如果只找到市字，保留到市，之后用星号替换
            SET masked_address = CONCAT(
                SUBSTRING(input_address, 1, city_end),
                REPEAT('*', CHAR_LENGTH(input_address) - city_end)
            );
        END IF;
    ELSE
        -- 如果既没有找到市字也没有找到区字，则全部用星号替换
        SET masked_address = REPEAT('*', CHAR_LENGTH(input_address));
    END IF;
    
    RETURN masked_address;
END //
DELIMITER ;
