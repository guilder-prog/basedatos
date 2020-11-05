-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema empresa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema empresa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `empresa` DEFAULT CHARACTER SET utf8 ;
USE `empresa` ;

-- -----------------------------------------------------
-- Table `empresa`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`category` (
  `id_category` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_category`),
  UNIQUE INDEX `id_categoria_UNIQUE` (`id_category` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`provider` (
  `id_provider` INT NOT NULL,
  `company_name` VARCHAR(50) NOT NULL,
  `phone` INT(9) NOT NULL,
  PRIMARY KEY (`id_provider`),
  UNIQUE INDEX `id_provider_UNIQUE` (`id_provider` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`product` (
  `id_product` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `stock` INT NULL,
  `price` DOUBLE NULL,
  `category_id_category` INT NOT NULL,
  `provider_id_provider` INT NOT NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE INDEX `id_producto_UNIQUE` (`id_product` ASC) VISIBLE,
  INDEX `fk_product_category1_idx` (`category_id_category` ASC) VISIBLE,
  INDEX `fk_product_provider1_idx` (`provider_id_provider` ASC) VISIBLE,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_id_category`)
    REFERENCES `empresa`.`category` (`id_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_provider1`
    FOREIGN KEY (`provider_id_provider`)
    REFERENCES `empresa`.`provider` (`id_provider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`employee` (
  `id_employee` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `employee_id_employee` INT NOT NULL,
  PRIMARY KEY (`id_employee`),
  UNIQUE INDEX `id_employee_UNIQUE` (`id_employee` ASC) VISIBLE,
  INDEX `fk_employee_employee1_idx` (`employee_id_employee` ASC) VISIBLE,
  CONSTRAINT `fk_employee_employee1`
    FOREIGN KEY (`employee_id_employee`)
    REFERENCES `empresa`.`employee` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`client` (
  `id_client` INT NOT NULL,
  `company_name` VARCHAR(50) NOT NULL,
  `contact_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE INDEX `id_client_UNIQUE` (`id_client` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`transport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`transport` (
  `id_transport` INT NOT NULL,
  `company_name` VARCHAR(50) NOT NULL,
  `phone` INT(9) NOT NULL,
  PRIMARY KEY (`id_transport`),
  UNIQUE INDEX `id_transport_UNIQUE` (`id_transport` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`order` (
  `id_order` INT NOT NULL,
  `employee_id_employee` INT NOT NULL,
  `client_id_client` INT NOT NULL,
  `transport_id_transport` INT NOT NULL,
  `date_order` DATE NOT NULL,
  PRIMARY KEY (`id_order`),
  UNIQUE INDEX `id_pedido_UNIQUE` (`id_order` ASC) VISIBLE,
  INDEX `fk_order_employee1_idx` (`employee_id_employee` ASC) VISIBLE,
  INDEX `fk_order_client1_idx` (`client_id_client` ASC) VISIBLE,
  INDEX `fk_order_transport1_idx` (`transport_id_transport` ASC) VISIBLE,
  CONSTRAINT `fk_order_employee1`
    FOREIGN KEY (`employee_id_employee`)
    REFERENCES `empresa`.`employee` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_client1`
    FOREIGN KEY (`client_id_client`)
    REFERENCES `empresa`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_transport1`
    FOREIGN KEY (`transport_id_transport`)
    REFERENCES `empresa`.`transport` (`id_transport`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`product_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`product_order` (
  `quantity` INT NOT NULL,
  `discount` INT NOT NULL,
  `unit_price` DOUBLE NOT NULL DEFAULT 0,
  `order_id_order` INT NOT NULL,
  `product_id_product` INT NOT NULL,
  PRIMARY KEY (`order_id_order`, `product_id_product`),
  INDEX `fk_product_order_product1_idx` (`product_id_product` ASC) VISIBLE,
  CONSTRAINT `fk_product_order_order1`
    FOREIGN KEY (`order_id_order`)
    REFERENCES `empresa`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_order_product1`
    FOREIGN KEY (`product_id_product`)
    REFERENCES `empresa`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
