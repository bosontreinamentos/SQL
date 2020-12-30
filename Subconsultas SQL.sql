USE db_biblioteca;

SELECT NomeLivro, PrecoLivro, IdEditora
FROM tbl_livro
WHERE IdEditora =
	(SELECT IdEditora
	FROM tbl_editora
    WHERE NomeEditora = 'Wiley');
    
UPDATE tbl_livro
SET PrecoLivro = PrecoLivro * 1.1
WHERE IdEditora =
	(SELECT IdEditora
	FROM tbl_editora
    WHERE NomeEditora = 'O´Reilly');
    
Select * from tbl_editora;
select * from tbl_livro;
select * from tbl_assunto;

INSERT INTO tbl_livro (NomeLivro,ISBN,PrecoLivro,NumPaginas,Edicao,DataPub,IdEditora,IdAssunto)
VALUES ('Guia dos Dinossauros','2345671278',45.30,460,2,'20000320',5,7);

DELETE FROM tbl_livro
WHERE IdAssunto =
	(SELECT IdAssunto
	FROM tbl_assunto
    WHERE NomeAssunto LIKE 'Dino%');
    
SELECT * FROM tbl_livro;

CREATE TABLE LivrosAssuntos (
ID TINYINT PRIMARY KEY AUTO_INCREMENT,
NomeLivro VARCHAR(50),
NomeAssunto VARCHAR(40)
);

INSERT INTO LivrosAssuntos (NomeLivro, NomeAssunto)
(SELECT L.NomeLivro, A.NomeAssunto
FROM tbl_livro L
INNER JOIN tbl_assunto A
ON L.IdAssunto = A.IdAssunto
WHERE L.NumPaginas >= 600);

SELECT * FROM LivrosAssuntos;