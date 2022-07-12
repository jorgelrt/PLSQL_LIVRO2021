
CREATE TABLE copy_students AS
	SELECT ID, FIRST_NAME, LAST_NAME FROM students;

CREATE UNIQUE INDEX studentname_ix ON copy_students(ID);

DECLARE
	v_stID students.ID%TYPE;
	v_stFirstName students.FIRST_NAME%TYPE;
	v_stLastName students.LAST_NAME%TYPE;
BEGIN
	SELECT ID, FIRST_NAME, LAST_NAME INTO v_stID, v_stFirstName, v_stLastName FROM students 
	WHERE ID = (SELECT MAX(ID) FROM students);
	
	UPDATE copy_students
	SET FIRST_NAME = 'JUQUINHA'
	WHERE ID = v_stID;
	
	DELETE FROM copy_students
	WHERE ID = (SELECT MIN(ID) FROM students);
	
	SAVEPOINT do_insert;
	
	INSERT INTO copy_students
	VALUES(v_stID, v_stFirstName, v_stLastName);

EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
		ROLLBACK TO do_insert;
		DBMS_OUTPUT.PUT_LINE('O ultimo Insert sofreu rollback');
END;
/

--retorna na ultima ocorrencia de my_savepoint(Reutilização SAVEPOINT)
DECLARE
	v_stID students.ID%TYPE;
	v_stFirstName students.FIRST_NAME%TYPE;
	v_stLastName students.LAST_NAME%TYPE;
BEGIN
	SELECT ID, FIRST_NAME, LAST_NAME INTO v_stID, v_stFirstName, v_stLastName FROM students 
	WHERE ID = (SELECT MAX(ID) FROM students);
	
	SAVEPOINT my_savepoint;
	
	UPDATE copy_students
	SET FIRST_NAME = 'JUQUINHA'
	WHERE ID = v_stID;
	
	DELETE FROM copy_students
	WHERE ID = (SELECT MIN(ID) FROM students);
	
	SAVEPOINT my_savepoint;
	
	INSERT INTO copy_students
	VALUES(v_stID, v_stFirstName, v_stLastName);

EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
		ROLLBACK TO my_savepoint;
		DBMS_OUTPUT.PUT_LINE('Transação sofreu rollback');
END;
/
