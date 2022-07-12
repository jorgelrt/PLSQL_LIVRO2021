CREATE TABLE tb_grupo (
  id_grupo INT NOT NULL,
  descricao VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_grupo));
  
CREATE TABLE  tb_comercio (
  id_com INT NOT NULL,
  nome_com VARCHAR(80) NOT NULL,
  logradouro_com VARCHAR(100) NULL,
  nr_com VARCHAR(5) NULL,
  cidade_com VARCHAR(45) NULL,
  uf_com VARCHAR(2) NULL,
  PRIMARY KEY (id_com))
;  

CREATE TABLE  tb_despesas (
  id_desp INT NOT NULL,
  dt_desp DATE NOT NULL,
  valor_desp NUMBER NULL,
  descricao_desp VARCHAR(45) NULL,
  grupo_id_grupo INT NOT NULL,
  tb_comercio_id_com INT NOT NULL,
  PRIMARY KEY (id_desp, grupo_id_grupo, tb_comercio_id_com));
  
  alter table tb_despesas
  add constraint fk_tb_despesas_tb_comercio1 foreign key(tb_comercio_id_com) 
  references tb_comercio(id_com);
  
  alter table tb_despesas
  add constraint fk_tb_despesas_grupo foreign key(grupo_id_grupo) 
  references tb_grupo(id_grupo);
  
  CREATE TABLE  tb_itens (
  codigo_item INT NOT NULL,
  descricao VARCHAR(100) NOT NULL,
  qtde INT NOT NULL,
  unidade_fornecimento VARCHAR(2) NULL,
  valor_unitario NUMBER NULL,
  tb_despesas_id_desp INT NOT NULL,
  tb_despesas_grupo_id_grupo INT NOT NULL,
  tb_despesas_tb_comercio_id_com INT NOT NULL,
  PRIMARY KEY (codigo_item, tb_despesas_id_desp, tb_despesas_grupo_id_grupo, tb_despesas_tb_comercio_id_com));
  
  
  alter table tb_itens
  add constraint fk_tb_itens_tb_despesas1 foreign key(tb_despesas_id_desp, tb_despesas_grupo_id_grupo, tb_despesas_tb_comercio_id_com) 
  references tb_despesas(id_desp, grupo_id_grupo, tb_comercio_id_com);