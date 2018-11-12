DROP TRIGGER IF EXISTS `db_notarial_office`.`date_limit_BEFORE_INSERT` ;

DELIMITER $$

CREATE TRIGGER `db_notarial_office`.`date_limit_BEFORE_INSERT`
	BEFORE INSERT ON `db_notarial_office`.`deal`
	FOR EACH ROW
BEGIN
	IF (NEW.date < NOW()) THEN
		
        SET NEW.date = NOW();
        
	END IF;
    
END
$$

DELIMITER ;