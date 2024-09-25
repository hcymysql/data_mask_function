-- 邮箱脱敏函数
DELIMITER //
CREATE FUNCTION mask_email(email VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE at_position INT;
    DECLARE local_part VARCHAR(255);
    DECLARE domain_part VARCHAR(255);
    DECLARE masked_local_part VARCHAR(255);
    
    SET at_position = LOCATE('@', email);
    
    IF at_position > 0 THEN
        SET local_part = LEFT(email, at_position - 1);
        SET domain_part = SUBSTRING(email, at_position);
        
        -- 创建与本地部分长度相同的星号字符串
        SET masked_local_part = REPEAT('*', LENGTH(local_part));
        
        RETURN CONCAT(masked_local_part, domain_part);
    ELSE
        RETURN email;
    END IF;
END //
DELIMITER ;

