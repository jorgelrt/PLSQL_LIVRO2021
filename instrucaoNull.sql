SET SERVEROUTPUT ON;
/*
	Em alguns casos, vc talvez queira indicar explicitamente que nenhuma ação deve acontecer.
	Isso pode ser feito via a instrução NULL
*/
DECLARE
	v_TempVar NUMBER := 7;
BEGIN
	DELETE FROM temp_table;
	IF v_TempVar < 5 THEN
		INSERT INTO temp_table(char_col)
		VALUES('Too small');
	ELSIF v_TempVar < 20 THEN
		NULL; --não faz nada
	ELSE	
		INSERT INTO temp_table(char_col)
		VALUES('Too big');
	END IF;
END;
/

