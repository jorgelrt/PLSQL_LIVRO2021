CREATE OR REPLACE FUNCTION AlmostFull(
	p_Department classes.department%TYPE,
	p_Course classes.course%TYPE) RETURN BOOLEAN IS
	
	--seção declarativa - variáveis
	v_CurrentStudents NUMBER;
	v_MaxStudents NUMBER;
	v_ReturnValue BOOLEAN;
	v_FullPercent CONSTANT NUMBER := 80;
BEGIN
	--obter os alunos atuais e máximo p/ o curso solicitado
	SELECT current_students, max_students INTO v_CurrentStudents, v_MaxStudents FROM classes
	WHERE department = p_Department
	AND course = p_Course;
	
	--se a classe estiver cheia com um percentual maior do que aquele fornecido por v_FullPercent, retorna TRUE. Caso contrário retorna FALSE
	IF((v_CurrentStudents / v_MaxStudents * 100) >= v_FullPercent) THEN
		v_ReturnValue := TRUE;
	ELSE
		v_ReturnValue := FALSE;
	END IF;
	RETURN v_ReturnValue;
END AlmostFull;
	
--Chamar a função dentro de um IF

DECLARE
	CURSOR c_Classes IS
		SELECT department, course FROM classes;
BEGIN
	FOR v_ClassRecord IN c_Classes LOOP
		IF(AlmostFull(v_ClassRecord.department, v_ClassRecord.course))THEN
			DBMS_OUTPUT.PUT_LINE(v_ClassRecord.department||' '||v_ClassRecord.course||' is almost full');
		END IF;
	END LOOP;
END;