# Вывести информацию о отелях и о количестве клиентов проживающих в нем.
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_numbers_clients_in_hotel` AS
    SELECT 
        `hotel`.`hotel_name` AS `hotel_name`,
        COUNT(`tour`.`id_client_fk`) AS `Num Clients`
    FROM
        (`hotel`
        JOIN `tour`)
    WHERE
        (`tour`.`id_hotel_fk` LIKE `hotel`.`id_hotel_pk`)
    GROUP BY `hotel`.`hotel_name`