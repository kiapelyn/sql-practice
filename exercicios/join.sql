
-- join

-- 41
 select v.nr_placa, v.nr_chassis, v.km_atual, c.desc_cor
	from loc_veiculo v
    inner join loc_cor c on v.cd_cor = c.cd_cor
    where c.desc_cor like '%L%';
    
-- 42
select v.nr_placa, v.nr_chassis, v.km_atual, c.desc_cor
	from loc_veiculo v
    inner join loc_cor c on v.cd_cor = c.cd_cor
    where v.km_atual between 10000 and 25000;
    
-- 43
select p.cd_proprietario, p.nm_proprietario, p.nr_cpf, v.nr_placa
	from loc_proprietario p
    inner join loc_veiculo v on p.cd_proprietario - v.cd_proprietario
    order by cd_proprietario; -- não precisaria pois escolhi usar proprietario como tabela de referncia, logo cd_proprietario é a pk

-- 44
select a.cd_agencia, a.nm_agencia, c.nm_cidade, e.nm_estado
	from loc_agencia a
    inner join loc_cidade c on a.cd_cidade = c.cd_cidade
    inner join loc_estado e on c.cd_estado = e.cd_estado;
    
-- 45
select ip.nr_pedido, ip.nr_placa, pl.dt_entrega
	from loc_pedido_locacao pl
    inner join loc_item_locacao ip on ip.nr_pedido = pl.nr_pedido
    order by pl.dt_entrega asc;

-- 46
select pl.nr_pedido, pl.dt_locacao, pl.vl_total, c.nm_cliente
	from loc_pedido_locacao pl
    inner join loc_cliente c on pl.cd_cliente = c.cd_cliente;
    
-- 47
select il.nr_pedido, il.nr_placa, pl.qt_dias, il.vl_diaria_calc, pl.dt_locacao, pl.vl_total, v.nr_placa, m.nm_modelo, p.nm_proprietario
	from loc_item_locacao il
	inner join loc_pedido_locacao pl on il.nr_pedido = pl.nr_pedido
	inner join loc_veiculo v on il.nr_placa = v.nr_placa
	inner join loc_modelo m on v.cd_modelo = m.cd_modelo
	inner join loc_proprietario p on v.cd_proprietario = p.cd_proprietario
	order by il.nr_pedido asc;
    
-- 48
select *
	from loc_veiculo v
    inner join loc_modelo m on v.cd_modelo = m.cd_modelo
    inner join loc_fabricante f on m.cd_fabricante = f.cd_fabricante;
    
-- 49
select *
	from loc_proprietario p
    inner join loc_veiculo v on p.cd_proprietario = v.cd_proprietario
    inner join loc_cor c on v.cd_cor = c.cd_cor
    where desc_cor != 'Amarelo';
    
-- 50
select v.nr_placa, p.nm_proprietario
	from loc_veiculo v
    inner join loc_proprietario p on v.cd_proprietario = p.cd_proprietario;
    
-- 51
select v.nr_placa, m.nm_modelo, f.nm_fabricante
	from loc_veiculo v
    inner join loc_modelo m on v.cd_modelo = m.cd_modelo
    inner join loc_fabricante f on m.cd_fabricante = f.cd_fabricante;

-- 52
select v.nr_placa, v.nr_chassis, v.km_atual, m.nm_modelo, f.nm_fabricante
	from loc_veiculo v
	inner join loc_modelo m on v.cd_modelo = m.cd_modelo
	inner join loc_fabricante f on m.cd_fabricante = f.cd_fabricante;
    
-- 53
select v.nr_placa, m.nm_modelo, f.nm_fabricante, p.nm_proprietario
	from loc_veiculo v
    inner join loc_modelo m on v.cd_modelo = m.cd_modelo
    inner join loc_fabricante f on m.cd_fabricante = f.cd_fabricante
    inner join loc_proprietario p on v.cd_proprietario = p.cd_proprietario;

-- 54
select v.nr_placa, m.nm_modelo, f.nm_fabricante, p.nm_proprietario, c.desc_cor
	from loc_veiculo v
    inner join loc_modelo m on v.cd_modelo = m.cd_modelo
    inner join loc_fabricante f on m.cd_fabricante = f.cd_fabricante
    inner join loc_proprietario p on v.cd_proprietario = p.cd_proprietario
    inner join loc_cor c on v.cd_cor = c.cd_cor;
    
-- 55
select nr_pedido, dt_locacao, qt_dias, vl_total, status, dt_retirada, dt_entrega, dt_pagto
	from loc_pedido_locacao;
-- essa é decisão de negócio, vc sabe identificar oq é informação principal?
-- minha decisão foi deixar apenas o que depende diretamente da pk nr_pedido

-- 56
select f.cd_func, f.nm_func, c.nm_cargo, d.nm_depto
	from loc_funcionario f
    inner join loc_cargo c on f.cd_cargo = c.cd_cargo
    inner join loc_depto d on f.cd_depto = d.cd_depto;
    
-- 57 
select f.cd_func, f.nm_func, g.nm_func
	from loc_funcionario f
	inner join loc_funcionario g on f.cd_gerente = g.cd_func;
		-- o inner join de uma tabela consigo mesma é chamada de SELF JOIN
        -- nesse caso, o inner join vai ocultar funcionarios que não tenham gerente
        -- o exercício 59 resolve esse problema

-- 58
select f.cd_func, f.nm_func, c.nm_cargo, d.nm_depto, g.nm_func, g.vl_salario
	from loc_funcionario f
    inner join loc_cargo c on f.cd_cargo = c.cd_cargo
    inner join loc_depto d on f.cd_depto = d.cd_depto
    left join loc_funcionario g on f.cd_gerente = g.cd_func;
    
-- 59 
select f.cd_func, f.nm_func, g.cd_func, g.nm_func
	from loc_funcionario f
	left join loc_funcionario g on f.cd_gerente = g.cd_func;
		-- já se usarmos o LEFT JOIN, incluímos também os funcionários que não tem gerente 
        
-- 60
select f.cd_func, f.nm_func, g.cd_func, g.nm_func
	from loc_funcionario f
	left join loc_funcionario g on f.cd_gerente = g.cd_func;

    

    


