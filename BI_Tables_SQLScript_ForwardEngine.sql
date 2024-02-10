-- MySQL Script genrated by MySQL Workbench
-- Sat Feb 11 11:02:03 2023
-- Model: New Model   Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `AddressID` BIGINT NOT NULL,
  `AddressLine1` VARCHAR(255) NULL,
  `AddressLine2` VARCHAR(255) NULL,
  `City` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  `Zipcode` INT NULL,
  PRIMARY KEY (`AddressID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `CustomerID` BIGINT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `PhoneNo` BIGINT NULL,
  `Email` VARCHAR(255) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CustomerAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CustomerAddress` (
  `CustomerID` BIGINT NOT NULL,
  `AddressID` BIGINT NOT NULL,
  PRIMARY KEY (`CustomerID`, `AddressID`),
  INDEX `AddressID_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AddressID`
    FOREIGN KEY (`AddressID`)
    REFERENCES `mydb`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CustomerPayment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CustomerPayment` (
  `PaymentID` BIGINT NOT NULL,
  `CustomerID` BIGINT NOT NULL,
  PRIMARY KEY (`PaymentID`, `CustomerID`),
  INDEX `fk_CustomerPayment_Customer1_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_CustomerPayment_Payment1`
    FOREIGN KEY (`PaymentID`)
    REFERENCES `mydb`.`Payment` (`PaymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CustomerPayment_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DeliveryDriver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DeliveryDriver` (
  `DriverID` BIGINT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `PhoneNo` BIGINT NULL,
  `VehicleType` VARCHAR(45) NULL,
  `DriversLicenseNo` VARCHAR(60) NULL,
  `DriverRate` FLOAT NULL,
  PRIMARY KEY (`DriverID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Menu` (
  `MenuID` BIGINT NOT NULL,
  `RestaurantID` BIGINT NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `fk_Menu_Restaurant1_idx` (`RestaurantID` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_Restaurant1`
    FOREIGN KEY (`RestaurantID`)
    REFERENCES `mydb`.`Restaurant` (`RestaurantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MenuItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MenuItem` (
  `MenuItemID` BIGINT NOT NULL,
  `MenuID` BIGINT NOT NULL,
  `ItemName` VARCHAR(255) NULL,
  `UnitPrice` FLOAT NULL,
  `ItemDescription` TEXT NULL,
  `InStock` TINYINT(1) NULL,
  PRIMARY KEY (`MenuItemID`),
  INDEX `fk_MenuItem_Menu1_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `fk_MenuItem_Menu1`
    FOREIGN KEY (`MenuID`)
    REFERENCES `mydb`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order` (
  `OrderID` BIGINT NOT NULL,
  `RestaurantID` BIGINT NOT NULL,
  `CustomerID` BIGINT NOT NULL,
  `DriverID` BIGINT NOT NULL,
  `PaymentID` BIGINT NOT NULL,
  `Date` VARCHAR(255) NOT NULL,
  `TotalAmount` FLOAT NULL,
  `Tips` FLOAT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Order_DeliveryDriver1_idx` (`DriverID` ASC) VISIBLE,
  INDEX `fk_Order_Restaurant1_idx` (`RestaurantID` ASC) VISIBLE,
  INDEX `fk_Order_Customer1_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_Order_Payment1_idx` (`PaymentID` ASC) VISIBLE,
  CONSTRAINT `fk_Order_DeliveryDriver1`
    FOREIGN KEY (`DriverID`)
    REFERENCES `mydb`.`DeliveryDriver` (`DriverID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Restaurant1`
    FOREIGN KEY (`RestaurantID`)
    REFERENCES `mydb`.`Restaurant` (`RestaurantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Payment1`
    FOREIGN KEY (`PaymentID`)
    REFERENCES `mydb`.`Payment` (`PaymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderLine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderLine` (
  `OrderID` BIGINT NOT NULL,
  `MenuItemID` BIGINT NOT NULL,
  `ItemQuantity` INT NULL,
  `Price` FLOAT NULL,
  PRIMARY KEY (`OrderID`, `MenuItemID`),
  INDEX `fk_OrderLine_MenuItem1_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `fk_OrderLine_Order1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `mydb`.`Order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderLine_MenuItem1`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `mydb`.`MenuItem` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `PaymentID` BIGINT NOT NULL,
  `PaymentMethod` VARCHAR(45) NULL,
  `PaymentNumber` MEDIUMTEXT NULL,
  PRIMARY KEY (`PaymentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Restaurant` (
  `RestaurantID` BIGINT NOT NULL,
  `AddressID` BIGINT NULL,
  `Name` VARCHAR(255) NULL,
  `CuisineType` VARCHAR(45) NULL,
  `CommissionRate` FLOAT NULL,
  PRIMARY KEY (`RestaurantID`),
  INDEX `AddressID_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `AddressID1`
    FOREIGN KEY (`AddressID`)
    REFERENCES `mydb`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Review` (
  `ReviewID` BIGINT NOT NULL,
  `OrderID` BIGINT NOT NULL,
  `Review` INT NULL,
  PRIMARY KEY (`ReviewID`),
  INDEX `fk_Review_Order1_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_Review_Order1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `mydb`.`Order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
