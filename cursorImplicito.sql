/*
O bloco fará um INSERT, caso o comando UPDATE não localize nenhum registro
*/
BEGIN
	UPDATE rooms
	SET number_seats = 100
	WHERE room_id = 99980;
	--se a instrução acima não corresponder c/ nenhum registro, insere um novo registro na tabela roons
	IF SQL%NOTFOUND THEN
		INSERT INTO rooms(room_id,number_seats)
		VALUES(99980,100);
	END IF;
END;
/

/*
podemos fazer a mesma coisa com o bloco abaixo
*/
BEGIN
	UPDATE rooms
	SET number_seats = 100
	WHERE room_id = 99980;
	IF SQL%ROWCOUNT = 0 THEN
		INSERT INTO rooms(room_id,number_seats)
		VALUES(99980,100);
	END IF;
END;
/