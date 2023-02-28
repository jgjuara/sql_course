-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema proyecto_coder
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `proyecto_coder` ;

-- -----------------------------------------------------
-- Schema proyecto_coder
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto_coder` DEFAULT CHARACTER SET utf8 ;
USE `proyecto_coder` ;

-- -----------------------------------------------------
-- Table `proyecto_coder`.`tipo_organismo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`tipo_organismo` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`tipo_organismo` (
  `idtipo_organismo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150) NOT NULL,
  `clase` ENUM('nacional', 'provincial', 'subprovincial') NOT NULL,
  PRIMARY KEY (`idtipo_organismo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`organismo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`organismo` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`organismo` (
  `idorganismo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo_organismo_idtipo_organismo` INT NOT NULL,
  PRIMARY KEY (`idorganismo`, `tipo_organismo_idtipo_organismo`),
  INDEX `fk_organismo_tipo_organismo1_idx` (`tipo_organismo_idtipo_organismo` ASC) VISIBLE,
  CONSTRAINT `fk_organismo_tipo_organismo1`
    FOREIGN KEY (`tipo_organismo_idtipo_organismo`)
    REFERENCES `proyecto_coder`.`tipo_organismo` (`idtipo_organismo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`provincia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`provincia` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`provincia` (
  `idprovincia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `organismo_idorganismo` INT NOT NULL,
  `organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  PRIMARY KEY (`idprovincia`, `organismo_idorganismo`, `organismo_tipo_organismo_idtipo_organismo`),
  INDEX `fk_provincia_organismo1_idx` (`organismo_idorganismo` ASC, `organismo_tipo_organismo_idtipo_organismo` ASC) VISIBLE,
  CONSTRAINT `fk_provincia_organismo1`
    FOREIGN KEY (`organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo`)
    REFERENCES `proyecto_coder`.`organismo` (`idorganismo` , `tipo_organismo_idtipo_organismo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`departamento` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`departamento` (
  `iddepartamento` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `provincia_idprovincia` INT NOT NULL,
  `organismo_idorganismo` INT NOT NULL,
  `organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  PRIMARY KEY (`provincia_idprovincia`, `iddepartamento`, `organismo_idorganismo`, `organismo_tipo_organismo_idtipo_organismo`),
  INDEX `fk_departamento_organismo1_idx` (`organismo_idorganismo` ASC, `organismo_tipo_organismo_idtipo_organismo` ASC) VISIBLE,
  CONSTRAINT `fk_departamento_provincia`
    FOREIGN KEY (`provincia_idprovincia`)
    REFERENCES `proyecto_coder`.`provincia` (`idprovincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departamento_organismo1`
    FOREIGN KEY (`organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo`)
    REFERENCES `proyecto_coder`.`organismo` (`idorganismo` , `tipo_organismo_idtipo_organismo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`entidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`entidad` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`entidad` (
  `identidad` INT NOT NULL,
  `nombre` VARCHAR(150) NOT NULL,
  `departamento_provincia_idprovincia` INT NOT NULL,
  `departamento_iddepartamento` INT NOT NULL,
  `organismo_idorganismo` INT NOT NULL,
  `organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  PRIMARY KEY (`identidad`, `departamento_provincia_idprovincia`, `departamento_iddepartamento`, `organismo_idorganismo`, `organismo_tipo_organismo_idtipo_organismo`),
  INDEX `fk_localidad_departamento1_idx` (`departamento_provincia_idprovincia` ASC, `departamento_iddepartamento` ASC) VISIBLE,
  INDEX `fk_localidad_organismo1_idx` (`organismo_idorganismo` ASC, `organismo_tipo_organismo_idtipo_organismo` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_departamento1`
    FOREIGN KEY (`departamento_provincia_idprovincia` , `departamento_iddepartamento`)
    REFERENCES `proyecto_coder`.`departamento` (`provincia_idprovincia` , `iddepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_localidad_organismo1`
    FOREIGN KEY (`organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo`)
    REFERENCES `proyecto_coder`.`organismo` (`idorganismo` , `tipo_organismo_idtipo_organismo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`usuario` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150) NOT NULL,
  `mail` VARCHAR(150) NOT NULL,
  `cuit` VARCHAR(45) NOT NULL,
  `rol` ENUM('admin', 'cliente') NOT NULL,
  `organismo_idorganismo` INT NOT NULL,
  `organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  `empleados_idempleados` INT NOT NULL,
  PRIMARY KEY (`idusuario`, `organismo_idorganismo`, `organismo_tipo_organismo_idtipo_organismo`, `empleados_idempleados`),
  INDEX `fk_usuario_organismo1_idx` (`organismo_idorganismo` ASC, `organismo_tipo_organismo_idtipo_organismo` ASC) VISIBLE,
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_organismo1`
    FOREIGN KEY (`organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo`)
    REFERENCES `proyecto_coder`.`organismo` (`idorganismo` , `tipo_organismo_idtipo_organismo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`hex500m`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`hex500m` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`hex500m` (
  `idubicacion_normal` INT NOT NULL,
  `hex500pol` POLYGON NOT NULL COMMENT 'crear spatial index',
  PRIMARY KEY (`idubicacion_normal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`hex50m`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`hex50m` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`hex50m` (
  `idubicacion_normal` INT NOT NULL,
  `hex50pol` POLYGON NOT NULL COMMENT 'crear spatial index',
  PRIMARY KEY (`idubicacion_normal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`hex100m`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`hex100m` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`hex100m` (
  `idubicacion_normal` INT NOT NULL,
  `hex100pol` POLYGON NOT NULL COMMENT 'crear spatial index',
  PRIMARY KEY (`idubicacion_normal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`ubicacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`ubicacion` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`ubicacion` (
  `calle_nombre` VARCHAR(200) NOT NULL,
  `calle_altura` INT NOT NULL,
  `piso` INT NOT NULL,
  `dpto` VARCHAR(2) NOT NULL,
  `entre_calle_a` VARCHAR(150) NOT NULL,
  `entre_calle_b` VARCHAR(150) NOT NULL,
  `lat_long` POINT NULL,
  `departamento_provincia_idprovincia` INT NOT NULL,
  `departamento_iddepartamento` INT NOT NULL,
  `departamento_organismo_idorganismo` INT NOT NULL,
  `departamento_organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `usuario_organismo_idorganismo` INT NOT NULL,
  `usuario_organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  `usuario_empleados_idempleados` INT NOT NULL,
  `hex500m_idubicacion_normal` INT NOT NULL,
  `hex50m_idubicacion_normal` INT NOT NULL,
  `hex100m_idubicacion_normal` INT NOT NULL,
  `entidad_identidad` INT NOT NULL,
  `entidad_departamento_provincia_idprovincia` INT NOT NULL,
  `entidad_departamento_iddepartamento` INT NOT NULL,
  `entidad_organismo_idorganismo` INT NOT NULL,
  `entidad_organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  PRIMARY KEY (`calle_nombre`, `calle_altura`, `dpto`, `piso`, `entre_calle_a`, `entre_calle_b`, `departamento_provincia_idprovincia`, `departamento_iddepartamento`, `departamento_organismo_idorganismo`, `departamento_organismo_tipo_organismo_idtipo_organismo`, `usuario_idusuario`, `usuario_organismo_idorganismo`, `usuario_organismo_tipo_organismo_idtipo_organismo`, `usuario_empleados_idempleados`),
  INDEX `fk_ubicacion_departamento1_idx` (`departamento_provincia_idprovincia` ASC, `departamento_iddepartamento` ASC, `departamento_organismo_idorganismo` ASC, `departamento_organismo_tipo_organismo_idtipo_organismo` ASC) VISIBLE,
  INDEX `fk_ubicacion_usuario1_idx` (`usuario_idusuario` ASC, `usuario_organismo_idorganismo` ASC, `usuario_organismo_tipo_organismo_idtipo_organismo` ASC, `usuario_empleados_idempleados` ASC) VISIBLE,
  INDEX `fk_ubicacion_hex500m1_idx` (`hex500m_idubicacion_normal` ASC) VISIBLE,
  INDEX `fk_ubicacion_hex50m1_idx` (`hex50m_idubicacion_normal` ASC) VISIBLE,
  INDEX `fk_ubicacion_hex100m1_idx` (`hex100m_idubicacion_normal` ASC) VISIBLE,
  INDEX `fk_ubicacion_entidad1_idx` (`entidad_identidad` ASC, `entidad_departamento_provincia_idprovincia` ASC, `entidad_departamento_iddepartamento` ASC, `entidad_organismo_idorganismo` ASC, `entidad_organismo_tipo_organismo_idtipo_organismo` ASC) VISIBLE,
  CONSTRAINT `fk_ubicacion_departamento1`
    FOREIGN KEY (`departamento_provincia_idprovincia` , `departamento_iddepartamento` , `departamento_organismo_idorganismo` , `departamento_organismo_tipo_organismo_idtipo_organismo`)
    REFERENCES `proyecto_coder`.`departamento` (`provincia_idprovincia` , `iddepartamento` , `organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ubicacion_usuario1`
    FOREIGN KEY (`usuario_idusuario` , `usuario_organismo_idorganismo` , `usuario_organismo_tipo_organismo_idtipo_organismo` , `usuario_empleados_idempleados`)
    REFERENCES `proyecto_coder`.`usuario` (`idusuario` , `organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo` , `empleados_idempleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ubicacion_hex500m1`
    FOREIGN KEY (`hex500m_idubicacion_normal`)
    REFERENCES `proyecto_coder`.`hex500m` (`idubicacion_normal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ubicacion_hex50m1`
    FOREIGN KEY (`hex50m_idubicacion_normal`)
    REFERENCES `proyecto_coder`.`hex50m` (`idubicacion_normal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ubicacion_hex100m1`
    FOREIGN KEY (`hex100m_idubicacion_normal`)
    REFERENCES `proyecto_coder`.`hex100m` (`idubicacion_normal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ubicacion_entidad1`
    FOREIGN KEY (`entidad_identidad` , `entidad_departamento_provincia_idprovincia` , `entidad_departamento_iddepartamento` , `entidad_organismo_idorganismo` , `entidad_organismo_tipo_organismo_idtipo_organismo`)
    REFERENCES `proyecto_coder`.`entidad` (`identidad` , `departamento_provincia_idprovincia` , `departamento_iddepartamento` , `organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`establecimiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`establecimiento` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`establecimiento` (
  `idestablecimiento` INT NOT NULL AUTO_INCREMENT,
  `establecimientocol` VARCHAR(45) NULL,
  `usuario_idusuario` INT NOT NULL,
  `usuario_organismo_idorganismo` INT NOT NULL,
  `usuario_organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  `usuario_empleados_idempleados` INT NOT NULL,
  `ubicacion_calle_nombre` VARCHAR(200) NOT NULL,
  `ubicacion_calle_altura` INT NOT NULL,
  `ubicacion_dpto` VARCHAR(2) NOT NULL,
  `ubicacion_piso` INT NOT NULL,
  `ubicacion_entre_calle_a` VARCHAR(150) NOT NULL,
  `ubicacion_entre_calle_b` VARCHAR(150) NOT NULL,
  `ubicacion_departamento_provincia_idprovincia` INT NOT NULL,
  `ubicacion_departamento_iddepartamento` INT NOT NULL,
  `ubicacion_departamento_organismo_idorganismo` INT NOT NULL,
  `ubicacion_departamento_organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  `ubicacion_usuario_idusuario` INT NOT NULL,
  `ubicacion_usuario_organismo_idorganismo` INT NOT NULL,
  `ubicacion_usuario_organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  `ubicacion_usuario_empleados_idempleados` INT NOT NULL,
  PRIMARY KEY (`idestablecimiento`, `usuario_idusuario`, `usuario_organismo_idorganismo`, `usuario_organismo_tipo_organismo_idtipo_organismo`, `usuario_empleados_idempleados`),
  INDEX `fk_establecimiento_usuario1_idx` (`usuario_idusuario` ASC, `usuario_organismo_idorganismo` ASC, `usuario_organismo_tipo_organismo_idtipo_organismo` ASC, `usuario_empleados_idempleados` ASC) VISIBLE,
  INDEX `fk_establecimiento_ubicacion1_idx` (`ubicacion_calle_nombre` ASC, `ubicacion_calle_altura` ASC, `ubicacion_dpto` ASC, `ubicacion_piso` ASC, `ubicacion_entre_calle_a` ASC, `ubicacion_entre_calle_b` ASC, `ubicacion_departamento_provincia_idprovincia` ASC, `ubicacion_departamento_iddepartamento` ASC, `ubicacion_departamento_organismo_idorganismo` ASC, `ubicacion_departamento_organismo_tipo_organismo_idtipo_organismo` ASC, `ubicacion_usuario_idusuario` ASC, `ubicacion_usuario_organismo_idorganismo` ASC, `ubicacion_usuario_organismo_tipo_organismo_idtipo_organismo` ASC, `ubicacion_usuario_empleados_idempleados` ASC) VISIBLE,
  CONSTRAINT `fk_establecimiento_usuario1`
    FOREIGN KEY (`usuario_idusuario` , `usuario_organismo_idorganismo` , `usuario_organismo_tipo_organismo_idtipo_organismo` , `usuario_empleados_idempleados`)
    REFERENCES `proyecto_coder`.`usuario` (`idusuario` , `organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo` , `empleados_idempleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_establecimiento_ubicacion1`
    FOREIGN KEY (`ubicacion_calle_nombre` , `ubicacion_calle_altura` , `ubicacion_dpto` , `ubicacion_piso` , `ubicacion_entre_calle_a` , `ubicacion_entre_calle_b` , `ubicacion_departamento_provincia_idprovincia` , `ubicacion_departamento_iddepartamento` , `ubicacion_departamento_organismo_idorganismo` , `ubicacion_departamento_organismo_tipo_organismo_idtipo_organismo` , `ubicacion_usuario_idusuario` , `ubicacion_usuario_organismo_idorganismo` , `ubicacion_usuario_organismo_tipo_organismo_idtipo_organismo` , `ubicacion_usuario_empleados_idempleados`)
    REFERENCES `proyecto_coder`.`ubicacion` (`calle_nombre` , `calle_altura` , `dpto` , `piso` , `entre_calle_a` , `entre_calle_b` , `departamento_provincia_idprovincia` , `departamento_iddepartamento` , `departamento_organismo_idorganismo` , `departamento_organismo_tipo_organismo_idtipo_organismo` , `usuario_idusuario` , `usuario_organismo_idorganismo` , `usuario_organismo_tipo_organismo_idtipo_organismo` , `usuario_empleados_idempleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`datos_funcionales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`datos_funcionales` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`datos_funcionales` (
  `iddatos_funcionales` INT NOT NULL AUTO_INCREMENT,
  `plazas` INT NOT NULL,
  `habitaciones` INT NOT NULL,
  `unidades` INT NOT NULL,
  `sup_cub` INT NOT NULL,
  `sup_desc` INT NOT NULL,
  `vol_pileta` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `usuario_organismo_idorganismo` INT NOT NULL,
  `usuario_organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  `usuario_empleados_idempleados` INT NOT NULL,
  `establecimiento_idestablecimiento` INT NOT NULL,
  `timstamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (`iddatos_funcionales`, `usuario_idusuario`, `usuario_organismo_idorganismo`, `usuario_organismo_tipo_organismo_idtipo_organismo`, `usuario_empleados_idempleados`, `establecimiento_idestablecimiento`),
  INDEX `fk_datos_funcionales_usuario1_idx` (`usuario_idusuario` ASC, `usuario_organismo_idorganismo` ASC, `usuario_organismo_tipo_organismo_idtipo_organismo` ASC, `usuario_empleados_idempleados` ASC) VISIBLE,
  INDEX `fk_datos_funcionales_establecimiento1_idx` (`establecimiento_idestablecimiento` ASC) VISIBLE,
  CONSTRAINT `fk_datos_funcionales_usuario1`
    FOREIGN KEY (`usuario_idusuario` , `usuario_organismo_idorganismo` , `usuario_organismo_tipo_organismo_idtipo_organismo` , `usuario_empleados_idempleados`)
    REFERENCES `proyecto_coder`.`usuario` (`idusuario` , `organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo` , `empleados_idempleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_datos_funcionales_establecimiento1`
    FOREIGN KEY (`establecimiento_idestablecimiento`)
    REFERENCES `proyecto_coder`.`establecimiento` (`idestablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`empleados` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`empleados` (
  `idempleados` INT NOT NULL,
  `permanentes` INT NOT NULL,
  `temporada` INT NOT NULL,
  `timestamp` TIMESTAMP NULL,
  `empleadoscol` VARCHAR(45) NULL,
  `establecimiento_idestablecimiento` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `usuario_organismo_idorganismo` INT NOT NULL,
  `usuario_organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  `usuario_empleados_idempleados` INT NOT NULL,
  PRIMARY KEY (`idempleados`, `establecimiento_idestablecimiento`, `usuario_idusuario`, `usuario_organismo_idorganismo`, `usuario_organismo_tipo_organismo_idtipo_organismo`, `usuario_empleados_idempleados`),
  INDEX `fk_empleados_establecimiento1_idx` (`establecimiento_idestablecimiento` ASC) VISIBLE,
  INDEX `fk_empleados_usuario1_idx` (`usuario_idusuario` ASC, `usuario_organismo_idorganismo` ASC, `usuario_organismo_tipo_organismo_idtipo_organismo` ASC, `usuario_empleados_idempleados` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_establecimiento1`
    FOREIGN KEY (`establecimiento_idestablecimiento`)
    REFERENCES `proyecto_coder`.`establecimiento` (`idestablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_usuario1`
    FOREIGN KEY (`usuario_idusuario` , `usuario_organismo_idorganismo` , `usuario_organismo_tipo_organismo_idtipo_organismo` , `usuario_empleados_idempleados`)
    REFERENCES `proyecto_coder`.`usuario` (`idusuario` , `organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo` , `empleados_idempleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`funcionamiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`funcionamiento` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`funcionamiento` (
  `estado` ENUM('abierto', 'temporalmente cerrado', 'permanentemente cerrado') NOT NULL,
  `fecha_desde` DATE NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  `idfuncionamiento` INT NOT NULL AUTO_INCREMENT,
  `usuario_idusuario` INT NOT NULL,
  `usuario_organismo_idorganismo` INT NOT NULL,
  `usuario_organismo_tipo_organismo_idtipo_organismo` INT NOT NULL,
  `establecimiento_idestablecimiento` INT NOT NULL,
  `fecha_hasta` DATE NULL,
  PRIMARY KEY (`idfuncionamiento`, `usuario_idusuario`, `usuario_organismo_idorganismo`, `usuario_organismo_tipo_organismo_idtipo_organismo`, `establecimiento_idestablecimiento`),
  INDEX `fk_funcionamiento_usuario1_idx` (`usuario_idusuario` ASC, `usuario_organismo_idorganismo` ASC, `usuario_organismo_tipo_organismo_idtipo_organismo` ASC) VISIBLE,
  INDEX `fk_funcionamiento_establecimiento1_idx` (`establecimiento_idestablecimiento` ASC) VISIBLE,
  CONSTRAINT `fk_funcionamiento_usuario1`
    FOREIGN KEY (`usuario_idusuario` , `usuario_organismo_idorganismo` , `usuario_organismo_tipo_organismo_idtipo_organismo`)
    REFERENCES `proyecto_coder`.`usuario` (`idusuario` , `organismo_idorganismo` , `organismo_tipo_organismo_idtipo_organismo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionamiento_establecimiento1`
    FOREIGN KEY (`establecimiento_idestablecimiento`)
    REFERENCES `proyecto_coder`.`establecimiento` (`idestablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_coder`.`callejero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_coder`.`callejero` ;

CREATE TABLE IF NOT EXISTS `proyecto_coder`.`callejero` (
  `FID` INT NOT NULL,
  PRIMARY KEY (`FID`))
ENGINE = InnoDB
COMMENT = 'bulk upload del callejero de datos.gob.ar';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
