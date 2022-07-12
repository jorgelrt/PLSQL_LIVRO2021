SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
	v_Departamento classes.department%TYPE;
	v_Curso classes.course%TYPE;
	
	CURSOR c_Classes(p_Departamento classes.department%TYPE, p_Curso classes.course%TYPE) IS --declaração dos parâmetros
		SELECT * FROM classes
		WHERE department = p_Departamento
		AND course = p_Curso;
    
    v_RegClasses c_Classes%ROWTYPE;
BEGIN
	v_Departamento := :v_Departamento;
	v_Curso := :v_Curso;
    
    OPEN c_Classes(v_Departamento, v_Curso); --passagem dos valores atraves de variáveis
    LOOP
        FETCH c_Classes INTO v_RegClasses;
        EXIT WHEN c_Classes%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('AQUI ESTA O REGISTRO OBTIDO: '||v_RegClasses.department||' - '||v_RegClasses.description);
    END LOOP;
	CLOSE c_Classes;
END;
/

