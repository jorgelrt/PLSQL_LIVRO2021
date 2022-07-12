DECLARE
	v_Department classes.department%TYPE;
	v_Course classes.course%TYPE;
	
	CURSOR c_AllClasses IS
		SELECT * FROM classes;
	
	v_ClassesRecord c_AllClasses%ROWTYPE;
BEGIN
	OPEN c_AllClasses;
	/*
	cláusula FETCH válida, q retorna a 1ª linha num registro PLSQL
	*/
	FETCH c_AllClasses INTO v_ClassesRecord;
	ATRIBUTOS_DO_CURSOR(%NOTFOUND, %FOUND, %ISOPEN, %ROWCOUNT) juntamente cláusula EXIT
	
END;
/