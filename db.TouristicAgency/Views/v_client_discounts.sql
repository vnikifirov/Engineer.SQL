# Вывести информацию о клиенте и о предоставляемой скидке.
CREATE VIEW v_client_discount AS 
	SELECT
		CONCAT(
			client.first_name, ' ',
			client.last_name
		) AS 'Client',
		
		tour.discount
		
	FROM
		tour JOIN client ON
			tour.id_client_fk = client.id_client_pk
	GROUP BY
		tour.discount;