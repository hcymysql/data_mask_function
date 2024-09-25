-- 姓名脱敏函数
DELIMITER //

CREATE FUNCTION mask_chinese_name(full_name VARCHAR(255) CHARACTER SET utf8mb4) 
RETURNS VARCHAR(255) CHARACTER SET utf8mb4
DETERMINISTIC
BEGIN
    DECLARE first_char VARCHAR(3) CHARACTER SET utf8mb4;
    DECLARE masked_name VARCHAR(255) CHARACTER SET utf8mb4;
    
    -- 提取第一个字符（姓）
    SET first_char = LEFT(full_name, 1);
    
    -- 如果名字长度大于1个中文字符，则掩码剩余部分
    IF CHAR_LENGTH(full_name) > 1 THEN
        SET masked_name = CONCAT(first_char, REPEAT('*', CHAR_LENGTH(full_name) - 1)); 
    ELSE
        SET masked_name = full_name;
    END IF;
    
    RETURN masked_name;
END //

DELIMITER ;
