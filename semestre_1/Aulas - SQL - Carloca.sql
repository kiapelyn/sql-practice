use carloca;

-- lista de exercícios

-- 1: Select Básico
-- Desenvolva uma instrução SQL que exiba os seguintes dados dos
-- funcionários: código, nome e salário. (Não utilize a cláusula *) na instrução SELECT.
select nm_func, cd_func, vl_salario
	from loc_funcionario;
    
-- 2: Select Básico
-- Crie uma instrução SQL que exiba todos os dados da tabela de
-- Proprietários. Exiba essa consulta em ordem de nome de proprietário
select * from loc_proprietario
	order by Nm_Proprietario;
    
-- 3: Select Básico
-- Crie uma instrução SQL que exiba todos os dados da tabela de Bancos.
-- Exiba essa consulta em ordem de nome de banco
select * from loc_banco
	order by nm_banco;
    
-- 4: Select Básico
-- Crie uma instrução SQL que exiba todos os dados da tabela de Grupos de Automóveis (LOC_GRUPO)?
select * from loc_grupo;

-- 5: Select Básico
-- Crie uma instrução SQL que exiba todos os dados da tabela de Pedidos de
-- Locação em ordem descendente de valor de locação. (Loc_Pedido_Locacao)
select * from loc_pedido_locacao
	order by vl_total desc;
    
-- 6: Select Básico
-- Crie uma instrução SQL que exiba todos os dados da tabela de Clientes.
-- Exiba essa consulta em ordem de código de cliente
select * from loc_cliente
	order by cd_cliente;
    
-- 7: Select Básico
-- Crie uma instrução SQL que exiba todos os dados da tabela de Clientes.
-- Exiba essa consulta em ordem de número de estrelas do cliente
select * from loc_cliente
	order by Nr_Estrelas;
    
-- 8: Select Básico
-- Crie uma instrução SQL que exiba todos os dados da tabela de Estado?
-- Exiba essa consulta em ordem de sigla de Estado
select * from loc_estado
	order by Sigla_Estado;
    
-- 9: Select Básico
-- Desenvolva uma instrução SQL que exiba os seguintes dados dos
-- funcionários: nome, código do departamento, percentual de comissão e
-- data de início. Não utilize a cláusula * na instrução SELECT. Classifique
-- essa consulta por ordem de nome de funcionário
select nm_func, cd_depto, vl_perc_comissao, dt_inicio
	from loc_funcionario
    order by nm_func;

-- 10: Select Básico
-- Crie uma instrução SQL que exiba todos os dados da tabela de Cidade.
-- Exiba essa consulta em ordem de código do Estado.
select * from loc_cidade
	order by cd_estado;

-- 12: Select Básico
-- Desenvolva uma instrução SQL que exiba os seguintes dados dos
-- funcionários: nome, código do departamento, CPF. Apresente apenas
-- dados cujo documento seja não nulo
SELECT Nm_Func AS "Nome", Cd_Depto AS "Código do departamento", Nr_CPF AS "CPF" 
	FROM loc_funcionario
    WHERE Nr_CPF IS NOT NULL;
    
-- 16: Select Básico - Operador Resto
-- Desenvolva uma instrução SQL que exiba os seguintes dados dos funcionários: nome, 
-- código do departamento, salário, comissão e data de início. (Não utilize a cláusula *) na 
-- instrução SELECT. Exiba somente os funcionários que  estejam cadastrados com números pares. 
-- Classifique essa consulta por ordem de código em ordem descendente
select nm_func, cd_depto, vl_salario, vl_perc_comissao, dt_inicio
	from loc_funcionario
    where cd_func % 2 = 0
    order by cd_func desc;
    
