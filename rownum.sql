--não podemos utilizar ROWNUM p/ recuperar as linhas N mais altas na ordem de pesquisa
SELECT first_name, last_name FROM students
WHERE ROWNUM < 3
ORDER BY first_name;
/*
	Apesar dessa instrução retornar duas linhas classificado, elas NÃO SERÃO as primeiras duas linhas da ordem de classificação inteira.
	Para garantir isso, é melhor criar um cursor e buscar as duas linhas primeiras
*/