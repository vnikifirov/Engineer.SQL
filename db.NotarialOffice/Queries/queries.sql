#1 Вывести на экран таблицу скидок
SELECT 
	*
FROM db_notarial_office.discount;

#2 Вывести ФИО клиента, который живет на улице Калинина
SELECT 
	client.first_name,
    client.last_name,
    client.middle_name
FROM 
	db_notarial_office.client
WHERE
	client.id_address_fk IN (
		SELECT 
			id_address_pk
        FROM 
			address
        WHERE
			address.street LIKE 'Калинина'
	);

#3 Вывести сделки, которые были составлены в промежутке с '2017-01-01' до '2017-03-21'
SELECT 
	*
FROM 
	db_notarial_office.deal
WHERE
	deal.date BETWEEN '2017-01-01' AND '2017-03-21';

    
#4 Вывести номера телефонов клиентов, у которых фамилия начинается на "И"
SELECT 
	client.phone
FROM 
	db_notarial_office.client
WHERE
	client.first_name LIKE 'И%';
    

#5 Вывести максимальную скидку
SELECT
	discount.id_discount_pk,
    discount.type,
	discount.discount AS 'Max Discount'  
FROM 
	db_notarial_office.discount
WHERE discount.discount IN (
		SELECT MAX(discount)
        FROM discount
	);
    
    
#6 Вывести сумму за услугу по удостоверения займ
SELECT 
	SUM(s.price) AS 'TOTAL Удостоверение займа'
FROM 
	db_notarial_office.deal d
		JOIN db_notarial_office.service s ON
			d.id_service_fk = s.id_service_pk
WHERE
	s.name LIKE 'Удостоверение займа';
    
#7 Вывести дату сделки, который был составлен между клиентом Ермаковым    
SELECT 
	client.first_name,
    client.last_name,
	deal.date
FROM 
	db_notarial_office.deal
		JOIN db_notarial_office.client ON
			deal.id_client_fk = client.id_client_pk
WHERE
	client.first_name LIKE 'Ермаков';


#8 Вывести адрес клиента, который заключил договор в '2017-04-25'
SELECT 
	address.id_address_pk,
	address.street,
    address.house_number
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
			deal.date LIKE '2017-04-25'
	);


#9 Вывести сумму сделки и комиссионные, между клиентом 'Уваров'
SELECT 
	client.first_name,
    client.last_name,
	deal.deal_price,
    deal.commission
FROM 
	db_notarial_office.deal
		JOIN db_notarial_office.client ON
			deal.id_client_fk = client.id_client_pk
WHERE
	client.first_name LIKE 'Уваров';
    
#10 Вывести вид скидки, который был предоставлен клиенту Осипову Алексею
SELECT 
	client.first_name,
    client.last_name,
	discount.type
FROM 
	db_notarial_office.deal
		JOIN db_notarial_office.client  ON
				deal.id_client_fk = client.id_client_pk
		JOIN db_notarial_office.discount ON
				deal.id_discount_fk = discount.id_discount_pk            
WHERE
	client.first_name LIKE 'Осипов' AND
    client.last_name LIKE 'Алексей';