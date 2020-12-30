USE db_biblioteca;

SELECT IdEditora, COUNT(NomeLivro) 'Qtde Livros'
FROM tbl_livro
GROUP BY IdEditora;

SELECT IdEditora, COUNT(NomeLivro) 'Qtde Livros', NumPaginas
FROM tbl_livro
GROUP BY IdEditora
HAVING NumPaginas > 900;

SELECT NomeLivro, NumPaginas,
EXTRACT(YEAR FROM DataPub) AS 'Ano de Publicação'
FROM tbl_livro
ORDER BY Datapub;

SELECT NomeLivro, NumPaginas,
EXTRACT(MONTH FROM DataPub) AS 'Mês de Publicação'
FROM tbl_livro;

SELECT EXTRACT(MONTH FROM DataPub) Mês, COUNT(*) 'Qtde Livros'
FROM tbl_livro
GROUP BY Mês;

LOAD DATA LOCAL INFILE 'C:/assuntos.csv'
INTO TABLE tbl_assunto
# Arquivo não foi salvo com codificação UTF-8; ajustar charset:
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(NomeAssunto);

SELECT * FROM tbl_assunto;

# Exemplo com arquivo salvo com codificação UTF-8
LOAD DATA LOCAL INFILE 'C:/autores.csv'
INTO TABLE tbl_autor
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(NomeAutor,SobrenomeAutor);

SELECT * FROM tbl_autor;

LOAD DATA LOCAL INFILE 'C:/livros.csv'
INTO TABLE tbl_livro
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(NomeLivro,ISBN,PrecoLivro,NumPaginas,Edicao,DataPub,IdEditora,IdAssunto);

SELECT * FROM tbl_livro;