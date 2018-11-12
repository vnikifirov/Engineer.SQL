INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('1', 'Россия', 'Нижний Новгород', 'Ульянова', '26', '606440');
INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('2', 'Россия', 'Санкт-Петербург', 'Журналистов', '2а', '198326');
INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('3', 'Россия', 'Челябинск', 'проспект Победы', '42', '42800');
INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('4', 'Россия', 'Казань', 'Чистопольская', '55', '420000');
INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('5', 'Россия', 'Владивосток', 'Бондаренко', '519', '121500');
INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('6', 'Россия', 'Екатеринбург', 'проспект Мира', '6', '624330');
INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('7', 'Россия', 'Нижний Новгород', 'Ульянова', '6', '606390');
INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('8', 'Россия', 'Ярославль', 'Которосльная набережная', '26', '152020');
INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('9', 'Россия', 'Санкт-Петербург', 'Садовая', '22/2', '197729');
INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('10', 'Россия', 'Москва', 'Измайловское шоссе', '71', '117623');
INSERT INTO `db_travel agents`.`address` (`id_address_pk`, `country`, `city`, `street`, `house_number`, `zip`) VALUES ('11', 'Россия', 'Казань', 'Петербургская', '1', '420080');


INSERT INTO `db_travel agents`.`client` (`id_client_pk`, `first_name`, `last_name`, `middle_name`, `phone`, `id_address_client_fk`) VALUES ('1', 'Николай', 'Осипов', 'Иванович', '7-987-205-03-01', '2');
INSERT INTO `db_travel agents`.`client` (`id_client_pk`, `first_name`, `last_name`, `middle_name`, `phone`, `id_address_client_fk`) VALUES ('2', 'Татьяна', 'Николаева', 'Сергеевна', '7-987-430-08-60', '3');
INSERT INTO `db_travel agents`.`client` (`id_client_pk`, `first_name`, `last_name`, `middle_name`, `phone`, `id_address_client_fk`) VALUES ('3', 'Андрей', 'Матвеев', 'Семенович', '7-917-892-79-17', '4');
INSERT INTO `db_travel agents`.`client` (`id_client_pk`, `first_name`, `last_name`, `middle_name`, `phone`, `id_address_client_fk`) VALUES ('4', 'Наталья', 'Спиридонова', 'Юрьевна', '7-917-262-39-99', '5');
INSERT INTO `db_travel agents`.`client` (`id_client_pk`, `first_name`, `last_name`, `middle_name`, `phone`, `id_address_client_fk`) VALUES ('5', 'Алексей', 'Андреев', 'Валерьевич', '7-905-377-33-38', '6');


INSERT INTO `db_travel agents`.`hotel` (`id_hotel_pk`, `hotel_name`, `cotegory`, `id_address_hotel_fk`) VALUES ('1', 'Монарх', '3', '7');
INSERT INTO `db_travel agents`.`hotel` (`id_hotel_pk`, `hotel_name`, `cotegory`, `id_address_hotel_fk`) VALUES ('2', 'Юбилейная', '4', '8');
INSERT INTO `db_travel agents`.`hotel` (`id_hotel_pk`, `hotel_name`, `cotegory`, `id_address_hotel_fk`) VALUES ('3', 'Majestic Boutique Hotel Deluxe', '5', '9');
INSERT INTO `db_travel agents`.`hotel` (`id_hotel_pk`, `hotel_name`, `cotegory`, `id_address_hotel_fk`) VALUES ('4', 'Измайлово Дельта', '5', '10');
INSERT INTO `db_travel agents`.`hotel` (`id_hotel_pk`, `hotel_name`, `cotegory`, `id_address_hotel_fk`) VALUES ('5', 'Гранд Отель', '4', '11');


INSERT INTO `db_travel agents`.`bill` (`id_bill_pk`, `id_hotel_pk`, `date_end`, `price`) VALUES ('1', '1', '2017-01-24 00:00:00', '19501.00');
INSERT INTO `db_travel agents`.`bill` (`id_bill_pk`, `id_hotel_pk`, `date_end`, `price`) VALUES ('2', '2', '2017-04-04 00:00:00', '30694.00');
INSERT INTO `db_travel agents`.`bill` (`id_bill_pk`, `id_hotel_pk`, `date_end`, `price`) VALUES ('3', '3', '2017-05-16 00:00:00', '25550.00');
INSERT INTO `db_travel agents`.`bill` (`id_bill_pk`, `id_hotel_pk`, `date_end`, `price`) VALUES ('4', '4', '2017-07-27 00:00:00', '45550.00');
INSERT INTO `db_travel agents`.`bill` (`id_bill_pk`, `id_hotel_pk`, `date_end`, `price`) VALUES ('5', '5', '2017-06-18 00:00:00', '13497.00');



INSERT INTO `db_travel agents`.`tour` (`id_tour_pk`, `date_start`, `discount`, `id_hotel_fk`, `id_client_fk`) VALUES ('1', '2017-01-08 00:00:00', '5.00', '1', '1');
INSERT INTO `db_travel agents`.`tour` (`id_tour_pk`, `date_start`, `discount`, `id_hotel_fk`, `id_client_fk`) VALUES ('2', '2017-03-28 00:00:00', '15.00', '2', '2');
INSERT INTO `db_travel agents`.`tour` (`id_tour_pk`, `date_start`, `discount`, `id_hotel_fk`, `id_client_fk`) VALUES ('3', '2017-05-08 00:00:00', '10.00', '3', '3');
INSERT INTO `db_travel agents`.`tour` (`id_tour_pk`, `date_start`, `discount`, `id_hotel_fk`, `id_client_fk`) VALUES ('4', '2017-07-09 00:00:00', '12.00', '4', '4');
INSERT INTO `db_travel agents`.`tour` (`id_tour_pk`, `date_start`, `discount`, `id_hotel_fk`, `id_client_fk`) VALUES ('5', '2017-05-12 00:00:00', '15.00', '5', '5');
