BEGIN
    --Insere em temp_table a partir da transação pai
    INSERT INTO temp_table
    VALUES(10,'Hello from the parent');
    
    --chama a autonomos, que será independente desta transação
    AUTONOMA;
    
    --mesmo se revertermos a transação Pai, a inserção feita a partir da AUTONOMA ainda é confirmada
    ROLLBACK;
END;
/


CREATE OR REPLACE PROCEDURE autonoma AS
	PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
	INSERT INTO temp_table
	VALUES(10,'Hello from Autonoumous!');
	COMMIT;
END autonoma;
/
