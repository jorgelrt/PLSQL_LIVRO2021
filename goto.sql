/*
	Qdo uma instrução GOTO é avaliada, o controle passa imediatamente p a instrução identificada pelo rótulo
*/
DECLARE
	v_LoopCounter BINARY_INTEGER := 1;
BEGIN
	LOOP	
		INSERT INTO temp_table
		VALUES(v_LoopCounter,'Contador incrementado do loop');
		
		v_LoopCounter := v_LoopCounter + 1;
		
		IF v_LoopCounter >= 50 THEN
			GOTO Index1;
		END IF;
	END LOOP;	
	
	<<Index1>>
	INSERT INTO temp_table(char_col)
	VALUES('Feito');
	
END;
/



CREATE OR REPLACE Function InfoTotalCreditosCurso
   (nome_in IN VARCHAR2)
	RETURN NUMBER 
IS
	v_totalCreditos NUMBER;

	CURSOR c1 IS
		SELECT total_credits FROM major_stats
		WHERE major = nome_in;
BEGIN
	OPEN c1;
	FETCH c1 INTO v_totalCreditos;

	IF c1%NOTFOUND THEN
		GOTO default_creditos;
	ELSE
		GOTO incrementa_creditos;
	END IF;

	<<default_creditos>>
		v_totalCreditos := 0;

	<<incrementa_creditos>>
	v_totalCreditos := v_totalCreditos ;

	close c1;

	return v_totalCreditos;
END;
/		

--utilizando a função acima


DECLARE
    v_resp NUMBER(38);
	v_Curso VARCHAR2(1000) := 'History';
BEGIN
    v_resp := InfoTotalCreditosCurso(v_Curso);
    IF v_resp = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Curso '||v_Curso||' inexistente: '||v_resp||' creditos');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Curso '||v_Curso||' existente e possui: '||v_resp||' creditos');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Curso de TI possui: '||InfoTotalCreditosCurso('TI')||' creditos');
END;
/





SET SERVEROUTPUT ON;
DECLARE
	var1 NUMBER := :value;
	var2 VARCHAR2(30);
BEGIN
	IF mod(var1,2) = 1 THEN
		var2 := 'O valor informado é impar');
		GOTO imprimeValor;
	END IF;
	var2:= 'O valor é par';
	
	<<imprimeValor>>
		DBMS_OUTPUT.PUT_LINE(var2);
END;
/




/*
	Loop artificial com GOTO
*/
SET SERVEROUTPUT ON;
DECLARE
	var1 NUMBER := 0;
BEGIN
	<<loop_artificial>>
	var1 := var1 + 1;
	DBMS_OUTPUT.PUT_LINE(var1);
	IF var1 != 10 THEN	
		GOTO loop_artificial;
	END IF;
END;
/




DECLARE
	v_num NUMBER := &value;
BEGIN
	IF v_num < 5 THEN
		GOTO small_number;
	ELSE		
		GOTO large_number;
	END IF;
	
	v_num := 25; --pula essa linha
	
	<<small_number>>
	DBMS_OUTPUT.PUT_LINE('Small number');
	GOTO end_message;
	
	<<large_number>>
	DBMS_OUTPUT.PUT_LINE('Large number');
	GOTO end_message;
	
	v_num := 0; --pula essa linha
	
	<<end_message>>
	DBMS_OUTPUT.PUT_LINE('The end');
	
END;
/


/*
	A Goto statement cannot transfer the control into an IF statement, Case statement, Loop statement or a sub-block.
*/
DECLARE
	v_num NUMBER := 5;
BEGIN
	GOTO then_clause;
	IF v_num < 8 THEN
		<<then_clause>>
		v_num := 8;
	END IF;
END;
/