-- 17: Select Básico - Operador Resto
-- Desenvolva uma instrução SQL que exiba os seguintes dados dos
-- funcionários: nome, código do departamento, salário, comissão e data de
-- início. (Não utilize a cláusula *) na instrução SELECT. Exiba somente os
-- funcionários que estejam cadastrados com números ímpares. Classifique
-- essa consulta por ordem de salário em ordem descendente
select nm_func, cd_depto, vl_salario, vl_perc_comissao, dt_inicio
	from loc_funcionario
    where cd_func % 2 != 0
    order by cd_func desc;

-- 19 Select Básico - Operadores Lógicos
-- Desenvolva uma instrução SQL que exiba todos os pedidos de locação
-- onde a data de retirada é maior do que a data de entrega. Exiba os
-- dados adequados para realizar análise.
select nr_pedido, dt_retirada, dt_entrega
	from loc_pedido_locacao
    where Dt_Retirada > Dt_Entrega;
    
-- 20 Select Básico - Operadores Lógicos
-- Desenvolva uma instrução SQL que exiba todos os pedidos de locação
-- onde a data do pedido é maior do que a data de entrega ou maior do que
-- a data de retirada ou o valor total do pedido é igual a zero. Exiba os
-- dados adequados para realizar análise.
select nr_pedido, dt_locacao, dt_retirada, dt_entrega, vl_total
	from loc_pedido_locacao
    where Dt_Locacao > Dt_Entrega or Dt_Locacao > Dt_Retirada or Vl_Total = 0;
    
-- 21: Select Básico - Operadores Lógicos
select nm_operadora, cd_operadora
	from loc_operadora
    where length(nm_operadora) > 5;
    
-- 22: Instrução SQL Básico
select nm_cliente
	from loc_cliente
    where length(nm_cliente) > 15 and nm_cliente like'%i%';
    
-- 24: Select Básico
select nm_depto, vl_orc_depto
	from loc_depto
    where Vl_Orc_Depto > 20000;
    
-- 25: Select Báscio (o máximo que eu tive saco de tentar)
select il.nr_pedido, nr_placa, truncate(vl_total,0), truncate(vl_total,1), truncate(vl_total,2)
	from loc_pedido_locacao pl
    inner join loc_item_locacao il
		on il.Nr_Pedido = pl.Nr_Pedido
    where il.Nr_Pedido = 10;
    
-- 31: Funções de Linha
 select upper(nm_func), lower(nm_func), substr(nm_func, 3, 7)
	from loc_funcionario;
    
-- 32: Uso de Funções de Linha
Select Nr_Pedido, Dt_Locacao, Vl_Total, Status, f.Cd_Func, Nm_Func, 
	c.Cd_Cliente, Nm_Cliente, Nm_Fone_Cliente,
    case
		when Nr_Estrelas is null then 'Sem estrelas'
        when nr_Estrelas <=1 then 'Estrela de Papel'
        when Nr_Estrelas = 2 then 'Estrela de Lata'
        when Nr_Estrelas = 3 then 'Estrela de Bronze'
        when Nr_Estrelas = 4 then 'Estrela de Prata'
        when Nr_Estrelas = 5 then 'Estrela de Ouro'
		else 'inválido'
	end as Nm_Estrelas
	from loc_pedido_locacao pl
    inner join loc_funcionario f
		on pl.Cd_Func = f.Cd_Func
	inner join loc_cliente c
		on pl.Cd_Cliente = c.Cd_cliente
	inner join loc_fone_cliente fc
		on fc.cd_Cliente = c.Cd_cliente;

-- 33: Função de linha
select nm_func
	from loc_funcionario
	where nm_func like'A%' or Nm_Func like'% A%';
    
-- 34: Objetivo: Função de Linha - Like
-- Crie uma instrução SQL que exiba todos os dados da tabela de Estado,
-- somente para os estados que tenham as seguintes letras em sua sigla
-- (A,S,T,M) ? Exiba essa consulta em ordem de sigla de Estado

select * from loc_estado
	where Sigla_Estado like '%A%' or '%S%' or '%T%' or '%M%'
    order by Sigla_Estado;
    
