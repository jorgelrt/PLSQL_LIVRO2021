SET SERVEROUTPUT ON SIZE 200000;
DECLARE
    SUBTYPE t_range_restrito IS binary_integer range 1..10; --1º define um subtipo
    v_Range t_range_restrito; --2º declara a variavel do subtipo
BEGIN
    v_Range := &value ;
    DBMS_OUTPUT.PUT_LINE('Valor informado: '||to_char(v_Range));
END;
/



SET SERVEROUTPUT ON;
DECLARE
    SUBTYPE t_NotNullNum IS NUMBER NOT NULL; --1º define um subtipo NOT NULL
    v_VarNumNN t_NotNullNum := :value; --2º declara a variavel do subtipo
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_VarNumNN);
END;
/



SET SERVEROUTPUT ON SIZE 200000;
DECLARE
    SUBTYPE t_Nome IS VARCHAR2(15);  --1º definindo subtipos
    SUBTYPE t_End IS VARCHAR2(100);  --1º definindo subtipos
    SUBTYPE t_Desc IS VARCHAR2(500); --1º definindo subtipos
    v_Nome t_Nome;  --2º declarando variáveis do tipo subtipo
    v_End t_End;    --2º declarando variáveis do tipo subtipo
    v_Desc t_Desc;  --2º declarando variáveis do tipo subtipo
BEGIN
    v_Nome := 'Jorge';
    v_End := 'Rua XPTO';
    v_Desc := 'Endereco de SJC';
    
    DBMS_OUTPUT.PUT_LINE('Registro: '||v_Nome||' - '||v_End||' - '||v_Desc);
END;
/
--Exemplos retirados: http://www.dba-oracle.com/t_plsql_user_defined_subtypes.htm


SET SERVEROUTPUT ON;
DECLARE
    SUBTYPE t_ContaLoop IS NUMBER; --1º define um subtipo
    v_ContaLoop t_ContaLoop; --2º declara uma variavel
BEGIN
    v_ContaLoop := 0;
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_ContaLoop);
        EXIT WHEN v_ContaLoop >= 10;
        v_ContaLoop := v_ContaLoop + 1;
    END LOOP;
END;
/


SET SERVEROUTPUT ON;
DECLARE
    SUBTYPE t_Dummy IS NUMBER(4);
    v_DummyVar t_Dummy;
BEGIN
	dbms_output.put_line('xxxxxxxxxxxxxxxxxxxxxxxxxxx');
    v_DummyVar := &value;
    dbms_output.put_line('O numero informado foi: '||v_DummyVar);
	dbms_output.put_line('xxxxxxxxxxxxxxxxxxxxxxxxxxx');
END;
/