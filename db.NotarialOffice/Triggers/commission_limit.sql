DROP TRIGGER IF EXISTS `db_notarial_office`.`commission_limit_BEFORE_INSERT` ;

DELIMITER $$

CREATE DEFINER = CURRENT_USER TRIGGER `db_notarial_office`.`commission_limit_BEFORE_INSERT` 
	BEFORE INSERT ON `deal` 
    FOR EACH ROW
BEGIN
	IF (NEW.commission >= 15.00) THEN
		
        SET NEW.commission = 15.00;
        
	END IF;    
END
$$

DELIMITER ;