DECLARE
	--definição que utiliza %ROWTYPE
	TYPE t_StudentsRef IS REF CURSOR
		RETURN students%ROWTYPE;
		
	--define um novo tipo de registro
	TYPE t_NameRecord IS RECORD(
		firstName students.first_name%TYPE,
		lastName students.last_name%TYPE);
	
	--uma variável do tipo acima
	v_NameRecord t_NameRecord;
	
	--uma variável de cursor que utiliza o tipo de registro
	TYPE t_NamesRef  IS REF CURSOR
		RETURN t_NameRecord;
		
	--Podemos declarar outro tipo, utilizando %TYPE p/ registro anteriormente definido
	TYPE t_NamesRef2 IS REF CURSOR	
		RETURN v_NameRecord%TYPE;
		
	--Declara as variáveis de cursor utilizando os tipos anteriores
	v_StudentCV t_StudentsRef;
	v_NameCV t_NamesRef;
	
	