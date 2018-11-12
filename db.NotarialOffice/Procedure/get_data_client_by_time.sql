#8 Вывести адрес, телефон и ФИО клиента, который заключил договор в [ TIME ]

Delimiter $$

CREATE PROCEDURE spGet_data_client_by_time (
		IN timecase DATE)
BEGIN			
	
	SELECT 
		CONCAT(
			client.id_client_pk, ', ',
			client.first_name, ', ',
			client.last_name
		) AS 'Client',
		
		client.phone AS 'Phone Number',
		
		CONCAT(
			address.id_address_pk, ', ',
			address.street, ', ',
			address.house_number
		) AS 'Address'
		FROM 
			address
		WHERE
			address.id_address_pk IN (
				SELECT 
					client.id_address_fk
				FROM 
					db_notarial_office.client
						JOIN db_notarial_office.deal ON
							client.id_client_pk = deal.id_client_fk
				WHERE
					deal.date LIKE timecase
			);
END
$$

Delimiter ;