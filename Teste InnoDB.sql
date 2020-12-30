USE Teste_InnoDB;

CREATE TABLE tbl_mult (
 ID SMALLINT PRIMARY KEY AUTO_INCREMENT,
 num1 SMALLINT NOT NULL,
 num2 SMALLINT NOT NULL,
 num3 SMALLINT GENERATED ALWAYS AS (num1 * num2) VIRTUAL
 );
 
 
 INSERT INTO tbl_mult (num1, num2)
 VALUES (2, 1), (2, 2), (2, 3), (2, 4);
 
 
 SELECT * FROM tbl_mult;
 
 
 UPDATE tbl_mult
 SET num2 = 8
 WHERE ID = 2;
 
 
 CREATE TABLE tbl_Vendas (
 ID_Venda SMALLINT PRIMARY KEY AUTO_INCREMENT,
 Preco_Produto DECIMAL(6,2) NOT NULL,
 Qtde TINYINT NOT NULL,
 Desconto DECIMAL(4,2) NOT NULL,
 Preco_Total DECIMAL(6,2) AS (Preco_Produto * Qtde * (1 - Desconto / 100)) STORED
 );
 
 
 INSERT INTO tbl_vendas (Preco_Produto, Qtde, Desconto)
 VALUES
 (50.00, 2, 20),
 (65.00, 3, 15),
 (100.00, 1, 12),
 (132.00, 3, 18);
 
 
 SELECT * FROM tbl_Vendas;
  
  
  
 SHOW COLUMNS
 FROM tbl_mult;
 
 DESCRIBE tbl_mult;