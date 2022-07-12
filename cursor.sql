DECLARE
	/*variáveis de saída p/ armazenar os resultados da consulta*/
	v_StudentID students.ID%TYPE;
	v_FirstName students.first_name%TYPE;
	v_LastName students.last_name%TYPE;
	
	/*variável de vinculação utilizada na consulta*/
	v_Major students.major%TYPE := 'Computer Science' ;
	
	/*declaração do cursor*/
	CURSOR c_Students IS
		SELECT id, first_name, last_name INTO v_StudentID, v_FirstName, v_LastName FROM students
		WHERE major = v_Major;
BEGIN
	/*identifica as linhas no conjunto ativo e prepara p/ outros processamentos de dados*/
	OPEN c_Students;
	LOOP
		/*recupera cada linha do conjunto ativo em variáveis PLSQL*/
		FETCH c_Students INTO v_StudentID, v_FirstName, v_LastName;
		/*NÃO INSERIR COMANDOS ANTES DA CLÀUSULA EXIT WHEN - no caso de um insert, irá duplicar o último registro*/
		/*se não houver outras linhas p buscar, sai do loop.*/
		EXIT WHEN c_Students%NOTFOUND;
		
		/*instruções aqui!*/
		INSERT INTO meia_students(id, first_name, last_name)
		VALUES(v_StudentID,v_FirstName,v_LastName);
		
	END LOOP;
	
	/*libera os recursos alocados*/
	CLOSE c_Students;
END;
/

