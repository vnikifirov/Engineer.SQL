DROP PROCEDURE spGet_client_hotel_by_name;

Delimiter $$

# Получить информацию о клиенте по фамилии, имени и категорию и цену отеля.
CREATE PROCEDURE spGet_client_hotel_by_name (
	IN inClient_name CHAR(48))
	BEGIN			        
        # START OF SELECT STATMENT    
		SELECT
			CONCAT(
				client.first_name, ' ',
				client.last_name
			) AS 'client',
			            
			hotel.hotel_name, 
			hotel.cotegory,            
			vData.price
				
		FROM
			v_showpriceanddurationtrips vData
				JOIN hotel ON
					vData.id_hotel_fk = hotel.id_hotel_pk
				JOIN client ON 
					vData.id_client_fk = client.id_client_pk
		WHERE CONCAT(
				client.first_name, 
				client.last_name,
				client.middle_name) 
				LIKE inClient_name
		GROUP BY
			vData.price
		ORDER BY
			vData.price DESC;
        # END OF SELECT STATMENT    
        
	END
$$

Delimiter ;

CALL spGet_client_hotel_by_name('%Осипов%');