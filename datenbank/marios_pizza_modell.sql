-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE,
    SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Schema marios_pizza_modell

CREATE SCHEMA IF NOT EXISTS `marios_pizza_modell`
DEFAULT CHARACTER SET utf8;

USE `marios_pizza_modell`;

-- Table kategorie

CREATE TABLE IF NOT EXISTS `marios_pizza_modell`.`kategorie` (
  `kategorie_id` INT NOT NULL AUTO_INCREMENT,
  `bezeichnung` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`kategorie_id`)
)
ENGINE = InnoDB;

-- Table artikel

CREATE TABLE IF NOT EXISTS `marios_pizza_modell`.`artikel` (
  `artikel_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `beschreibung` VARCHAR(120) NULL,
  `preis` DECIMAL(6,2) NOT NULL,
  `kategorie_id` INT NOT NULL,
  PRIMARY KEY (`artikel_id`),
  INDEX `fk_artikel_kategorie_idx` (`kategorie_id` ASC),
  CONSTRAINT `fk_artikel_kategorie`
    FOREIGN KEY (`kategorie_id`)
    REFERENCES `marios_pizza_modell`.`kategorie` (`kategorie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- Table kunde

CREATE TABLE IF NOT EXISTS `marios_pizza_modell`.`kunde` (
  `kunde_id` INT NOT NULL AUTO_INCREMENT,
  `vorname` VARCHAR(40) NOT NULL,
  `nachname` VARCHAR(40) NOT NULL,
  `telefon` VARCHAR(20) NULL,
  `strasse` VARCHAR(60) NULL,
  `plz` VARCHAR(10) NULL,
  `ort` VARCHAR(40) NULL,
  PRIMARY KEY (`kunde_id`)
)
ENGINE = InnoDB;

-- Table bestellung

CREATE TABLE IF NOT EXISTS `marios_pizza_modell`.`bestellung` (
  `bestell_id` INT NOT NULL AUTO_INCREMENT,
  `bestelldatum` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lieferart` VARCHAR(15) NOT NULL,
  `kunde_id` INT NOT NULL,
  PRIMARY KEY (`bestell_id`),
  INDEX `fk_bestellung_kunde1_idx` (`kunde_id` ASC),
  CONSTRAINT `fk_bestellung_kunde1`
    FOREIGN KEY (`kunde_id`)
    REFERENCES `marios_pizza_modell`.`kunde` (`kunde_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- Table bestellposition

CREATE TABLE IF NOT EXISTS `marios_pizza_modell`.`bestellposition` (
  `menge` INT NOT NULL DEFAULT 1,
  `bestell_id` INT NOT NULL,
  `artikel_id` INT NOT NULL,
  PRIMARY KEY (`bestell_id`, `artikel_id`),
  INDEX `fk_bestellposition_artikel1_idx` (`artikel_id` ASC),
  CONSTRAINT `fk_bestellposition_bestellung1`
    FOREIGN KEY (`bestell_id`)
    REFERENCES `marios_pizza_modell`.`bestellung` (`bestell_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bestellposition_artikel1`
    FOREIGN KEY (`artikel_id`)
    REFERENCES `marios_pizza_modell`.`artikel` (`artikel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;