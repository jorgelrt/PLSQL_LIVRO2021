/*
SQL%NOTFOUND possa ser utilizado com SELECT INTO, não é aconselhável, pois pode ocorrer o erro: ORA-1403: no data found
Esse ERRO faz com que o controle passe imediatamente para a seção de tratamento de exception do bloco
EVITANDO a verificação SQL%NOTFOUND
*/
DECLARE
	--registro p/ armazenar informações da sala
	v_RoomData rooms%ROWTYPE;
BEGIN
	--Recupera as informações sobre o ID = -1
	SELECT * INTO v_RoomData FROM rooms
	WHERE room_id = -1;
	--a instrução NUNCA será executada e o controle passa IMEDIATAMENTE p/ handler de exception
	IF SQL%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('SQL%NOTFOUND is true!');
	END IF;
	
EXCEPTION	
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND levantada!');
		--Note que é possível verificar SQL%NOTFOUND dentro do handler de exception NO_DATA_FOUND, mas SQL%NOTFOUND sempre será avaliada como TRUE neste ponto.
		/*
		IF NOT SQL%NOTFOUND THEN
			DBMS_OUTPUT.PUT_LINE('true');
		END IF;
		*/
END;
/

/*
Observação: SQL%ISOPEN também é válida, contudo, sempre será avaliada como FALSE, pelo fato do cursor implícito ser automaticamente fechado depois da instrução dentro for processada
*/