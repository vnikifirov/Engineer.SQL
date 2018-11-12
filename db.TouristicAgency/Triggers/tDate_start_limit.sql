DELIMITER $$

CREATE DEFINER = CURRENT_USER TRIGGER `db_travel agents`.`date_limit_BEFORE_INSERT`
	BEFORE INSERT ON `tour` 
	FOR EACH ROW
BEGIN
	IF (NEW.date_start >= NOW())
    THEN
    
		INSERT INTO `travel agents`.`tour` (
			date_start,
            discount,
            id_hotel_fk,
            id_client_fk)
		VALUES (
			NEW.date_start,
            NEW.discount,
            NEW.id_hotel_fk,
            NEW.id_client_fk);
            
	END IF;
END
$$

DELIMITER ;