-- 35: Uso de Função de Linha
select Nm_Proprietario, substr(Nm_Proprietario, instr(Nm_Proprietario, ' '))
	from loc_proprietario;
    
-- 38: Select Básico - Like e Operadores Relacionais
Select *
	from loc_cliente
    where (Nm_Cliente like '%I%' or Nm_Cliente like '%i%') 
		and Nr_Estrelas < 4;

-- 41: Join
Select Nr_Placa, Nr_Chassis, Km_Atual, Desc_Cor
	from loc_veiculo v
    inner join loc_cor c
		on v.cd_cor = c.cd_Cor
	where Desc_Cor like '%l%';

-- 42: Join
select Nr_Placa, Nr_Chassis, Km_Atual, Desc_Cor
	from loc_veiculo
	inner join loc_cor
	where loc_veiculo.cd_cor = loc_cor.cd_Cor
		and Km_Atual> 10000 and Km_Atual<25000;
    
-- 43: Join
select p.cd_proprietario, nm_proprietario, nr_cpf, nr_placa
	from loc_proprietario p
    inner join loc_veiculo v
		on p.cd_proprietario = v.Cd_Proprietario
	order by cd_proprietario;

-- 51: Join
select nr_placa, nm_modelo, nm_fabricante
	from loc_veiculo v
    inner join loc_modelo m
		on m.cd_Modelo = v.cd_Modelo
    inner join loc_fabricante f
		on m.cd_fabricante = f.cd_Fabricante;
	
-- 52: Join
select nm_modelo, nm_fabricante
	from loc_modelo m
    inner join loc_fabricante f 
		on m.cd_Fabricante = f.cd_Fabricante;


-- 58: Join
select f.cd_func, f.nm_func, nm_cargo, nm_depto, fu.Nm_Func, fu.vl_salario
	from loc_funcionario f
    inner join loc_cargo c
		on f.Cd_Cargo = c.Cd_Cargo
    inner join loc_depto d
		on f.Cd_Depto = d.Cd_Depto
	inner join loc_funcionario fu
		on f.Cd_Gerente = fu.Cd_func;
    
-- 63: Join
select Nr_Placa, Desc_cor
	from loc_veiculo v
    inner join loc_cor c
		on v.cd_cor = c.cd_cor
	where desc_cor like '%Pr%';
    
-- 67: Join
select nr_placa, nm_grupo
	from loc_veiculo v
    inner join loc_grupo g
		on v.cd_grupo = g.cd_Grupo;
        
-- 71: Grupamento
select nm_depto, max(vl_salario)
	from loc_depto d
    inner join loc_funcionario f
		on d.Cd_Depto = f.cd_depto
	group by f.cd_depto;

-- 72: Uso de Funções de Grupamento
select nm_func, max(vl_salario)
	from loc_funcionario;
    
-- 73: Grupamento
select nm_depto, avg(vl_salario)
	from loc_funcionario f
    inner join loc_depto d
		on f.Cd_Depto = d.Cd_Depto
	where Vl_Perc_Comissao = 3
	group by d.cd_depto;
    
-- 75: Funções de Gurpamento
select min(qt_dias), max(qt_dias)
	from loc_pedido_locacao;

-- 77: Funções de Grupamento
select truncate(sum(vl_diaria),2), truncate(avg(vl_diaria),2)
	from loc_veiculo;

-- 82: Uso de Funções de Grupamento
select max(Km_Atual), min(Km_Atual), avg(Km_Atual)
	from Loc_Veiculo v;
    
-- 83: Grupamento
select nm_cargo, avg(vl_salario)
	from loc_funcionario f
    inner join loc_cargo c
		on f.Cd_Cargo = c.Cd_Cargo
	group by nm_cargo
	having avg(Vl_Salario) > 5000;

-- 85: grupamento
select nm_cidade
	from loc_cidade c
    inner join loc_agencia a
		on c.Cd_Cidade = a.cd_Cidade
	group by c.cd_cidade
    having sum(cd_Agencia) > 3;

