use carloca;

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



------------------------------------------



Pré-normalização

TABELA PEDIDO
Nm_Comanda
Nm_Cliente
Nm_Produto
Nm_Tp_Produto
Vl_Produto
Vl_Perc_Desc

1ª Forma Normal

Repete: Cd_Produto, Cd_Tipo_Produto, Vl_Procuto, Vl_Perc_Desc
Não repete: Nr_Comanda, Cd_Cliente

2ª Forma Normal

Dos que repetem: o que depende apenas da chave primária (Cd_Comanda) e
o que depende de algo a mais

Item_Comanda -> Vl_Perc_Desc
Cd_Produto -> Cd_Tipo_Produto, Vl_Procuto, Vl_Perc_Desc

3ª Forma Normal

Dos que não repetem: o que dependem de algo que não seja a 
chave primária?

Cliente -> Cd_Cliente
Comanda -> Nr_Comanda


