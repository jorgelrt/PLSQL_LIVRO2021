DECLARE
	v_TempVar VARCHAR2(3);
BEGIN
	v_TempVar := 'ABCD';
END;
/

DECLARE
	v_TempVar2 NUMBER(2);
BEGIN
	SELECT id INTO v_TempVar2 FROM students
	WHERE last_name = 'Smith';
END;
/