-- 91: Grupamento
-- Desenvolva uma instrução SQL que exiba a quantidade de clientes
-- agrupada por número de estrelas e, dentro do grupamento de estrelas,
-- por tipo de cliente
select count(cd_cliente), nr_estrelas, nm_tp_cliente
	from loc_cliente c
    inner join loc_tp_cliente tc
		on c.Cd_Tp_Cliente = tc.cd_Tp_Cliente
	group by Nr_estrelas, Nm_Tp_Cliente;
        
	
-- 93: Grupamento
Select c.desc_cor, m.nm_modelo, count(Nr_Placa) Quantidade
	from loc_veiculo v
	inner join loc_cor c on c.cd_Cor = v.cd_cor
	inner join loc_modelo m on m.cd_Modelo = v.cd_Modelo
	group by c.cd_cor, m.nm_modelo
    having count(Nr_placa) >= 2;
    
-- 107: Objetivo: Join e Grupamento
-- Liste o valor médio e soma de locações por nome do cliente, mas
-- considere apenas valores maiores que 150 e médias maiores que 250.
-- Usar a tabela Loc_Pedido_Locacao e Loc_Cliente
-- Sugestão: usar funções Sum, Avg, grupamento e join entre tabelas
select nm_cliente, avg(vl_total), sum(vl_total)
	from loc_cliente c
    inner join loc_pedido_locacao pl
		on c.Cd_cliente = pl.Cd_Cliente
	where Vl_Total > 150
    group by Nm_Cliente
    having avg(vl_total) > 250;
    
-- 111. Objetivo: Subquery
-- Desenvolva uma instrução SQL que exiba os dados dos veículos que não
-- tenham pedido de locação feito até o momento.
select nr_placa, count(nr_pedido)
	from loc_item_locacao
    group by nr_placa
    having count(nr_pedido) = 0;

-- 113: Subquery
Select Nm_Func, Vl_Salario
  from loc_funcionario
  where Vl_Salario > any(Select avg(Vl_Salario)
							from loc_funcionario);

-- 114: Objetivo: Subquery
-- Desenvolva uma instrução SQL que exiba os seguintes os nomes e
-- salários dos funcionários que tenham salários maior que a média salarial
-- de todos departamento.

select nm_func, vl_salario
	from loc_funcionario
    where vl_salario > all (select avg(vl_salario)
								from loc_funcionario f
								inner join loc_depto d
								where f.Cd_Depto = d.Cd_Depto);

-- 117: Subquery
Select *
	from loc_funcionario
	where Vl_Salario > (Select avg(Vl_Salario)
						from loc_funcionario
                        where cd_depto = 10)
	order by Vl_Salario ASC;


-- 118
select * from loc_funcionario 
where Vl_Salario >=
		(select avg(Vl_Salario)
		from loc_funcionario
		where Cd_Depto = 52);
        
-- 119
select * 
	from loc_depto 
	where Cd_Depto in (select Cd_Depto
							from loc_funcionario 
							group by Cd_Depto
							having count(*)<=3);
                            
-- 120. Objetivo: Subquery
-- Desenvolva uma instrução SQL que exiba os dados dos proprietários que
-- não tenham mais que 7 veículos cadastrados até o momento.
select p.cd_proprietario, count(p.cd_proprietario), Nm_Proprietario, nr_cpf
	from loc_proprietario p
    inner join loc_veiculo v
		on p.cd_proprietario = v.Cd_Proprietario
	group by p.cd_proprietario
    having count(p.cd_proprietario) > 7;
    
