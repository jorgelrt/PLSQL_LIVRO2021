DECLARE
	--esse CURSOR lista duas colunas p/ a cláusula UPDATE
	CURSOR c_AllStudents IS
		SELECT * FROM students FOR UPDATE OF first_name, last_name;
		
	--esse CURSOR não lista nenhuma colunas
	CURSOR c_LargeClasses IS
		SELECT department, course FROM classes
		WHERE max_students > 50
		FOR UPDATE;
BEGIN
END;
/