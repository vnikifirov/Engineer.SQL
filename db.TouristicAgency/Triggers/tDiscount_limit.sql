DELIMITER &&

CREATE TRIGGER `travel agents`.`discount_limit_BEFORE_INSERT`
	BEFORE INSERT ON `db_travel agents`.`tour`
	FOR EACH ROW
BEGIN
	IF (NEW.discount >= 35)
    THEN
		
        SET NEW.discount = 35;
        
	END IF;
END
$$

DELIMITER ;