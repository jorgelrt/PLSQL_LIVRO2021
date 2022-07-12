/*
Pergunta: Quais são alguns exemplos de trabalho de um tipo de objeto em PL/SQL?

Resposta: Os tipos de objetos em PL/SQL são muito mais rápidos do que os cursores PL/SQL explícitos. 
          Aqui estão alguns exemplos de trabalho de construções do tipo objeto PL/SQL:
*/

CREATE OR REPLACE TYPE t_endereco AS OBJECT(
	logradouro CHAR(40),
	cidade CHAR(40),
	uf CHAR(2),
	cep CHAR(8));
	
CREATE TABLE pessoa(
	nome CHAR(40),
	sobrenome CHAR(40),
	endereco t_endereco --endereço como objeto
	);

describe pessoa;

INSERT INTO pessoa
VALUES('JORGE','RODRIGUES',t_endereco('AMANDO GEERTS,464','SAO JOSE DO CALCADO','ES','29470000'));



DECLARE
	v_nome pessoa.nome%TYPE;
	v_sobrenome pessoa.sobrenome%TYPE;
	v_endereco t_endereco;
BEGIN
	v_nome := 'CAMILLE';
	v_sobrenome := 'ETIENE';
	v_endereco := t_endereco('RUA VAZ DE CAMINHA, 401','RIO DE JANEIRO','RJ','20780330');
	commit;
END;
/


SELECT nome, sobrenome, endereco FROM pessoa; --mostra endereco como OBJETO

SELECT nome, sobrenome, p.endereco.logradouro, p.endereco.cidade FROM pessoa p; --mostra cada tupla do OBJETO