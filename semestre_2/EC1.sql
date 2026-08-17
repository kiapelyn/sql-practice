use carloca;
-- 1- Elabore, usando WHILE, algoritmo que apresente os ímpares entre dois números dados.
DROP FUNCTION IF EXISTS IMPARES;

DELIMITER //
CREATE FUNCTION IMPARES(N1 INT, N2 INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE TEXTO VARCHAR(100) DEFAULT 'Ímpares = ';
    IF N1 % 2 = 0 THEN
        SET N1 = N1 + 1;
    END IF;
    WHILE N1 <= N2 DO
        SET TEXTO = CONCAT(TEXTO, ' ', CONVERT(N1, CHAR));
        SET N1 = N1 + 2;
    END WHILE;
    RETURN TEXTO;
END//
DELIMITER ;

SELECT IMPARES(10, 20);


-- 2- Elabore algoritmo que apresente a soma dos ímpares entre dois números dados.
DROP FUNCTION IF EXISTS somaImpares;

DELIMITER //
CREATE PROCEDURE somaImpares(a INT, b INT)
BEGIN
	DECLARE soma INT DEFAULT 0;
    DECLARE aux INT DEFAULT b;
    DECLARE qtdnum INT DEFAULT 0;
    
	IF b < a THEN
		BEGIN
            SET b = a;
            SET a = aux;
		END;
	END IF;
    
	IF MOD(a,2) = 0 THEN
		BEGIN
			SET a = a + 1;
        END;
	END IF;

	IF MOD(b,2) = 0 THEN
		BEGIN
			SET b = b - 1;
        END;
	END IF;
    
    SET qtdnum = (b - a ) / 2 + 1;
    
	SET SOMA = (a + b) * qtdnum/2;
    SELECT SOMA;

END //
DELIMITER ;

CALL somaImpares(20,70);


-- 3- Elabore algoritmo que apresente os “n” primeiros termos de Fibonacci(0 1 1 2 3 5 8 13 21 34...)
DROP FUNCTION IF EXISTS FIBONACCI;

DELIMITER //
CREATE FUNCTION FIBONACCI(c int)
returns varchar(80)
deterministic
begin
	declare i int default 0;
	declare b int default 1;
    declare cont int default 0;
	declare proximo int;
	declare textoFIB varchar(255) default 'Fibonacci: ';	

	while cont<c do
		set textoFIB = concat(textoFIB, ' - ', convert(i,char));
		set proximo = i+b;
		set b = i;
		set i = proximo;
        set cont = cont +1;
	end while;
	return textoFIB;
end//
DELIMITER ;

select FIBONACCI(10);


-- 4- Dados dois números indique seu Máximo Divisor Comum
DROP PROCEDURE IF EXISTS MDC;
DELIMITER //
CREATE PROCEDURE MDC(m INT, n INT)
BEGIN
	DECLARE aux INT DEFAULT n;
    
    IF n < m THEN
		BEGIN
			SET n = m;
            SET m = aux;
        END;
    END IF;

	loop_mdc: LOOP
		
		IF n > m THEN
			BEGIN
				SET aux = m;
				SET m = n;
				SET n = aux;
			END;
		END IF;
        
		IF n = 0 THEN
			BEGIN
				LEAVE loop_mdc;
			END;
		END IF;
    
		IF n > 0 THEN
			BEGIN 
				SET aux = m;
				SET m = n;
				SET n = MOD(aux, n);
			END;
		END IF;
        

	END lOOP loop_mdc;
    
    SELECT m;
END //
DELIMITER ;

CALL MDC(10, 5);
CALL MDC(14, 21);
CALL MDC(9, 28);


-- 5- Elabore algoritmo que apresente números primos entre dois números dados. Avalie a possibilidade de otimizar o algoritmo.

DROP PROCEDURE IF EXISTS intervalPrimo;

DELIMITER //
CREATE PROCEDURE intervalPrimo(a INT, b INT)
BEGIN
    DECLARE aux INT DEFAULT b;
    DECLARE num INT DEFAULT 0;
    DECLARE texto VARCHAR(9999) DEFAULT '';
    DECLARE i INT;
    DECLARE ehprimo BOOL;

	# Ajuste de intervalo
	IF b < a THEN
		SET aux = a;
		SET a = b;
		SET b = aux;
	END IF;

	# Loop do num até B
    loop_num :LOOP
        IF num > b THEN 
            LEAVE loop_num;
        END IF;

        SET ehprimo = TRUE;

        IF num <= 1 THEN
            SET ehprimo = FALSE;
        ELSEIF num = 2 THEN
            SET ehprimo = TRUE;
        ELSEIF MOD(num,2) = 0 THEN
            SET ehprimo = FALSE;
        ELSE
            SET i = 3;
            loop_primo: LOOP
                IF i > POW(num,0.5) THEN
                    LEAVE loop_primo;
                END IF;

                IF MOD(num,i) = 0 THEN
                    SET ehprimo = FALSE;
                    LEAVE loop_primo;
                END IF;

                SET i = i + 2;
            END LOOP loop_primo;
        END IF;

        IF ehprimo THEN
            SET texto = CONCAT(texto, ' ', num);
        END IF;

        SET num = num + 1;
    END LOOP loop_num;

    SELECT texto;
END //
DELIMITER ;

CALL intervalPrimo(30, 1);
