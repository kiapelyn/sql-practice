USE mundi;

DROP TABLE IF EXISTS DIM_Modo;
CREATE TABLE IF NOT EXISTS DIM_Modo (
    sk_modo INT NOT NULL AUTO_INCREMENT,
    Nome_Modo VARCHAR(45) NOT NULL,
    PRIMARY KEY (sk_modo)
)
ENGINE = InnoDB;

DROP PROCEDURE IF EXISTS Fill_DIM_Modo;

DELIMITER //
CREATE PROCEDURE Fill_Dim_Modo()
BEGIN
    DECLARE existe_mais_linhas INT DEFAULT 0;
    DECLARE vModo VARCHAR(45);

    DECLARE ModoCursor CURSOR FOR
        SELECT ModoEnvio FROM Modo;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas = 1;

    OPEN ModoCursor;

    ModoLoop: LOOP
        FETCH ModoCursor INTO vModo;

        IF existe_mais_linhas = 1 THEN
            LEAVE ModoLoop;
        END IF;

        INSERT INTO Dim_Modo(
			Nome_Modo
		)
        
        VALUES (
			vModo
            );
    END LOOP ModoLoop;

    CLOSE ModoCursor;
END //
DELIMITER ;

CALL Fill_DIM_Modo;
SELECT * FROM DIM_Modo;
