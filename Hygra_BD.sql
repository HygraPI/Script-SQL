CREATE DATABASE hygra;
USE hygra;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR (45) NOT NULL,
cnpj VARCHAR (20) NOT NULL,
cidade VARCHAR (45) NOT NULL,
estado VARCHAR (45) NOT NULL,
codigo_ativacao CHAR(5) NOT NULL
);

INSERT INTO empresa values
(DEFAULT, 'Renner', '92754738000162', 'Cabreúva', 'São Paulo', 'EDGWO'),
(DEFAULT, 'C&A','45242914000105', 'São Paulo', 'São Paulo', 'SVKEO'),
(DEFAULT, 'Riachuelo', '33200056000149', 'Natal', 'Rio Grande do Norte', 'POMTS'),
(DEFAULT, 'Lacoste', '29511391000190', 'Brusque', 'Santa Catarina', 'RTSNJ'),
(DEFAULT, 'Levis', '43351097000190', 'São Paulo', 'São Paulo', 'OASJG'),
(DEFAULT, 'Pernambucanas', '42106529000134', 'Ribeirão preto',  'São Paulo', 'PTIYM'),
(DEFAULT, 'Hering', '78876950000171', 'São Paulo', 'São Paulo', 'ASAIE');

SELECT * FROM empresa;

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nomeFuncionario VARCHAR (45) NOT NULL,  
email VARCHAR (45) NOT NULL UNIQUE,
senha VARCHAR (45) NOT NULL,
cpf char(11) unique NOT NULL, 
tipo varchar(20) default 'padrao',
fkEmpresa int  NOT NULL,
CONSTRAINT fkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO usuario VALUES
(DEFAULT, 'Fabio Adegas Faccio', 'fabioadegas@gmail.com', 'fabioadegas123', '12345678901', 'Suporte', 1),
(DEFAULT, 'Paulo Correa', 'paulocorrea@outlook.com', 'paulo123', '22345678901', default, 2),
(DEFAULT, 'Flávio Rocha', 'flaviorocha@gmail.com', 'flaviorocha123', '32345678901', 'Suporte', 3),
(DEFAULT, 'Éric Vallat', 'ericvallat@outlook.com', 'vallat123', '42345678901', default, 4),
(DEFAULT, 'Leonid Radvinsky', 'leonid@gmail.com', 'leonid123', '52345678901', 'Suporte', 5),
(DEFAULT, 'Ricardo Doebeli', 'ricardodoebelli@gmail.com', 'doebelli123', '62345678901', default, 6),
(DEFAULT, 'David Python', 'davidphyton@outlook.com', 'python123', '72345678901', 'Suporte', 7);

SELECT * FROM usuario;

create table tecido(
idTecido int primary key auto_increment,
nome varchar(45) not null unique,
maxUmidade float not null,
minUmidade float not null
);

insert into tecido(nome, maxUmidade, minUmidade) values
('Seda', 40, 50),
('Lã', 55, 65),
('Algodão', 45, 55),
('Linho', 50, 60);

select * from tecido;

CREATE TABLE lugar (
idLugar INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR (15)  NOT NULL,
setor INT  NOT NULL,
fkEmpresa INT  NOT NULL,
fkTecido int  NOT NULL,
CONSTRAINT fkEmpresaLugar FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT chkTipo CHECK (tipo IN ('ESTOQUE', 'ARMAZÉM')),
constraint fkTecido foreign key (fkTecido) references tecido(idTecido)
);

select * from empresa;

INSERT INTO lugar(idLugar, tipo, setor, fkEmpresa, fkTecido) VALUES
(DEFAULT, 'ESTOQUE', 1, 5,1),
(DEFAULT, 'ARMAZÉM', 3, 4,2),
(DEFAULT, 'ARMAZÉM', 3, 3,3),
(DEFAULT, 'ESTOQUE', 2, 2,4),
(DEFAULT, 'ARMAZÉM', 1, 6,1),
(DEFAULT, 'ESTOQUE', 5, 7,2),
(DEFAULT, 'ESTOQUE', 4, 1,3);

SELECT * FROM lugar;

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkLugar INT  NOT NULL,
CONSTRAINT  fkLugar FOREIGN KEY (fkLugar) REFERENCES lugar(IdLugar)
);

INSERT INTO sensor VALUES
(DEFAULT, 1),
(DEFAULT, 2),
(DEFAULT, 3),
(DEFAULT, 4),
(DEFAULT, 5),
(DEFAULT, 6),
(DEFAULT, 7);

SELECT * FROM sensor;

create table alerta(
	idAlerta int primary key auto_increment,
    dataAlerta datetime default current_timestamp,
    tipo varchar(45)  NOT NULL
    constraint ck_tipoAlerta check(tipo = 'umidade alta' or tipo = 'umidade baixa' or tipo = 'umidade correta')
);

insert into alerta(tipo) values
('umidade baixa'),
('umidade baixa'),
('umidade baixa'),
('umidade alta'),
('umidade alta'),
('umidade correta');

select * from alerta;

create table leitura(
idRegistro int primary key auto_increment,
fkSensor int  NOT NULL,
umidade float not null,
dtLeitura datetime default current_timestamp,
fkAlerta int not null,
constraint fkSensor foreign key (fkSensor) references sensor(idSensor),
constraint foreign key (fkAlerta) references alerta(idAlerta)
);

select * from leitura;

insert into leitura(fkSensor, umidade, fkAlerta) values
(1, 20, 1),
(1, 30, 2),
(1, 40, 3),
(1, 50, 6),
(1, 60, 4),
(1, 70, 5);

SELECT * FROM leitura;

SELECT * FROM 
empresa JOIN usuario ON usuario.fkEmpresa = idEmpresa
JOIN lugar ON lugar.fkEmpresa = idEmpresa
JOIN sensor ON fkLugar = idLugar
JOIN leitura ON fkSensor = idSensor;

SELECT 
idEmpresa AS 'ID',
nomeEmpresa AS 'Empresa', 
nomeFuncionario AS 'Dono da empresa', 
tipoLugar AS 'Tipo de lugar',  
setorlugar AS 'Setor', 
idSensor AS 'Sensor', 
umidade, 
dtRegistro AS 'Data de registro'
FROM 
empresa JOIN usuario ON usuario.fkEmpresa = idEmpresa
JOIN lugar ON lugar.fkEmpresa = idEmpresa
JOIN sensor ON fkLugar = idLugar
JOIN leitura ON fkSensor = idSensor;

SELECT 
idEmpresa AS 'ID',
nomeEmpresa AS 'Empresa', 
nomeFuncionario AS 'Dono da empresa', 
tipoLugar AS 'Tipo de lugar',  
setorlugar AS 'Setor', 
idSensor AS 'Sensor', 
umidade, 
dtRegistro AS 'Data de registro'
FROM 
empresa JOIN usuario ON usuario.fkEmpresa = idEmpresa
JOIN lugar ON lugar.fkEmpresa = idEmpresa
JOIN sensor ON fkLugar = idLugar
JOIN leitura ON fkSensor = idSensor;

SELECT 
nomeEmpresa AS 'Empresa',
idSensor AS 'Sensor',
umidade,
CASE 
    WHEN umidade < 30 THEN 'Baixa'
    WHEN umidade <= 60 THEN 'Normal'
    ELSE 'Alta'
END AS 'Situação'
FROM empresa 
JOIN usuario ON usuario.fkEmpresa = idEmpresa
JOIN lugar ON lugar.fkEmpresa = idEmpresa
JOIN sensor ON fkLugar = idLugar
JOIN leitura ON fkSensor = idSensor;

