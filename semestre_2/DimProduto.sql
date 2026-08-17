USE mundi;

-- -----------------------------------------------------
-- Table `mundi`.`DIM_Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mundi`.`DIM_Produto` ;

CREATE TABLE IF NOT EXISTS `mundi`.`DIM_Produto` (
  `SK_produto` INT NOT NULL AUTO_INCREMENT,
  `produto_nome` VARCHAR(150) NOT NULL,
  `produto_categoria` VARCHAR(150) NOT NULL,
  `produto_subcategoria` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`SK_produto`))
ENGINE = InnoDB;

DROP PROCEDURE IF EXISTS Construir_Dim_Produto;

DELIMITER //
CREATE PROCEDURE Construir_Dim_Produto()
BEGIN 
    -- Declaração de variáveis
    DECLARE existe_mais_linhas INT DEFAULT 0;

    -- Variáveis para os cursores
    DECLARE vNome_Produto VARCHAR(150);
    DECLARE vNome_Categoria VARCHAR(150);
    DECLARE vNome_subCategoria VARCHAR(150);

    -- Declaração do cursor para a tabela mundi.produto
    DECLARE ProdutoCursor CURSOR FOR
        SELECT P.NomeProduto, C.NomeCategoria, S.NomeSubCategoria
        FROM produto P  
        INNER JOIN SubCategoria S ON P.codSubCat = S.CodSubCat 
        INNER JOIN Categoria C ON S.IdCategoria = C.IdCategoria;

    -- Tratamento para quando não houver mais linhas nos cursores
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas = 1;

    -- Abrir o cursor
    OPEN ProdutoCursor;

    -- Loop para percorrer os dados do cursor
    ProdutoLoop: LOOP
        -- Buscar valores do cursor
        FETCH ProdutoCursor INTO vNome_Produto, vNome_Categoria, vNome_subCategoria;

        -- Encerrar o loop se não houver mais linhas
        IF existe_mais_linhas = 1 THEN 
            LEAVE ProdutoLoop;
        END IF;
        -- Inserir os dados na tabela Dim_Produto
        INSERT INTO Dim_Produto(
            produto_nome, produto_categoria, produto_subcategoria
        )
        VALUES (
            vNome_Produto, vNome_Categoria, vNome_subCategoria
        );
    END LOOP ProdutoLoop;

    -- Fechar o cursor
    CLOSE ProdutoCursor;

END //
DELIMITER ;

-- Chamar o procedimento
CALL Construir_Dim_Produto();

-- Consultar a tabela final
SELECT * FROM Dim_Produto;
