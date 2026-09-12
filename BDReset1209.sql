-- ============================================================
-- CORETRACE - RESET / REBUILD COMPLETO
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;
SET UNIQUE_CHECKS = 0;

DROP DATABASE IF EXISTS `coretrace`;

CREATE DATABASE `coretrace`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci
  DEFAULT ENCRYPTION='N';

USE `coretrace`;

-- ============================================================
-- TABELAS
-- ============================================================

-- Tabela: empresa
CREATE TABLE `empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `cnpj` char(14) NOT NULL,
  `codigo` char(16) NOT NULL,
  `dt_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_ultimo_contrato` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_empresa`),
  UNIQUE KEY `cnpj` (`cnpj`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: papeis
CREATE TABLE `papeis` (
  `id_papeis` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `nivel_papel` int DEFAULT NULL,
  PRIMARY KEY (`id_papeis`),
  CONSTRAINT `chk_papeis` CHECK ((`tipo` in ('GESTOR','FUNCIONARIO')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: setores
CREATE TABLE `setores` (
  `id_setores` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(80) NOT NULL,
  `empresa` int NOT NULL,
  `dt_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_fim` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_setores`),
  UNIQUE KEY `nome` (`nome`,`empresa`),
  KEY `fk_setores_empresa` (`empresa`),
  CONSTRAINT `fk_setores_empresa` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: servidores
CREATE TABLE `servidores` (
  `id_servidor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `setor` int NOT NULL,
  `dt_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_fim` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_servidor`),
  KEY `fk_servidores_setores` (`setor`),
  CONSTRAINT `fk_servidores_setores` FOREIGN KEY (`setor`) REFERENCES `setores` (`id_setores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: maquina
CREATE TABLE `maquina` (
  `id_maquina` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `codigo` char(16) NOT NULL,
  `dt_inicio` datetime DEFAULT CURRENT_TIMESTAMP,
  `dt_fim` datetime DEFAULT NULL,
  `servidor` int NOT NULL,
  PRIMARY KEY (`id_maquina`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `fk_maquina_servidor` (`servidor`),
  CONSTRAINT `fk_maquina_servidor` FOREIGN KEY (`servidor`) REFERENCES `servidores` (`id_servidor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: usuarios
CREATE TABLE `usuarios` (
  `id_usuarios` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `papel` int NOT NULL,
  `cadastrado` int DEFAULT NULL,
  `empresa` int NOT NULL,
  `dt_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_retirada` timestamp NULL DEFAULT NULL,
  `dt_ultimo_login` timestamp NULL DEFAULT NULL,
  `atividade` tinyint DEFAULT '1',
  `passkey` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_usuarios`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `passkey` (`passkey`),
  KEY `fk_usuarios_papeis` (`papel`),
  KEY `fk_usuarios_cadastrado_por` (`cadastrado`),
  KEY `fk_usuarios_empresa` (`empresa`),
  CONSTRAINT `fk_usuarios_cadastrado_por` FOREIGN KEY (`cadastrado`) REFERENCES `usuarios` (`id_usuarios`),
  CONSTRAINT `fk_usuarios_empresa` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`id_empresa`),
  CONSTRAINT `fk_usuarios_papeis` FOREIGN KEY (`papel`) REFERENCES `papeis` (`id_papeis`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: componentes
CREATE TABLE `componentes` (
  `id_componentes` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `maquina` int NOT NULL,
  `dt_adicao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_retirada` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_componentes`),
  KEY `fk_maquina_componentes` (`maquina`),
  CONSTRAINT `fk_maquina_componentes` FOREIGN KEY (`maquina`) REFERENCES `maquina` (`id_maquina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: parametros
CREATE TABLE `parametros` (
  `id_parametro` int NOT NULL AUTO_INCREMENT,
  `nome_parametro` varchar(45) DEFAULT NULL,
  `valor_parametro` double DEFAULT NULL,
  `dt_adicao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_retirada` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_parametro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: parametros_componentes
CREATE TABLE `parametros_componentes` (
  `parametros` int NOT NULL,
  `componente` int NOT NULL,
  `dt_adicao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_retirada` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`parametros`,`componente`),
  KEY `fk_componente` (`componente`),
  CONSTRAINT `fk_componente` FOREIGN KEY (`componente`) REFERENCES `componentes` (`id_componentes`),
  CONSTRAINT `fk_parametros` FOREIGN KEY (`parametros`) REFERENCES `parametros` (`id_parametro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: acessos_servidor
CREATE TABLE `acessos_servidor` (
  `usuario` int NOT NULL,
  `servidor` int NOT NULL,
  `concedido_por` int NOT NULL,
  `dt_concessao` datetime DEFAULT CURRENT_TIMESTAMP,
  `dt_acesso` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_retirada` timestamp NULL DEFAULT NULL,
  `maquina` int NOT NULL,
  PRIMARY KEY (`usuario`,`servidor`, `maquina`),
  KEY `fk_acessos_servidores` (`servidor`),
  KEY `fk_acessos_concedido_por` (`concedido_por`),
  KEY `fk_maquina` (`maquina`),
  CONSTRAINT `fk_acessos_concedido_por` FOREIGN KEY (`concedido_por`) REFERENCES `usuarios` (`id_usuarios`),
  CONSTRAINT `fk_acessos_servidores` FOREIGN KEY (`servidor`) REFERENCES `servidores` (`id_servidor`),
  CONSTRAINT `fk_acessos_usuarios` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id_usuarios`),
  CONSTRAINT `fk_maquina` FOREIGN KEY (`maquina`) REFERENCES `maquina` (`id_maquina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ============================================================
-- VIEWS
-- ============================================================

DROP VIEW IF EXISTS `vw_detalhes_acessos_servidor`;

CREATE VIEW `vw_detalhes_acessos_servidor` AS 
SELECT 
  `u`.`id_usuarios` AS `id_usuario`,
  `u`.`nome` AS `nome_usuario`,
  `st`.`id_setores` AS `id_setor`,
  `st`.`nome` AS `nome_setor`,
  `sv`.`id_servidor` AS `id_servidor`,
  `sv`.`nome` AS `nome_servidor`,
  `m`.`id_maquina` AS `id_maquina`,
  `m`.`nome` AS `nome_maquina`,
  `m`.`codigo` AS `codigo_maquina`,
  `m`.`dt_inicio` AS `dt_inicio_maquina`,
  `m`.`dt_fim` AS `dt_fim_maquina` 
FROM `servidores` `sv`
LEFT JOIN `setores` `st` 
  ON `st`.`id_setores` = `sv`.`setor`
LEFT JOIN `acessos_servidor` 
  ON `sv`.`id_servidor` = `acessos_servidor`.`servidor`
LEFT JOIN `usuarios` `u` 
  ON `u`.`id_usuarios` = `acessos_servidor`.`usuario`
LEFT JOIN `maquina` `m` 
  ON `m`.`servidor` = `sv`.`id_servidor`;

DROP VIEW IF EXISTS `vw_info_user`;
CREATE VIEW `vw_info_user` AS 
SELECT 
  `usuarios`.`id_usuarios` AS `id`,
  `usuarios`.`nome` AS `nome`,
  `usuarios`.`senha` AS `senha`,
  `usuarios`.`email` AS `email`,
  `usuarios`.`empresa` AS `id_empresa`,
  `usuarios`.`passkey` AS `passkey`,
  `papeis`.`id_papeis` AS `id_papel`,
  `papeis`.`nome` AS `nome_papel`,
  `papeis`.`tipo` AS `tipo_papel` 
FROM (`usuarios` JOIN `papeis` ON (`papeis`.`id_papeis` = `usuarios`.`papel`));

DROP VIEW IF EXISTS `vw_papeis`;
CREATE VIEW `vw_papeis` AS 
SELECT 
  `papeis`.`id_papeis` AS `id_papeis`,
  `papeis`.`nome` AS `nome`,
  `papeis`.`tipo` AS `tipo` 
FROM `papeis`;

DROP VIEW IF EXISTS `vw_usuarios_papeis`;
CREATE VIEW `vw_usuarios_papeis` AS 
SELECT 
  `u`.`id_usuarios` AS `id`,
  `u`.`nome` AS `nome`,
  `u`.`email` AS `email`,
  `p`.`nome` AS `papel`,
  `p`.`tipo` AS `tipo_papel`,
  `u`.`empresa` AS `id_empresa` 
FROM (`usuarios` `u` JOIN `papeis` `p` ON (`p`.`id_papeis` = `u`.`papel`));

-- ============================================================
-- RESET EXPLÍCITO DOS AUTO_INCREMENT
-- ============================================================

ALTER TABLE `empresa` AUTO_INCREMENT = 1;
ALTER TABLE `maquina` AUTO_INCREMENT = 1;
ALTER TABLE `papeis` AUTO_INCREMENT = 1;
ALTER TABLE `parametros` AUTO_INCREMENT = 1;
ALTER TABLE `componentes` AUTO_INCREMENT = 1;
ALTER TABLE `servidores` AUTO_INCREMENT = 1;
ALTER TABLE `setores` AUTO_INCREMENT = 1;
ALTER TABLE `usuarios` AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;
SET UNIQUE_CHECKS = 1;

-- ============================================================
-- FIM DO RESET / REBUILD
-- ============================================================