DROP DATABASE IF EXISTS Post_Office_by_Nikiforov_Vadim;
CREATE DATABASE Post_Office_by__Nikiforov_Vadim;
USE Post_Office_by_Nikiforov_Vadim;

CREATE TABLE IF NOT EXISTS Customer
(
	id_customer 	INT		 	PRIMARY KEY 	AUTO_INCREMENT,
	first_name	 	CHAR(50)	NOT NULL,
    last_name	 	CHAR(50)	NOT NULL,
    midle_name		CHAR(50)	NOT NULL,
	address	 		CHAR(50)	NOT NULL,
    phone			INT			NOT NULL
);


CREATE TABLE IF NOT EXISTS Editon
(
	id_editon			INT			PRIMARY KEY 	AUTO_INCREMENT,	
	title_editon 		CHAR(50)	NOT NULL,
    quality_editon		INT			NOT NULL,
    cost_editon			INT			NOT NULL
);


CREATE TABLE IF NOT EXISTS Subscription
(
	id_subscription	 	INT		PRIMARY KEY 	AUTO_INCREMENT,	
	date_beg 			DATE	NOT NULL,
    date_end	 		DATE 	NOT NULL,
    delivery			TINYINT NOT NULL
);
# id_customer common key
# id_edition  common key	
# id_edition  common key  
  
CREATE TABLE Employee
(
    id_employee 	INT PRIMARY KEY AUTO_INCREMENT,
	first_name	 	CHAR(50)	NOT NULL,
    last_name	 	CHAR(50)	NOT NULL,
    midle_name		CHAR(50)	NOT NULL,
    phone			INT			NOT NULL
);