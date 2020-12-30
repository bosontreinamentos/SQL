-- Criar Banco
CREATE DATABASE db_Faculdade;
USE db_Faculdade;

-- Criar Tabelas
CREATE TABLE Departamento (
Cod_Departamento INT PRIMARY KEY AUTO_INCREMENT,
Nome_departamento VARCHAR(20) NOT NULL
);

CREATE TABLE Professor (
Cod_Professor INT PRIMARY KEY AUTO_INCREMENT,
Nome_Professor VARCHAR(20) NOT NULL,
Sobrenome_Professor VARCHAR(50) NOT NULL,
Status_Professor TINYINT,
Cod_Departamento INT,
CONSTRAINT fk_Codigo_departamento FOREIGN KEY(Cod_Departamento) REFERENCES Departamento (Cod_Departamento)
);

CREATE TABLE Curso (
Cod_Curso INT PRIMARY KEY AUTO_INCREMENT,
Nome_Curso VARCHAR(30),
Cod_Departamento INT,
CONSTRAINT fk_Cod_Departamento FOREIGN KEY (Cod_Departamento) REFERENCES Departamento (Cod_Departamento)
);

CREATE TABLE Turma (
Cod_Turma INT PRIMARY KEY AUTO_INCREMENT,
Cod_Curso INT,
Periodo VARCHAR(8),
Num_Alunos INT,
Data_Inicio DATE,
Data_Fim DATE,
CONSTRAINT fk_Cod_Curso FOREIGN KEY (Cod_Curso) REFERENCES Curso (Cod_Curso)
);

CREATE TABLE Disciplina (
Cod_Disciplina INT PRIMARY KEY AUTO_INCREMENT,
Cod_Disciplina_Depende INT NULL, /* Auto-relacionamento */
Nome_Disciplina VARCHAR(30),
Cod_Departamento INT NOT NULL,
Carga_Horaria INT NOT NULL,
Descrição VARCHAR(80),
Num_Alunos INT NOT NULL,
CONSTRAINT fk_Cod_Departamento_Disciplina FOREIGN KEY (Cod_Departamento) REFERENCES Departamento (Cod_Departamento),
CONSTRAINT fk_Cod_Disciplina FOREIGN KEY (Cod_Disciplina_Depende) REFERENCES Disciplina (Cod_Disciplina)
);

CREATE TABLE Prof_Disciplina (
Cod_Professor INT NOT NULL,
Cod_Disciplina INT NOT NULL,
PRIMARY KEY (Cod_Professor, Cod_Disciplina), 
CONSTRAINT fk_Cod_Professor_Prof FOREIGN KEY (Cod_Professor) REFERENCES Professor (Cod_Professor),
CONSTRAINT fk_Cod_Disciplina_Prof FOREIGN KEY (Cod_Disciplina) REFERENCES Disciplina (Cod_Disciplina)
);

CREATE TABLE Curso_Disciplina (
Cod_Curso INT NOT NULL,
Cod_Disciplina INT NOT NULL,
PRIMARY KEY (Cod_Curso, Cod_Disciplina), 
CONSTRAINT fk_Cod_Curso_Disci FOREIGN KEY (Cod_Curso) REFERENCES Curso (Cod_Curso),
CONSTRAINT fk_Cod_Disciplina_Disci FOREIGN KEY (Cod_Disciplina) REFERENCES Disciplina (Cod_Disciplina)
);

CREATE TABLE Aluno (
RA INT PRIMARY KEY AUTO_INCREMENT,
Nome_Aluno VARCHAR(20) NOT NULL,
Sobrenome_Aluno VARCHAR(20) NOT NULL,
CPF VARCHAR(11) NOT NULL,
Status_Aluno TINYINT(1) NOT NULL,
Cod_Turma INT,
Sexo VARCHAR(1),
Cod_Curso INT,
Nome_Pai VARCHAR(50) NOT NULL,
Nome_Mae VARCHAR(50) NOT NULL,
Email VARCHAR(50) NOT NULL,
Whatsapp VARCHAR(20) NOT NULL,
CONSTRAINT fk_Cod_Turma_Aluno FOREIGN KEY(Cod_Turma) REFERENCES Turma (Cod_Turma),
CONSTRAINT fk_Cod_Curso_Aluno FOREIGN KEY(Cod_Curso) REFERENCES Curso (Cod_Curso)
);

