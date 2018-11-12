    Delimiter $$

	#10 Вывести вид скидки, который был предоставлен клиенту по ФИО
	CREATE PROCEDURE spGet_discount_by_name (
			IN client_full_name CHAR(32))
		BEGIN						
        
			SELECT 
				CONCAT(
					client.first_name, ' ',
					client.last_name, ' ',
					client.middle_name
				) AS 'Client',
				discount.type,
				discount.discount AS 'Persentase'
			FROM 
				db_notarial_office.deal
					JOIN db_notarial_office.client  ON
							deal.id_client_fk = client.id_client_pk
					JOIN db_notarial_office.discount ON
							deal.id_discount_fk = discount.id_discount_pk            
			WHERE
				CONCAT(
					client.first_name, ' ',
					client.last_name, ' ',
					client.middle_name) LIKE client_full_name;
	END
$$

Delimiter ;