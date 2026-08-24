create database coretrace;
use coretrace;

 
-- Regra de acesso
CREATE TABLE papeis (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  tipo VARCHAR(20) NOT NULL -- ('GESTOR', 'FUNCIONARIO')
);
 
-- Usuários do sistema (quem faz login)
CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  papel_id INT NOT NULL,
  cadastrado_por INT,
  CONSTRAINT fk_usuarios_papeis FOREIGN KEY (papel_id) REFERENCES papeis(id),
  CONSTRAINT fk_usuarios_cadastrado_por FOREIGN KEY (cadastrado_por) REFERENCES usuarios(id)
);
 
-- Setores da empresa (Financeiro, TI, Marketing...)
CREATE TABLE setores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE
);
 
-- Servidores monitorados, cada um pertence a um setor
CREATE TABLE servidores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  setor_id INT NOT NULL,
  CONSTRAINT fk_servidores_setores FOREIGN KEY (setor_id) REFERENCES setores(id)
);
 
-- Quem pode ver qual servidor 
CREATE TABLE acessos_servidor (
  usuario_id INT NOT NULL,
  servidor_id INT NOT NULL,
  concedido_por INT NOT NULL,
  PRIMARY KEY (usuario_id, servidor_id),
  CONSTRAINT fk_acessos_usuarios FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  CONSTRAINT fk_acessos_servidores FOREIGN KEY (servidor_id) REFERENCES servidores(id),
  CONSTRAINT fk_acessos_concedido_por FOREIGN KEY (concedido_por) REFERENCES usuarios(id)
);
 

INSERT INTO papeis (nome, tipo) VALUES
  ('Gestor de Infraestrutura', 'GESTOR'),
  ('Analista de Dados', 'FUNCIONARIO');
 
INSERT INTO usuarios (nome, email, senha, papel_id, cadastrado_por) VALUES
  ('Marina Gestora', 'marina@empresa.com', 'senha', 1, NULL);
 
INSERT INTO setores (nome) VALUES
  ('Financeiro'), ('TI'), ('Marketing'), ('Logística');