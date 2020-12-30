# Exemplo 01
SELECT Nome_Livro Livro, Preco_Livro Preço, 'Livro Caro' Resultado
FROM tbl_Livros
WHERE Preco_Livro >= 60.00
UNION
SELECT Nome_Livro Livro, Preco_Livro Preço, 'Preço Razoável' Resultado
FROM tbl_Livros
WHERE Preco_Livro < 60.00
ORDER BY Preço;

# Exemplo 02
SELECT L.Nome_Livro Livro, L.Data_Pub 'Data de Publicação',
L.Preco_Livro 'Preço Normal', L.Preco_Livro * 0.90 'Preço Ajustado'
FROM tbl_Livros L
WHERE L.Preco_Livro > 65.00
UNION
SELECT L.Nome_Livro Livro, L.Data_Pub 'Data de Publicação', L.Preco_Livro 'Preço Normal', L.Preco_Livro * 1.15 'Preço Ajustado'
FROM tbl_Livros L 
WHERE L.Data_Pub < '20120415';

SELECT * FROM tbl_livros;