SET SERVEROUTPOUT ON;
DECLARE
	v_LoopCounter NUMBER;
BEGIN
	FOR v_LoopCounter IN 1..50 LOOP
		INSERT INTO temp_table(num_col)
		VALUES(v_LoopCounter);
	END LOOP;
END;
/




/*
declaração implícita de v_LoopCounter, e seu tipo será BINARY_INTEGER
*/
BEGIN
	FOR v_LoopCounter IN 1..50 LOOP
		INSERT INTO temp_table(num_col)
		VALUES(v_LoopCounter);
	END LOOP;
END;
/




/*
Os valores inicial e final precisam ser literais numéricos. Podem ser qq expressão numérica q pode ser convertida em um valor numérico
*/
DECLARE
	v_Inicio NUMBER := 1;
	v_Final NUMBER := 50;
BEGIN
	FOR v_LoopCounter IN v_Inicio..v_Final LOOP
		INSERT INTO temp_table(num_col)
		VALUES(v_LoopCounter);
	END LOOP;
END;
/




--O bloco abaixo não funciona com SUBTYPE range
--PLS-00456: o item 'V_LOOPCOUNTER' não é um cursor
SET SERVEROUTPOUT ON;
DECLARE
	SUBTYPE t_Range IS NUMBER range 1..50 ;
	v_LoopCounter t_Range;
BEGIN
	FOR x IN v_LoopCounter LOOP
		INSERT INTO temp_table(num_col)
		VALUES(v_LoopCounter);
	END LOOP;
END;
/