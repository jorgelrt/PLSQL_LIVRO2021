DECLARE
    v_ID students.ID%TYPE;
    v_FirstName students.first_name%TYPE;
    CURSOR c_Students IS
		SELECT id, first_name  FROM students;	
BEGIN
	OPEN c_Students;
	LOOP
		FETCH c_Students INTO v_ID, v_FirstName;
		EXIT WHEN c_Students%NOTFOUND;
		IF c_Students%ISOPEN THEN
			DBMS_OUTPUT.PUT_LINE(v_ID);
		END IF;
	END LOOP;
	CLOSE c_Students;
    
    IF c_Students%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Cursor ainda está aberto');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cursor fechado');
    END IF;
END;
/