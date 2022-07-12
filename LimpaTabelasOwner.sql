SET SERVEROUTPUT ON;
DECLARE
    v_String VARCHAR2(200);
BEGIN
    FOR r_c1 IN (SELECT * FROM USER_TABLES) LOOP
        v_String := 'delete from '||r_c1.table_name||';';
        DBMS_OUTPUT.PUT_LINE(v_String);
        EXECUTE IMMEDIATE v_String;
    END LOOP;
    COMMIT;
END;
/