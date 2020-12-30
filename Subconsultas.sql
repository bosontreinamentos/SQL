USE db_biblioteca;

SELECT NomeLivro, PrecoLivro, IdEditora
FROM tbl_livro
WHERE IdEditora =
	(SELECT IdEditora
	FROM tbl_editora
	WHERE NomeEditora = 'Wiley');
    
SELECT * FROM tbl_livro;

UPDATE tbl_livro
SET PrecoLivro = PrecoLivro * 1.12
WHERE IdEditora = 
	(SELECT IdEditora
	FROM tbl_editora
	WHERE NomeEditora = 'Microsoft Press');