-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema db_notarial_office
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_notarial_office
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_notarial_office` DEFAULT CHARACTER SET utf8 ;
USE `db_notarial_office` ;

-- -----------------------------------------------------
-- Table `db_notarial_office`.`client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_notarial_office`.`client` ;

CREATE TABLE IF NOT EXISTS `db_notarial_office`.`client` (
  `id_client_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` CHAR(15) NOT NULL,
  `last_name` CHAR(15) NOT NULL,
  `middle_name` CHAR(15) NOT NULL,
  `id_address_fk` INT UNSIGNED NOT NULL,
  `phone` CHAR(15) NOT NULL,
  PRIMARY KEY (`id_client_pk`));


-- -----------------------------------------------------
-- Table `db_notarial_office`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_notarial_office`.`address` ;

CREATE TABLE IF NOT EXISTS `db_notarial_office`.`address` (
  `id_address_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `street` CHAR(40) UNICODE NOT NULL,
  `house_number` CHAR(6) UNICODE NOT NULL,
  PRIMARY KEY (`id_address_pk`),
  CONSTRAINT `fk_address_client`
    FOREIGN KEY (`id_address_pk`)
    REFERENCES `db_notarial_office`.`client` (`id_client_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `db_notarial_office`.`deal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_notarial_office`.`deal` ;

CREATE TABLE IF NOT EXISTS `db_notarial_office`.`deal` (
  `id_deal_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_client_fk` INT UNSIGNED NOT NULL,
  `data` TEXT NOT NULL,
  `total_price` DECIMAL(10,2) UNSIGNED NOT NULL,
  `commission` DECIMAL(10,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_deal_pk`),
  INDEX `fk_deal_client1_idx` (`id_client_fk` ASC),
  CONSTRAINT `fk_deal_client1`
    FOREIGN KEY (`id_client_fk`)
    REFERENCES `db_notarial_office`.`client` (`id_client_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_notarial_office`.`discount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_notarial_office`.`discount` ;

CREATE TABLE IF NOT EXISTS `db_notarial_office`.`discount` (
  `id_discount_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_deal_fk` INT UNSIGNED NOT NULL,
  `discount` DECIMAL(10,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_discount_pk`),
  INDEX `fk_discount_deal1_idx` (`id_deal_fk` ASC),
  CONSTRAINT `fk_discount_deal1`
    FOREIGN KEY (`id_deal_fk`)
    REFERENCES `db_notarial_office`.`deal` (`id_deal_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_notarial_office`.`service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_notarial_office`.`service` ;

CREATE TABLE IF NOT EXISTS `db_notarial_office`.`service` (
  `id_service_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_deal_fk` INT UNSIGNED NOT NULL,
  `description` TEXT NOT NULL,
  `price` DECIMAL(10,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_service_pk`),
  INDEX `fk_service_deal1_idx` (`id_deal_fk` ASC),
  CONSTRAINT `fk_service_deal1`
    FOREIGN KEY (`id_deal_fk`)
    REFERENCES `db_notarial_office`.`deal` (`id_deal_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
