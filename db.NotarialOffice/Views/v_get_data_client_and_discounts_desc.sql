CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `db_notarial_office`.`v_get_data_client_and_discounts_desc` AS
    SELECT 
        `db_notarial_office`.`client`.`first_name` AS `first_name`,
        `db_notarial_office`.`client`.`last_name` AS `last_name`,
        `db_notarial_office`.`discount`.`type` AS `type`,
        `db_notarial_office`.`discount`.`discount` AS `discount`
    FROM
        ((`db_notarial_office`.`client`
        LEFT JOIN `db_notarial_office`.`deal` ON ((`db_notarial_office`.`deal`.`id_client_fk` = `db_notarial_office`.`client`.`id_client_pk`)))
        LEFT JOIN `db_notarial_office`.`discount` ON ((`db_notarial_office`.`deal`.`id_discount_fk` = `db_notarial_office`.`discount`.`id_discount_pk`)))
    ORDER BY `db_notarial_office`.`discount`.`discount` DESC