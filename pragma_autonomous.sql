--Toda vez que o usuário C##PLSQL fizer logon no BD, será gravado. Porém o INSERT na trigger, será realizado rollback
CREATE OR REPLACE PROCEDURE RegistraLogon AS
	v_Usuario VARCHAR2(100);
	v_Estacao VARCHAR2(100);
    v_Programa VARCHAR2(100);
    pragma autonomous_transaction;
BEGIN
	SELECT username, machine, program INTO v_Usuario, v_Estacao, v_Programa FROM SYS.V_$SESSION
	WHERE audsid = USERENV('SESSIONID')
	AND audsid != 0  -- Don't Check SYS Connections
	AND ROWNUM = 1;
	
	INSERT INTO log_table(code, message, info)
	VALUES(10,'usuario: '||v_Usuario||' logou em '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS')||' atraves da estacao: '||v_Estacao,'Programa: '||v_Programa);
	COMMIT;
END;
/	

CREATE OR REPLACE TRIGGER TgLogon
    AFTER LOGON ON DATABASE
BEGIN
    RegistraLogon; --chamada a procedure autonomous transact
    INSERT INTO temp_table
    VALUES(1,'teste trigger');
    rollback; --mesmo efetuando roolback, a inserção e comitada, pois trata-se de uma autonomous transact
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro trigger de logon');
    
END;
/