USE db_Biblioteca;

CREATE TABLE tbl_Autor (
IdAutor SMALLINT AUTO_INCREMENT PRIMARY KEY,
NomeAutor VARCHAR(50) NOT NULL,
SobrenomeAutor VARCHAR(60) NOT NULL
);

CREATE TABLE tbl_Assunto (
IdAssunto SMALLINT PRIMARY KEY AUTO_INCREMENT,
NomeAssunto VARCHAR(35) NOT NULL
);

CREATE TABLE tbl_Editora (
IdEditora SMALLINT PRIMARY KEY AUTO_INCREMENT,
NomeEditora VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS tbl_Livro (
IdLivro SMALLINT AUTO_INCREMENT PRIMARY KEY,
NomeLivro VARCHAR(80) NOT NULL,
ISBN CHAR(13),
PrecoLivro DECIMAL(6,2) NOT NULL,
NumPaginas SMALLINT NOT NULL,
Edicao TINYINT,
DataPub DATE,
IdEditora SMALLINT NOT NULL,
IdAssunto SMALLINT NOT NULL,
CONSTRAINT fk_id_editora FOREIGN KEY (IdEditora)
 REFERENCES tbl_Editora(IdEditora)
 ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_id_assunto FOREIGN KEY (IdAssunto)
 REFERENCES tbl_Assunto(IdAssunto)
 ON DELETE CASCADE ON UPDATE CASCADE
) AUTO_INCREMENT = 100;

CREATE TABLE tbl_Autor_Livro (
IdAutor SMALLINT,
IdLivro SMALLINT,
CONSTRAINT pk_autor_livro PRIMARY KEY(IdAutor,IdLivro), # Chave Primária Composta
CONSTRAINT fk_id_autor FOREIGN KEY (IdAutor)
 REFERENCES tbl_Autor(IdAutor) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_id_livro FOREIGN KEY (IdLivro)
 REFERENCES tbl_Livro(IdLivro) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE tbl_autores;

INSERT INTO tbl_editora (NomeEditora) VALUES ('Prentice Hall');
INSERT INTO tbl_editora (NomeEditora) VALUES ('O´Reilly');
INSERT INTO tbl_editora (NomeEditora) VALUES ('Microsoft Press');
INSERT INTO tbl_editora (NomeEditora) VALUES ('Wiley');
INSERT INTO tbl_editora (NomeEditora) VALUES ('McGraw-Hill Education');

SELECT * FROM tbl_Editora;

INSERT INTO tbl_Autor (NomeAutor,SobrenomeAutor)
VALUES
('Gerald', 'Carter'),
('Mark', 'Sobell'),
('William', 'Stanek'),
('Richard', 'Blum'),
('Jostein', 'Gaarder'),
('Umberto', 'Eco'),
('Neil', 'De Grasse Tyson'),
('Stephen', 'Hawking'),
('Stephen', 'Jay Gould'),
('Charles', 'Darwin'),
('Alan', 'Turing'),
('Simon', 'Monk'),
('Paul', 'Scherz');

SELECT * FROM tbl_Autor;

INSERT INTO tbl_Assunto (NomeAssunto)
VALUES
('Tecnologia'),
('História'),
('Literatura'),
('Astronomia'),
('Botânica');

SELECT * FROM tbl_Editora;

INSERT INTO tbl_Livro
(NomeLivro, ISBN, DataPub, PrecoLivro, NumPaginas, Edicao, IdAssunto, IdEditora)
VALUES
('SSH, the Secure Shell','9780596008956', '20050517', 58.30, 435, 1, 1, 2),
('Using Samba','9780596002565', '20031221', 61.45, 385, 1, 1, 2),
('Fedora and Red Hat Linux', '9780133477436', '20140110', 62.24, 780, 1, 1, 4),
('Windows Server 2012 Inside Out','9780735666313', '20130125', 66.80, 1236, 2, 1, 3),
('Microsoft Exchange Server 2010','9780735640610', '20101201', 45.30, 950, 3, 1, 3),
('Practical Electronics for Inventors', '9781259587542', '20160324', 67.80, 963, 4, 1, 5);

SELECT IdLivro, NomeLivro FROM tbl_livro;
SELECT * FROM tbl_Autor;

INSERT INTO tbl_autor_livro (IdAutor, IdLivro)
VALUES
(1,2),
(2,3),
(5,4),
(4,5),
(4,6),
(13,7),
(14,7);

SELECT * FROM tbl_autor_livro;

SELECT * FROM tbl_assunto;
SELECT * FROM tbl_livro;
SELECT NomeAssunto FROM tbl_assunto;
SELECT NomeLivro FROM tbl_Livro;
SELECT NomeAutor, SobrenomeAutor FROM tbl_autor;

SELECT NomeLivro, PrecoLivro, Edicao
FROM tbl_Livro
ORDER BY Edicao, PrecoLivro;

SELECT * FROM tbl_Livro;

SELECT IdEditora, NomeLivro, PrecoLivro
FROM tbl_livro
WHERE NOT IdEditora = 3
ORDER BY IdEditora DESC;

SELECT NomeAutor, SobrenomeAutor
FROM tbl_autor
ORDER BY NomeAutor DESC;

INSERT INTO tbl_assunto (NomeAssunto)
VALUES ('Dinossauros');

DELETE FROM tbl_assunto
WHERE IdAssunto = 6;

SELECT * FROM tbl_assunto;

SELECT IdAssunto ID, NomeAssunto 'Nome do Assunto'
FROM tbl_assunto A;

SELECT PrecoLivro Preço, DataPub 'Data de Publicação'
FROM tbl_livro AS L
WHERE IdEditora >= 3
ORDER BY Preço;

INSERT INTO tbl_Editora (NomeEditora)
VALUES 
('Apress'),('Bookman'),('Bookboon'),
('Packtpub'),('Springer'),('Érica'),
('For Dummies'),('Novatec'),('Cisco Press'),
('Addison-Wesley'),('Companhia das Letras'),('Artech House'),
('CRC Press'),('Manning'),('Penguin Books'),('Sage Publishing');

SELECT * FROM tbl_editora;

DROP INDEX idx_editora ON tbl_Editora;

EXPLAIN SELECT * FROM tbl_Editora WHERE NomeEditora = 'Springer';

CREATE INDEX idx_editora ON tbl_Editora(NomeEditora);

SHOW INDEX FROM tbl_editora;

SELECT COUNT(*) FROM tbl_editora;

SELECT COUNT(DISTINCT ideditora) FROM tbl_Livro;

SELECT COUNT(ideditora) FROM tbl_Livro;

SELECT MAX(DataPub) FROM tbl_Livro;

SELECT AVG(PrecoLivro) AS 'Média de Preços'
FROM tbl_livro;

SELECT IdLivro, NomeLivro, PrecoLivro
FROM tbl_livro;

UPDATE tbl_Livro
SET NomeLivro = 'SSH, o Shell Seguro'
WHERE IdLIVRO = 2;

SELECT NomeLivro, DataPub 'Data de Publicação'
FROM tbl_Livro
WHERE DataPub NOT BETWEEN '20040517' AND '20110517';

SELECT NomeLivro, PrecoLivro AS Preço
FROM tbl_Livro
WHERE PrecoLivro NOT BETWEEN 60.00 AND 70.00
ORDER BY PrecoLivro;

SELECT NomeLivro, DataPub AS 'Data de Publicação'
FROm tbl_livro;

UPDATE tbl_livro
SET PrecoLivro = 80.67
WHERE IdLivro = 1;

SELECT * FROM tbl_Autor
WHERE SobrenomeAutor LIKE '%t'
ORDER BY Nome; 

SELECT NomeLivro
FROM tbl_Livro
WHERE NomeLivro NOT LIKE '___,%'
ORDER BY NomeLivro;

SELECT NomeLivro AS Livro, PrecoLivro AS Valor
FROM tbl_livro
WHERE NomeLivro NOT LIKE 'F%'
AND PrecoLivro > 65.00
ORDER BY Valor;

CREATE VIEW vw_LivrosEditoras
AS SELECT tbl_Livro.NomeLivro AS Livro, tbl_Livro.PrecoLivro Preço,
tbl_Editora.NomeEditora AS Editora
FROM tbl_Livro
INNER JOIN tbl_editora
ON tbl_Livro.IdEditora = tbl_editora.IdEditora
ORDER BY Preço DESC;

CREATE VIEW vw_LivrosAssuntos
AS SELECT tbl_Livro.NomeLivro AS L, tbl_assunto.NomeAssunto AS A
FROM tbl_Livro
INNER JOIN tbl_assunto
ON tbl_Livro.IdAssunto = tbl_assunto.IdAssunto
ORDER BY L;

SELECT L, A
FROM vw_livrosassuntos;

SELECT Livro, Editora, Preço
FROM vw_LivrosEditoras
WHERE Preço > 66.00;

DROP VIEW vw_livroseditoras;

SELECT 3 * 9 AS Resultado;

SELECT NomeLivro, PrecoLivro AS 'Preço Unitário',
PrecoLivro * 5  AS 'Preço de 5 Unidades'
FROM tbl_Livro;

SELECT 2 * 9 / 3;

SELECT NomeLivro, PrecoLivro / 2 AS 'Preço com 50% de desconto'
FROM tbl_Livro;

SELECT 10 MOD 3;

UPDATE tbl_livro
SET PrecoLivro = PrecoLivro * 1.1
WHERE IdLivro >= 1;

SELECT * FROM tbl_Livro;

SELECT NomeLivro, FLOOR(PrecoLivro * 5)  AS  'Preço Arredondado'
FROM tbl_livro;

SELECT PI();

SELECT POW(2,4);
SELECT SQRT(81);
SELECT SIN(PI());
SELECT HEX(1200);

CREATE TABLE tbl_mult (
  ID SMALLINT PRIMARY KEY AUTO_INCREMENT,
  num1 SMALLINT NOT NULL,
  num2 SMALLINT NOT NULL,
  num3 SMALLINT GENERATED ALWAYS AS (num1 * num2) VIRTUAL
);

INSERT INTO tbl_mult (num1, num2)
VALUES (2,1), (2,2), (2,3), (2,4);

SELECT * FROM tbl_mult;

CREATE TABLE tbl_Vendas (
 ID_Venda SMALLINT PRIMARY KEY AUTO_INCREMENT,
 Preco_Produto DECIMAL(6,2) NOT NULL,
 Qtde TINYINT NOT NULL,
 Desconto DECIMAL(4,2) NOT NULL,
 Preco_Total DECIMAL(6,2) AS (Preco_Produto * Qtde * (1 - Desconto / 100)) STORED
);

INSERT INTO tbl_Vendas (Preco_Produto, Qtde, Desconto)
VALUES
(50.00, 2, 20),
(65.00, 3, 15),
(100.00, 1, 12),
(132.00, 3, 18);

SELECT * FROM tbl_vendas;




