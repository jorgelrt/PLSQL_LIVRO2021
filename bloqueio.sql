DECLARE
	--nº de creditos a ser add ao total de cada aluno
	v_NumCredits classes.num_credits%TYPE;
	--este cursor selecionará apenas alunos inscritos HIS 101
	CURSOR c_RegisteredStudents IS
		SELECT * FROM students
		WHERE id IN(SELECT student_id FROM registered_students
					WHERE department = 'HIS' AND course = 101) 
		FOR UPDATE OF current_credits; --coluna da tabela students
BEGIN
		--configura o cursor do loop de busca
		FOR v_StudentInfo IN c_RegisteredStudents LOOP
			--determina o nº de créditos p/ HIS 101
			SELECT num_credits INTO v_NumCredits FROM classes
			WHERE department = 'HIS'
			AND course = 101;
			--atualiza a linha que acabamos de recuperar a partir do cursor
			UPDATE students
			SET current_credits = current_credits + v_NumCredits
			WHERE CURRENT OF c_RegisteredStudents;	
		END LOOP;
		--confirma o nosso trabalho e libera o bloqueio
		COMMIT;		
END;
/