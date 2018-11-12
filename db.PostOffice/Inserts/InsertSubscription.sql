SELECT * FROM post_office.subscription;

INSERT INTO subscription VALUES
	(1, current_date(), "2016-12-31", 0, 5, 1, 1),
	(2, "2016-05-06", current_date(), 1, 2, 1, 8),
	(3, current_date(), "2017-02-15", 1, 3, 2, 5),
	(4, "2016-03-01", "2017-02-15", 0, 2, 2, 2),
    (5, current_date(), "2016-12-31", 1, 1, 3, 3),
	(6, "2016-05-06", current_date(), 0, 3, 3, 6),
	(7, current_date(), "2017-05-11", 1, 4, 4, 4),
	(8, "2016-03-01", "2017-02-15", 0, 5, 4, 7);