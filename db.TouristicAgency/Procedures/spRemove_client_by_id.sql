START TRANSACTION;

	USE `Travel Agents`;

	DROP PROCEDURE IF EXISTS `remove_client_by_id`;

	Delimiter $$	
    
	CREATE PROCEDURE `remove_client_by_id` (
		 IN id_client INT,
         OUT status CHAR(50))
		 
		BEGIN			
        
			DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
			BEGIN 	
				SET status = "Remove operation wasn't executed";										
			END;
        
			DELETE FROM `Travel Agents`.`client`
			WHERE id_client_pk LIKE id_client;																	
			
			SET status = "Changes was successful";			
			SELECT status;			
		END
	$$

	Delimiter ;

ROLLBACK;