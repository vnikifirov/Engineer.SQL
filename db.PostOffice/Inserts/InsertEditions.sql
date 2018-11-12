SELECT * FROM post_office.edition;
   
ALTER TABLE edition
ADD city char(75); # I think so will be a few of better;)
   
INSERT INTO edition VALUES
	(1, 'DMK-Press', 95, 'Moscow'),
	(2, 'SPB-Peterburg', 90, 'Peterburg'),
	(3, 'Agenda', 88, 'Moscow'),
	(4, 'Arguments and Facts', 96, 'Kazan'),
    (5, 'Karavan Stories', 99, 'Kazan');

    