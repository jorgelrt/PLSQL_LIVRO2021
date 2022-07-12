BEGIN
	SELECT...
	SELECT...
	SELECT...
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		--qual instrução SELECT levantou a exceção?
END;
/

--Método 1 - numerando as consultas
DECLARE
	v_SelectCounter NUMBER := 1;
BEGIN
	SELECT...
	v_SelectCounter :=2;
	SELECT...
	v_SelectCounter :=3;
	SELECT...
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		INSERT INTO log_table(info)
		VALUES('NO_DATA_FOUND levantada no SELECT '||v_SelectCounter);
	
END;
/

--Método 2 - colocando cada consulta num bloco
BEGIN
	BEGIN
		SELECT...
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			INSERT INTO log_table(info)
		VALUES('NO_DATA_FOUND levantada no SELECT 1');
	END;
	
	BEGIN
		SELECT...
		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			INSERT INTO log_table(info)
		VALUES('NO_DATA_FOUND levantada no SELECT 2');
	END;
	
	BEGIN
		SELECT...
		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			INSERT INTO log_table(info)
		VALUES('NO_DATA_FOUND levantada no SELECT 3');
	END;
END;
	