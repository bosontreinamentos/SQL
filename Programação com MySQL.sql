USE db_meuslivros;

DELIMITER //
CREATE FUNCTION teste()
RETURNS DECIMAL(10,2)
BEGIN
	DECLARE maiorPreco DECIMAL(10,2);
    DECLARE menorPreco DECIMAL(10,2);
    DECLARE diferenca DECIMAL(10,2);
    SELECT MAX(PrecoLivro), MIN(PrecoLivro)
    INTO maiorPreco,MenorPreco
    FROM tbl_livros;
	SET diferenca = maiorPreco - menorPreco;
	RETURN diferenca;
END//
DELIMITER ;

SELECT teste();
SELECT CONCAT('Diferença entre o livro mais caro e o mais barato: R$',teste())
AS Resultado;

DROP FUNCTION teste;

# IF ELSEIF ELSE
DELIMITER //
CREATE FUNCTION testeIF(num SMALLINT)
RETURNS VARCHAR(30)
BEGIN
	DECLARE valor SMALLINT;
	SET valor = num;
    IF (valor > 10) THEN
		RETURN 'Número maior que 10';
	ELSEIF (valor < 10) THEN
		RETURN 'Numero menor que 10';
    ELSE
		RETURN 'Numero igual a 10';
    END IF;
END//
DELIMITER ;

DROP FUNCTION testeIF;

SELECT testeIF(10);

DELIMITER //
CREATE FUNCTION testeP(id SMALLINT)
RETURNS VARCHAR(50)
BEGIN
	DECLARE numP SMALLINT;
    
    SELECT NumeroPaginas INTO numP
    FROM tbl_livros WHERE IDLivro = id;
    
    IF numP >= 1000 THEN
		RETURN CONCAT(numP, ' Páginas. Livro grande hein?');
    ELSE
		RETURN CONCAT(numP, ' Páginas. Tranquilo para ler');
    END IF;
END//
DELIMITER ;

SELECT testeP(104);

DROP FUNCTION testeP;

SELECT * FROM tbl_livros;

# Estruturas de Repetição: Bloco WHILE
DELIMITER //
CREATE PROCEDURE acumula_while (limite TINYINT UNSIGNED)
BEGIN
	DECLARE contador TINYINT UNSIGNED DEFAULT 0;
	DECLARE soma INT DEFAULT 0;
	WHILE contador < limite DO
    	SET contador = contador + 1;
    	SET soma = soma + contador;
	END WHILE;
	SELECT soma;
END//
DELIMITER ;

CALL acumula_while(1000);
CALL acumula_while(0);

# Estrutura de Repetição LOOP
DELIMITER //
CREATE PROCEDURE acumula (limite INT)
BEGIN
	DECLARE contador INT DEFAULT 0;
	DECLARE soma INT DEFAULT 0;
	loop_teste: LOOP
    		SET contador = contador + 1;
    		SET soma = soma + contador;
    		IF contador >= limite THEN
        			LEAVE loop_teste;
    		END IF;
	END LOOP loop_teste;
	SELECT soma;
END//
DELIMITER ;

CALL acumula(10);

# Estrutura de Repetição REPEAT
DELIMITER //
CREATE PROCEDURE acumula_repita (limite TINYINT UNSIGNED)
BEGIN
	DECLARE contador TINYINT UNSIGNED DEFAULT 0;
	DECLARE soma INT DEFAULT 0;
	REPEAT
    		SET contador = contador + 1;
    		SET soma = soma + contador;
		UNTIL contador >= limite
	END REPEAT;
	SELECT soma;
END//
DELIMITER ;

CALL acumula_repita(10);
CALL acumula_repita(0);

