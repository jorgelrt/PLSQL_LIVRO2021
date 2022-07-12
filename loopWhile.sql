SET SERVEROUTPUT ON;
DECLARE
	v_LoopCounter NUMBER := 1;
BEGIN
	WHILE (v_LoopCounter <= 50) LOOP	--a condição é avaliada antes  de cada iteração do loop
		INSERT INTO temp_table(num_col)
		VALUES(v_LoopCounter);
		
		v_LoopCounter := v_LoopCounter + 1;
	END LOOP;
	
	
END;
/




--Podemos utilizar EXIT ou EXIT WHEN dentro do loop WHILE

SET SERVEROUTPUT ON;
DECLARE
	v_LoopCounter NUMBER := 1;
	v_Flag BOOLEAN := FALSE;
BEGIN
	WHILE (v_LoopCounter <= 50) LOOP	--a condição é avaliada antes  de cada iteração do loop
		INSERT INTO temp_table(num_col)
		VALUES(v_LoopCounter);
		IF ((v_LoopCounter > 40) AND (v_Flag = TRUE)) THEN
			EXIT;
		END IF;
		v_LoopCounter := v_LoopCounter + 1;
	END LOOP;
END;
/
