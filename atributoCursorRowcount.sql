SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
	v_Contador NUMBER := 0;
	CURSOR c_Students IS
		SELECT * FROM students;
	
	v_RegStudents c_Students%ROWTYPE;
BEGIN
	OPEN c_Students;
	LOOP
        --v_Contador := c_Students%ROWCOUNT; 
        EXIT WHEN c_Students%NOTFOUND;
        FETCH c_Students INTO v_RegStudents; 
        v_Contador := c_Students%ROWCOUNT; 
        DBMS_OUTPUT.PUT_LINE(v_Contador||' linhas '||v_RegStudents.ID||' - '||v_RegStudents.first_name);
	END LOOP;
    CLOSE c_Students;
    DBMS_OUTPUT.PUT_LINE('Ate o momento -> quer dizer q haverá a repetição do último registro - ver pág 210');
END;
/
