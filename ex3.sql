CREATE DATABASE ex3

USE ex3

CREATE TABLE Pacientes(
	cpf VARCHAR(20) NOT NULL PRIMARY KEY,
	nome VARCHAR(30) NOT NULL,
	rua VARCHAR(30) NOT NULL,
	num INT NOT NULL,
	bairro VARCHAR(30) NOT NULL,
	telefone INT NULL,
	data_nasc DATE NOT NULL
)
CREATE TABLE Medico(
	codigo INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(30) NOT NULL,
	especialidade VARCHAR(30) NOT NULL
)
CREATE TABLE Prontuario(
	data DATE NOT NULL,
	cpf_paciente VARCHAR(20) NOT NULL,
	codigo_medico INT NOT NULL,
	diagnostico VARCHAR(30) NOT NULL,
	medicamento VARCHAR(30) NOT NULL

	constraint fk_cpf_paciente FOREIGN KEY(cpf_paciente) REFERENCES Pacientes(cpf),
	constraint fk_codigo_medico FOREIGN KEY(codigo_medico) REFERENCES Medico(codigo),

	constraint pk_prontuario PRIMARY KEY(data, cpf_paciente, codigo_medico)
)

INSERT INTO Pacientes(cpf, nome, rua, num, bairro, telefone, data_nasc)
VALUES ('35454562890', 'José Rubens', 'Campos Salles', 2750, 'Centro', 21450998, '1954-10-18'),
	   ('29865439810', 'Ana Claudia', 'Sete de Setembro', 178, 'Centro', 97382764, '1960-05-29'),
	   ('82176534800', 'Marcos Aurélio', 'Timóteo Penteado', 236, 'Vila Galvão',68172651, '1980-09-24'),
	   ('12386758770', 'Maria Rita', 'Castello Branco', 7765, 'Vila Rosália', NULL, '1975-03-30'),
	   ('92173458910', 'Joana de Souza', 'XV de Novembro', 298, 'Centro', 21276578, '1944-04-24')

INSERT INTO Medico(nome, especialidade)
VALUES ('Wilson Cesar', 'Pediatra'),
	   ('Marcia Matos', 'Geriatra'),
       ('Carolina Oliveira', 'Ortopedista'),
       ('Vinicius Araujo', 'Clínico Geral')

INSERT INTO Prontuario(data, cpf_paciente, codigo_medico, diagnostico, medicamento)
VALUES ('2020-09-10', 35454562890, 2, 'Reumatismo', 'Celebra'),
	   ('2020-09-10', 92173458910, 2, 'Renite Alérgica', 'Allegra'),	
       ('2020-09-12', 29865439810, 1, 'Inflamação de garganta', 'Nimesulida'),
       ('2020-09-13', 35454562890, 2, 'H1N1', 'Tamiflu'),
       ('2020-09-15', 82176534800, 4, 'Gripe', 'Resprin'),
       ('2020-09-15', 12386758770, 3, 'Braço Quebrado', 'Dorflex + Gesso')

SELECT nome, rua + ', ' + CAST(num AS VARCHAR(4)) + ' - ' + bairro AS endereço 
FROM Pacientes 
WHERE DATEDIFF(YEAR, data_nasc, GETDATE()) > 50

SELECT especialidade 
FROM Medico 
WHERE nome = 'Carolina Oliveira'

SELECT medicamento 
FROM Prontuario 
WHERE diagnostico = 'Reumatismo' 

SELECT diagnostico, medicamento 
FROM Prontuario 
WHERE cpf_paciente IN (
	SELECT cpf 
	FROM Pacientes 
	WHERE nome = 'José Rubens'
)

SELECT nome, 
	CASE 
		WHEN LEN(especialidade) > 3 THEN	
			SUBSTRING(especialidade, 1, 3) + '...'
		ELSE
			especialidade
		END as especilidade
FROM Medico 
WHERE codigo IN (
	SELECT codigo_medico 
	FROM Prontuario
	WHERE cpf_paciente IN (
		SELECT cpf 
		FROM Pacientes
		WHERE nome = 'José Rubens'
	)
)

SELECT SUBSTRING(cpf,1, 3) + '.' + SUBSTRING(cpf, 4,3) + '.'+ SUBSTRING(cpf, 7, 3)+'-'+SUBSTRING(cpf, 10, 2) AS cpf,
	nome, 
	rua + ', ' +CAST(num AS VARCHAR(4))+' - ' + bairro as endereço_completo,
	CASE 
		WHEN (telefone = NULL) THEN
			'-'
		ELSE
			telefone
	END AS telefone
FROM Pacientes 
WHERE cpf in (
	SELECT cpf_paciente 
	FROM Prontuario 
	WHERE codigo_medico IN (
		SELECT codigo 
		FROM Medico 
		WHERE nome like 'Vinicius%'
	)
)

SELECT DATEDIFF(DAY, data, GETDATE()) as dias_diff
FROM Prontuario 
WHERE cpf_paciente IN (
	SELECT cpf 
	FROM Pacientes 
	WHERE nome = 'Maria Rita'
)

UPDATE Pacientes
	SET telefone = 98345621  
	WHERE nome = 'Maria Rita'

UPDATE Pacientes 
	SET rua = 'Voluntários da Pátria',
	num = 1980,
	bairro = 'Jd.Aeroporto'
	WHERE nome = 'joana de Souza'