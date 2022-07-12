DECLARE	
	--Define um tipo irrestrito de referência pg227
	TYPE t_FlexibleRef IS REF CURSOR;
	
	--e uma variável deste tipo
	v_CursorVar t_FlexibleRef;