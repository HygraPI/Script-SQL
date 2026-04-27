CREATE DATABASE hygra;
USE hygra;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR (45) NOT NULL,
cnpj VARCHAR (20),
cidade VARCHAR (45),
estado VARCHAR (45),
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
fkEmpresa int,
CONSTRAINT fkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO usuario VALUES
(DEFAULT, 'Fabio Adegas Faccio', 'fabioadegas@gmail.com', 'fabioadegas123', 1),
(DEFAULT, 'Paulo Correa', 'paulocorrea@outlook.com', 'paulo123', 2),
(DEFAULT, 'Flávio Rocha', 'flaviorocha@gmail.com', 'flaviorocha123', 3),
(DEFAULT, 'Éric Vallat', 'ericvallat@outlook.com', 'vallat123', 4),
(DEFAULT, 'Leonid Radvinsky', 'leonid@gmail.com', 'leonid123', 5),
(DEFAULT, 'Ricardo Doebeli', 'ricardodoebelli@gmail.com', 'doebelli123', 6),
(DEFAULT, 'David Python', 'davidphyton@outlook.com', 'python123', 7);

SELECT * FROM usuario;

CREATE TABLE lugar (
idLugar INT PRIMARY KEY AUTO_INCREMENT,
tipoLugar VARCHAR (15)
	CONSTRAINT chkTipo CHECK (tipoLugar IN ('ESTOQUE', 'ARMAZÉM')),
setorLugar INT,
fkEmpresa INT,
	CONSTRAINT fkEmpresaLugar FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO lugar VALUES
(DEFAULT, 'ESTOQUE', 1, 5),
(DEFAULT, 'ARMAZÉM', 3, 4),
(DEFAULT, 'ARMAZÉM', 3, 3),
(DEFAULT, 'ESTOQUE', 2, 2),
(DEFAULT, 'ARMAZÉM', 1, 6),
(DEFAULT, 'ESTOQUE', 5, 7),
(DEFAULT, 'ESTOQUE', 4, 1);

SELECT * FROM lugar;


CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkLugar INT,
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

create table leitura(
idRegistro int primary key auto_increment,
fkSensor int,
constraint fkSensor foreign key (fkSensor) references sensor(idSensor),
umidade float not null,
dtLeitura datetime default current_timestamp
);

insert into leitura(fkSensor, umidade) values
(1, 20),
(1, 30),
(1, 40),
(1, 50),
(1, 60),
(1, 70);

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
dtLeitura AS 'Data de registro'
FROM 
empresa JOIN usuario ON usuario.fkEmpresa = idEmpresa
JOIN lugar ON lugar.fkEmpresa = idEmpresa
JOIN sensor ON fkLugar = idLugar
JOIN leitura ON fkSensor = idSensor;
