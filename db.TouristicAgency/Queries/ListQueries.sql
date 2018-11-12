# 1 Вернуть дату въезда / выезда для клиента из отеля и использовать view
SELECT
	client.first_name,
    client.last_name,
    
    CONCAT(
		date_start, ' / ',
        date_end
    ) AS 'Departure/Return'
FROM
	v_showPriceAndDurationTrips, client
WHERE
	client.id_client_pk IN (
		SELECT id_client_fk
		FROM v_showPriceAndDurationTrips
    );
	
#2 В каких отелях живут клиенты, группировать по цене и упорядочить по убыванию
SELECT 
    CONCAT(
		client.first_name, ' ',
		client.last_name
    ) AS 'Client',
    
    hotel.hotel_name,
    vData.price
    
FROM
	v_showpriceanddurationtrips vData
		JOIN hotel ON
			vData.id_hotel_fk = hotel.id_hotel_pk
        JOIN client ON 
			vData.id_client_fk = client.id_client_pk
GROUP BY
	vData.price
ORDER BY
	vData.price DESC;

# 3 Получить фамилию, имя клиента 'Николай Осипов' и категорию и цену отеля.
SELECT
	CONCAT(
		client.first_name, ' ',
		client.last_name
	) AS 'Client',
				
	hotel.hotel_name,
	hotel.cotegory,
	vData.price
	
FROM
	v_showpriceanddurationtrips vData
		JOIN hotel ON
			vData.id_hotel_fk = hotel.id_hotel_pk
		JOIN client ON 
			vData.id_client_fk = client.id_client_pk
WHERE
	client.first_name LIKE 'Николай' AND
	client.last_name LIKE 'Осипов'
GROUP BY
	vData.price
ORDER BY
	vData.price DESC;
    
# 4 Клиенты проживающие в 3х звездочном отеле
SELECT
	CONCAT(
		client.first_name, ' ',
		client.last_name
	) AS 'Client',				
	hotel.hotel_name,
	hotel.cotegory	
FROM
	v_showpriceanddurationtrips vData
		JOIN hotel ON
			vData.id_hotel_fk = hotel.id_hotel_pk
		JOIN client ON 
			vData.id_client_fk = client.id_client_pk
WHERE
	hotel.cotegory = 4;
    
# 5 Количество клиентов в отеле
SELECT
	hotel.hotel_name,
    COUNT(tour.id_client_fk) AS 'Num Clients'
FROM
	hotel, tour
WHERE
	tour.id_hotel_fk LIKE hotel.id_hotel_pk
GROUP BY
	hotel.hotel_name;


    
# 6 Информация о клиентах имеющих скидку 10 - 15 %
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
	tour.discount BETWEEN 10.00 AND 15.00;
	
# 7 Получить информацию о клиенте ФИО и дату въезда выезда и название отеля
SELECT
	CONCAT(
		client.first_name, ' ',
		client.last_name, ' ',
        client.middle_name
    ) AS 'Client',

	vData.date_start,
    vData.date_end,
    hotel.hotel_name
FROM
	v_showpriceanddurationtrips vData 
		JOIN client ON vData.id_client_fk = client.id_client_pk
        JOIN hotel ON vData.id_hotel_fk = hotel.id_hotel_pk;
        
# 8 Получить среднюю скидку проживания для туров в Ярославль
SELECT
	hotel.hotel_name,
    address.city,
    AVG(tour.discount) AS 'AVG Price'
FROM
	tour JOIN hotel ON
		tour.id_hotel_fk = hotel.id_hotel_pk
    JOIN address ON
		hotel.id_address_hotel_fk = address.id_address_pk
	JOIN bill ON
		hotel.id_hotel_pk = bill.id_hotel_pk
	
WHERE
	address.city LIKE 'Ярославль'
GROUP BY 
	hotel.hotel_name,
    address.city;
    
# 9 Получить колчиество туров в Ярославль
SELECT
    COUNT(address.city) AS 'Numbers Tours in Ярославль'
FROM
	tour JOIN hotel ON
		tour.id_hotel_fk = hotel.id_hotel_pk
    JOIN address ON
		hotel.id_address_hotel_fk = address.id_address_pk
	JOIN bill ON
		hotel.id_hotel_pk = bill.id_hotel_pk
WHERE
	address.city LIKE 'Ярославль';
    
#5 Вывести максимальную скидку
SELECT
	MAX(tour.discount) AS 'Max Discount'  
FROM 
	`db_travel agents`.tour;