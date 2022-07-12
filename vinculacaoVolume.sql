/*
	As instruções SQL em blocos PL/SQL são enviadas p/ o mecanismo da SQL - p/ serem executadas e por sua vez, o SQL pode devolver ao mecanismo PLSQL.
	As alternações de contexto (PLSQL -> SQL -> PLSQL) podem ser reduzidas a somente 1 num caso de 500 alternações(500 INSERTS), utilizando a instrução FORALL
	
	Em várias situações, os dados a serem inseridos ou atualizados no BD são primeiramente colocados em uma coleção PLSQL e então essa coleção é iterada com um loop FOR
	p/ enviar as informações ao mecanismo SQL. Isso resulta em uma alternação de contexto entre a PLSQL e a SQL p/ cada linha na coleção.
	
	A instrução FORALL permite em apenas uma operação passar todas as linhas de uma coleção ao mecanismo SQL eliminando quase todas, exceto uma, alternações de contexto.
	Isso é conhecido como "vinculação em lote ou volume"
*/
DECLARE
	TYPE t_Numeros IS TABLE OF temp_table.num_col%TYPE
		INDEX BY BINARY_INTEGER;
	TYPE t_Textos IS TABLE OF temp_table.char_col%TYPE
		INDEX BY BINARY_INTEGER;
	
	v_Numeros t_Numeros;
	v_Textos t_Textos;
BEGIN
	--preencher os arrays com 5000 linhas
	FOR v_Count IN 1..5000 LOOP
		v_Numeros(v_Count) := v_Count;
		v_Textos(v_Count) := 'linha #'||v_Count;
	END LOOP;
	--inserção utilizando apenas 1 troca de contexto das 50 existentes - através da vinculação de volume
	FORALL v_Count IN 1..5000
		INSERT INTO temp_table
		VALUES(v_Numeros(v_Count), v_Textos(v_Count));
END;
/
--0,342 milisegundos



DECLARE
	TYPE t_Numeros IS TABLE OF temp_table.num_col%TYPE
		INDEX BY BINARY_INTEGER;
	TYPE t_Textos IS TABLE OF temp_table.char_col%TYPE
		INDEX BY BINARY_INTEGER;
	
	v_Numeros t_Numeros;
	v_Textos t_Textos;
BEGIN
	--preencher os arrays com 500 linhas
	FOR v_Count IN 1..5000 LOOP
		v_Numeros(v_Count) := v_Count;
		v_Textos(v_Count) := 'linha #'||to_char(v_Count);
	END LOOP;
	--inserção utilizando apenas 1 troca de contexto das 50 existentes - através da vinculação de volume
	FOR v_Count 1..5000 LOOP
		INSERT INTO temp_table
		VALUES(v_Numeros(v_Count), v_Textos(v_Count));
	END LOOP;
END;
/
--0,731 milisegundos


--Exemplo livro pg 468
DECLARE
	TYPE t_Numeros IS TABLE OF temp_table.num_col%TYPE;
	TYPE t_Textos IS TABLE OF temp_table.char_col%TYPE;
	v_Numeros t_Numeros := t_Numeros(1);
	v_Textos t_Textos := t_Textos(1);
	

	--imprime o total de linhas em temp_table
	PROCEDURE ImprimeTotalLinhas(p_Msg IN VARCHAR2) IS
		v_Count NUMBER;
	BEGIN
		SELECT COUNT(*) INTO v_Count FROM temp_table;
		DBMS_OUTPUT.PUT_LINE(p_Msg||' : contém '||v_Count||' linhas');
	END ImprimeTotalLinhas;
	
BEGIN
	ImprimeTotalLinhas('Vendo o que há na tabela ao iniciar bloco');
	
	--primeiro exclui temp_table
	DELETE FROM temp_table;
	
	--preenche as tabelas aninhadas PLSQL com 1000 registros
	v_Numeros.EXTEND(1000); --add 1000 zeros
	v_Textos.EXTEND(1000);
	FOR v_Count IN 1..1000 LOOP
		v_Numeros(v_Count) := v_Count;
		v_Textos(v_Count) := 'Registro numero '||TO_CHAR(v_Count);
	END LOOP;
	
	--Insere todos os 1000 elementos utilizando uma única instrução FORALL
	FORALL v_Count IN 1..1000
		INSERT INTO temp_table
		VALUES(v_Numeros(v_Count),v_Textos(v_Count));
	
    
	--devemos ter 1000 linhas(registros)
	ImprimeTotalLinhas('Após o primeiro INSERT');
	
	--Insere os elementos de 501 a 1000 novamente
	FORALL v_Count IN 501..1000
		INSERT INTO temp_table
		VALUES(v_Numeros(v_Count),v_Textos(v_Count));
	
	--devemos ter agora 1500 linhas (registros)
	ImprimeTotalLinhas('Após segundo INSERT');
	
	--Atualiza todas as linhas(registros)
	FORALL v_Count IN 1..1000
		UPDATE temp_table
		SET char_col = 'Alterado'
		WHERE num_col = v_Numeros(v_Count);
	/*
	Mesmo que haja apenas 1000 elementos, a instrução anterior atualizou 1500 linhas
	uma vez que a cláusula WHERE correspondeu com 2 linhas para cada uma das últimas 500
	*/
	DBMS_OUTPUT.PUT_LINE('Alteradas '||SQL%ROWCOUNT||' de linhas');
	
	--Da mesma forma, esse DELETE removerá 300 linhas
	FORALL v_Count IN 401..600
		DELETE FROM temp_table	
		WHERE num_col = v_Numeros(v_Count);
	
	--Assim deve sobrar 1200 linhas(registros)
	ImprimeTotalLinhas('Após o DELETE');
		
END;
/  


--entendendo EXTEND - que aparece no codigo acima
/*
    Fonte: https://www.sqlsplus.com/oracle-extend-method/
*/
--cria um tipo numbertype (nt)
CREATE OR REPLACE TYPE nt_type IS TABLE OF NUMBER;

CREATE OR REPLACE PROCEDURE Imprime_nt(nt nt_type) IS
    i NUMBER;
BEGIN
    i := nt.FIRST;
    
    IF i IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('nt está vazio');
    ELSE
        WHILE i IS NOT NULL LOOP
            DBMS_OUTPUT.PUT_LINE('nt.('||i||') = '||nt(I)); 
            i := nt.NEXT(i);
        END LOOP;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('----');
END Imprime_nt;

DECLARE
    nt nt_type := nt_type(11,22,33);
BEGIN
    Imprime_nt(nt);
    
    nt.EXTEND(2,1); --add 2 copias do primeiro elemento
    Imprime_nt(nt);
    
    nt.DELETE(5); --remove o quinto elemento
    Imprime_nt(nt);
    
    nt.EXTEND; --add um nulo a tabela(elemento)
    Imprime_nt(nt);
END;
/


