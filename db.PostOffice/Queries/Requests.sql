USE post_office;
SHOW TABLES;

#1 Request (The list of all employees)
SELECT 
	emp.first_name 			AS 'Frist Name',
	emp.last_name 			AS 'Last Name',
	emp.serviced_addresses 	AS'Service Address' 
FROM 
	employee emp;

#2 Request (People who living on the street Sadovaya)
SELECT 
	c.first_name 	AS 'Frist Name',
	c.last_name  	AS 'Last Name',
	c.phone 		AS 'Contact number',
	c.address 		AS 'Domicile'
FROM 
	customer c
WHERE 
	c.address LIKE "%Sadovaya%";

#3 Request (Employees serving the address of the people who live there)
SELECT 
    emp.id_employee		 	AS 'Employee',
    emp.first_name 		 	AS 'Fisrt Name',
    emp.last_name  		 	AS 'Last Name',
    emp.serviced_addresses  AS 'Service Address',
    c.id_customer 			AS 'Customer',
    c.first_name 			AS 'Frist Name',
	c.last_name  			AS 'Last Name',
    c.address				AS 'Domicile'
FROM
    employee emp,
    customer c
WHERE
    emp.serviced_addresses LIKE '%Lenina%'
        AND c.address LIKE '%Lenina%';


#4 Request (Conditions: TimeSpan: 2016-03-01' and '2016-05-06; Need of delevery is true; Subscripted isn't end.)
SELECT 
	c.id_customer 	AS 'Signed',
	c.first_name 	AS 'Frist Name',
	c.last_name  	AS 'Last Name',
	e.title_edition AS 'Subscripted edition',
	sub.date_beg 	AS 'Beginning subscription',
	sub.date_end 	AS 'End subscription',
	sub.delivery 	AS 'Delivery'
FROM 
	subscription sub 
	JOIN customer c
		ON sub.id_customer = c.id_customer
	JOIN edition e
		ON e.id_edition = sub.id_edition
WHERE 
	sub.date_beg BETWEEN '2016-03-01' AND '2016-12-06' 
	AND 
		sub.delivery != 0 
	AND 
		CURRENT_DATE() < sub.date_end;

#5 Request (Counting the numbers of signs)
SELECT 
	e.id_edition		  	AS 'ID',
	e.title_edition    	  	AS 'Name edition',
	e.city 					AS 'City',
	COUNT(sub.id_customer)	AS 'Numbers of signs'
FROM 
	subscription sub
		INNER JOIN edition e 
			ON sub.id_edition = e.id_edition
	GROUP BY e.id_edition;


#6 Request (Editon is lactating in Kazan)
SELECT 
	e.id_edition		  	AS 'ID',
	e.title_edition    	  	AS 'Name edition',
	e.city 					AS 'City',
	COUNT(sub.id_customer) 	AS 'Numbers of signs',
	emp.id_employee		 	AS 'Employee',
	emp.first_name 		 	AS 'Fisrt Name',
	emp.last_name  		 	AS 'Last Name'
FROM
	subscription sub
		INNER JOIN edition e 
			ON sub.id_edition = e.id_edition
		INNER JOIN employee emp 
			ON sub.id_employee = emp.id_employee
WHERE 
	e.city LIKE 'Kazan'
		GROUP BY e.id_edition;

#7 Request (Subscripted date is less than to now day)
SELECT 
	sub.id_subscription 	AS 'ID Subscription',
	sub.date_beg 			AS 'Beginning subscription',
	sub.date_end	 		AS 'End subscription',
	sub.delivery 			AS 'Delivery',
	sub.id_edition 			AS 'ID Edition',
	sub.id_employee 		AS 'ID Employee',
	sub.id_customer 		AS 'ID Customer'
FROM
	subscription sub
WHERE
	sub.date_end <= CURRENT_DATE();

#8 Request (Most expensive price from edition)
SELECT 
	e.id_edition 			AS 'ID edition',
	e.title_edition 		AS 'Name edition',
	MAX(e.price_edition) 	AS 'Most expensive price',
	e.city 					AS 'Location'
FROM 
	edition e;

#9 Request (Don't need to delivery of subscription and Price, descending order by price)
SELECT 
	c.first_name 		AS 'Signed',
	e.title_edition 	AS 'Subscription',
	sub.delivery 		AS 'Delivery',
	e.price_edition 	AS 'Price' 
FROM subscription sub
	JOIN customer c 
		ON sub.id_customer = c.id_customer
	JOIN edition e
		ON e.id_edition = sub.id_edition
WHERE
	sub.delivery = 0
		ORDER BY e.price_edition DESC; 

#10 Request ('Long subscription')
SELECT 
	c.id_customer	 	  AS 'ID signed',
	c.first_name      	  AS 'Frist Name',
	c.address 		 	  AS 'Domicile',
	e.title_edition  	  AS 'Name edition',
	sub.date_beg 		  AS 'Beginning subscription',
	sub.date_end 		  AS 'End subscription',
	emp.id_employee    	  AS 'ID employee',
	emp.first_name 	 	  AS 'Fisrt Name'
FROM 
	subscription sub
	JOIN customer c 
		ON sub.id_customer = c.id_customer
    JOIN edition e 
		ON sub.id_edition = e.id_edition
    JOIN employee emp
		ON sub.id_employee = emp.id_employee
WHERE 
	sub.date_end IN(
		SELECT 
			MAX(sub.date_end) 
        FROM 
			subscription sub
	);

#11 Request (Range the cost of subscription, between 80 and 90)
SELECT c.first_name 		AS 'Signed',
	   e.title_edition 		AS 'Subscription',
       e.price_edition 		AS 'Price in range 80-90'
FROM subscription sub
	JOIN customer c
		ON sub.id_customer = c.id_customer
	JOIN edition e
		ON e.id_edition = sub.id_edition
WHERE
	e.price_edition BETWEEN 80 AND 90;
        
#12 Request (Short Subscription)
SELECT
		c.first_name 		AS 'First Name',
		c.last_name 		AS 'Last Name',
		sub.date_end	 	AS 'Short Subscription'
FROM 
	subscription sub
		JOIN customer c 
			ON c.id_customer = sub.id_customer
WHERE 
	sub.date_end IN( 
		SELECT 
			MIN(sub.date_end) 
		FROM 
			subscription sub
        WHERE
			sub.date_end > CURRENT_DATE()
	);