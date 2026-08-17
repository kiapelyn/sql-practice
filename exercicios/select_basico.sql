
-- Select básico

-- 1
select cd_func, nm_func, vl_salario
	from loc_funcionario;
    
-- 2
select *
	from loc_proprietario
    order by nm_proprietario;
    
-- 3
select *
	from loc_banco
    order by nm_banco;
    
-- 4
select *
	from loc_grupo;
    
-- 5
select *
	from loc_pedido_locacao
    order by vl_total desc;
 
-- 6
select *
	from loc_cliente; -- o exercício pedia para ordernar por id do cliente, mas como o cd_cliente é a pk, ela naturalmente vem ordenada

-- 7
select * 
	from loc_cliente
	order by nr_estrelas;

-- 8
select *
	from loc_estado
    order by sigla_estado;
   
-- 9
select nm_func, cd_depto, vl_perc_comissao, dt_inicio
	from loc_funcionario
    order by nm_func;

-- 10
select *
	from loc_cidade
    order by cd_estado;
    
-- 11
select *
	from loc_cidade
	where nm_cidade like '% %'
    order by cd_estado;
    
-- 12
select nm_func, cd_depto, nr_cpf
	from loc_funcionario
    where nr_cpf is not null;
    
-- 13
select cd_func, nm_func, vl_salario, vl_perc_comissao
	from loc_funcionario;
    
-- 14
select nr_placa, nr_chassis
	from loc_veiculo;
    
-- 15
select *
	from loc_cidade
    where (nm_cidade like '%Z%' or nm_cidade like '%B%') and cd_estado = 3 ;
    -- note que o MYSQL e o SQL Server não diferenciam maiusculas e minusculas
    -- caso use o PostgreSQL, troque LIKE por ILIKE se quiser ignorar essa diferenciação
    
-- 16 
select nm_func, cd_depto, vl_salario, vl_perc_comissao, dt_inicio
	from loc_funcionario
    where cd_func % 2 = 0
    order by cd_func desc;
    
-- 17
select nm_func, cd_depto, vl_salario, vl_perc_comissao, dt_inicio
	from loc_funcionario
    where cd_func % 2 != 0
    order by cd_func desc;
    
-- 18
select nm_func, vl_salario
	from loc_funcionario
    order by nm_func;
    
-- 19
select nr_pedido, dt_retirada, dt_entrega
	from loc_pedido_locacao
    where dt_retirada > dt_entrega;
    -- note que, em via de negócio, essa query não faz sentido, você não retira depois da data que você devolveu o carro
    -- essa instrução é para mostrar que resultados vazios são possíveis e estão corretos
    
-- 20
select nr_pedido, dt_locacao, dt_retirada, dt_entrega, vl_total
	from loc_pedido_locacao
    where (dt_locacao > dt_entrega) or (dt_locacao > dt_retirada) or vl_total = 0;

-- 21
select cd_operadora, nm_operadora 
	from loc_operadora
    where length(nm_operadora) > 5;
    
-- 22
select *
	from loc_cliente
    where length(nm_cliente) > 15 and nm_cliente like '%i%';
    
-- 23
select nm_cliente, cd_tp_cliente
	from loc_cliente;

-- 24
select nm_depto, vl_orc_depto
	from loc_depto
    where vl_orc_depto > 20000;
    
-- 25
select nr_pedido,
       nr_placa,
       round(vl_diaria, 0) as vl_tot_sem_casa_decimal,
       round(vl_diaria, 1) as vl_tot_com_1_casa_decimal,
       round(vl_diaria, 2) as vl_tot_com_2_casa_decimal
	from loc_item_locacao
	where nr_pedido = 10;
    -- você pode usar o comando AS para mudar o nome de um campo no result grid
    
-- 26
select cd_cliente, nm_cliente, cd_tp_cliente, nr_estrelas, nr_habilitacao
	from loc_cliente
    order by cd_cliente; 
    -- lembrando que a ordenação aqui não é obrigatória no mundo real por se tratar da pk
    -- mas, se estiver na instrução, na prova precisa!
    
-- 27
select cd_cliente, nm_cliente, nr_estrelas
	from loc_cliente
    where nr_estrelas % 2 = 1;
    
-- 28
select nm_func, vl_salario
	from loc_funcionario
    where vl_salario > 7000;
    
-- 29
select nr_placa, vl_diaria
	from loc_veiculo
    where vl_diaria > 300
    order by vl_diaria desc;
    
-- 30
select nr_placa, vl_diaria
	from loc_veiculo
    where vl_diaria > 300
    order by vl_diaria asc;
    -- para ordenar de forma crescente pode-se, ou não, usar ASC, não colocar nada também configura como ASC como padrão
    