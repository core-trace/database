-- ============================================================
-- CORETRACE - RESET / REBUILD DATABASE
-- ============================================================
-- ATENÇÃO:
-- Este script DESTRÓI o banco `coretrace` existente e o recria
-- integralmente com a estrutura desta versão.
--
-- TODOS OS DADOS ATUAIS DO BANCO SERÃO APAGADOS.
-- Este arquivo NÃO contém INSERTs e, portanto, não restaura dados.
--
-- Compatível com MySQL 8.x
-- ============================================================

DROP DATABASE IF EXISTS `coretrace`;

CREATE DATABASE `coretrace`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci
  DEFAULT ENCRYPTION='N';

USE `coretrace`;

-- ------------------------------------------------------------
-- Configurações temporárias para reconstrução
-- ------------------------------------------------------------
SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS;
SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION;
SET @OLD_TIME_ZONE = @@TIME_ZONE;
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET @OLD_SQL_MODE = @@SQL_MODE;
SET @OLD_SQL_NOTES = @@SQL_NOTES;

SET NAMES utf8mb4;
SET TIME_ZONE = '+00:00';
SET UNIQUE_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET SQL_NOTES = 0;

-- ============================================================
-- ESTRUTURA DO BANCO
-- ============================================================

-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: coretrace
-- ------------------------------------------------------
-- Server version	8.4.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acessos_servidor`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acessos_servidor` (
  `usuario` int NOT NULL,
  `servidor` int NOT NULL,
  `concedido_por` int NOT NULL,
  `dt_concessao` datetime DEFAULT CURRENT_TIMESTAMP,
  `dt_acesso` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_retirada` timestamp NULL DEFAULT NULL,
  `maquina` int NOT NULL,
  PRIMARY KEY (`usuario`,`servidor`),
  KEY `fk_acessos_servidores` (`servidor`),
  KEY `fk_acessos_concedido_por` (`concedido_por`),
  KEY `fk_maquina` (`maquina`),
  CONSTRAINT `fk_acessos_concedido_por` FOREIGN KEY (`concedido_por`) REFERENCES `usuarios` (`id_usuarios`),
  CONSTRAINT `fk_acessos_servidores` FOREIGN KEY (`servidor`) REFERENCES `servidores` (`id_servidor`),
  CONSTRAINT `fk_acessos_usuarios` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id_usuarios`),
  CONSTRAINT `fk_maquina` FOREIGN KEY (`maquina`) REFERENCES `maquina` (`id_maquina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `componentes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empresa`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `maquina`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `papeis`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `papeis` (
  `id_papeis` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `nivel_papel` int DEFAULT NULL,
  PRIMARY KEY (`id_papeis`),
  CONSTRAINT `chk_papeis` CHECK ((`tipo` in (_utf8mb4'GESTOR',_utf8mb4'FUNCIONARIO')))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parametros`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parametros` (
  `id_parametro` int NOT NULL AUTO_INCREMENT,
  `nome_parametro` varchar(45) DEFAULT NULL,
  `valor_parametro` double DEFAULT NULL,
  `dt_adicao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_retirada` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_parametro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parametros_componentes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servidores`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servidores` (
  `id_servidor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `setor` int NOT NULL,
  `dt_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_fim` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_servidor`),
  KEY `fk_servidores_setores` (`setor`),
  CONSTRAINT `fk_servidores_setores` FOREIGN KEY (`setor`) REFERENCES `setores` (`id_setores`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `setores`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vw_detalhes_acessos_servidor`
--

/*!50001 DROP VIEW IF EXISTS `vw_detalhes_acessos_servidor`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_detalhes_acessos_servidor` AS SELECT
 1 AS `id_usuario`,
 1 AS `nome_usuario`,
 1 AS `id_setor`,
 1 AS `nome_setor`,
 1 AS `id_servidor`,
 1 AS `nome_servidor`,
 1 AS `id_maquina`,
 1 AS `nome_maquina`,
 1 AS `codigo_maquina`,
 1 AS `dt_inicio_maquina`,
 1 AS `dt_fim_maquina`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_info_user`
--

/*!50001 DROP VIEW IF EXISTS `vw_info_user`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_info_user` AS SELECT
 1 AS `id`,
 1 AS `nome`,
 1 AS `senha`,
 1 AS `email`,
 1 AS `id_empresa`,
 1 AS `passkey`,
 1 AS `id_papel`,
 1 AS `nome_papel`,
 1 AS `tipo_papel`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_papeis`
--

/*!50001 DROP VIEW IF EXISTS `vw_papeis`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_papeis` AS SELECT
 1 AS `id_papeis`,
 1 AS `nome`,
 1 AS `tipo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_usuarios_papeis`
--

/*!50001 DROP VIEW IF EXISTS `vw_usuarios_papeis`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_usuarios_papeis` AS SELECT
 1 AS `id`,
 1 AS `nome`,
 1 AS `email`,
 1 AS `papel`,
 1 AS `tipo_papel`,
 1 AS `id_empresa`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_detalhes_acessos_servidor`
--

/*!50001 DROP VIEW IF EXISTS `vw_detalhes_acessos_servidor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aluno`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_detalhes_acessos_servidor` AS select `u`.`id_usuarios` AS `id_usuario`,`u`.`nome` AS `nome_usuario`,`st`.`id_setores` AS `id_setor`,`st`.`nome` AS `nome_setor`,`sv`.`id_servidor` AS `id_servidor`,`sv`.`nome` AS `nome_servidor`,`m`.`id_maquina` AS `id_maquina`,`m`.`nome` AS `nome_maquina`,`m`.`codigo` AS `codigo_maquina`,`m`.`dt_inicio` AS `dt_inicio_maquina`,`m`.`dt_fim` AS `dt_fim_maquina` from (((`servidores` `sv` left join (`acessos_servidor` join `setores` `st`) on(((`sv`.`id_servidor` = `acessos_servidor`.`servidor`) and (`st`.`id_setores` = `sv`.`setor`)))) left join `usuarios` `u` on((`u`.`id_usuarios` = `acessos_servidor`.`usuario`))) left join `maquina` `m` on((`m`.`servidor` = `sv`.`id_servidor`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_info_user`
--

/*!50001 DROP VIEW IF EXISTS `vw_info_user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aluno`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_info_user` AS select `usuarios`.`id_usuarios` AS `id`,`usuarios`.`nome` AS `nome`,`usuarios`.`senha` AS `senha`,`usuarios`.`email` AS `email`,`usuarios`.`empresa` AS `id_empresa`,`usuarios`.`passkey` AS `passkey`,`papeis`.`id_papeis` AS `id_papel`,`papeis`.`nome` AS `nome_papel`,`papeis`.`tipo` AS `tipo_papel` from (`usuarios` join `papeis` on((`papeis`.`id_papeis` = `usuarios`.`papel`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_papeis`
--

/*!50001 DROP VIEW IF EXISTS `vw_papeis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aluno`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_papeis` AS select `papeis`.`id_papeis` AS `id_papeis`,`papeis`.`nome` AS `nome`,`papeis`.`tipo` AS `tipo` from `papeis` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_usuarios_papeis`
--

/*!50001 DROP VIEW IF EXISTS `vw_usuarios_papeis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aluno`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_usuarios_papeis` AS select `u`.`id_usuarios` AS `id`,`u`.`nome` AS `nome`,`u`.`email` AS `email`,`p`.`nome` AS `papel`,`p`.`tipo` AS `tipo_papel`,`u`.`empresa` AS `id_empresa` from (`usuarios` `u` join `papeis` `p` on((`p`.`id_papeis` = `u`.`papel`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
-- ============================================================
-- FINALIZAÇÃO
-- ============================================================

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- RESET / REBUILD script generated from the supplied CoreTrace structure.
