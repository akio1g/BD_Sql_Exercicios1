CREATE DATABASE ex2
USE ex2

CREATE TABLE Carro(
	placa CHAR(7) NOT NULL PRIMARY KEY,
	marca VARCHAR(7) NOT NULL,
	modelo VARCHAR(6) NOT NULL,
	cor VARCHAR(5) NOT NULL,
	ano INT NOT NULL
)
CREATE TABLE Clientes(
	nome VARCHAR(15) NOT NULL,
	logradouro VARCHAR(25) NOT NULL,
	num INT NOT NULL,
	bairro VARCHAR(20) NOT NULL,
	telefone VARCHAR(9) NOT NULL,
	carro CHAR(7) NOT NULL 

	constraint fk_carro FOREIGN KEY(carro) REFERENCES Carro(placa),
	constraint pk_cliente PRIMARY KEY(carro)
)
CREATE TABLE Pecas(
	codigo INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(20) NOT NULL,
	valor INT NOT NULL
)
CREATE TABLE Servicos(
	carro CHAR(7) NOT NULL,
	peca INT NOT NULL,
	quantidade INT NOT NULL,
	valor INT NOT NULL,
	data DATE NOT NULL

	constraint fk_carro_servicos FOREIGN KEY (carro) REFERENCES Carro(placa),
	constraint fk_peca FOREIGN KEY (peca) REFERENCES Pecas(codigo),

	constraint pk_servicos PRIMARY KEY(carro, peca, data)
)

INSERT INTO Carro(placa, marca, modelo, cor, ano)
VALUES ('AFT9087','VW','Gol','Preto',2007),
       ('DXO9876','Ford','Ka','Azul',2000),
       ('EGT4631','Renault','Clio','Verde',2004),
       ('LKM7380','Fiat','Palio','Prata',1997),
       ('BCD7521','Ford','Fiesta','Preto',1999)

INSERT INTO Clientes(nome, logradouro, num, bairro, telefone, carro)
VALUES ('João Alves', 'R. Pereira Barreto', 1258, 'Jd. Oliveiras', '2154-9658','DXO9876'),
	   ('Ana Maria', 'R. 7 de Setembro', 259, 'Centro', '9658-8541', 'LKM7380'),
	   ('Clara Oliveira', 'Av. Nações Unidas', 10254, 'Pinheiros', '2458-9658', 'EGT4631'),
	   ('José Simões', 'R. XV de Novembro', 36, 'Água Branca', '7895-2459', 'BCD7521'),
	   ('Paula Rocha', 'R. Anhaia', 548, 'Barra Funda', '6958-2548', 'AFT9087')

INSERT INTO Pecas(nome, valor)
VALUES ('Vela', 70),
	   ('Correia Dentada', 125),
	   ('Trambulador', 90),
	   ('Filtro de Ar', 30)

INSERT INTO Servicos(carro, peca, quantidade, valor, data)
VALUES ('DXO9876', 1, 4, 280, '01/08/2020'),
	   ('DXO9876',	4, 1, 30, '01/08/2020'),
	   ('EGT4631',	3, 1, 90, '02/08/2020'),
	   ('DXO9876', 2, 1, 125, '07/08/2020')

SELECT telefone 
FROM Clientes
WHERE carro IN (
	SELECT placa 
	FROM Carro	
	WHERE modelo like 'Ka' AND cor like 'Azul'
)

SELECT logradouro + ', ' + CAST(num as VARCHAR(5)) +' - '+  bairro AS endereco_completo
FROM Clientes 
WHERE carro IN (
	SELECT carro 
	FROM Servicos
	WHERE data = '02/08/2020'
)

SELECT placa
FROM Carro 
WHERE ano < 2001

SELECT marca + ' ' + modelo + ' ' + cor 
AS carro 
FROM Carro 
WHERE ano > 2005 

SELECT codigo, nome 
FROM pecas 
WHERE valor < 80