-- P1 tipo 2

use carloca;
  
-- 1. Elabore procedure que receba um número inteiro e apresente a soma de seus divisores. 
  
DROP PROCEDURE IF EXISTS SomaDivisores;
  
DELIMITER //
CREATE PROCEDURE SomaDivisores(IN numero INT, OUT soma INT)
BEGIN
  DECLARE indice INT DEFAULT 1;
  DECLARE total INT DEFAULT 0;

  SumLoop: LOOP
    IF indice > numero THEN
      LEAVE SumLoop;
    END IF;

    IF MOD(numero, indice) = 0 THEN
      SET total = total + indice;
    END IF;
    
    SET indice = indice + 1;

  END LOOP;


  SET soma = total;
  
END//
DELIMITER ;


CALL SomaDivisores(12, @resultado);
SELECT @resultado;

CALL SomaDivisores(28, @resultado);
SELECT @resultado;


-- 2. Elabore procedure que apresente a média de comissões de todos os departamentos.
  


DROP PROCEDURE IF EXISTS ComsMedia;

DELIMITER //
CREATE PROCEDURE ComsMedia()
BEGIN
  DECLARE v_CdDepto INT;
  DECLARE v_NmDepto VARCHAR(100);
  DECLARE mais_linhas INT DEFAULT 0;

  DECLARE DeptosCursor CURSOR FOR SELECT Cd_Depto, Nm_Depto FROM loc_depto;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET mais_linhas = 1;

  OPEN DeptosCursor;

  depto_loop: LOOP
    FETCH DeptosCursor INTO v_CdDepto, v_NmDepto;
    IF mais_linhas = 1 THEN 
      LEAVE depto_loop;
    END IF;

    SELECT d.Nm_Depto as Departamento, avg(f.Vl_Perc_Comissao) as MediaComissao
    FROM loc_funcionario f
    INNER JOIN loc_depto d
      ON f.Cd_Depto = d.Cd_Depto
    GROUP BY d.Nm_Depto;

    LEAVE depto_loop;
  END LOOP;


  CLOSE DeptosCursor;
END//
DELIMITER ;


CALL ComsMedia();