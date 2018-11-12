DROP TRIGGER IF EXISTS `db_notarial_office`.`discount_limit_BEFORE_INSERT`  ;

DELIMITER $$

CREATE DEFINER = CURRENT_USER TRIGGER `db_notarial_office`.`discount_limit_BEFORE_INSERT` 
	BEFORE INSERT ON `discount` 
    FOR EACH ROW
BEGIN
	IF (NEW.discount >= 30.00) THEN
		
        SET NEW.discount = 30.00;
        
	END IF;
END
$$

DELIMITER ;