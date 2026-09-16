-- -- (DESMARQUE ABAIXO CASO  OCORRA O ERRO: Error Code: 1146. Table 'tabelaqualquer.papeis' doesn't exist)ou Error Code: 1046. No database selected Select the default DB to be used by double-clicking its name in the SCHEMAS list in the sidebar.
-- USE coretrace; 

-- Inserts
 
INSERT INTO papeis (nome, tipo) VALUES
  ('Gestor de Infraestrutura', 'GESTOR'),
  ('Analista de Dados', 'FUNCIONARIO');
 
-- Precisa existir uma empresa antes do usuário, já que empresa agora é NOT NULL
INSERT INTO empresa (nome, cnpj, codigo) VALUES
  ('Empresa Exemplo', '12345678000199', 'EMP0000000000001');
 
INSERT INTO usuarios (nome, email, senha, papel, cadastrado, empresa) VALUES
  ('Marina Gestora', 'marina@empresa.com', 'senha', 1, NULL, 1);

INSERT INTO usuarios (nome, email, senha, papel, cadastrado, empresa) VALUES
  ('Funcionario01', 'funcionario01@empresa.com', 'senha', 2, NULL, 1);
  
  
UPDATE usuarios SET passkey = "123456" WHERE id_usuarios = 2;
 
INSERT INTO setores (nome) VALUES
  ('Financeiro'), ('TI'), ('Marketing'), ('Logística');
  
  SELECT * FROM usuarios;
  
  SELECT id, nome, email, id_empresa, id_papel, nome_papel, tipo_papel 
        FROM vw_info_user 
        WHERE email = "marina@empresa.com" AND senha = "senha";

  
  SELECT * FROM vw_info_user;
  
DESC usuarios;
  
  CREATE VIEW vw_info_user AS
	SELECT
            usuarios.id_usuarios AS id,
            usuarios.nome,
            usuarios.senha,
            usuarios.email,
            usuarios.empresa AS id_empresa,
            papeis.id_papeis AS id_papel,
            papeis.nome AS nome_papel,
            papeis.tipo AS tipo_papel
        FROM usuarios
        INNER JOIN papeis ON papeis.id_papeis = usuarios.papel;

CREATE VIEW vw_papeis AS
    SELECT 
    papeis.id_papeis as id_papeis,
    papeis.nome as nome,
    papeis.tipo as tipo
    FROM papeis;

  INSERT INTO papeis (nome, tipo) VALUES
  ('Gestor de Infraestrutura', 'GESTOR'),
  ('Analista de Dados', 'FUNCIONARIO');
  
  SELECT * FROM papeis
