DELIMITER $$

CREATE DEFINER = CURRENT_USER TRIGGER `db_travel agents`.`bill_BEFORE_INSERT`
	BEFORE INSERT ON `bill` 
    FOR EACH ROW
BEGIN
	# Members
	DECLARE mDate_start TIMESTAMP;
    
    # Query
    SELECT 
		tour.date_start
	INTO 
		mDate_start
	FROM
		tour
	WHERE
		NEW.id_hotel_pk LIKE tour.id_hotel_fk;

	# Ограничение длительность поездки не превышает 4 недели.
	IF (NEW.date_end >= mDate_start AND 
		NEW.date_end <= DATE_ADD( 
							CURRENT_TIMESTAMP(),
							INTERVAL 4 WEEK ))
    THEN
    # Make Insert
		INSERT INTO `travel agents`.`bill` (
			id_hotel_pk,
            date_end,
            price)
		VALUES (
			NEW.id_hotel_pk,
			NEW.date_end,
            NEW.price);
            
	END IF;
    
END
$$

DELIMITER ;

# [ Test : Try add of a new time of end trip ]
START TRANSACTION;

	INSERT INTO 
		`db_travel agents`.`bill` (`id_bill_pk`, `id_hotel_pk`, `date_end`, `price`) 
	VALUES 
		('5', '5', '2017-05-12 00:00:00', '13497.00');

ROLLBACK;