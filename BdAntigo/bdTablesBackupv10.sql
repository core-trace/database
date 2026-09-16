DROP DATABASE IF EXISTS coretrace;
CREATE DATABASE coretrace;
USE coretrace;

DROP TABLE IF EXISTS `acessos_servidor`;
CREATE TABLE `acessos_servidor` (
  `usuario` int NOT NULL,
  `servidor` int NOT NULL,
  `concedido_por` int NOT NULL,
  `dt_acesso` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_retirada` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuario`,`servidor`),
  KEY `fk_acessos_servidores` (`servidor`),
  KEY `fk_acessos_concedido_por` (`concedido_por`),
  CONSTRAINT `fk_acessos_concedido_por` FOREIGN KEY (`concedido_por`) REFERENCES `usuarios` (`id_usuarios`),
  CONSTRAINT `fk_acessos_servidores` FOREIGN KEY (`servidor`) REFERENCES `servidores` (`id_servidor`),
  CONSTRAINT `fk_acessos_usuarios` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id_usuarios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `componentes`
--

DROP TABLE IF EXISTS `componentes`;
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

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
CREATE TABLE `empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `cnpj` char(14) DEFAULT NULL,
  `codigo` char(16) NOT NULL,
  `dt_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_ultimo_contrato` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_empresa`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `maquina`
--

DROP TABLE IF EXISTS `maquina`;
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

--
-- Table structure for table `papeis`
--

DROP TABLE IF EXISTS `papeis`;
CREATE TABLE `papeis` (
  `id_papeis` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_papeis`),
  CONSTRAINT `chk_papeis` CHECK ((`tipo` in (_utf8mb4'GESTOR',_utf8mb4'FUNCIONARIO')))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `parametros`
--

DROP TABLE IF EXISTS `parametros`;
CREATE TABLE `parametros` (
  `id_parametro` int NOT NULL AUTO_INCREMENT,
  `nome_parametro` varchar(45) DEFAULT NULL,
  `valor_paramentro` double DEFAULT NULL,
  `dt_adicao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_retirada` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_parametro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `parametros_componentes`
--

DROP TABLE IF EXISTS `parametros_componentes`;
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

DROP TABLE IF EXISTS `servidores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servidores` (
  `id_servidor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `setor` int NOT NULL,
  `empresa` int NOT NULL,
  `dt_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_fim` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_servidor`),
  KEY `fk_servidores_setores` (`setor`),
  KEY `fk_servidor_empresa` (`empresa`),
  CONSTRAINT `fk_servidor_empresa` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`id_empresa`),
  CONSTRAINT `fk_servidores_setores` FOREIGN KEY (`setor`) REFERENCES `setores` (`id_setores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `setores`
--

DROP TABLE IF EXISTS `setores`;
CREATE TABLE `setores` (
  `id_setores` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(80) NOT NULL,
  `dt_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_fim` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_setores`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
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
  PRIMARY KEY (`id_usuarios`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_usuarios_papeis` (`papel`),
  KEY `fk_usuarios_cadastrado_por` (`cadastrado`),
  KEY `fk_usuarios_empresa` (`empresa`),
  CONSTRAINT `fk_usuarios_cadastrado_por` FOREIGN KEY (`cadastrado`) REFERENCES `usuarios` (`id_usuarios`),
  CONSTRAINT `fk_usuarios_empresa` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`id_empresa`),
  CONSTRAINT `fk_usuarios_papeis` FOREIGN KEY (`papel`) REFERENCES `papeis` (`id_papeis`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping routines for database 'coretrace'
--

-- Dump completed on 2026-09-03 20:28:58
