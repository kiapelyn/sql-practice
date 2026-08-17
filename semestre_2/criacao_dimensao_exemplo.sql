-- criação da dimensão x

DROP TABLE IF EXISTS 'carloca'.'Dim_X'´;

CREATE TABLE IF NOT EXISTS 'carloca'.'Dim_X' (
'sk_x' INT NOT NULL AUTO_INCREMENT,
`Codigo_x` INT NULL,
`Nome_x` VARCHAR(45) NOT NULL,
`Nome_Cidade` VARCHAR(45) NOT NULL,
`Populacao_Cidade` INT NULL,
`Sigla_Estado` VARCHAR(2) NOT NULL,
`Nome_Estado` VARCHAR(45) NOT NULL,
PRIMARY KEY (`sk_x`))
ENGINE = InnoDB;

-- Procedure para Cosntrução de uma dimensão
-- Cursor varre agências
DROP PROCEDURE IF EXISTS Insere_Dim_X;

DELIMITER //
CREATE PROCEDURE Insere_Dim_X()
BEGIN

  -- Definição de variáveis
  DECLARE existe_mais_linhas INT DEFAULT 0;
  DECLARE variaveis INT;
  DECLARE variaveis Varchar;

  -- Definir o cursor
  DECLARE XCursor CURSOR FOR
    SELECT todos os atributos necessários do carloca
      FROM loc_x
      INNER JOIN´s pra juntar tudo

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas = 1;

  -- abre o cursor
  OPEN XCursor;

  -- loop do cursor
  XLopp: LOOP
    FETCH XCursor INTO variaveis nomeadas;
 
    -- controle de saída
    IF existe_mais_linhas = 1 THEN
      LEAVE XLoop;
    END IF;