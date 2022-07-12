/*
	Registra o aluno identificado pelo parametro p_StudentID na 
	classe identificada pelos parametros p_Department e p_Course
*/
CREATE OR REPLACE PROCEDURE Register(p_StudentID IN students.id%TYPE,
									 p_Department IN classes.department%TYPE,
									 p_Course IN classes.course%TYPE) AS
	v_CurrentStudents classes.max_students%TYPE;
	v_MaxStudents classes.max_students%TYPE;
	v_NumCredits classes.num_credits%TYPE;
	v_Count NUMBER;
BEGIN
		/*
			Determina o nº atual de alunos inscritos e o nº max. de alunos que tem permissão de inscrição
		*/
	BEGIN
		SELECT current_students, max_students, num_credits INTO v_CurrentStudents, v_MaxStudents, v_NumCredits FROM classes
		WHERE course = p_Course
		AND department = p_Department;
		/*
			Certifica-se de que há lugar suficiente p esse aluno add
		*/
		IF v_CurrentStudents + 1 > v_MaxStudents THEN
			RAISE_APPLICATION_ERROR(-20000,'Impossível add aluno a classe '||p_Department||' '||p_Course);
		END IF;
		--não existe informações sobre a classe passada p/ a procedure
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001,p_Department||' '||p_Course||' não existe');
	END;	
	--Assegura que o aluno não está atualmente inscrito
	SELECT COUNT(*) INTO v_Count FROM registered_students
	WHERE student_id = p_StudentID
	AND department = p_Department
	AND course = p_Course;
	
	IF v_Count = 1 THEN
		RAISE_APPLICATION_ERROR(-20002,'Aluno '||p_StudentID||' está registrado para '||p_Department||' '||p_Course);
	END IF;
	/*
		Há lugar suficiente e o aluno ainda não esta na classe. Atualiza as tabelas necessárias
	*/
	INSERT INTO registered_students(student_id, department, course)
	VALUES(p_StudentID, p_Department, p_Course);
	
	UPDATE students
	SET current_credits = current_credits + v_NumCredits
	WHERE id = p_StudentID;
	
	UPDATE classes
	SET current_students = current_students + 1
	WHERE course = p_Course
	AND department = p_Department;

END Register;
/
	
	
	