SET SERVEROUTPUT ON;
<<pg69_InsertIntoTemp_Rotulado>>
DECLARE
    v_num1 NUMBER := 1;
    v_num2 NUMBER := 2;
    v_String1 VARCHAR2(50) := 'Alo Mundo!';
    v_String2 VARCHAR2(50) := ' -- Esta mensagem foi gerada pela PLSQL';
    v_OutPutStr VARCHAR2(50);
BEGIN
    INSERT INTO temp_table(num_col,char_col)
    VALUES(v_num1, v_String1);
    INSERT INTO temp_table(num_col,char_col)
    VALUES(v_num2, v_String2);
    
    SELECT char_col INTO v_OutPutStr FROM TEMP_TABLE
    WHERE num_col = v_num1;
    DBMS_OUTPUT.PUT_LINE(v_OutPutStr);
    SELECT char_col INTO v_OutPutStr FROM TEMP_TABLE
    WHERE num_col = v_num2;
    DBMS_OUTPUT.PUT_LINE(v_OutPutStr);
    ROLLBACK;
END pg69_InsertIntoTemp_Rotulado;
/