CREATE TABLE Aluno_Disc (
RA INT NOT NULL,
Cod_Disciplina INT NOT NULL,
PRIMARY KEY (RA, Cod_Disciplina),
CONSTRAINT fk_RA_Aluno FOREIGN KEY (RA) REFERENCES Aluno (RA),
CONSTRAINT fk_Cod_Disciplina_Aluno FOREIGN KEY (Cod_Disciplina) REFERENCES Disciplina (Cod_Disciplina)
);

CREATE TABLE Historico (
Cod_Historico INT PRIMARY KEY AUTO_INCREMENT,
RA INT NOT NULL,
Data_Inicio DATE NOT NULL,
Data_Final DATE,
CONSTRAINT fk_Cod_RA FOREIGN KEY (RA) REFERENCES Aluno (RA)
);

CREATE TABLE Disc_Hist (
Cod_Historico INT NOT NULL,
Cod_Disciplina INT NOT NULL,
Nota INT,
Frequência INT,
PRIMARY KEY (Cod_Historico, Cod_Disciplina), 
CONSTRAINT fk_Cod_Historico FOREIGN KEY (Cod_Historico) REFERENCES Historico (Cod_Historico),
CONSTRAINT fk_Cod_Disciplina_Hist FOREIGN KEY (Cod_Disciplina) REFERENCES Disciplina (Cod_Disciplina)
);

CREATE TABLE Tipo_Telefone(
Cod_Tipo_Telefone INT PRIMARY KEY AUTO_INCREMENT,
Tipo_Telefone VARCHAR(8)
);

CREATE TABLE Telefones_Aluno (
Cod_Telefones_Aluno INT PRIMARY KEY AUTO_INCREMENT,
RA INT NOT NULL,
Cod_Tipo_Telefone INT NOT NULL,
Num_Telefone VARCHAR(20) NOT NULL,
CONSTRAINT fk_Cod_RA_Tel FOREIGN KEY (RA) REFERENCES Aluno (RA),
CONSTRAINT fk_Cod_Tipo_Telefone FOREIGN KEY (Cod_Tipo_Telefone) REFERENCES Tipo_Telefone (Cod_Tipo_Telefone)
);

CREATE TABLE Tipo_Logradouro (
Cod_Tipo_Logradouro INT PRIMARY KEY AUTO_INCREMENT,
Tipo_Logradouro VARCHAR(11)
);

CREATE TABLE Endereco_Aluno (
Cod_Endereco_Aluno INT PRIMARY KEY AUTO_INCREMENT,
RA INT NOT NULL,
Cod_Tipo_Logradouro INT NOT NULL,
Nome_Rua VARCHAR(50) NOT NULL,
Num_Rua INT NOT NULL,
Complemento VARCHAR(20) NULL,
CEP VARCHAR(8) NOT NULL,
CONSTRAINT fk_Cod_RA_End FOREIGN KEY(RA) REFERENCES Aluno (RA),
CONSTRAINT fk_Cod_Tipo_Lougradouro FOREIGN KEY(Cod_Tipo_Logradouro) REFERENCES Tipo_Logradouro (Cod_Tipo_Logradouro)
);

-- Carga de Dados para Testes
INSERT INTO Departamento (Nome_Departamento) VALUES
('Ciências Humanas'),
('Matemática'),
('Biológicas'),
('Estágio');

INSERT INTO Professor (Nome_Professor, Sobrenome_Professor, Status_Professor, Cod_Departamento)
VALUES
('Fábio', 'dos Reis', 0, 2),
('Sophie', 'Allemand', 1, 1),
('Monica', 'Barroso', 1, 3);

INSERT INTO Curso (Nome_Curso, Cod_Departamento) VALUES
('Matemática', 2),
('Psicologia', 1),
('Análise de Sistemas', 2),
('Biologia', 3),
('História', 1),
('Engenharia', 2);

INSERT INTO Turma (Cod_Curso, Periodo, Num_Alunos, Data_Inicio, Data_Fim)
VALUES
(2, 'Manhã', 20, '2016-05-12', '2017-10-15'),
(1, 'Noite', 10, '2014-05-12', '2020-03-05'),
(3, 'Tarde', 15, '2012-05-12', '2014-05-10');

