/* ================================================
   KIT DE SOBREVIVÊNCIA MYSQL – FUNCTIONS & PROCEDURES
   ================================================ */

-- 🔹 1. Criar uma PROCEDURE
DELIMITER //
CREATE PROCEDURE ExemploProcedure(IN valor INT)
BEGIN
    -- Aqui vai o código da procedure
    UPDATE Funcionarios SET Salario = Salario + valor;
END;
//
DELIMITER ;

-- Chamando procedure:
CALL ExemploProcedure(500);


-- 🔹 2. Criar uma FUNCTION
DELIMITER //
CREATE FUNCTION ExemploFuncao(valor INT)
RETURNS INT
DETERMINISTIC
BEGIN
    -- Sempre precisa retornar algo
    RETURN valor * 2;
END;
//
DELIMITER ;

-- Usando function:
SELECT ExemploFuncao(5); -- retorna 10


/* ================================================
   PARÂMETROS
   ================================================ */
-- IN     = entrada (default, pode omitir)
-- OUT    = saída (a procedure devolve algo)
-- INOUT  = pode ser entrada e saída

-- Exemplo com OUT:
DELIMITER //
CREATE PROCEDURE ContaFuncionarios(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM Funcionarios;
END;
//
DELIMITER ;

-- Chamando:
CALL ContaFuncionarios(@qtd);
SELECT @qtd; -- mostra o valor retornado


/* ================================================
   VARIÁVEIS LOCAIS
   ================================================ */
-- Criando variáveis internas:
DECLARE contador INT DEFAULT 0;
SET contador = 5;


/* ================================================
   CONTROLE DE FLUXO
   ================================================ */

-- IF
IF salario > 1000 THEN
    SET bonus = 200;
ELSE
    SET bonus = 100;
END IF;

-- CASE
CASE cargo
    WHEN 'Gerente' THEN SET bonus = 500;
    WHEN 'Analista' THEN SET bonus = 300;
    ELSE SET bonus = 100;
END CASE;

-- WHILE
SET contador = 1;
WHILE contador <= 5 DO
    INSERT INTO Numeros(valor) VALUES (contador);
    SET contador = contador + 1;
END WHILE;

-- REPEAT
SET contador = 1;
REPEAT
    INSERT INTO Numeros(valor) VALUES (contador);
    SET contador = contador + 1;
UNTIL contador > 5
END REPEAT;

-- LOOP + LEAVE
SET contador = 1;
meu_loop: LOOP
    IF contador > 5 THEN
        LEAVE meu_loop; -- sai do loop
    END IF;
    INSERT INTO Numeros(valor) VALUES (contador);
    SET contador = contador + 1;
END LOOP;


/* ================================================
   SELECT INTO
   ================================================ */
-- Armazena resultado de query em variável:
SELECT COUNT(*) INTO total FROM Funcionarios;


/* ================================================
   DIFERENÇA FUNCTION vs PROCEDURE
   ================================================ */
-- FUNCTION → sempre retorna valor, usada em SELECT
-- PROCEDURE → executa ações, pode alterar tabelas, chamada com CALL

-- Frase de ouro: 
-- "FUNCTION responde, PROCEDURE age"



/* ================================================
   CURSORES EM MySQL - EXEMPLOS E DICAS (TUDO NUM BLOCO)
   ================================================ */

-- IMPORTANTE: em MySQL use DELIMITER ao criar stored routines
DELIMITER //

/* 1) CURSOR BÁSICO: percorre funcionários e insere num log */
CREATE PROCEDURE ExemploCursorLog()
BEGIN
    -- DECLARES: sempre logo após o BEGIN
    DECLARE v_id INT;
    DECLARE v_nome VARCHAR(100);
    DECLARE fim_cursor INT DEFAULT 0;                  -- flag para saber quando terminar

    -- declara o cursor que traz as linhas
    DECLARE c CURSOR FOR 
        SELECT id, nome FROM Funcionarios;

    -- handler para quando não houver mais linhas (evita erro)
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_cursor = 1;

    -- abrir e percorrer
    OPEN c;
    meu_loop: LOOP
        FETCH c INTO v_id, v_nome;                     -- joga linha nas variáveis
        IF fim_cursor = 1 THEN
            LEAVE meu_loop;                           -- sai quando acabar
        END IF;

        -- faça o que precisar com os valores (aqui: insere em tabela de log)
        INSERT INTO LogFuncionarios(id_func, nome_func, data_log) 
        VALUES (v_id, v_nome, NOW());
    END LOOP;

    CLOSE c;                                          -- não esquecer de fechar o cursor
END;
//


/* 2) EXEMPLO CLÁSSICO DE PROVA: soma salários com CURSOR e devolve via OUT */
CREATE PROCEDURE SomaSalariosCursor(OUT total_salarios DECIMAL(15,2))
BEGIN
    DECLARE v_salario DECIMAL(15,2);
    DECLARE feito INT DEFAULT 0;                      -- flag NOT FOUND
    DECLARE cur CURSOR FOR SELECT salario FROM Funcionarios;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET feito = 1;

    SET total_salarios = 0.00;                       -- inicializa o OUT (evita NULL)
    OPEN cur;

    soma_loop: LOOP
        FETCH cur INTO v_salario;
        IF feito = 1 THEN
            LEAVE soma_loop;
        END IF;

        -- evita somar NULLs
        SET total_salarios = total_salarios + IFNULL(v_salario, 0);
    END LOOP;

    CLOSE cur;
END;
//

/* 3) (OPCIONAL) EXEMPLO DE PROCEDURE COM CURSOR E UPDATE em outra tabela */
CREATE PROCEDURE AtualizaStatusPorCursor()
BEGIN
    DECLARE v_id INT;
    DECLARE v_status_atual VARCHAR(20);
    DECLARE fim INT DEFAULT 0;
    DECLARE c CURSOR FOR SELECT id, status FROM OrdemServico WHERE status = 'PENDENTE';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;

    OPEN c;
    upd_loop: LOOP
        FETCH c INTO v_id, v_status_atual;
        IF fim = 1 THEN
            LEAVE upd_loop;
        END IF;

        -- Exemplo: marca como processando e grava log
        UPDATE OrdemServico SET status = 'PROCESSANDO' WHERE id = v_id;
        INSERT INTO LogOrdem(id_ordem, acao, data_hora) VALUES (v_id, 'PROCESSANDO', NOW());
    END LOOP;
    CLOSE c;
END;
//

DELIMITER ;

-- COMO CHAMAR / TESTAR:
-- CALL ExemploCursorLog();
-- CALL SomaSalariosCursor(@total); SELECT @total;   -- ou: CALL SomaSalariosCursor(@total); SELECT @total;
-- CALL AtualizaStatusPorCursor();


/* =========================
   ALTERNATIVA (sempre preferível quando possível)
   =========================
   Em quase todos os casos, operações linha-a-linha com cursor são mais lentas.
   Sempre que puder, prefira operações set-based:

   -- soma direta (sem cursor):
   SELECT SUM(salario) INTO @soma FROM Funcionarios;
   -- ou dentro de procedure:
   -- CREATE PROCEDURE SomaSalariosSet(OUT total_salarios DECIMAL(15,2))
   -- BEGIN
   --    SELECT SUM(salario) INTO total_salarios FROM Funcionarios;
   -- END;

   Use cursor só quando TIVER que processar linha a linha (ex.: lógica complexa por linha).
*/

/* =========================
   DICAS RÁPIDAS / ARMADILHAS COMUNS
   =========================
   1) DECLARE (variáveis, handlers, cursor) deve ficar logo após o BEGIN, antes de statements executáveis.
   2) Sempre DECLARE CONTINUE HANDLER FOR NOT FOUND SET <flag>; antes do OPEN.
   3) Inicialize acumuladores (OUT ou variáveis locais) antes de usar (ex: SET total = 0).
   4) Não esqueça de CLOSE <cursor>; — deixar aberto pode causar problemas.
   5) Parâmetros IN são somente leitura; se precisar incrementar um contador, DECLARE uma variável local:
        DECLARE contador INT DEFAULT limite;  -- pode usar DEFAULT parametro se seu MySQL permitir
   6) Preferir SELECT ... INTO para agregações simples (SUM, COUNT) — é mais simples e performático.
   7) Em prova: cuidado com DELIMITER; esquece-lo é erro clássico.
*/

