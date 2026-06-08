CREATE DATABASE hygra;
USE hygra;


CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR (45) NOT NULL,
cnpj VARCHAR (20) NOT NULL,
emailEmpresa varchar (50) NOT NULL,
cidade VARCHAR (45) NOT NULL,
estado VARCHAR (45) NOT NULL,
codigo_ativacao CHAR(5) NOT NULL
);

INSERT INTO empresa values
(DEFAULT, 'Renner', '92754738000162', 'empresa1@gmail.com', 'Cabreúva', 'São Paulo', 'EDGWO'),
(DEFAULT, 'C&A','45242914000105', 'empresa2@gmail.com', 'São Paulo', 'São Paulo', 'SVKEO'),
(DEFAULT, 'Riachuelo', '33200056000149', 'empresa3@gmail.com', 'Natal', 'Rio Grande do Norte', 'POMTS'),
(DEFAULT, 'Lacoste', '29511391000190', 'empresa4@gmail.com', 'Brusque', 'Santa Catarina', 'RTSNJ'),
(DEFAULT, 'Levis', '43351097000190', 'empresa5@gmail.com', 'São Paulo', 'São Paulo', 'OASJG'),
(DEFAULT, 'Pernambucanas', '42106529000134', 'empresa6@gmail.com', 'Ribeirão preto',  'São Paulo', 'PTIYM'),
(DEFAULT, 'Hering', '78876950000171', 'empresa7@gmail.com', 'São Paulo', 'São Paulo', 'ASAIE');

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
(DEFAULT, 'Henrique Rezende', 'henrique@gmail.com', '123', '12345678905', 'padrao', 1),
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
('Seda', 55, 45),
('Lã', 65, 55),
('Algodão', 50, 40),
('Linho', 60, 50);

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
(DEFAULT, 7),
(default, 7),
(default, 7),
(default, 7);

SELECT * FROM sensor;

create table alerta(
	idAlerta int primary key auto_increment,
    dataAlerta datetime default current_timestamp,
    tipo varchar(45) 
    constraint ck_tipoAlerta check(tipo = 'umidade alta' or tipo = 'umidade baixa' or tipo = 'umidade baixa crítica'  or tipo = 'umidade alta crítica')
);



insert into alerta(tipo) values
('umidade baixa crítica'),
('umidade baixa'),
('umidade alta'),
('umidade alta crítica');

select * from alerta;

create table leitura(
idLeitura int primary key auto_increment,
fkSensor int  NOT NULL,
umidade float not null,
dtLeitura datetime default current_timestamp,
fkAlerta int,
constraint fkSensor foreign key (fkSensor) references sensor(idSensor),
constraint fkAlerta foreign key (fkAlerta) references alerta(idAlerta)
);


select * from leitura;

insert into leitura(fkSensor, umidade, fkAlerta) values
(1, 20, 1),
(1, 30, 1),
(1, 40, 2),
(1, 50, null),
(1, 60, 3),
(1, 70, 4),
(2, 25, 1),
(2, 35, 2),
(2, 45, null),
(2, 55, 3),
(2, 65, 4),
(3, 18, 1),
(3, 28, 1),
(3, 38, 2),
(3, 48, null),
(3, 58, 3),
(4, 22, 1),
(4, 32, 2),
(4, 42, null),
(4, 52, 3),
(4, 62, 4),
(5, 15, 1),
(5, 25, 1),
(5, 35, 2),
(5, 45, null),
(5, 55, 3),
(6, 27, 1),
(6, 37, 2),
(6, 47, null),
(6, 57, 3),
(6, 67, 4),
(7, 27, 1),
(7, 37, 2),
(7, 47, null),
(7, 57, 3),
(7, 69, 4);

SELECT * FROM leitura;

SELECT * FROM 
empresa JOIN usuario ON usuario.fkEmpresa = idEmpresa
JOIN lugar ON lugar.fkEmpresa = idEmpresa
JOIN sensor ON fkLugar = idLugar
JOIN leitura ON fkSensor = idSensor;

CREATE VIEW ViewKPIS AS SELECT 
idEmpresa AS 'ID',
nomeEmpresa AS 'Empresa', 
nomeFuncionario AS 'Dono da empresa', 
lugar.tipo AS 'Tipo de lugar',  
setor AS 'Setor', 
idSensor AS 'Sensor', 
concat(umidade, '%') as Umidade,
alerta.tipo as Alerta,
time(dtLeitura) AS Horário
FROM 
empresa JOIN usuario ON usuario.fkEmpresa = idEmpresa
JOIN lugar ON lugar.fkEmpresa = idEmpresa
JOIN sensor ON fkLugar = idLugar
JOIN leitura ON fkSensor = idSensor
JOIN alerta on fkAlerta = idAlerta
WHERE alerta.tipo IS NOT NULL
ORDER BY dtLeitura DESC
LIMIT 1;

create VIEW Viewgraficos AS SELECT 
idEmpresa AS 'ID',
nomeEmpresa AS 'Empresa', 
lugar.tipo AS 'Tipo de lugar',  
setor AS 'Setor', 
idSensor AS 'Sensor', 
concat(umidade, '%') AS Umidade, 
alerta.tipo as Alerta,
dtLeitura AS 'Data de registro'
FROM 
empresa JOIN usuario ON usuario.fkEmpresa = idEmpresa
JOIN lugar ON lugar.fkEmpresa = idEmpresa
JOIN sensor ON fkLugar = idLugar
JOIN leitura ON fkSensor = idSensor
JOIN alerta on fkAlerta = idAlerta;

-- select * from empresa as e
-- join lugar as lu on e.idEmpresa = lu.fkEmpresa
-- join sensor as s on lu.idLugar = s.fkLugar
-- join tecido as t on lu.fkTecido = t.idTecido
-- join leitura as le on s.idSensor = le.fkSensor
-- join alerta as a on le.fkAlerta = a.idAlerta;

select * from Viewgraficos;

create view vw_sensoresPorEmpresa as 
select 
e.idEmpresa as 'idEmpresa',
e.nomeEmpresa as 'nomeEmpresa', 
lu.idLugar as 'idLugar', 
lu.setor as 'idSetor', 
s.idSensor as 'idSensor',
(select umidade from leitura as le where le.fkSensor = s.idSensor order by le.dtLeitura desc limit 1) AS 'leitura',
max(le.dtLeitura) as 'data',
IFNULL((select a.tipo from alerta a join leitura l on l.fkAlerta = a.idAlerta where l.fkSensor = s.idSensor order by l.dtLeitura desc limit 1), 'umidade ideal') AS StatusDeAlerta,
t.nome as 'tecido'
from empresa as e
join lugar as lu on e.idEmpresa = lu.fkEmpresa
join tecido as t on lu.fkTecido = t.idTecido
join sensor as s on lu.idLugar = s.fkLugar
join leitura as le on s.idSensor = le.fkSensor
left join alerta as a on le.fkAlerta = a.idAlerta
group by s.idSensor;




select * from leitura order by idLeitura desc;
select * from vw_sensoresPorEmpresa where idEmpresa = 1;
select * from usuario;
select * from vw_sensoresPorEmpresa where idEmpresa = 1;
select * from sensor;
select * from alerta;
select * from leitura;
select * from usuario;
SELECT * FROM vw_sensoresPorEmpresa;
