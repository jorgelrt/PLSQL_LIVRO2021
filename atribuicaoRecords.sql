SET SERVEROUTPUT ON;
DECLARE
	TYPE t_Reg1 IS RECORD(
		campo1 NUMBER,
		campo2 VARCHAR2(5));
	TYPE t_Reg2 IS RECORD(
		campo1 NUMBER,
		campo2 VARCHAR2(5));
	TYPE t_Reg3 IS RECORD(
		campo1 NUMBER,
		campo2 VARCHAR2(5));
        
	v_Reg1 t_Reg1;
	v_Reg2 t_Reg2;
    v_Reg3 t_Reg3;
BEGIN
	SELECT ID, FIRST_NAME INTO v_Reg1.campo1, v_Reg1.campo2 FROM students
	WHERE ID = (SELECT MAX(ID) FROM students);
	
	DBMS_OUTPUT.PUT_LINE(v_Reg1.campo1||' - '||v_Reg1.campo2);
    
    v_Reg2.campo1 := v_Reg1.campo1; -- correta atribuição entre tipos iguais
    v_Reg2.campo2 := v_Reg1.campo2;
 
    v_Reg3.campo1 := 24; -- exemplo de como atribuir valores
    v_Reg3.campo2 := 'JORGE';
    
    DBMS_OUTPUT.PUT_LINE(v_Reg3.campo1||' - '||v_Reg3.campo2);
    
   -- v_Reg2 := v_Reg1; --aqui é gerado o ERRO PL382
    
	
END;
/