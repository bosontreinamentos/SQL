USE db_meuslivros;
-- 1 - Criar a tabela de exemplo:
CREATE TABLE Produto (
  idProduto INT NOT NULL AUTO_INCREMENT,
  Nome_Produto VARCHAR(45) NULL,
  Preco_Normal DECIMAL(10,2) NULL,
  Preco_Desconto DECIMAL(10,2) NULL,
  PRIMARY KEY (idProduto));

-- 2 - Criar o Trigger:
CREATE TRIGGER tr_desconto BEFORE INSERT
ON Produto
FOR EACH ROW
SET NEW.Preco_Desconto = (NEW.Preco_Normal * 0.90);

-- 3 - Executar uma inserção que irá disparar o Trigger:
INSERT INTO Produto (Nome_Produto, Preco_Normal)
VALUES ("DVD", 1.00), ("Pendrive", 18.00);

-- 4 - Verificar se trigger foi disparado observando o preço com desconto:
SELECT * FROM Produto;

DROP FUNCTION IF EXISTS inicial_maiuscula;
DELIMITER //
CREATE FUNCTION inicial_maiuscula(texto VARCHAR(100))
RETURNS VARCHAR(100)
BEGIN
	RETURN CONCAT(UPPER(LEFT(texto,1)),SUBSTRING(texto,2));
END//
DELIMITER ;

SELECT inicial_maiuscula('fábio'),
inicial_maiuscula('frase iniciada em minúscula'),
inicial_maiuscula('PIZZA'),
inicial_maiuscula('pANDEMIA');

SELECT * FROM INFORMATION_SCHEMA.INNODB_FT_DEFAULT_STOPWORD;

SHOW VARIABLES LIKE 'event%';
SET GLOBAL event_scheduler = ON;

DELIMITER //
CREATE EVENT consulta_teste
ON SCHEDULE AT NOW()
DO BEGIN
	SELECT * FROM tbl_assuntos;
END//
DELIMITER ;   


DELIMITER //
CREATE EVENT insert_teste
ON SCHEDULE AT NOW()
DO BEGIN
	INSERT INTO tbl_editoras(NomeEditora)
    VALUES ('Bóson Books');
END//
DELIMITER ;   
SELECT * FROM tbl_editoras;
SHOW EVENTS;
DROP EVENT consulta_teste;