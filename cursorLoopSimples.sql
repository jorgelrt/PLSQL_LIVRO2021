DECLARE
	--declarar variáveis p/ conter as informações sobre os alunos que estão se especializando em HISTORIA
	v_StudentID students.id%TYPE;
	v_FirstName students.first_name%TYPE;
	v_LastName students.last_name%TYPE;
	--cursor p/ recuperar as informações sobre alunos de história
	CURSOR c_HistoryStudents IS
		SELECT id, first_name, last_name FROM students
		WHERE major = 'History';
	
BEGIN
	OPEN c_HistoryStudents;
	LOOP
		--Recupera as informações sobre o próximo registro
		FETCH c_HistoryStudents INTO v_StudentID, v_FirstName, v_LastName;
		--condição de saída do loop 
		EXIT WHEN c_HistoryStudents%NOTFOUND;
		--processamento
		INSERT INTO registered_students(student_id, department, course)
		VALUES(v_StudentID,'HIS',301);
		INSERT INTO teste(col1, col2)
		VALUES(v_StudentID, v_FirstName||' '||v_LastName);
	END LOOP;
	--libera os recursos utilizados pelo cursor
	CLOSE c_HistoryStudents;
END;
/

/*
Repare que a instrução EXIT WHEN vem logo após FETCH - isso é necessário p não processar linhas nulas ou possibilidade de duplicidade.
O último FETCH não modificará v_StudentID, v_FirstName e v_LastName, pois não há outras linhas no conjunto ativo. 
Pelo fato da verificação acontecer depois do processamento, há duplicidade!
Substituindo os comandos de processamento de INSERT pelo DBMS_OUTPUT, podemos ver q o último registro se duplica
*/
DECLARE
	--declarar variáveis p/ conter as informações sobre os alunos que estão se especializando em HISTORIA
	v_StudentID students.id%TYPE;
	v_FirstName students.first_name%TYPE;
	v_LastName students.last_name%TYPE;
	--cursor p/ recuperar as informações sobre alunos de história
	CURSOR c_HistoryStudents IS
		SELECT id, first_name, last_name FROM students
		WHERE major = 'History';
	
BEGIN
	OPEN c_HistoryStudents;
	LOOP
		--Recupera as informações sobre o próximo registro
		FETCH c_HistoryStudents INTO v_StudentID, v_FirstName, v_LastName;
		--processamento
        DBMS_OUTPUT.PUT_LINE(v_studentID||' '||v_FirstName||' '||v_LastName);
        --condição de saída do loop 
		EXIT WHEN c_HistoryStudents%NOTFOUND;
	END LOOP;
	--libera os recursos utilizados pelo cursor
	CLOSE c_HistoryStudents;
END;
/

10001 Margaret Mason
10004 Patrick Poll
10005 Timothy Taller
10005 Timothy Taller


Procedimento PL/SQL concluído com sucesso.