DECLARE
	v_RowID ROWID;
	v_FirstName students.first_name%TYPE;
	v_LastName students.last_name%TYPE;
	v_ID students.ID%TYPE;
BEGIN
	--insere uma nova linha e ao mesmo tempo obtém o rowid da nova linha
	INSERT INTO students(ID,FIRST_NAME,LAST_NAME,MAJOR, CURRENT_CREDITS)
	VALUES(student_sequence.NEXTVAL, 'Jorge','Rodrigues','TI',0) RETURNING rowid INTO v_RowID;
	
	DBMS_OUTPUT.PUT_LINE('rowid da nova linha inserida é: '||v_RowID);
	
	--atualizando
	UPDATE students
	SET current_credits = current_credits + 3
	WHERE rowid = v_RowID RETURNING first_name, last_name INTO v_FirstName, v_LastName;
	
	DBMS_OUTPUT.PUT_LINE('Nome: '||v_FirstName||' '||v_LastName);
	
	--exclusão
	DELETE FROM students
	WHERE rowid = v_RowID RETURNING ID INTO v_ID;
	
	DBMS_OUTPUT.PUT_LINE('ID excluido: '||v_ID);
END;
/