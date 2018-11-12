DELIMITER $$

#  Если удалить клиента, то и сделка тоже будет удалена.
CREATE DEFINER = CURRENT_USER TRIGGER `db_notarial_office`.`client_BEFORE_DELETE` 
	BEFORE DELETE ON `client` 
    FOR EACH ROW
BEGIN    
	DELETE FROM `db_notarial_office`.deal
	WHERE deal.id_client_fk = OLD.id_cleint_pk;
END
$$

DELIMITER ;