--Exemplo de trigger:
--Assegura que apenas valores positivos serão incluídos na tabela TEMP_TABLE
--Lógica: valores menores que 0 NÃO SÃO ACEITOS!!!
CREATE OR REPLACE TRIGGER SomenteValorPositivo
   BEFORE INSERT OR UPDATE OF num_col ON temp_table
   FOR EACH ROW
   BEGIN
		IF :new.num_col < 0 THEN
			RAISE_APPLICATION_ERROR(-20100,'Por favor, inserir um valor positivo para a coluna num_col da tabela temp_table');
		END IF;
			
   END SomenteValorPositivo;
 
 /*
INSERT INTO temp_table(num_col, char_col)
VALUES(1,'Valor 1 sendo informado');
INSERT INTO temp_table(num_col, char_col)
VALUES(-1,'Valor -1 sendo informado');

ROLLBACK;
   
Obs.: Nem chega a mostrar a mensagem do bloco abaixo quando é negativo. Ao invés disso informa a mensagem contida na trigger      
   
SET SERVEROUTPUT ON;
DECLARE
    v_valorPositivo NUMBER := 1;
    v_valorNegativo NUMBER := -1 ;     
     v_numcol NUMBER;
    v_linha temp_table%ROWTYPE;
BEGIN
    INSERT INTO temp_table(num_col, char_col)
    VALUES(v_valorPositivo,'Valor '||v_valorPositivo||' sendo informado');
    
    SELECT num_col,char_col into v_linha FROM temp_table;
    
    SELECT num_col into v_numcol FROM temp_table;
    DBMS_OUTPUT.PUT_LINE('Dando saída ao valor positivo inserido: '||v_linha.num_col||' - '||v_linha.char_col);
    
    INSERT INTO temp_table(num_col, char_col)
    VALUES(v_valorNegativo,'Valor '||v_valorNegativo||' sendo informado');
    
    delete from temp_table;
END ;

