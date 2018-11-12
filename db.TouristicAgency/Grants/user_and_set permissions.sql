START TRANSACTION;
	
    # Create a new use 
	CREATE USER 'user1'@'localhost' IDENTIFIED BY '123';
    # Set a permision SELECT
	GRANT SELECT ON `db_travel agents`. v_client_discount TO 'user1'@'localhost';
    # Acept change
    FLUSH PRIVILEGES;

ROLLBACK;
COMMIT;