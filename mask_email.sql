-- 邮箱脱敏函数
DELIMITER //

CREATE FUNCTION mask_email(email VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE at_position INT;
    SET at_position = LOCATE('@', email);
    
    IF at_position > 0 THEN
        RETURN CONCAT('xxxx', SUBSTRING(email, at_position));
    ELSE
        RETURN email;
    END IF;
END //

DELIMITER ;
