Delimiter $$

CREATE PROCEDURE spGet_client_by_range_discount (
		IN valueFrom DECIMAL,
		IN valueTo DECIMAL)
	 
	BEGIN			
	
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
			tour.discount
		HAVING 
			tour.discount BETWEEN valueFrom  AND valueTo;

	END
$$

Delimiter ;

# [ Make a test query ]
CALL spGet_client_by_range_discount(14.00, 15.00);