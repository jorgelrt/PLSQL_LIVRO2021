/*
    Os próprios loops podem ser rotulados. Se o forem, o rótulo pode ser utilizado
    em uma instrução EXIT para indicar qual loop deve ser finalizado
*/
SET SERVEROUTPUT ON ;
DECLARE
 v_Saida VARCHAR2(500):='';

BEGIN
    <<l_Outer>>
	FOR v_OuterIndex IN 1..9 LOOP
        <<l_Inner>>
		FOR v_InnerIndex IN 1..5 LOOP
			v_Saida := v_Saida||'  '||TO_CHAR(v_OuterIndex)||'.'||TO_CHAR(v_InnerIndex);
            IF v_OuterIndex > 5 THEN
                EXIT l_Outer; --finaliza ambos os loops
            END IF;
		END LOOP;
        SELECT TRIM(v_Saida) INTO v_Saida FROM dual;
        DBMS_OUTPUT.PUT_LINE(v_Saida);
        v_Saida := '';
	END LOOP;
END;
/

