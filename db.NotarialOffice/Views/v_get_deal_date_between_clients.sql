#7 Вывести дату сделки, который был составлен между клиентами
CREATE VIEW v_get_deal_date_between_clients AS
	SELECT 
		client.first_name,
		client.last_name,
		deal.date
	FROM 
		db_notarial_office.deal
			JOIN db_notarial_office.client ON
				deal.id_client_fk = client.id_client_pk;
                
                
                