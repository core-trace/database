create database CoreTrace;

use CoreTrace;

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
    FOREIGN KEY (fkNivelAcesso)
        REFERENCES nivel_acesso(idNivelAcesso),
    FOREIGN KEY (fkPermissoes)
        REFERENCES permissoes(idPermissoes)
);

CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),                  
    email VARCHAR(100) UNIQUE,          
    senha VARCHAR(255),                 
    token VARCHAR(255),
    status VARCHAR(20),
    cpf CHAR(11)
);

CREATE TABLE empresa(
idEmpresa int auto_increment primary key,
razaoSocial varchar(45),
cnpj char(14),
dt_Registro DATE
);
CREATE TABLE endereco(
idEndereço int auto_increment primary key,
numero VARCHAR(10),
cidade VARCHAR(45),
estado VARCHAR(45),
logradouro VARCHAR(100),
fkEmpresa INT,
foreign key(fkEmpresa) references empresa(idEmpresa)
);


CREATE TABLE servidores (
idServidores int auto_increment primary key,
nome varchar(45),
estado varchar(45),
fkSetores int,
fkEmpresa INT,
foreign key(fkempresa) references empresa(idEmpresa)
);

CREATE TABLE container (
    idContainer INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    status VARCHAR(45),
    fkServidores INT,
    FOREIGN KEY (fkServidores) REFERENCES servidores(idServidores)
);

CREATE TABLE componentes (
idComponentes int auto_increment primary key,
nome Varchar(45),
comando Varchar(45),
unidade Varchar(45)
);

CREATE TABLE componente_container (
    fkContainer INT,
    fkComponentes INT,
    limite_atencao DECIMAL(10,2),
    limite_critico DECIMAL(10,2),
    PRIMARY KEY (fkContainer, fkComponentes),
    FOREIGN KEY (fkContainer) REFERENCES container(idContainer),
    FOREIGN KEY (fkComponentes) REFERENCES componentes(idComponentes)
);






