CREATE DATABASE ex4

USE ex4

CREATE TABLE Cliente(
	cpf VARCHAR(15) PRIMARY KEY NOT NULL,
	nome VARCHAR(30) NOT NULL,
	telefone VARCHAR(30) NOT NULL
)
CREATE TABLE Fornecedor(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(15) NOT NULL,
	logradouro VARCHAR(20) NOT NULL,
	num INT NOT NULL,
	complemento VARCHAR(20) NOT NULL,
	cidade VARCHAR(10) NOT NULL
)
CREATE TABLE Produto(
	codigo INT IDENTITY(1,1) PRIMARY KEY,
	descricao VARCHAR(50) NOT NULL,
	fornecedor  INT NOT NULL,
	preco DECIMAL(7,2)

	constraint fk_fornecedor FOREIGN KEY (fornecedor) REFERENCES Fornecedor(id)
)

CREATE TABLE Venda(
	codigo INT NOT NULL,
	produto INT NOT NULL,
	cliente VARCHAR(15) NOT NULL,
	quantidade INT NOT NULL,
	valor_total DECIMAL(7,2) NOT NULL,
	data DATE NOT NULL
	
	constraint fk_produto FOREIGN KEY(produto) REFERENCES produto(codigo),
	constraint fk_cliente FOREIGN KEY(cliente) REFERENCES Cliente(cpf),

	constraint pk_venda PRIMARY KEY(codigo, produto, cliente)
)

INSERT INTO Cliente(cpf, nome, telefone)
VALUES('345789092-90', 'Julio Cesar', '8273-6541'),
	  ('251865337-10', 'Maria Antonia', '8765-2314'),
	  ('876273154-16', 'Luiz Carlos', '6128-9012'),
	  ('791826398-00', 'Paulo Cesar', '9076-5273')

INSERT INTO Fornecedor(nome, logradouro, num, complemento, cidade)
VALUES('LG', 'Rod. Bandeirantes', 70000, 'Km 70', 'Itapeva'),
	  ('Asus', 'Av. Nações Unidas', 10206, 'Sala 225', 'São Paulo'),
	  ('AMD', 'Av. Nações Unidas', 10206, 'Sala 1095', 'São Paulo'),
	  ('Leadership', 'Av. Nações Unidas', 10206, 'Sala 87', 'São Paulo'),
	  ('Inno', 'Av. Nações Unidas', 10206, 'Sala 34', 'São Paulo')

INSERT INTO Produto(descricao, fornecedor, preco)
VALUES('Monitor 19 pol.', 1 ,449.99),
	  ('Netbook 1GB Ram 4 Gb HD', 2, 699.99),
	  ('Gravador de DVD - Sata', 1, 99.99),
	  ('Leitor de CD', 1, 49.99),
	  ('Processador - Phenom X3 - 2.1GHz', 3, 349.99),
	  ('Mouse', 4, 19.99),
	  ('Teclado', 4, 25.99),
	  ('Placa de Video - Nvidia 9800 GTX - 256MB/256 bits', 5, 599.99)

INSERT INTO Venda(codigo, produto, cliente, quantidade, valor_total, data)
VALUES(1, 1, '251865337-10', 1, 449.99, '03/09/2009'),
	(1, 4, '251865337-10', 1, 49.99, '03/09/2009'),
	(1, 5, '251865337-10', 1, 349.99, '03/09/2009'),
	(2, 6, '791826398-00', 4, 79.99, '06/09/2009'),
	(3, 8, '876273154-16', 1, 599.99, '06/09/2009'),
	(3, 3, '876273154-16', 1, 99.99, '06/09/2009'),
	(3, 7, '876273154-16', 1, 25.99, '06/09/2009'),
	(4, 2, '345789092-90', 2, 1399.98, '08/09/2009')


SELECT CONVERT(VARCHAR(10), data, 103) AS data
FROM Venda 
WHERE codigo = 4

ALTER TABLE Fornecedor
	ADD telefone VARCHAR(9)

UPDATE Fornecedor
	SET telefone = '7216-5311'
	WHERE id = 1

UPDATE Fornecedor	
	SET telefone = '8715-3738'
	WHERE id = 2

UPDATE Fornecedor
	SET telefone = '3654-6289'
	WHERE id = 4

SELECT nome, logradouro + ', ' + 
	   CAST(num AS VARCHAR(5)) + ' - '+complemento+' - ' +cidade as endereco, 
	   telefone 
FROM Fornecedor
ORDER BY nome

SELECT produto, quantidade, valor_total 
FROM Venda 
WHERE cliente IN(
	SELECT cpf 
	FROM Cliente 
	WHERE nome = 'Julio Cesar'
)

SELECT CONVERT(VARCHAR(10), data, 103) AS data,
	   valor_total
FROM Venda
WHERE cliente IN(
	SELECT cpf 
	FROM Cliente 
	WHERE nome = 'Paulo Cesar'
)

SELECT descricao, preco 
FROM Produto 
ORDER BY preco DESC