--ESTRUTURA CONDICIONAL {IF_THEN_ELSE}
SET SERVEROUTPUT ON
DECLARE
    v_Hora VARCHAR2(10);
BEGIN
    SELECT TO_CHAR(SYSDATE,'HH24') INTO v_Hora FROM dual;
    DBMS_OUTPUT.PUT_LINE('Hora obtida: '||v_Hora);
    IF(v_Hora < 12) THEN
        DBMS_OUTPUT.PUT_LINE('Bom dia');
    ELSIF (v_Hora > 12 AND v_Hora < 18) THEN --pode haver qtas quiser ELSIF
        DBMS_OUTPUT.PUT_LINE('Boa tarde');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Boa noite');
    END IF;
END;
/




--ESTRUTURA CONDICIONAL CASE
SET SERVEROUTPUT ON;
DECLARE
	v_Dia VARCHAR2(2);
BEGIN
	SELECT TO_CHAR(SYSDATE,'HH24') INTO v_Dia FROM dual;
	DBMS_OUTPUT.PUT_LINE('Hora obtida: '||v_Dia);
    CASE v_Dia
        WHEN 15 THEN DBMS_OUTPUT.PUT_LINE('Pago até a data limite');
        WHEN 16 THEN DBMS_OUTPUT.PUT_LINE('1 dia de atraso');
        WHEN 17 THEN DBMS_OUTPUT.PUT_LINE('2 dia de atraso');
    END CASE;
END;
/




--ESTRUTURA CONDICIONAL {CASE - pesquisada}
--onde cada cláusula WHEN compara um valor contra uma única expressão de teste
DECLARE
	v_Hora VARCHAR2(10);
BEGIN
	SELECT TO_CHAR(SYSDATE,'HH24') INTO v_Hora FROM dual;
	DBMS_OUTPUT.PUT_LINE('Hora obtida: '||v_Hora);
	CASE 
		WHEN v_Hora < 12 THEN 
			DBMS_OUTPUT.PUT_LINE('Bom dia');
		WHEN v_Hora > 12 AND v_Hora < 18 THEN 
			DBMS_OUTPUT.PUT_LINE('Boa tarde');
		ELSE 
			DBMS_OUTPUT.PUT_LINE('Boa noite');
	END CASE;
END;
/




/*
	Instruções CASE sem cláusula ELSE - que é opcional
*/
DECLARE
	v_Hora VARCHAR2(10);
BEGIN
	SELECT TO_CHAR(SYSDATE,'HH24') INTO v_Hora FROM dual;
	DBMS_OUTPUT.PUT_LINE('Hora obtida: '||v_Hora);
	CASE 
		WHEN v_Hora < 12 THEN 
			DBMS_OUTPUT.PUT_LINE('Bom dia');
		WHEN v_Hora > 12 AND v_Hora < 18 THEN 
			DBMS_OUTPUT.PUT_LINE('Boa tarde');
		WHEN v_Hora > 18 AND v_Hora < 23 THEN
			DBMS_OUTPUT.PUT_LINE('Boa noite');
	END CASE;
END;
/