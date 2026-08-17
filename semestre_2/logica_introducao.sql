-- SEGUNDO PERÍODO

use carloca;

-- select também funciona como print
select "Alô Mundo";
select 3 * 9;

-- criando uma função

DELIMITER //
CREATE FUNCTION Alo_Mundo(frase varchar(70)) -- cria a função Alo_Mundo
RETURNS varchar(70) -- retorna um varchar de até 70 caracteres
DETERMINISTIC
BEGIN
RETURN frase;
END //
DELIMITER ; -- para criar a função, selecione ela inteira e aperte no raio sem I

Select Alo_Mundo('Alô Mundo!');


DELIMITER //
CREATE FUNCTION ola (frase_entrada CHAR(70)) 
RETURNS CHAR(70) 
DETERMINISTIC 
BEGIN
   RETURN CONCAT('Olá, ',frase_entrada,'!');  
END //
DELIMITER ;

SELECT ola('ESPM');

select * from loc_funcionario;

-- o if dentro do select vem para uma tomada de decisão

Select Nm_Func, Vl_Salario, 
       if(Vl_Salario<3000,'baixo',if(Vl_Salario< 8000,'médio','alto'))
  from loc_funcionario
  order by Vl_Salario;

-- Exiba o maior entre dois números distintos entre si
DROP FUNCTION IF EXISTS Maior;

DELIMITER //
CREATE FUNCTION Maior(n INT, m INT) -- entra dois inteiros
  RETURNS VARCHAR(20) --
  
  DETERMINISTIC 
  BEGIN
    DECLARE maior int;
    DECLARE s varchar(20);

    IF n > m THEN SET maior = n;
    ELSE SET maior = m;
    END IF;
    
    set s = concat(maior,' é o maior!');
    
    RETURN s;
END //

DELIMITER ;

Select Maior(2,2);
Select Maior(4,7);
Select Maior(3,2);

-- Comparando dois números

DELIMITER //

CREATE FUNCTION Comparar(n INT, m INT)
  RETURNS VARCHAR(20)
  
  DETERMINISTIC 
  BEGIN
    DECLARE s VARCHAR(20);

    IF n > m THEN SET s = '>';
    ELSEIF n = m THEN SET s = '=';
    ELSE SET s = '<';
    END IF;

    SET s = CONCAT(n, ' ', s, ' ', m);

    RETURN s;
  END //

DELIMITER ;

Select Comparar(12,11);
Select Comparar(11,11);
Select Comparar(11,12);

-- Dados 3 números inteiros e distintos entre si, imprima o maior deles

DROP FUNCTION IF EXISTS Maior_de_3_Var_Aux;
-- Estratégia da Variável Auxiliar
DELIMITER //
CREATE FUNCTION Maior_de_3_Var_Aux(a INT, b INT, c INT)
  RETURNS VARCHAR(20)
  
  DETERMINISTIC 
  BEGIN
    DECLARE maior int;
    DECLARE s varchar(20);

    IF a > b THEN SET maior = a;
    ELSE SET maior = b;
    END IF;
    
    if c > maior then SET maior = c;
    END IF;
    
    set s = concat(maior,' é o maior!');
    
    RETURN s;
END //

DELIMITER ;

Select Maior_de_3_Var_Aux(1,2,3);
Select Maior_de_3_Var_Aux(3,2,1);
Select Maior_de_3_Var_Aux(1,3,2);

DROP FUNCTION IF EXISTS Maior_de_3_Ordenado;

-- Estratégia da Ordenação
DELIMITER //
CREATE FUNCTION Maior_de_3_Ordenado(a INT, b INT, c INT)
  RETURNS VARCHAR(20)
  
  DETERMINISTIC 
  BEGIN
    DECLARE d int;
    DECLARE s varchar(20);

    IF a > b THEN
       BEGIN 
          SET d = a;
          SET a = b;
          SET b = d;
       END;   
    END IF; 
	IF b > c THEN 
       BEGIN
         SET d = b;
         SET b = c;
         SET c = d;
       END;  
    END IF;   
              
    set s = concat(c,' é o maior!');
    
    RETURN s;
END //

DELIMITER ;

Select Maior_de_3_ordenado(1,2,3);
Select Maior_de_3_ordenado(3,2,1);
Select Maior_de_3_ordenado(1,3,2);

-- indicar a quantidade de selos com base no peso
-- selos de 3 e de 5, usar a menor quantidade possível
-- até 8g -> valor de 8 selos
-- 9g -> valor de 9 selos
-- 15g -> valor de 15 selos

DROP procedure IF EXISTS Selos;

