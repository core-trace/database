create database coretrace;
use coretrace;


-- Regra de acesso
CREATE TABLE papeis (
  id_papeis INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  tipo VARCHAR(20) NOT NULL -- ('GESTOR', 'FUNCIONARIO')
);
 
-- Usuários do sistema (quem faz login)
CREATE TABLE usuarios (
  id_usuarios INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  papel INT NOT NULL,
  cadastrado INT,
  empresa INT,
  CONSTRAINT fk_usuarios_papeis FOREIGN KEY (papel) REFERENCES papeis(id_papeis),
  CONSTRAINT fk_usuarios_cadastrado_por FOREIGN KEY (cadastrado) REFERENCES usuarios(id_usuarios),
  CONSTRAINT fk_usuarios_empresa FOREIGN KEY (empresa) REFERENCES empresa(id_empresa)
);
 
-- Setores da empresa (Financeiro, TI, Marketing...)
CREATE TABLE setores (
  id_setores INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE
);
 
-- Servidores monitorados, cada um pertence a um setor
CREATE TABLE servidores (
  id_servidor INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  setor INT NOT NULL,
  empresa INT,
CONSTRAINT fk_servidores_setores FOREIGN KEY (setor) REFERENCES setores(id_setores),
CONSTRAINT fk_servidor_empresa FOREIGN KEY(empresa) REFERENCES empresa(id_empresa)
);
 
-- Quem pode ver qual servidor 
CREATE TABLE acessos_servidor (
  usuario INT NOT NULL,
  servidor INT NOT NULL,
  concedido_por INT NOT NULL,
  PRIMARY KEY (usuario_id, servidor_id),
  CONSTRAINT fk_acessos_usuarios FOREIGN KEY (usuario) REFERENCES usuarios(id_usuarios),
  CONSTRAINT fk_acessos_servidores FOREIGN KEY (servidor) REFERENCES servidores(id_servidor),
  CONSTRAINT fk_acessos_concedido_por FOREIGN KEY (concedido_por) REFERENCES usuarios(id_usuarios)
);

CREATE TABLE empresa(
id_empresa INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(45),
cnpj CHAR(14),
codigo CHAR(16) NOT NULL UNIQUE
);

CREATE TABLE maquina(
id_maquina INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(45),
codigo CHAR(16) NOT NULL UNIQUE,
dt_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
dt_fim DATETIME,
servidor INT,
CONSTRAINT fk_maquina_servidor FOREIGN KEY(servidor) REFERENCES servidores (id_servidor)
);

CREATE TABLE componentes (
id_componentes INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(45),
maquina INT,
CONSTRAINT fk_maquina_componentes FOREIGN KEY(maquina) REFERENCES maquina (id_maquina)
);

CREATE TABLE parametros (
id_parametro INT AUTO_INCREMENT PRIMARY KEY,
nome_parametro VARCHAR(45),
valor_paramentro DOUBLE
);

CREATE TABLE parametros_componentes(
parametros INT,
componente INT,
CONSTRAINT fk_paramentros FOREIGN KEY (parametros) REFERENCES parametros(id_parametro),
CONSTRAINT fk_componente FOREIGN KEY (componentes) REFERENCES componentes(id_componentes)  
);

 

INSERT INTO papeis (nome, tipo) VALUES
  ('Gestor de Infraestrutura', 'GESTOR'),
  ('Analista de Dados', 'FUNCIONARIO');
 
INSERT INTO usuarios (nome, email, senha, papel, cadastrado) VALUES
  ('Marina Gestora', 'marina@empresa.com', 'senha', 1, NULL);
 
INSERT INTO setores (nome) VALUES
  ('Financeiro'), ('TI'), ('Marketing'), ('Logística');