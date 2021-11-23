create database ex1

use ex1

CREATE TABLE Aluno(
	ra INT NOT NULL PRIMARY KEY IDENTITY(12345,1),
	nome VARCHAR(6) NOT NULL,
	sobrenome VARCHAR(12) NOT NULL,
	rua VARCHAR(25) NOT NULL, 
	num INT NOT NULL,
	bairro VARCHAR(20) NOT NULL,
	cep INT NOT NULL,
	telefone INT NULL
)
CREATE TABLE Cursos(
	codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(15) NOT NULL,
	carga_horaria INT NOT NULL,
	turno CHAR(5) NOT NULL
)
CREATE TABLE Disciplinas(
	codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(20) NOT NULL,
	carga_horaria INT NOT NULL,
	turno Char(5) NOT NULL,
	semestre INT NOT NULL
)

INSERT INTO Aluno(nome,sobrenome,rua,num,bairro,cep,telefone)
VALUES('Jos�', 'Silva', 'Almirante Noronha', 234, 'Jardim S�o Paulo', 1589000, 69875287),
	  ('Ana', 'Maria Bastos', 'Anhaia', 1568, 'Barra Funda', 3569000, 25698526),
	  ('Mario', 'Santos', 'XV de Novembro', 1841, 'Centro', 1020030, NULL),
	  ('Marcia', 'Neves', 'Volunt�rios da Patria', 225, 'Santana', 2785090, 78964152 )

INSERT INTO Cursos(nome, carga_horaria, turno)
VALUES('Inform�tica', 2800, 'Tarde'),
	  ('Inform�tica', 2800, 'Noite'),
	  ('Log�stica', 2650, 'Tarde'),
	  ('Log�stica', 2640, 'Noite'),
	  ('Pl�stico', 2500, 'Tarde'),
	  ('Pl�stico', 2500, 'Noite')

INSERT INTO Disciplinas(nome,carga_horaria, turno, semestre)
VALUES('Inform�tica', 4 , 'Tarde', 1),
	  ('Inform�tica', 4 , 'Noite', 1),
	  ('Quimica', 4, 'Tarde', 1),
	  ('Quimica', 4, 'Noite', 1),
	  ('Banco de Dados I', 2, 'Tarde', 3),
	  ('Banco de Dados I', 2, 'Noite', 3),
	  ('Estrutura de Dados', 4, 'Tarde', 4),
	  ('Estrutura de Dados', 4, 'Noite', 4)

SELECT nome + ' ' + sobrenome AS nome_completo 
FROM Aluno

SELECT rua + ', ' + CAST(num as VARCHAR(4)) +' - '+  bairro + ' - ' + SUBSTRING(CAST(cep AS VARCHAR(10)),1,5) + '-' + SUBSTRING(CAST(cep AS VARCHAR(10)), 6, 3)
AS endereco_completo
FROM Aluno

SELECT SUBSTRING(CAST(telefone AS VARCHAR(8)), 1, 4)+ '-' + SUBSTRING(CAST(telefone AS VARCHAR(8)),5, 4)
AS telefone
FROM Aluno 
WHERE ra = 12348

SELECT nome, turno 
FROM Cursos 
WHERE carga_horaria = 2800

SELECT semestre 
FROM Disciplinas 
WHERE nome like 'Banco%' AND turno = 'Noite'