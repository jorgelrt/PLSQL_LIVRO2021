DECLARE
	--cursor p/ recuperar as informações sobre alunos de história
	CURSOR c_HistoryStudents IS
		SELECT id, first_name, last_name FROM students
		WHERE major = 'History';
	
BEGIN
	--inicia um OPEN implícito em c_HistoryStudents
	FOR v_StudentsData IN c_HistoryStudents LOOP		
		--um FETCH implícito é feito aqui c_HistoryStudents
		--%NOTFOUND tbm são implícitos 
		INSERT INTO registered_students(student_id, department, course)
		VALUES(v_StudentsData.id,'HIS',301);
		INSERT INTO teste(col1, col2)
		VALUES(v_StudentsData.id, v_StudentsData.first_name||' '||v_StudentsData.last_name);
	END LOOP;
	
END;
/