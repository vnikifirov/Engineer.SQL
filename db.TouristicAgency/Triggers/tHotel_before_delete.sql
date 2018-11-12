USE `travel agents`;

# [ If you wonna remove a trigger ]
DROP TRIGGER hotel_before_delete;

DELIMITER $$

# [ Create of a new instance TRIGGER object ]
CREATE
	TRIGGER hotel_before_delete BEFORE DELETE 
		ON `db_travel agents`.`hotel`
		FOR EACH ROW
    BEGIN
    
		DELETE FROM `travel agents`.bill
        WHERE bill.id_hotel_pk = OLD.id_hotel_pk;
    
		DELETE FROM `travel agents`.tour
        WHERE tour.id_hotel_fk = OLD.id_hotel_pk;
    
    END;
$$

DELIMITER ;

# [ Test : Try remove of an one of hotels ]
START TRANSACTION;

	DELETE FROM `travel agents`.hotel
	WHERE hotel.id_hotel_pk = 1;

ROLLBACK;