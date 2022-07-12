SET SERVEROUTPUT ON;
DECLARE
	--Exceção p/ indicar uma condição de erro
	e_TooManyStudents EXCEPTION;
	--nº atual de alunos inscritos em HIS 101
	v_CurrentsStudents NUMBER(3);
	--nº max. de alunos permitidos em HIS 101
	v_MaxStudents NUMBER(3);
	
BEGIN
	/*
		localiza o nº atual de alunos inscritos e o nº max. de alunos permitidos
	*/
	SELECT current_students, max_students INTO v_CurrentsStudents, v_MaxStudents FROM classes
	WHERE department = 'HIS' 
	AND course = 101;
	
	--verifica o nº de alunos nessa classe
	IF v_CurrentsStudents > v_MaxStudents THEN
		RAISE e_TooManyStudents;
	END IF;
EXCEPTION
	WHEN e_TooManyStudents THEN
		DBMS_OUTPUT.PUT_LINE('Exceção levantada pelo usuário - RAISE');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Exception OTHERS levantada, código: '||to_char(SQLCODE)||' msg: '||to_char(SQLERRM));
END;
/