INSERT INTO Disciplina (Nome_Disciplina, Cod_Departamento, Carga_Horaria, Descrição, Num_Alunos)
VALUES
('Raciocínio Lógico', 2, 1200, 'Desenvolver o raciocínio lógico', 50),
('Psicologia Cognitiva', 1, 1400, 'Entender o funcionamento do aprendizado', 30),
('Programação em C', 2, 1200, 'Aprender uma linguagem de programação', 20),
('Eletrônica Digital', 2, 300, 'Funcionamento de circuitos digitais', 30);

INSERT INTO Aluno (Nome_Aluno, Sobrenome_Aluno, CPF, Status_Aluno, Cod_Turma, Sexo, Cod_Curso, Nome_Pai, Nome_Mae, Email, Whatsapp)
VALUES
('Marcos', 'Aurelio Martins', 14278914536, 1, 2, 'M', 3, 'Marcio Aurelio', 'Maria Aparecida', 'marcosaurelio@gmail.com', 946231249),
('Gabriel', 'Fernando de Almeida', 14470954536, 1, 1, 'M', 1, 'Adão Almeida', 'Fernanda Almeida', 'gabrielalmeida@yahoo.com', 941741247),
('Beatriz', 'Sonia Meneguel', 1520984537, 1, 3, 'F', 3, 'Samuel Meneguel', 'Gabriella Meneguel', 'batrizmene@hotmail.com', 945781412),
('Jorge', 'Soares', 14223651562, 1, 3, 'M', 4, 'João Soares', 'Maria Richter', 'jorgesoares@gmail.com', 925637857),
('Ana Paula', 'Ferretti', 32968914522, 1, 3, 'F', 5, 'Marcio Ferretti', 'Ana Hoffbahn', 'anapaulaferretti@hotmail.com', 974267423),
('Mônica', 'Yamaguti', 32988914510, 1, 2, 'F', 6, 'Wilson Oliveira', 'Fernanda Yamaguti', 'monyamaguti@outlook.com', 932619560);

INSERT INTO Aluno_Disc (RA, Cod_Disciplina)
VALUES
(3, 1),
(1, 2),
(2, 3),
(4, 3),
(5, 4),
(6, 1);

INSERT INTO Curso_Disciplina(Cod_Curso, Cod_Disciplina)
VALUES
(1, 1),
(2, 2),
(3, 3),
(6, 4);

INSERT INTO Prof_Disciplina(Cod_Professor, Cod_Disciplina)
VALUES
(2, 1),
(1, 2),
(3, 3),
(2, 4);

INSERT INTO Historico (RA, Data_Inicio, Data_Final)
VALUES
(2, '2016-05-12', '2017-10-15'),
(3, '2014-05-12', '2020-03-05'),
(1, '2010-05-12', '2012-05-10');

INSERT INTO Tipo_Logradouro (Tipo_Logradouro)
VALUES
('Rua'),
('Avenida'),
('Alameda'),
('Travessa');

INSERT INTO Endereco_Aluno (RA, Cod_Tipo_Logradouro, Nome_Rua, Num_Rua, Complemento, CEP)
VALUES
(2, 1, 'das Giestas', 255, 'Casa 02', 02854000),
(3, 3, 'Lorena', 10, 'Apto 15', 02945000),
(1, 2, 'do Cursino', 1248, '', 0851040),
(4, 1, 'das Heras', 495, '', 03563142),
(5, 3, 'Santos', 1856, '', 04523963),
(6, 4, 'Matão', 206, '', 04213650);


-- Consultas para testes no banco
SELECT * FROM Aluno;

SELECT * FROM Disciplina;

SELECT * FROM Curso;

SELECT * FROM Professor;

SELECT A.Nome_Aluno, A.Sobrenome_Aluno, C.Nome_Curso
FROM Curso C
INNER JOIN Aluno A
ON C.Cod_Curso = A.Cod_Curso;

-- TESTES FINAIS E CORREÇÕES

-- Alterar campo NOTA da tabela Disc_Hist para FLOAT
ALTER TABLE Disc_Hist
MODIFY COLUMN NOTA FLOAT(4,2);

