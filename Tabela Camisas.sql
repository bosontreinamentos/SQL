CREATE TABLE camisas (
  idCamisa TINYINT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(25),
  tamanho ENUM('pequena','média','grande','extra-grande')
);


INSERT INTO camisas (nome, tamanho)
VALUES ('regata', 'grande');


SELECT * FROM camisas;


INSERT INTO camisas (nome, tamanho)
VALUES ('social', 'medium');


INSERT INTO camisas (nome, tamanho)
VALUES
('social', 'média'),
('polo', 'pequena'),
('polo', 'grande'),
('camiseta', 'extra-grande');


SELECT * FROM camisas;

/* consultar os valores permissíveis para a coluna */
SHOW COLUMNS
FROM camisas
LIKE 'tamanho';


/* visualizar números de índice dos valores enumerados */
SELECT nome, tamanho+0
FROM camisas;


/* Problemas com ORDER BY */
SELECT * FROM camisas
ORDER BY tamanho;


/* Resolvendo problema com ORDER BY */
SELECT * FROM camisas
ORDER BY CAST(tamanho AS CHAR);


DROP TABLE camisas;