-- 121. Objetivo: Uso de Funções, Join, Grupamento e Subquery
-- Liste o valor médio e soma de locações por nome do cliente somente
-- para clientes com médias maiores que a média geral da CARLOCA.
-- Usar a tabela Loc_Pedido_Locacao e Loc_Cliente
-- Sugestão: usar funções Sum, Avg, grupamento, join entre tabelas e subquery
select avg(vl_total), sum(vl_total), nm_cliente
	from loc_pedido_locacao pl
    inner join loc_cliente c
		on pl.Cd_Cliente = c.Cd_cliente
	group by nm_cliente
    having avg(vl_total) > (select avg(vl_total)
								from loc_pedido_locacao);


-- 129: Subquery e Grupamento
Select Nr_Estrelas Estrelas, count(Cd_cliente) Quantidade, Nm_Tp_Cliente
	from loc_cliente c
	inner join loc_tp_cliente tc
		on c.Cd_Tp_Cliente = tc.cd_Tp_Cliente
	where Nm_Tp_Cliente = "GOLDEN";
    
    
    
-- P2

-- 1- Desenvolva uma instrução SQL que exiba os seguintes dados: O código, o nome do departamento,
-- o valor médio do salário gasto com salários, o menor salário, o maior salário e o valor total 
-- gasto por departamento. 
select d.cd_depto, nm_depto, avg(vl_salario), min(vl_salario), max(vl_salario), sum(vl_salario)
	from loc_depto d
    inner join loc_funcionario f
		on d.Cd_Depto = f.Cd_Depto
	group by Cd_Depto;

-- 2-	Desenvolva uma instrução SQL que exiba os seguintes dados dos veículos: placa,
-- nome do proprietário que tenham a sílaba ‘da’ como parte do nome. 
select nr_placa, nm_proprietario
	from loc_veiculo v
    inner join loc_proprietario p
		on v.Cd_Proprietario = p.cd_proprietario
	where Nm_Proprietario like'%da%';

-- 3-	Desenvolva uma instrução SQL que exiba nomes das cores e a quantidade (contagem)
-- de locações, apenas da cor de veículo com mais locações. 
select c.desc_cor, count(il.nr_pedido)
	from loc_veiculo v
	inner join loc_cor c 
		on v.cd_cor = c.cd_Cor
	inner join loc_item_locacao il 
		on v.nr_placa = il.nr_placa
	group by c.cd_cor, c.desc_cor
    having count(il.nr_pedido) = (select max(contagem_por_cor)
										from (select count(il.nr_pedido) as contagem_por_cor
													from loc_veiculo v
                                                    inner join loc_item_locacao il
														on v.nr_placa = il.nr_placa
                                                        group by v.cd_cor) as subquery_contagens);

-- 4-	Quantos carros temos de cada cor, ordenados alfabeticamente pelo nome da cor, 
-- desde que a cor tenha ao menos uma letra “e” no seu nome?
select desc_cor, count(nr_placa)
	from loc_veiculo v
    inner join loc_cor c
		on v.cd_cor = c.cd_Cor
	where desc_cor like'%e%'
	group by c.cd_cor
    order by desc_cor;

-- 5-	Desenvolva uma instrução SQL que exiba a quantidade de clientes agrupada por tipo de
-- cliente e, detro do grupamento por tipo de cliente, por número de estrelas.
select count(cd_cliente), Nm_Tp_Cliente, nr_estrelas
	from loc_cliente c
    inner join loc_tp_cliente tc
		on c.Cd_Tp_Cliente = tc.cd_Tp_Cliente
	group by Nm_Tp_Cliente, Nr_Estrelas;

-- 6-	Liste a maior, menor e a quilometragem média dos veículos da CARLOCA.
select max(km_atual), min(km_atual), avg(km_atual)
	from loc_veiculo;

-- 7-	Liste o Nome do Gerente e o menor salário pago a algum subordinado dele.
select g.nm_func 'Nome do gerente', min(f.vl_salario) 'Salário do funcionário'
	from loc_funcionario f
    inner join loc_funcionario g
		on g.Cd_Func = f.Cd_Gerente
    group by g.Nm_Func;
    
