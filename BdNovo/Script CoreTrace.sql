CREATE DATABASE CoreTrace;

USE CoreTrace;

CREATE TABLE empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(45),
    cnpj CHAR(14),
    codigo CHAR(4),
    dt_Registro DATE
);

CREATE TABLE nivel_acesso (
    idNivelAcesso INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45)
);

CREATE TABLE permissoes (
    idPermissoes INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    descricao VARCHAR(45)
);

CREATE TABLE nivel_acesso_permissoes (
    fkNivelAcesso INT,
    fkPermissoes INT,
    PRIMARY KEY (fkNivelAcesso, fkPermissoes),
    FOREIGN KEY (fkNivelAcesso) REFERENCES nivel_acesso(idNivelAcesso),
    FOREIGN KEY (fkPermissoes) REFERENCES permissoes(idPermissoes)
);

CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(255),
    cpf CHAR(11),
    token_instalacao VARCHAR(45),
    token VARCHAR(32),
    telefone VARCHAR(45),
    fkEmpresa INT,
    fkNivelAcesso INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (fkNivelAcesso) REFERENCES nivel_acesso(idNivelAcesso)
);

CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10),
    cidade VARCHAR(45),
    estado VARCHAR(45),
    logradouro VARCHAR(100),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE perfil_servidor (
    idPerfilServidor INT AUTO_INCREMENT PRIMARY KEY,
    ativo_container TINYINT,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE servidores (
    idServidores INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    status VARCHAR(45),
    fkPerfilServidor INT,
    FOREIGN KEY (fkPerfilServidor) REFERENCES perfil_servidor(idPerfilServidor)
);

CREATE TABLE container (
    idContainer INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    status VARCHAR(45),
    fkPerfilServidor INT,
    fkServidor INT,
    FOREIGN KEY (fkPerfilServidor) REFERENCES perfil_servidor(idPerfilServidor),
    FOREIGN KEY (fkServidor) REFERENCES servidores(idServidores)
);

CREATE TABLE componentes (
    idComponentes INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    comando VARCHAR(45),
    unidade VARCHAR(45)
);

CREATE TABLE componente_perfil (
    fkComponente INT,
    fkPerfilServidor INT,
    limite_atencao DECIMAL(10,2),
    limite_critico DECIMAL(10,2),
    PRIMARY KEY (fkComponente, fkPerfilServidor),
    FOREIGN KEY (fkComponente) REFERENCES componentes(idComponentes),
    FOREIGN KEY (fkPerfilServidor) REFERENCES perfil_servidor(idPerfilServidor)
);

CREATE TABLE componente_container (
    fkContainer INT,
    fkComponente INT,
    limite_atencao DECIMAL(10,2),
    limite_critico DECIMAL(10,2),
    PRIMARY KEY (fkContainer, fkComponente),
    FOREIGN KEY (fkContainer) REFERENCES container(idContainer),
    FOREIGN KEY (fkComponente) REFERENCES componentes(idComponentes)
);

CREATE TABLE usuario_perfil_servidor (
    fkUsuario INT,
    fkPerfilServidor INT,
    PRIMARY KEY (fkUsuario, fkPerfilServidor),
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (fkPerfilServidor) REFERENCES perfil_servidor(idPerfilServidor)
);