DELIMITER //
CREATE PROCEDURE Selos(peso int) -- cria o procedure
BEGIN
  DECLARE v1 INT; -- declara as variaveis e seus tipos
  DECLARE soma INT;
  DECLARE Tres INT; 
  DECLARE Cinco INT;
  DECLARE QuocienteR FLOAT;
  DECLARE Quociente INT;
  DECLARE Resto INT;
  DECLARE Texto VARCHAR(80);
  
  if Peso < 8 then
     set Peso = 8;
  end if;
  
  SET QuocienteR = Peso / 5;
  SET Quociente = Truncate(quocienteR,0);
  -- Necessário converter para Inteiro, pois não há "meio" selo...
  set Resto = Mod(Peso,5);
  
  -- Para ver resultados intermediários tire esse comentário e comente a saída final 
  -- Select Concat('Peso ',convert(peso,char),'  QuocienteR ',convert(quocienter,char),'  Quociente: ',convert(Quociente,char),'  e Resto: ',convert(Resto,char));
  
  if Resto = 0 then
     SET Cinco = Quociente;
     SET Tres  = 0;
  else
     if Resto = 1 then
        SET Cinco = Quociente - 1;
        SET Tres  = 2;
     else   
        if Resto = 2 then
           SET Cinco = Quociente - 2;
           SET Tres  = 4;
        else   
           if Resto = 3 then
              SET Cinco = Quociente;
              SET Tres  = 1;
           else
              if Resto = 4 then
                 SET Cinco = Quociente - 1;
                 SET Tres  = 3;   
              end if;   
           end if;   
        end if;   
     end if;   
  end if;  
  
 Set Texto = Concat('Total de Selos de Cinco é ',convert(Cinco,char),' e o total de seles de Três é ',convert(Tres,char));
 Select Texto;    

END//
DELIMITER ;

Call Selos(13);  
Call Selos(11);

-- LOOPS

-- Loop Acumular "n" números
Drop procedure if exists acumula;
DELIMITER //
CREATE PROCEDURE acumula (limite INT) -- o range
BEGIN
DECLARE contador INT DEFAULT 0;
DECLARE soma INT DEFAULT 0;
loop_teste: LOOP                     -- for i in range(limite):
    SET contador = contador + 1;     -- 	contador += 1
    SET soma = soma + contador;      -- 	soma += contador
    IF contador >= limite THEN
        LEAVE loop_teste;
    END IF;
END LOOP loop_teste;
SELECT soma;                         -- print(soma)
END//
DELIMITER ;

-- Testando
CALL acumula(5);


DROP procedure IF EXISTS DOWHILE;

DELIMITER //
CREATE PROCEDURE dowhile(limite int)
BEGIN
  DECLARE v1 INT DEFAULT 0;      -- mesma coisa que o de cima, mas é com while
  DECLARE soma INT DEFAULT 0;
  WHILE v1 <= limite DO          -- while v1 <= limite:
    SET soma = soma + v1;        -- 	soma += v1
    SET v1 = v1 + 1;             -- 	v1 += 1
  END WHILE;
Select Soma;                     -- print(soma)
END//
DELIMITER ;


CALL dowhile(5);

DROP procedure IF EXISTS Proc_Impares;

-- Ímpares entre 2 números
DELIMITER //
CREATE PROCEDURE Proc_impares (a INT, b INT) -- nomeia as variaveis
BEGIN
DECLARE i INT DEFAULT a; -- i tem valor inicial de a
DECLARE Texto VARCHAR(80);
SET Texto = 'Ímpares ';
set i = a;
loop_impar: LOOP                                          -- for i in range(a, b+1):
	if mod(i,2) != 0 then -- mod significa resto          -- 	if i % 2 != 0:
       set texto = Concat(texto,' - ',convert(i,char));   -- 		adiciona i em char ao texto
    end if;  
    set i = i + 1;
    if i > b then
       leave loop_impar;
    end if;   
END LOOP loop_impar;
SELECT texto;
END//
DELIMITER ;

Call Proc_Impares(10,20);


DROP function IF EXISTS Func_Impares;

-- Ímpares entre 2 números
DELIMITER //
CREATE Function Func_impares (a INT, b INT)
  RETURNS Varchar(80)
DETERMINISTIC  
BEGIN
DECLARE i INT DEFAULT a;
DECLARE Texto VARCHAR(80);
SET Texto = 'Ímpares ';
set i = a;
loop_impar: LOOP
	if mod(i,2) != 0 then
       set texto = Concat(texto,' - ',convert(i,char));
    end if;  
    set i = i + 1;
    if i > b then
       leave loop_impar;
    end if;   
END LOOP loop_impar;
RETURN texto;
END//
DELIMITER ;

Select Func_Impares(10,20);