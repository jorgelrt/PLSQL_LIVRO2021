CREATE OR REPLACE PROCEDURE TESTATRIGGER(
    v_valorPositivo NUMBER ,
    v_valorNegativo NUMBER ) AS
     
     v_numcol NUMBER;
    v_linha temp_table%ROWTYPE;
BEGIN
	delete from temp_table;
	
    INSERT INTO temp_table(num_col, char_col)
    VALUES(v_valorPositivo,'Valor '||v_valorPositivo||' sendo informado');
    
    SELECT num_col,char_col into v_linha FROM temp_table;
    
    SELECT num_col into v_numcol FROM temp_table;
    DBMS_OUTPUT.PUT_LINE('Dando saída ao valor positivo inserido: '||v_linha.num_col||' - '||v_linha.char_col);
    
    INSERT INTO temp_table(num_col, char_col)
    VALUES(v_valorNegativo,'Valor '||v_valorNegativo||' sendo informado');
    
END TESTATRIGGER;


--obs.: chamando a procedure
begin
	testatrigger(1,-1);
end;

