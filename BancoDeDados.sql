create database PI;
use PI;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR (45) NOT NULL,
email VARCHAR (45) NOT NULL UNIQUE,
cnpj VARCHAR (20),
cidade VARCHAR (45),
estado VARCHAR (45)
);

insert into empresa values
(default, 'Renner', 'renner@outlook.com', '92754738000162', 'Cabreúva', 'São Paulo'),
(default, 'C&A', 'cea@outlook.com', '45242914000105', 'São Paulo', 'São Paulo'),
(default, 'Riachuelo', 'riachuelo@outlook.com', '33200056000149', 'Natal', 'Rio Grande do Norte'),
(default, 'Lacoste', 'lacoste@outlook.com', '29511391000190', 'Brusque', 'Santa Catarina'),
(default, 'Levis', 'levis@gmail.com', '43351097000190', 'São Paulo', 'São Paulo'),
(default, 'Pernambucanas', 'pernambucanas@gmail.com', '42106529000134', 'Ribeirão preto',  'São Paulo'),
(default, 'Hering', 'hering@outlook.com', '78876950000171', 'São Paulo', 'São Paulo');

select * from empresa;


CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nomeFuncionario VARCHAR (45) NOT NULL,  
email VARCHAR (45) NOT NULL UNIQUE,
senha VARCHAR (45) NOT NULL, 
fkEmpresa int,
constraint fkEmpresa foreign key (fkEmpresa) references empresa(idEmpresa)
);

insert into usuario values
(default, 'Fabio Adegas Faccio', 'fabioadegas@gmail.com', 'fabioadegas123', 1),
(default, 'Paulo Correa', 'paulocorrea@outlook.com', 'paulo123', 2),
(default, 'Flávio Rocha', 'flaviorocha@gmail.com', 'flaviorocha123', 3),
(default, 'Éric Vallat', 'ericvallat@outlook.com', 'vallat123', 4),
(default, 'Leonid Radvinsky', 'leonid@gmail.com', 'leonid123', 5),
(default, 'Ricardo Doebeli', 'ricardodoebelli@gmail.com', 'doebelli123', 6),
(default, 'David Python', 'davidphyton@outlook.com', 'python123', 7);

select * from usuario;


CREATE TABLE lugar (
idLugar INT PRIMARY KEY AUTO_INCREMENT,
tipoLugar VARCHAR (15)
	CONSTRAINT chkTipo CHECK (tipoLugar IN ('ESTOQUE', 'ARMAZÉM')),
setorlugar int,
fkEmpresa int,
	constraint fkEmpresaLugar foreign key (fkEmpresa) references empresa(idEmpresa)
);

insert into lugar values
(default, 'ESTOQUE', 1, 5),
(default, 'ARMAZÉM', 3, 4),
(default, 'ARMAZÉM', 3, 3),
(default, 'ESTOQUE', 2, 2),
(default, 'ARMAZÉM', 1, 6),
(default, 'ESTOQUE', 5, 7),
(default, 'ESTOQUE', 4, 1);

select * from lugar;


CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkLugar INT,
constraint  fkLugar foreign key (fkLugar) references lugar(IdLugar)
);

insert into sensor values
(default, 1),
(default, 2),
(default, 3),
(default, 4),
(default, 5),
(default, 6),
(default, 7);

select * from sensor;


CREATE TABLE registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
fkSensor INT,
constraint fkSensor foreign key (fkSensor) references sensor(idSensor),
temperatura int,
umidade decimal(4,2) not null, 
dtRegistro DATETIME DEFAULT current_timestamp
);

insert into registro values
(default, 1, 27, 60, default),
(default, 2, 20, 55.4, default),
(default, 3, 24, 62, default),
(default, 4, 25, 65, default),
(default, 5, 28, 70.3, default),
(default, 6, 17, 48.3, default),
(default, 7, 21, 57.2, default);

select * from registro;


select * from 
empresa join usuario on usuario.fkEmpresa = idEmpresa
join lugar on lugar.fkEmpresa = idEmpresa
join sensor on fkLugar = idLugar
join registro on fkSensor = idSensor;

select 
idEmpresa as 'ID',
nomeEmpresa as 'Empresa', 
nomeFuncionario as 'Dono da empresa', 
tipoLugar as 'Tipo de lugar',  
setorlugar as 'Setor', 
idSensor as 'Sensor', 
temperatura, 
umidade, 
dtRegistro as 'Data de registro'
from 
empresa join usuario on usuario.fkEmpresa = idEmpresa
join lugar on lugar.fkEmpresa = idEmpresa
join sensor on fkLugar = idLugar
join registro on fkSensor = idSensor;