# REPEAT com LEAVE
DELIMITER //
CREATE PROCEDURE acumula_leave (limite TINYINT UNSIGNED)
main:BEGIN
	DECLARE contador TINYINT UNSIGNED DEFAULT 0;
	DECLARE soma INT DEFAULT 0;
	IF limite < 1 THEN
    	SELECT 'O valor deve ser maior que zero.' AS Erro;
    	LEAVE main;
	END IF;
	REPEAT
    	SET contador = contador + 1;
    	SET soma = soma + contador;
	UNTIL contador >= limite
	END REPEAT;
	SELECT soma;
END//
DELIMITER ;

CALL acumula_leave(10);
CALL acumula_leave(0);

# Declaração ITERATE
DELIMITER //
CREATE PROCEDURE acumula_iterate (limite TINYINT UNSIGNED)
BEGIN
	DECLARE contador TINYINT UNSIGNED DEFAULT 0;
	DECLARE soma INT UNSIGNED DEFAULT 0;
	teste: LOOP
		SET contador = contador +1;
		SET soma = soma + contador;
		IF contador < limite THEN
			ITERATE teste;
		END IF;
		LEAVE teste;
	END LOOP teste;
	SELECT soma;
END//
DELIMITER ;

CALL acumula_iterate(100);

# ITERATE 02
DELIMITER //
CREATE PROCEDURE pares(limite TINYINT UNSIGNED)
main: BEGIN
	DECLARE contador TINYINT DEFAULT 0;
	meuloop: WHILE contador < limite DO
    	SET contador = contador + 1;
    	IF MOD(contador, 2) THEN
        		ITERATE meuloop;
    	END IF;
    	SELECT CONCAT(contador, ' é um número par') AS Valor;
	END WHILE;
END//
DELIMITER ;

CALL pares(19);

# Triggers
# Criar trigger
CREATE TRIGGER tr_insere_assunto AFTER INSERT
ON tbl_assuntos
FOR EACH ROW
SET @msg = "Assunto inserido com sucesso!";

# Inserir registro para testar disparo do trigger
INSERT INTO tbl_assuntos(Assunto)
VALUES ("Cálculo");

# Verificar resultado
SELECT @msg;

# Triggers: Exemplo 02
# Criar trigger
DROP TRIGGER IF EXISTS tr_insere_livro;
DELIMITER //
CREATE TRIGGER tr_insere_livro BEFORE INSERT
ON tbl_livros
FOR EACH ROW
BEGIN
	IF NEW.DataPub IS NULL THEN
		SET NEW.DataPub = CURDATE();
	END IF;
END//
DELIMITER ;

# Inserir registro para testar disparo do trigger
USE db_meuslivros;
INSERT INTO tbl_Livros (NomeLivro, ISBN13, DataPub, PrecoLivro, NumeroPaginas, IdAssunto, IdEditora)
VALUES
('Livro Teste','9780952012899', NULL, 180.21, 999, 5, 4);

INSERT INTO tbl_Livros (NomeLivro, ISBN13, PrecoLivro, NumeroPaginas, IdAssunto, IdEditora)
VALUES
('Livro Teste 2','9780952012899', 180.21, 999, 5, 4);

# Verificando a funcionalidade do trigger:
SELECT * FROM tbl_livros;
SELECT variable_name
FROM performance_schema.user_variables_by_thread;

SHOW EVENTS;

# CASE ... WHEN
DROP PROCEDURE IF EXISTS num_paginas;
DELIMITER $$
CREATE PROCEDURE num_paginas(var_id SMALLINT)
BEGIN
DECLARE var_num_pag SMALLINT;
SELECT NumeroPaginas INTO var_num_pag
FROM tbl_livros WHERE IDLivro = var_id;

CASE
	WHEN var_num_pag < 100 THEN SELECT 'Livreto';
	WHEN var_num_pag BETWEEN 100 AND 900 THEN SELECT 'Livro grande';
    WHEN var_num_pag > 900 THEN SELECT 'Livro grande';
	ELSE SELECT 'Valor inválido';
END CASE;
END $$
DELIMITER ;

CALL num_paginas(105);

SELECT * FROM tbl_livros;
