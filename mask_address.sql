-- 地址脱敏函数
DELIMITER //
CREATE FUNCTION mask_address(input_address VARCHAR(255))
RETURNS VARCHAR(255)
BEGIN
    DECLARE district_end INT;
    DECLARE masked_address VARCHAR(255);
    
    -- 找到第一个区字的位置
    SET district_end = LOCATE('区', input_address);
    
    IF district_end > 0 THEN
        -- 如果找到区字，保留到区，之后用星号替换
        SET masked_address = CONCAT(
            SUBSTRING(input_address, 1, district_end),
            REPEAT('*', CHAR_LENGTH(input_address) - district_end)
        );
    ELSE
        -- 如果没找到区字，则全部保留
        SET masked_address = input_address;
    END IF;
    
    RETURN masked_address;
END //
DELIMITER ;