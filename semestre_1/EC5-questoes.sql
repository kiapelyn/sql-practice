use carloca;
-- 93.	Objetivo: Grupamento
-- Desenvolva uma instrução SQL que exiba a quantidade 
-- total de veículos agrupado por cor e modelo. Exiba 
-- somente os dados que tenham 2 ou mais veículos 
-- cadastrados.

Select c.desc_cor, m.nm_modelo, count(Nr_Placa) Quantidade
	from loc_veiculo v
	inner join loc_cor c on c.cd_Cor = v.cd_cor
	inner join loc_modelo m on m.cd_Modelo = v.cd_Modelo
	group by c.cd_cor, m.nm_modelo
    having count(Nr_placa) >= 2;

-- 112.	Objetivo: Subquery
-- Desenvolva uma instrução SQL que exiba os seguintes os nomes
-- e salários dos funcionários que tenham salários maior que 
-- a média salarial de algum departamento. 


Select Nm_Func, Vl_Salario
  from loc_funcionario
  where Vl_Salario > any(Select avg(Vl_Salario)
							from loc_funcionario);


-- 117.	Objetivo: Subquery
-- Crie uma instrução SQL que exiba todos os dados do 
-- funcionário que ganham o salário igual ou maior do
-- que a média do salário gasto pelo departamento 10. 
-- Classifique a consulta por salário em ordem ascendente.

Select *
	from loc_funcionario
	where Vl_Salario > (Select avg(Vl_Salario)
						from loc_funcionario
                        where cd_depto = 10)
	order by Vl_Salario ASC;


-- 119. Objetivo: Subquery
-- Desenvolva uma instrução SQL que exiba os dados dos departamentos
-- que tenham até 3 funcionários cadastrados até o momento.

Select * 
	from loc_depto 
	where Cd_Depto in (select Cd_Depto
							from loc_funcionario 
							group by Cd_Depto
							having count(*)<=3);


-- 129. Objetivo: Grupamento ou Subquery
-- Desenvolva uma instrução SQL que exiba Nr_Estrelas e quantidade de
-- clientes com o número de estrelas para clientes do tipo GOLDEN.


Select Nr_Estrelas Estrelas, count(Cd_cliente) Quantidade, Nm_Tp_Cliente
	from loc_cliente c
	inner join loc_tp_cliente tc
		on c.Cd_Tp_Cliente = tc.cd_Tp_Cliente
	where Nm_Tp_Cliente = "GOLDEN";