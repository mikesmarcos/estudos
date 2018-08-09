-- MySQL Script generated by MySQL Workbench
-- Wed Aug  8 16:29:39 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema default_schema
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sistemahx
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sistemahx` ;

-- -----------------------------------------------------
-- Schema sistemahx
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sistemahx` DEFAULT CHARACTER SET utf8 ;
USE `sistemahx` ;

-- -----------------------------------------------------
-- Table `roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roles` ;

CREATE TABLE IF NOT EXISTS `roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users` ;

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` CHAR(128) NOT NULL,
  `salt` CHAR(128) NOT NULL,
  `role_id` INT NOT NULL,
  `status` INT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  CONSTRAINT `users_role_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `users_role_id_idx` ON `users` (`role_id` ASC) ;

CREATE INDEX `users_role_id` ON `users` (`role_id` ASC) ;


-- -----------------------------------------------------
-- Table `login_attempts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `login_attempts` ;

CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `user_id`),
  CONSTRAINT `login_attempts_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `login_attempts_user_id_idx` ON `login_attempts` (`user_id` ASC) ;

CREATE INDEX `login_attempts_user_id` ON `login_attempts` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `recoveries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recoveries` ;

CREATE TABLE IF NOT EXISTS `recoveries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `status` INT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `user_id`),
  CONSTRAINT `passwords_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `passwords_user_id_idx` ON `recoveries` (`user_id` ASC) ;

CREATE INDEX `passwords_user_id` ON `recoveries` (`user_id` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;