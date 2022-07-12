SET SERVEROUTPUT ON;
DECLARE
	v_Identificador students.ID%TYPE;
	v_linhaStudent students%ROWTYPE;
BEGIN
	SELECT MAX(ID) INTO v_Identificador FROM students;
	SELECT * INTO v_linhaStudent FROM students
	WHERE ID = v_Identificador;
	DBMS_OUTPUT.PUT_LINE('ID: '||v_linhaStudent.ID);
    DBMS_OUTPUT.PUT_LINE('NOME: '||v_linhaStudent.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('SOBRENOME: '||v_linhaStudent.LAST_NAME);
END;
/