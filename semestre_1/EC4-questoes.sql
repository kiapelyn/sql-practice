use carloca;

-- 2- Exercício: Objetivo: Select Básico
-- Crie uma instrução SQL que exiba todos os dados da tabela de
-- Proprietários. Exiba essa consulta em ordem de nome de proprietário.

Select * 
   from loc_proprietario
   order by Nm_Proprietario ASC;


-- 12. Desenvolva uma instrução SQL que exiba os seguintes dados dos funcionários: 
-- nome, código do departamento, CPF. Apresente apenas dados cujo documento seja 
-- não nulo.

SELECT Nm_Func AS "Nome", Cd_Depto AS "Código do departamento", Nr_CPF AS "CPF" 
	FROM loc_funcionario
    WHERE Nr_CPF IS NOT NULL;


-- 32. Desenvolva uma instrução SQL que exiba os seguintes dados: número do pedido,
-- data do pedido, valor total do pedido, status do pedido, código do funcionário que 
-- atendeu o pedido, nome do funcionário que atendeu o pedido, código do cliente, 
-- nome do cliente, telefone do cliente e número de estrelas do cliente. 
-- Caso o número de estrelas seja:
-- o	NULL  (em branco) exibir o texto “Sem estrelas”
-- o	<=1 exibir o texto “Estrela de Papel”
-- o	=  2 exibir o texto “Estrela de Lata”
-- o	=  3 exibir o texto “Estrela de Bronze”
-- o	=  4 exibir o texto “Estrela de Prata”
-- o	=  5 exibir o texto “Estrela de Ouro”

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


-- 42.	Objetivo: Join
-- Listar Número da Placa, Número do Chassi, Quilometragem Atual e Descrição da Cor de veículos, 
-- desde que a quilometragem seja maior ou igual 10000 e menor ou igual a 25000.
-- Usar as tabelas Loc_Veiculo e Loc_Cor
-- Sugestão: Usar operadores relacionais (>, >=, <, <>, etc) ou between, além da junção entre 
-- tabelas (inner join ou com where)


select Nr_Placa, Nr_Chassis, Km_Atual, Desc_Cor
	from loc_veiculo
	inner join loc_cor
	where loc_veiculo.cd_cor = loc_cor.cd_Cor
		and Km_Atual> 10000 and Km_Atual<25000;


-- 52.	Objetivo: Join
-- Desenvolva uma instrução SQL que exiba os dados dos veículos 
-- relativos aos modelos e fabricantes.

select nm_modelo, nm_fabricante
	from loc_modelo m
    inner join loc_fabricante f on m.cd_Fabricante = f.cd_Fabricante;


-- 72.	Objetivo: Uso de Funções de Grupamento
-- Elabore instrução SQL que apresente o maior salário pago na CARLOCA.

SELECT Nm_Func, max(Vl_Salario) 
	FROM loc_funcionario;


-- 82. Liste a maior, menor e a quilometragem média dos veículos 
-- da CARLOCA. Usar tabela Loc_Veiculo. Sugestão: usar funções 
-- Max, Min e Avg

select max(Km_Atual), min(Km_Atual), avg(Km_Atual)
	from Loc_Veiculo v;