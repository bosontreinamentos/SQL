SELECT * FROM tbl_editoras;
SHOW EVENTS FROM db_meuslivros;

# Exemplo 01 - Eventos
DELIMITER //
CREATE EVENT insert_imediato
ON SCHEDULE AT CURRENT_TIMESTAMP
DO BEGIN
INSERT INTO tbl_editoras(NomeEditora)
VALUES ('Bóson Books');
END//
DELIMITER ;

# Exemplo 02 - Eventos
DELIMITER //
CREATE EVENT insert_em_um_mes
ON SCHEDULE AT NOW() + INTERVAL 1 MONTH
DO BEGIN
INSERT INTO tbl_editoras(NomeEditora)
VALUES ('Tech Books Brazil');
END//
DELIMITER ;

# Exemplo 03 - Eventos
DELIMITER //
CREATE EVENT insert_mensal
ON SCHEDULE EVERY 1 MONTH
STARTS '2020-10-15'
DO BEGIN
INSERT INTO tbl_editoras(NomeEditora)
VALUES ('Bóson Books');
END//
DELIMITER ;