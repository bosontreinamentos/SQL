# Operadores IN e NOT IN
# Filtragem usando listas de valores no MySQL

USE db_biblioteca;

# Exemplo 01
SELECT NomeLivro, IdEditora
FROM tbl_livro
WHERE IdEditora IN (2,4);

# Exemplo 02
SELECT NomeLivro, Edicao
FROM tbl_livro
WHERE Edicao NOT IN (1,2);

# Exemplo 03
SELECT NomeLivro, IdEditora
FROM tbl_livro 
WHERE IdEditora IN (
	SELECT IdEditora
    FROM tbl_editora
    WHERE NomeEditora = 'Wiley' OR NomeEditora = 'Microsoft Press'
);

SELECT * FROM tbl_livro;

SELECT NomeEditora, IdEditora
FROM tbl_editora;