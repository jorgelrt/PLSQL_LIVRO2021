/*
	Pelo fato da cláusula FOR UPDATE adquirir bloqueios, eles serão liberados pelo COMMIT.
	Qdo isso acontece o cursor é invalidado
*/
DECLARE
	--cursor p/ recuperar todos alunos e bloquear as linhas
	CURSOR c_AllStudents IS	
		SELECT * FROM STUDENTS
		FOR UPDATE;
	--variável p/ dados recuperados
	v_StudentInfo c_AllStudents%ROWTYPE;
BEGIN
	--Abre o cursor. Isso irá adquirir os bloqueios
	OPEN c_AllStudents;
	--Recupera o primeiro registro
	FETCH c_AllStudents INTO v_StudentInfo;
	
	--Emite um commit. Isso liberará os bloqueios, invalidando o cursor
	COMMIT;
	
	--Este FETCH levantará o erro ORA-1002
	FETCH c_AllStudents INTO v_StudentInfo;	
END;
/
/*
	Portanto, se houver um COMMIT dentro de um loop de busca SELECT...FOR UPDATE, qq buscas feitas depois do
	COMMIT falharão
*/







/*
	Para atualizar a linha recém-buscada a partir do cursor e utilizar um commit dentro do loop
	basta não usar a cláusula FOR UPDATE
*/
DECLARE
	--nº de creditos a serem add ao total de cada aluno 
	v_NumCredits classes.num_credits%TYPE;
	
	--Este cursor seleciona apenas alunos q estão inscritos em HIS 101
	CURSOR c_RegisteredStudents IS
		SELECT * FROM students
		WHERE id IN (SELECT student_id FROM registered_students 
					 WHERE department = 'HIS' AND course = 101);
BEGIN
	--configura o loop de busca do cursor
	FOR v_StudentInfo IN c_RegisteredStudents LOOP
		--determina o nº de creditos em HIS 101
		SELECT num_credits INTO v_NumCredits FROM classes
		WHERE department = 'HIS'
		AND course = 101;
		
		--Atualiza a linha q acabamos de recuperar do cursor
		UPDATE students
		SET current_credits = current_credits + v_NumCredits
		WHERE id = v_StudentInfo.id;
		--Podemos confirmar dentro do loop, uma vez que o cursor não é declarado FOR UPDATE
		COMMIT;
	END LOOP;
END;
/

--O Exemplo acima simula a cláusula WHERE CURRENT OF, mas não cria bloqueios.


















