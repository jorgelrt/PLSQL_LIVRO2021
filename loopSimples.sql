DECLARE
	v_LoopCounter NUMBER := 1;
BEGIN
	DELETE FROM temp_table;
	
	LOOP
		INSERT INTO temp_table(num_col)
		VALUES(v_LoopCounter);
		EXIT WHEN v_LoopCounter >= 50; --condição de término
		v_LoopCounter := v_LoopCounter + 1;
	END LOOP;
END;
/

/*
	A instrução: 
		EXIT WHEN condição;

	é equivalente a: 
	IF condição THEN
		EXIT;
	END IF;
*/

DECLARE
	v_LoopCounter NUMBER := 1;
BEGIN
	LOOP
		INSERT INTO temp_table(num_col)
		VALUES(v_LoopCounter);
		v_LoopCounter := v_LoopCounter + 1;
		IF v_LoopCounter >= 50 THEN --cláusula IF contendo o comando EXIT
			EXIT;
		END IF;
	END LOOP;
END;
/

