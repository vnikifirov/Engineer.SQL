# Показать информацию о туре, дате начала, дате окончания поездки, стоимость и id клиента с отелем
CREATE VIEW v_showPriceAndDurationTrips AS
	SELECT
		tour.id_tour_pk,
        tour.date_start,
        bill.date_end,
		bill.price,
        tour.id_client_fk,
        tour.id_hotel_fk
	FROM
		hotel JOIN tour ON 
			hotel.id_hotel_pk = tour.id_tour_pk
		JOIN bill ON 
			hotel.id_hotel_pk = bill.id_hotel_pk;	
			