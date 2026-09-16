create database CoreTrace;
use CoreTrace;

CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),                  
    email VARCHAR(100) UNIQUE,          
    senha VARCHAR(255),                 
    passkey CHAR(4),
    cargo VARCHAR(45)
);

CREATE TABLE empresa(
idEmpresa int auto_increment primary key,
razaoSocial varchar(45),
cnpj char(14),
dt_Registro DATE
);

CREATE TABLE setores (
idSetores int auto_increment primary key,
nome varchar(45),
fkEmpresa int,
foreign key(fkEmpresa) references empresa(idEmpresa)
);

CREATE TABLE servidores (
idServidores int auto_increment primary key,
nome varchar(45),
estado varchar(45),
fkSetores int,
foreign key(fkSetores) references setores(idSetores)
);

CREATE TABLE maquinas (
idMaquina int auto_increment primary key,
nome varchar(45),
fkServidores int,
foreign key(fkServidores) references servidores(idServidores)
);

CREATE TABLE componente (
idComponente int auto_increment primary key,
nome Varchar(45),
comando Varchar(45),
unidade Varchar(45)
);

CREATE TABLE componente_Maquina (
	fkMaquina int,
	fkComponente int,
	primary key(fkMaquina, fkComponente),
	foreign key(fkMaquina) references maquinas(idMaquina),
	foreign key(fkComponente) references componente(idComponente)
);

CREATE TABLE acessoMaquina(
	fkUsuario int,
	fkMaquina int,
	primary key(fkUsuario,fkMaquina),
	foreign key(fkUsuario) references usuario(idUsuario),
	foreign key(fkMaquina) references maquinas(idMaquina)
);

CREATE TABLE acessoSetores(
	fkSetores int,
    fkUsuario int,
    foreign key(fkSetores) references setores(idSetores),
    foreign key(fkUsuario) references usuario(idUsuario)
);





