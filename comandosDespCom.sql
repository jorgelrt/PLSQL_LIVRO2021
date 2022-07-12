select * from tb_comercio;--23
select * from tb_grupo;--21
select * from tb_despesas;--46
select * from tb_itens;

BEGIN
    imprimenota(46);
END;
/

BEGIN
    insereitens(45593,'dramin 50mg c/10 capsula',1,'un',10.99,46,21,23);
END;
/

BEGIN
    inserecomercio('drogaria boechat de castro ltda','rua satiro garibaldi',207,'itaperuna','rj');
END;
/

BEGIN
    inseredespesas('insumos internação Ana','17/02/2021',37.24,21,23);
END;
/

commit;


select distinct c.nome_com,
       d.dt_desp,
       d.descricao_desp,
       d.valor_desp
       --sum(VALOR_DESP)
from tb_comercio c join tb_despesas d
on c.id_com = d.tb_comercio_id_com join tb_grupo g
on d.grupo_id_grupo = g.id_grupo join tb_itens i
on d.id_desp = i.tb_despesas_id_desp
where d.dt_desp >= to_date('29/03/21')
--group by c.nome_com, d.dt_desp, d.descricao_desp,d.valor_desp,sum(VALOR_DESP)
order by dt_desp;


select d.descricao_desp,
       sum(d.valor_desp)
from tb_comercio c join tb_despesas d
on c.id_com = d.tb_comercio_id_com join tb_grupo g
on d.grupo_id_grupo = g.id_grupo 
where d.dt_desp >= to_date('29/03/21')
group by rollup(d.descricao_desp)



select codigo_item, descricao, qtde, valor_unitario, vl_total from tb_itens 
where tb_despesas_id_desp=96;

select descricao, sum(vl_total) from tb_itens
where tb_despesas_id_desp=96
group by rollup(descricao);


