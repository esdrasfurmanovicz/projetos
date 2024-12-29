-- MySQL Script generated by MySQL Workbench
-- Sat Apr 27 14:45:19 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema blog
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema blog
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blog` DEFAULT CHARACTER SET utf8 ;
USE `blog` ;

-- -----------------------------------------------------
-- Table `blog`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blog`.`usuario` (
  `id` INT NOT NULL,
  `perfil` ENUM("adm", "regular", "autor") NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(65) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `sobrenome` VARCHAR(100) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `biografia` VARCHAR(500) NULL,
  `foto_perfil` BLOB NULL,
  `data_inclusao` DATETIME NOT NULL,
  `data_alteracao` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blog`.`postagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blog`.`postagem` (
  `id` INT NOT NULL,
  `titulo` VARCHAR(255) NOT NULL,
  `conteudo` LONGBLOB NOT NULL,
  `keywords` VARCHAR(255) NULL,
  `data_inclusao` DATETIME NOT NULL,
  `data_alteracao` DATETIME NULL,
  `inclusao_usuario_id` INT NOT NULL,
  `alteracao_usuario_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_postagens_usuarios_idx` (`inclusao_usuario_id` ASC) ,
  INDEX `fk_postagens_usuarios1_idx` (`alteracao_usuario_id` ASC) ,
  CONSTRAINT `fk_postagens_usuarios`
    FOREIGN KEY (`inclusao_usuario_id`)
    REFERENCES `blog`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_postagens_usuarios1`
    FOREIGN KEY (`alteracao_usuario_id`)
    REFERENCES `blog`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blog`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blog`.`comentario` (
  `id` INT NOT NULL,
  `comentario` VARCHAR(100) NULL,
  `comentario_id` INT NOT NULL,
  `postagem_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `data_inclusao` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentario_comentario1_idx` (`comentario_id` ASC) ,
  INDEX `fk_comentario_postagens1_idx` (`postagem_id` ASC) ,
  INDEX `fk_comentario_usuarios1_idx` (`usuario_id` ASC) ,
  CONSTRAINT `fk_comentario_comentario1`
    FOREIGN KEY (`comentario_id`)
    REFERENCES `blog`.`comentario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentario_postagens1`
    FOREIGN KEY (`postagem_id`)
    REFERENCES `blog`.`postagem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentario_usuarios1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `blog`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;