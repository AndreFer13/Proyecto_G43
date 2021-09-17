-- MySQL Script generated by MySQL Workbench
-- Thu Sep 16 23:51:13 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema proyectoC3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyectoC3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyectoC3` DEFAULT CHARACTER SET utf8 ;
USE `proyectoC3` ;

-- -----------------------------------------------------
-- Table `proyectoC3`.`empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoC3`.`empresa` ;

CREATE TABLE IF NOT EXISTS `proyectoC3`.`empresa` (
  `idempresa` INT NOT NULL AUTO_INCREMENT,
  `nit` VARCHAR(11) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(11) NULL,
  `correo` VARCHAR(50) NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `ciudad` VARCHAR(60) NOT NULL,
  `departamento` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idempresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyectoC3`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoC3`.`rol` ;

CREATE TABLE IF NOT EXISTS `proyectoC3`.`rol` (
  `idrol` INT NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyectoC3`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoC3`.`usuario` ;

CREATE TABLE IF NOT EXISTS `proyectoC3`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(100) NULL,
  `telefono` VARCHAR(11) NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `sexo` VARCHAR(45) NOT NULL,
  `rol_idrol` INT NOT NULL,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_rol1_idx` (`rol_idrol` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_rol1`
    FOREIGN KEY (`rol_idrol`)
    REFERENCES `proyectoC3`.`rol` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyectoC3`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoC3`.`categoria` ;

CREATE TABLE IF NOT EXISTS `proyectoC3`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyectoC3`.`servicio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoC3`.`servicio` ;

CREATE TABLE IF NOT EXISTS `proyectoC3`.`servicio` (
  `idservicio` INT NOT NULL AUTO_INCREMENT,
  `servicio` VARCHAR(45) NOT NULL,
  `categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`idservicio`),
  INDEX `fk_servicio_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  CONSTRAINT `fk_servicio_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `proyectoC3`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyectoC3`.`empresaservicio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoC3`.`empresaservicio` ;

CREATE TABLE IF NOT EXISTS `proyectoC3`.`empresaservicio` (
  `idempresaservicio` INT NOT NULL AUTO_INCREMENT,
  `duracion` INT NOT NULL DEFAULT 0,
  `precio` DECIMAL NOT NULL DEFAULT 0,
  `estado` VARCHAR(45) NOT NULL,
  `empresa_idempresa` INT NOT NULL,
  `servicio_idservicio` INT NOT NULL,
  PRIMARY KEY (`idempresaservicio`),
  INDEX `fk_empresaservicios_empresa1_idx` (`empresa_idempresa` ASC) VISIBLE,
  INDEX `fk_empresaservicios_servicio1_idx` (`servicio_idservicio` ASC) VISIBLE,
  CONSTRAINT `fk_empresaservicios_empresa1`
    FOREIGN KEY (`empresa_idempresa`)
    REFERENCES `proyectoC3`.`empresa` (`idempresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empresaservicios_servicio1`
    FOREIGN KEY (`servicio_idservicio`)
    REFERENCES `proyectoC3`.`servicio` (`idservicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyectoC3`.`agenda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoC3`.`agenda` ;

CREATE TABLE IF NOT EXISTS `proyectoC3`.`agenda` (
  `idagenta` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `estado` VARCHAR(45) NULL,
  `usuario_idcliente` INT NOT NULL,
  PRIMARY KEY (`idagenta`),
  INDEX `fk_agenta_usuario1_idx` (`usuario_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_agenta_usuario1`
    FOREIGN KEY (`usuario_idcliente`)
    REFERENCES `proyectoC3`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyectoC3`.`agendaservicio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoC3`.`agendaservicio` ;

CREATE TABLE IF NOT EXISTS `proyectoC3`.`agendaservicio` (
  `idagendaservicio` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(45) NOT NULL,
  `agenda_idagenta` INT NOT NULL,
  `empresaservicio_idempresaservicio` INT NOT NULL,
  PRIMARY KEY (`idagendaservicio`),
  INDEX `fk_agendaservicio_agenta1_idx` (`agenda_idagenta` ASC) VISIBLE,
  INDEX `fk_agendaservicio_empresaservicio1_idx` (`empresaservicio_idempresaservicio` ASC) VISIBLE,
  CONSTRAINT `fk_agendaservicio_agenta1`
    FOREIGN KEY (`agenda_idagenta`)
    REFERENCES `proyectoC3`.`agenda` (`idagenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_agendaservicio_empresaservicio1`
    FOREIGN KEY (`empresaservicio_idempresaservicio`)
    REFERENCES `proyectoC3`.`empresaservicio` (`idempresaservicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyectoC3`.`factura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoC3`.`factura` ;

CREATE TABLE IF NOT EXISTS `proyectoC3`.`factura` (
  `idfactura` INT NOT NULL,
  `codigo` VARCHAR(10) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `usuario_idcliente` INT NOT NULL,
  PRIMARY KEY (`idfactura`),
  INDEX `fk_factura_usuario1_idx` (`usuario_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_factura_usuario1`
    FOREIGN KEY (`usuario_idcliente`)
    REFERENCES `proyectoC3`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyectoC3`.`detallefactura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoC3`.`detallefactura` ;

CREATE TABLE IF NOT EXISTS `proyectoC3`.`detallefactura` (
  `iddetallefactura` INT NOT NULL AUTO_INCREMENT,
  `duracion` INT NOT NULL,
  `valor` DECIMAL NOT NULL,
  `factura_idfactura` INT NOT NULL,
  `agendaservicio_idagendaservicio` INT NOT NULL,
  PRIMARY KEY (`iddetallefactura`),
  INDEX `fk_detallefactura_factura1_idx` (`factura_idfactura` ASC) VISIBLE,
  INDEX `fk_detallefactura_agendaservicio1_idx` (`agendaservicio_idagendaservicio` ASC) VISIBLE,
  CONSTRAINT `fk_detallefactura_factura1`
    FOREIGN KEY (`factura_idfactura`)
    REFERENCES `proyectoC3`.`factura` (`idfactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detallefactura_agendaservicio1`
    FOREIGN KEY (`agendaservicio_idagendaservicio`)
    REFERENCES `proyectoC3`.`agendaservicio` (`idagendaservicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
