SET autocommit=0;
SELECT @@autocommit;
START TRANSACTION;
INSERT INTO curso (Nome_Curso, Cod_Departamento) VALUES ('História da Numismática', 1);
INSERT INTO curso (Nome_Curso, Cod_Departamento) VALUES ('Biologia Marinha', A);
INSERT INTO curso (Nome_Curso, Cod_Departamento) VALUES ('Química', 1);
INSERT INTO curso (Nome_Curso, Cod_Departamento) VALUES ('Artes', 1);
ROLLBACK;

SELECT * FROM curso;

SHOW TABLE STATUS WHERE name = 'curso';