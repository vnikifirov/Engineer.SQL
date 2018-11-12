CREATE VIEW v_get_data_client_and_discounts_DESC AS 
	SELECT 
		client.first_name,
		client.last_name,
		discount.type,
		discount.discount
    FROM 
		db_notarial_office.deal
			RIGHT JOIN db_notarial_office.client  ON
				deal.id_client_fk = client.id_client_pk         
			LEFT JOIN db_notarial_office.discount ON
					deal.id_discount_fk = discount.id_discount_pk
	ORDER BY discount.discount DESC;
    
    
    