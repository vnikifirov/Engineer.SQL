#3 Вывести сделки, которые были составлены в промежутке с и до.

Delimiter $$

CREATE PROCEDURE spDeal_between_timespan (
		IN from_period DATE,
		IN to_period DATE)
	 
	BEGIN			
		
		SELECT 
			*
		FROM 
			db_notarial_office.deal
		WHERE
			deal.date BETWEEN from_period AND to_period;

END
$$

Delimiter ;