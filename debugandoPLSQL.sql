create or replace PROCEDURE aprendendo
(p_Max_Rows IN NUMBER) AS
	TYPE reg IS RECORD(
	nome VARCHAR2(20),
	sobrenome VARCHAR2(20),
	idade number);

	TYPE t_reg IS TABLE OF reg
		INDEX BY BINARY_INTEGER;

	lista t_reg;

	v_nome varchar2(20);
	v_sobrenome varchar2(20);
	v_davez varchar2(20);


BEGIN
	lista(1).nome := 'Jorge';
	lista(1).sobrenome := 'Luiz';
	lista(1).idade := 43;

	lista(2).nome := '';
	lista(2).sobrenome := 'Silva';
	lista(2).idade:= 20;

	lista(3).nome := 'Karen';
	lista(3).sobrenome := 'Rodrigues';
	lista(3).idade := 15;

	FOR i IN lista.FIRST..lista.LAST LOOP
		--v_davez := lista(i).nome;
		IF(lista(i).nome is null) THEN
			DBMS_OUTPUT.PUT_LINE('ENTROU NO IF COM ''IS NULL'' no indice #'||i);
		END IF;
	END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION NO_DATA_FOUND');

END;