BEGIN
	--inicia o loop e um OPEN implícito é emitido
	FOR v_StudentsData IN (SELECT id, first_name, last_name FROM students WHERE major = 'History') LOOP
		--um FETCH implícito é emitido e %NOTFOUND é verificado
		INSERT INTO registered_students(student_id, department, course)
		VALUES(v_StudentsData.id,'HIS',301);
		INSERT INTO teste(col1,col2)
		VALUES(v_StudentsData.id||' '||v_StudentsData.first_name||' '||v_StudentsData.last_name);
	END LOOP;
	--CLOSE implícito é realizado
END;
/