create database PI;
use PI;

/*Dados da empresa*/
CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR (45) NOT NULL,
email VARCHAR (45) NOT NULL UNIQUE,
cnpj VARCHAR (20),
cidade VARCHAR (45),
estado VARCHAR (45)
);

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nomeFuncionario VARCHAR (45) NOT NULL,  
email VARCHAR (45) NOT NULL UNIQUE,
senha VARCHAR (45) NOT NULL, 
fkEmpresa int,
constraint fkEmpresa foreign key (fkEmpresa) references empresa(idEmpresa)
);

/**/
CREATE TABLE lugar (
idLugar INT PRIMARY KEY AUTO_INCREMENT,
tipoLugar VARCHAR (15)
	CONSTRAINT chkTipo CHECK (tipoLugar IN ('ESTOQUE', 'ARMAZÉM')),
setorlugar int,
fkEmpresa int,
	constraint fkEmpresaLugar foreign key (fkEmpresa) references empresa(idEmpresa)
);


CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkLugar INT,
constraint  fkLugar foreign key (fkLugar) references lugar(IdLugar)
);

CREATE TABLE registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
fkSensor INT,
constraint fkSensor foreign key (fkSensor) references sensor(idSensor),
temperatura int,
umidade decimal(4,2) not null, 
dtRegistro DATETIME DEFAULT current_timestamp
);



-- INSERTE E SELECT TESTE CLIENTES  
INSERT INTO empresa (nomeEmpresa, email, senha, dtCriacao)
VALUES ('Renner', 'Renner@outlook.com', 'r0403@n', default);

SELECT 
	nomeEmpresa AS 'Nome Da Empresa',
    email AS 'E-MAIL',
    dtCriacao AS 'Data De Cadastdro' 
FROM Empresas;

-- INSERT E SELECT TESTE LUGARES 
INSERT INTO lugares (nomeLugar, tipoLugar, descricaoLugar) 
VALUES ('Estoque Principal Renner', 'Estoque', 'Armazém de seda e linho');

SELECT 
	nomeLugar AS 'Nome Do Local',
    tipoLugar AS 'Tipo Do Local',
    descricaoLugar AS 'Descrição Do Local'
FROM lugares;

-- INSERT E SELECT TESTE SENSOR 
INSERT INTO sensores (modeloSensor, idLugar, tipoSensor, dtInstalacao)
VALUES ('DHT11', 1, 'temp. e umi.', '2026-08-14');

SELECT 
	modeloSensor AS 'Sensor Utilizado',
    idLugar AS 'Local Instalado',
    tipoSensor AS 'Tipo De Sensor',
    dtInstalacao AS 'Data De Instalação'
FROM sensores;

-- INSERT E SELECT TESTE DAS MEDIÇÕES 
INSERT INTO medicoes (idSensor, valores, unidadeDeMedida, pontoDeOrvalho)
VALUES (1, 27.5, 'celsius', 22.3 ),
	(1, 77.10 , 'porcentagem', 53.2);

SELECT
    idSensor AS 'Codigo Sensor',
    valores AS 'Valores',
    unidadeDeMedida AS 'Unidade De Medida', 
    pontoDeOrvalho AS 'Ponto De Orvalho'
FROM medicoes; 

-- APENAS AMBIENTES CRÍTICOS
SELECT 
	idSensor AS 'Codigo Sensor',
    valores AS 'Valores',
    unidadeDeMedida AS 'Unidade De Medida'
FROM medicoes WHERE valores > 65;
