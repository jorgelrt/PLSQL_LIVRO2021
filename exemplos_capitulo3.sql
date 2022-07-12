/*
	Recupera o número atual de créditos do aluno 10002
	
	aprendizado: conversão implicita
	
	No BD current_credits é NUMBER(3). Entretanto , v_Creditos é uma variável VARCHAR2(5)
*/
SET SERVEROUTPUT ON;

DECLARE
	--v_Creditos students.currents_credits%TYPE; --boa prática
	v_Creditos VARCHAR2(5);
BEGIN
	SELECT TO_CHAR(current_credits) INTO v_Creditos FROM students --boa pratica é converter com função e não deixar converter implicitamente, pois pode ocorrer erro inesperado
	WHERE ID = 10002;
	--DBMS_OUTPUT.PUT_LINE('Aluno de ID:10002 tem '||to_char(v_Creditos)||' creditos'); --boa prática
    DBMS_OUTPUT.PUT_LINE('Aluno de ID:10002 tem '||v_Creditos||' creditos');
END;
/


SET SERVEROUTPUT ON
<<v_Saida>>
DECLARE
	v_SSN NUMBER(9) := 972466940;
BEGIN
	DBMS_OUTPUT.PUT_LINE(v_SSN);
	DECLARE
		v_SSN CHAR(11) := 'ABC';
	BEGIN
		DBMS_OUTPUT.PUT_LINE(v_Saida.v_SSN);
		DBMS_OUTPUT.PUT_LINE(v_SSN);
	END;
END;
/
