

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema e-commerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema e-commerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `e-commerce` DEFAULT CHARACTER SET utf8 ;
USE `e-commerce` ;

-- -----------------------------------------------------
-- Table `e-commerce`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`Clientes` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `bdate` DATE NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `adress` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-commerce`.`Dealer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`Dealer` (
  `idDealer` INT NOT NULL,
  `FName` VARCHAR(45) NOT NULL,
  `CPNJ` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `adress` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idDealer`),
  UNIQUE INDEX `CPNJ_UNIQUE` (`CPNJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-commerce`.`Envios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`Envios` (
  `idEnvios` INT NOT NULL AUTO_INCREMENT,
  `Status` ENUM("Aberto", "Enviado", "Entregue") NOT NULL DEFAULT 'Aberto',
  `Cod_rastreio` VARCHAR(45) NULL,
  `Pedidos_idPedido` INT NOT NULL,
  `Pedidos_Clientes_idCliente` INT NOT NULL,
  PRIMARY KEY (`idEnvios`, `Pedidos_idPedido`, `Pedidos_Clientes_idCliente`),
  INDEX `fk_Envios_Pedidos1_idx` (`Pedidos_idPedido` ASC, `Pedidos_Clientes_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Envios_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedido` , `Pedidos_Clientes_idCliente`)
    REFERENCES `e-commerce`.`Pedidos` (`idPedido` , `Clientes_Cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-commerce`.`Pagamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`Pagamentos` (
  `idPagamentos` INT NOT NULL AUTO_INCREMENT,
  `Pagamentos_status` ENUM("Aberto", "Pago", "Cancelado") NOT NULL DEFAULT 'Aberto',
  `Pedidos_idPedido` INT NOT NULL,
  `Pedidos_Clientes_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPagamentos`, `Pedidos_idPedido`, `Pedidos_Clientes_idCliente`),
  INDEX `fk_Pagamentos_Pedidos1_idx` (`Pedidos_idPedido` ASC, `Pedidos_Clientes_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamentos_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedido` , `Pedidos_Clientes_idCliente`)
    REFERENCES `e-commerce`.`Pedidos` (`idPedido` , `Clientes_Cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-commerce`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`Pedidos` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `data_pedido` DATETIME NOT NULL,
  `Liberado` TINYINT NOT NULL DEFAULT 0 COMMENT '0 - não liberado\n1 - liberado',
  `Descricao` VARCHAR(45) NULL,
  `Clientes_Cliente_id` INT NOT NULL,
  `Envios_idEnvios` INT NULL,
  `Valor` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idPedido`, `Clientes_Cliente_id`, `Envios_idEnvios`),
  INDEX `fk_Pedidos_Clientes_idx` (`Clientes_Cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Clientes`
    FOREIGN KEY (`Clientes_Cliente_id`)
    REFERENCES `e-commerce`.`Clientes` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-commerce`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`Produto` (
  `idProduto` INT NOT NULL,
  `Description` VARCHAR(45) NULL,
  `Valor` FLOAT NOT NULL DEFAULT 0,
  `Dealer_idDealer` INT NOT NULL,
  `Category` VARCHAR(45) NULL,
  `Status` ENUM("Disponivel", "Indisponivel") NOT NULL DEFAULT 'Disponivel',
  PRIMARY KEY (`idProduto`, `Dealer_idDealer`),
  INDEX `fk_Produto_Dealer1_idx` (`Dealer_idDealer` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Dealer1`
    FOREIGN KEY (`Dealer_idDealer`)
    REFERENCES `e-commerce`.`Dealer` (`idDealer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-commerce`.`Produto do pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`Produto do pedido` (
  `Pedidos_idPedido` INT NOT NULL,
  `Produto_Produto_id` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  `Produto do pedidocol` ENUM("Em andamento", "Pronto", "Enviado") NOT NULL DEFAULT '\"Em Andamento\"',
  PRIMARY KEY (`Pedidos_idPedido`, `Produto_Produto_id`),
  INDEX `fk_Pedidos_has_Produto_Produto1_idx` (`Produto_Produto_id` ASC) VISIBLE,
  INDEX `fk_Pedidos_has_Produto_Pedidos1_idx` (`Pedidos_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_has_Produto_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedido`)
    REFERENCES `e-commerce`.`Pedidos` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_has_Produto_Produto1`
    FOREIGN KEY (`Produto_Produto_id`)
    REFERENCES `e-commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-commerce`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-commerce`.`Stock` (
  `Produto_idProduto` INT NOT NULL,
  `Quant` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Produto_idProduto`),
  CONSTRAINT `fk_Stock_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `e-commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
