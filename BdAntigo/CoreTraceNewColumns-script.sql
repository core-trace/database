
CREATE DATABASE coretrace;
USE coretrace;
 
-- Regra de acesso
CREATE TABLE papeis (
  id_papeis INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  tipo ENUM('GESTOR', 'FUNCIONARIO') NOT NULL
);
 
-- Empresas (precisa existir antes de usuarios e servidores)
CREATE TABLE empresa (
  id_empresa INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45),
  cnpj CHAR(14),
  codigo CHAR(16) NOT NULL UNIQUE
);
 
-- Setores da empresa (Financeiro, TI, Marketing...)
CREATE TABLE setores (
  id_setores INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE
);
 
-- Usuários do sistema (quem faz login)
CREATE TABLE usuarios (
  id_usuarios INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  papel INT NOT NULL,
  cadastrado INT,
  empresa INT NOT NULL,
  CONSTRAINT fk_usuarios_papeis FOREIGN KEY (papel) REFERENCES papeis(id_papeis),
  CONSTRAINT fk_usuarios_cadastrado_por FOREIGN KEY (cadastrado) REFERENCES usuarios(id_usuarios),
  CONSTRAINT fk_usuarios_empresa FOREIGN KEY (empresa) REFERENCES empresa(id_empresa)
);
 
-- Servidores monitorados, cada um pertence a um setor
CREATE TABLE servidores (
  id_servidor INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  setor INT NOT NULL,
  empresa INT NOT NULL,
  CONSTRAINT fk_servidores_setores FOREIGN KEY (setor) REFERENCES setores(id_setores),
  CONSTRAINT fk_servidor_empresa FOREIGN KEY (empresa) REFERENCES empresa(id_empresa)
);
 
-- Quem pode ver qual servidor
CREATE TABLE acessos_servidor (
  usuario INT NOT NULL,
  servidor INT NOT NULL,
  concedido_por INT NOT NULL,
  PRIMARY KEY (usuario, servidor),
  CONSTRAINT fk_acessos_usuarios FOREIGN KEY (usuario) REFERENCES usuarios(id_usuarios),
  CONSTRAINT fk_acessos_servidores FOREIGN KEY (servidor) REFERENCES servidores(id_servidor),
  CONSTRAINT fk_acessos_concedido_por FOREIGN KEY (concedido_por) REFERENCES usuarios(id_usuarios)
);
 
CREATE TABLE maquina (
  id_maquina INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45),
  codigo CHAR(16) NOT NULL UNIQUE,
  dt_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
  dt_fim DATETIME,
  servidor INT NOT NULL,
  CONSTRAINT fk_maquina_servidor FOREIGN KEY (servidor) REFERENCES servidores(id_servidor)
);
 
CREATE TABLE componentes (
  id_componentes INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45),
  maquina INT NOT NULL,
  CONSTRAINT fk_maquina_componentes FOREIGN KEY (maquina) REFERENCES maquina(id_maquina)
);
 
CREATE TABLE parametros (
  id_parametro INT AUTO_INCREMENT PRIMARY KEY,
  nome_parametro VARCHAR(45),
  valor_paramentro DOUBLE
);
 
CREATE TABLE parametros_componentes (
  parametros INT NOT NULL,
  componente INT NOT NULL,
  PRIMARY KEY (parametros, componente),
  CONSTRAINT fk_parametros FOREIGN KEY (parametros) REFERENCES parametros(id_parametro),
  CONSTRAINT fk_componente FOREIGN KEY (componente) REFERENCES componentes(id_componentes)
);
  
-- Adicionando novas colunas nas tabelas.
ALTER TABLE papeis MODIFY COLUMN tipo VARCHAR(100), ADD CONSTRAINT chk_papeis CHECK (tipo IN ('GESTOR','FUNCIONARIO'));

ALTER TABLE empresa ADD COLUMN dt_criacao TIMESTAMP DEFAULT current_timestamp, ADD COLUMN dt_ultimo_contrato TIMESTAMP DEFAULT current_timestamp;

ALTER TABLE setores ADD COLUMN dt_criacao TIMESTAMP DEFAULT current_timestamp, ADD COLUMN dt_fim TIMESTAMP;

ALTER TABLE usuarios ADD COLUMN dt_criacao TIMESTAMP DEFAULT current_timestamp, ADD COLUMN dt_retirada TIMESTAMP, ADD COLUMN dt_ultimo_login TIMESTAMP;

ALTER TABLE servidores ADD COLUMN dt_criacao TIMESTAMP DEFAULT current_timestamp, ADD COLUMN dt_fim TIMESTAMP;

ALTER TABLE componentes ADD COLUMN dt_adicao TIMESTAMP DEFAULT current_timestamp, ADD COLUMN dt_retirada TIMESTAMP;

ALTER TABLE parametros ADD COLUMN dt_adicao TIMESTAMP DEFAULT current_timestamp, ADD COLUMN dt_retirada TIMESTAMP;

ALTER TABLE acessos_servidor ADD COLUMN dt_acesso TIMESTAMP DEFAULT current_timestamp, ADD COLUMN dt_retirada TIMESTAMP;

ALTER TABLE parametros_componentes ADD COLUMN dt_adicao TIMESTAMP DEFAULT current_timestamp, ADD COLUMN dt_retirada TIMESTAMP;	

ALTER TABLE usuarios ADD COLUMN atividade TINYINT DEFAULT 1;