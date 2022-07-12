
CREATE DATABASE LINK nome_do_link
CONNECT TO nome_usuario IDENTIFIED BY senha
USING string_de_sqlnet;

--declaração SQL
CREATE DATABASE LINK sales.us.americas.acme_auto.com
USING 'sales_us';
--conexão databases >> sales usando o nome de serviço sales_us
--conecta como >> usuario conectado
--tipo de link >> usuario conectado privado

CREATE DATABASE LINK foo 
CONNECT TO CURRENT_USER 
USING 'am_sls';
--conexão databases >> sales usando o nome de serviço am_sls

CREATE DATABASE LINK sales.us.americas.acme_auto.com
CONNECT TO scott IDENTIFIED BY tiger
USING 'sales_us';
--conexão databases >> sales usando o nome de serviço sales_us
--conecta como >> tiger

CREATE PUBLIC DATABASE LINK sales
CONNECT TO scott IDENTIFIED BY tiger
USING 'rev';
--conexão databases >> sales usando o nome de serviço rev
--conecta como >> scott com senha tiger

--Passo a passo p/ criar o database link
https://docs.oracle.com/cd/B28359_01/server.111/b28310/ds_admin002.htm#ADMIN12152
