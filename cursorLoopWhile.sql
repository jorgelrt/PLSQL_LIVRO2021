DECLARE
	--cursor p/ recuperar as informações sobre alunos de história
	CURSOR c_HistoryStudents IS
		SELECT id, first_name, last_name FROM students
		WHERE major = 'History';
	--cria um registro do próprio cursor
	v_StudentsData c_HistoryStudents%ROWTYPE;
BEGIN
	OPEN c_HistoryStudents;
	FETCH c_HistoryStudents INTO v_StudentsData;
	WHILE c_HistoryStudents%FOUND LOOP
		INSERT INTO registered_students(student_id, department, course)
		VALUES(v_StudentsData.id,'HIS',301);
		INSERT INTO teste(col1, col2)
		VALUES(v_StudentsData.id, v_StudentsData.first_name||' '||v_StudentsData.last_name);
		--Recupera as informações sobre o próximo registro
		FETCH c_HistoryStudents INTO v_StudentsData;
	END LOOP;
	--libera os recursos utilizados pelo cursor
	CLOSE c_HistoryStudents;
END;
/
/*
Observe que a instrução FETCH aparece duas vezes: uma antes do LOOP e outra depois do processamento do LOOP.
Isso é necessário na medida em que a condição de loop(c_HistoryStudents%FOUND) será avaliada.
Lembre-se que WHILE continua sempre que a condição é verdadeira
*/