-- Inserir dados de disciplinas e notas no histórico
INSERT INTO Disc_Hist (Cod_Historico, Cod_Disciplina, Nota, Frequência)
VALUES
(1, 2, 7, 6),   -- Marcos - Psicologia Cognitiva (cod 2)
(2, 3, 8.5, 2), -- Beatriz - Programação em C (cod 3)
(3, 1, 6.8, 8); -- Gabriel - Raciocínio Lógico (cod 1)

-- 1. RAs, Nomes e Sobrenomes dos Alunos, Nomes dos Cursos e Períodos das Turmas, ordenados pelo primeiro nome de aluno:
SELECT A.RA, A.Nome_Aluno, A.Sobrenome_Aluno, T.Periodo, C.Nome_Curso
FROM Aluno A
INNER JOIN Curso C
ON C.Cod_Curso = A.Cod_Curso
INNER JOIN Turma T
ON A.Cod_Turma = T.Cod_Turma
ORDER BY A.Nome_Aluno;

-- 2. Todas as disciplinas cursadas por um aluno, com suas respectivas notas:
-- Aluno: RA 3 (Beatriz)
SELECT A.Nome_Aluno, A.Sobrenome_Aluno, D.Nome_Disciplina, DH.Nota
FROM Aluno A
INNER JOIN Aluno_Disc AD
ON A.RA = AD.RA
INNER JOIN Disciplina D
ON D.Cod_Disciplina = AD.Cod_Disciplina
INNER JOIN Historico H
ON A.RA = H.RA
INNER JOIN Disc_Hist DH
ON H.Cod_Historico = DH.Cod_Historico
WHERE A.RA = 3;

-- 3. Nomes e sobrenomes dos professores, e disciplinas que ministram com suas cargas horárias:
SELECT CONCAT(P.Nome_Professor, ' ', P.Sobrenome_Professor) AS Docente,
D.Nome_Disciplina, D.Carga_Horaria
FROM Professor P
INNER JOIN Prof_Disciplina PD
ON P.Cod_Professor = PD.Cod_Professor
INNER JOIN Disciplina D
ON D.Cod_Disciplina = PD.Cod_Disciplina
ORDER BY D.Nome_Disciplina;

-- Inserir dados de tipos de telefones e os telefones dos alunos
INSERT INTO Tipo_Telefone (Tipo_Telefone)
VALUES
('Res'),
('Com'),
('Cel'),
('Rec');

INSERT INTO Telefones_Aluno (RA, Cod_Tipo_Telefone, Num_Telefone)
VALUES
(1, 1, 28467853),
(2, 1, 24653298),
(2, 3, 996324521),
(3, 1, 36549875),
(3, 3, 994532165),
(4, 1, 21956345),
(4, 3, 986321452),
(5, 1, 24569832),
(5, 2, 23854696),
(6, 1, 27698753);

-- 4. Gerar "relatório" com nomes, sobrenomes, CPF dos alunos, tipos e números de telefones e
-- endereços completos.
SELECT CONCAT(A.Nome_Aluno, ' ', A.Sobrenome_Aluno) AS Aluno, A.CPF, T.Num_Telefone, CONCAT(TL.Tipo_Logradouro, ' ', E.Nome_Rua, ', ', E.Num_Rua) AS Logradouro, E.Complemento, E.CEP
FROM Aluno A
INNER JOIN Telefones_Aluno T
ON A.RA = T.RA
INNER JOIN Endereco_Aluno E
ON A.RA = E.RA
INNER JOIN Tipo_Logradouro TL
ON TL.Cod_Tipo_Logradouro = E.Cod_Tipo_Logradouro;

-- 5. Listar as disciplinas, indicando seus departamentos, cursos e professores
SELECT Di.Nome_Disciplina, C.Nome_Curso,
CONCAT(P.Nome_Professor, ' ', P.Sobrenome_Professor) AS Docente, De.Nome_Departamento
FROM Disciplina Di
INNER JOIN Departamento De
ON Di.Cod_Departamento = De.Cod_Departamento
INNER JOIN Prof_Disciplina PD
ON Di.Cod_Disciplina = PD.Cod_Disciplina
INNER JOIN Professor P
ON P.Cod_Professor = PD.Cod_Professor
INNER JOIN Curso_Disciplina CD
ON Di.Cod_Disciplina = CD.Cod_Disciplina
INNER JOIN Curso C
ON C.Cod_Curso = CD.Cod_Curso
ORDER BY Di.Nome_Disciplina; 
