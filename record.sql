SET SERVEROUTPUT ON;
DECLARE
	TYPE t_StudentsRecord IS RECORD(
		StudentID NUMBER(5),
		FirstName VARCHAR2(20),
		LastName VARCHAR2(20));
	
    v_Student t_StudentsRecord;	
BEGIN
	SELECT ID, FIRST_NAME, LAST_NAME INTO v_Student FROM students
	WHERE ID = (SELECT MAX(ID) FROM students);
	
	DBMS_OUTPUT.PUT_LINE('ID: '||TO_CHAR(v_Student.StudentID));
	DBMS_OUTPUT.PUT_LINE('NOME: '||TO_CHAR(v_Student.FirstName));
	DBMS_OUTPUT.PUT_LINE('SOBRENOME: '||TO_CHAR(v_Student.LastName));
END;
/