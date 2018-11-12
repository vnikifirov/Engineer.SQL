DELIMITER $$;

CREATE DEFINER=`root`@`localhost` PROCEDURE `spPlace_tour`(
	 IN id_hotel INT,
	 IN id_client INT,
	 IN date_start TIMESTAMP,         
	 IN date_end TIMESTAMP,
	 IN price DECIMAL,
	 IN discount DECIMAL,	
	 OUT status CHAR(6))
BEGIN			
		
	DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
	BEGIN 					

		ROLLBACK;           			
		SET status = "Failed";
		SELECT status;	

	END;

	START TRANSACTION;			

	INSERT 
		INTO `travel agents`.`tour` (
			date_start,
			discount,
			id_hotel_fk,
			id_client_fk)
		VALUES (
			date_start,
			discount,
			id_hotel,
			id_client);

	INSERT 
		INTO `travel agents`.`bill` (
			id_hotel_pk,
			date_end,
			price)
		VALUES (
			id_hotel,
			date_end,
			price);	
		
	COMMIT;        
	SET status = 'OK';
	SELECT status;

END
$$

DELIMITER ;
