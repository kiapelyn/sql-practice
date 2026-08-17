
-- Funções Simples

-- 31
select upper(nm_func) as MAIUSCULAS, lower(nm_func) as minusculas, substr(nm_func, 3, 6) as tres_ao_oito
	from loc_funcionario;
    -- sintaxe do substr() = substr(campo, onde_começa, quantos_caracteres_pega)
    -- logo, a partir do caractere 3, queremos 6 caracteres (3 - 4 - 5 - 6 - 7 - 8) para chegar até o 8
    
-- 32
select pl.nr_pedido, pl.dt_locacao, pl.vl_total, pl.status, f.cd_func, f.nm_func, c.cd_cliente, nm_cliente, nm_fone_cliente, nr_estrelas,
	case 
           when c.nr_estrelas is null then 'Sem estrelas'
           when c.nr_estrelas <= 1    then 'Estrela de Papel'
           when c.nr_estrelas = 2     then 'Estrela de Lata'
           when c.nr_estrelas = 3     then 'Estrela de Bronze'
           when c.nr_estrelas = 4     then 'Estrela de Prata'
           when c.nr_estrelas = 5     then 'Estrela de Ouro'
           else 'Outra Categoria' -- Garantia caso exista um valor maior que 5
       end as categoria_estrelas
    from loc_pedido_locacao pl
    inner join loc_funcionario f on pl.cd_func = f.cd_func
    inner join loc_cliente c on pl.cd_cliente = c.cd_cliente
    inner join loc_fone_cliente fc on c.cd_cliente = fc.cd_cliente
    order by nr_estrelas;
    
-- 33
select nm_func
	from loc_funcionario
    where nm_func like '%A' or nm_func like '%A %';
    
-- 34
select *
	from loc_estado
    where sigla_estado regexp '[ASTM]';
    -- regexp funciona como uma lista, a query vai puxar pela existência de qualquer caractere da expressão regular
    
-- 35
select nm_proprietario as nome_completo,
       substr(nm_proprietario, instr(nm_proprietario, ' ') + 1) as segundo_e_demais_nomes
	from Loc_Proprietario
	where instr(nm_proprietario, ' ') > 0;
    
-- 36
select *
	from loc_grupo
    where nm_grupo like '%RA%';
    
-- 37
select nm_func
	from loc_funcionario
    where nm_func like '%SI%';
    
-- 38
select *
	from loc_cliente
    where nm_cliente like '%i%' and nr_estrelas < 4;
    -- lembrando que o mysql não diferencia maiúsculo de minusculo nos registros
    
-- 39
select *
	from loc_funcionario
    where nm_func like '%i%' and vl_salario < 7500;
    
-- 40
select *
	from loc_veiculo
    where nr_chassis like '%2%' and km_atual > 10000;