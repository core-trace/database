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
 
INSERT INTO setores (nome) VALUES
  ('Financeiro'), ('TI'), ('Marketing'), ('Logística');