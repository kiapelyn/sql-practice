use carloca;
    
-- ---------------------------------------------------------------------------

-- 5. Crie uma instrução SQL que exiba todos os dados da tabela de Pedidos de Locação 
-- em ordem descendente de valor de locação. (Loc_Pedido_Locacao) 

Select * 
	from loc_pedido_locacao
	order by Vl_Total desc;
    
-- ---------------------------------------------------------------------------

-- 16. Desenvolva uma instrução SQL que exiba os seguintes dados dos funcionários: 
-- nome, código do departamento, salário, comissão e data de início. (Não utilize
-- a cláusula*) na instrução SELECT. Exiba somente os funcionários que estejam 
-- cadastrados com números pares. Classifique essa consulta por ordem de código em 
-- ordem descendente

Select Nm_Func, Cd_Depto, Vl_Salario, Vl_Perc_Comissao, Dt_Inicio
	from loc_funcionario
    where Cd_Func % 2 = 0
    order by Cd_Func desc;
    
-- ---------------------------------------------------------------------------

-- 21. Desenvolva uma instrução SQL que exiba os seguintes dados: 
-- código e nome da operadora. Exiba somente as operadoras que
-- tenham mais do que 5 caracteres em seus nomes.

Select cd_Operadora, Nm_Operadora
	from loc_operadora
    where length(Nm_Operadora) > 5;
    
-- --------------------------------------------------------------------------

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

-- --------------------------------------------------------------------------

-- 38. Crie uma instrução SQL que exiba todos os dados do cliente. 
-- Somente exiba os clientes que tenham em qualquer parte do nome letra cadastrada
-- “I” maiúsculo ou “i” minúsculo e que o numero de estrelas seja inferior a 4.

Select *
	from loc_cliente
    where (Nm_Cliente like '%I%' or Nm_Cliente like '%i%') 
		and Nr_Estrelas < 4;
        
-- --------------------------------------------------------------------------

-- 41. Listar Número da Placa, Número do Chassi, Quilometragem Atual e Descrição da 
-- Cor de veículos, desde que a cor tenha ao menos uma letra “l” (ele) em seu nome. 
-- Algo como amare’L’o, azu’L’, etc... Usar as tabelas Loc_Veiculo e Loc_Cor 
-- Sugestão: Usar função like e a cláusula inner join (ou uso de where com chaves)

Select Nr_Placa, Nr_Chassis, Km_Atual, Desc_Cor
	from loc_veiculo v
    inner join loc_cor c
		on v.cd_cor = c.cd_Cor
	where Desc_Cor like '%l%';

-- --------------------------------------------------------------------------

-- 43. Desenvolva uma instrução SQL que exiba os seguintes dados: 
-- código e nome do proprietário, seu dados e seus veículos cadastrados. 
-- Classifique o resultado em ordem de código de proprietário.

Select p.Cd_Proprietario, p.Nm_Proprietario, Nr_CPF, Nr_Placa
	from loc_proprietario p
    inner join loc_veiculo v
		on p.cd_Proprietario = v.Cd_Proprietario
	order by cd_proprietario;
    
-- ---------------------------------------------------------------------------

-- 63. Elabore instrução SQL que apresente Nr da Placa dos Veículos e os nomes de suas Cores, 
-- desde que as cores tenham as letras “Pr” nessa sequência.
    
select Nr_Placa, Desc_cor
	from loc_veiculo v
    inner join loc_cor c
		on v.cd_cor = c.cd_cor
	where desc_cor like '%Pr%';
    