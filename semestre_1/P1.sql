
-- 1- Listar Código e Nome de Cidade e Estado. Tabelas Loc_Cidade e Loc_Estado. 

use carloca;

select c.cd_cidade, nm_cidade, e.cd_estado, nm_estado
	from loc_estado e 
    inner join loc_cidade c
		on e.Cd_Estado = c.Cd_Estado;


-- 2- Liste Nome do Funcionário e o Salário de funcionários com salários maiores que 7000 e que pertençam ao departamento 10. Tabela Loc_Funcionario

select Nm_Func, Vl_Salario, f.cd_depto
	from loc_funcionario f
	inner join loc_depto d
		on f.Cd_Depto = d.Cd_Depto
	where Vl_Salario > 7000 and d.cd_depto = 10;


-- 3- Listar Número da Chapa, Valor da Diária e Nome da Cor do Veículo para diárias acima de 920. Tabela Loc_Veiculo e Loc_Cor.

select nr_placa, vl_diaria, desc_cor
	from loc_veiculo v
	inner join loc_cor c
		on v.cd_cor = c.cd_cor
	where vl_diaria > 920;

-- 4- Listar Veículos (Número da Chapa), Nome da Cor e Nome do Proprietário que pertençam a proprietários com códigos menores ou iguais a 5, cuja cor também tenham códigos menor ou igual a 5. Tabela Loc_Veiculo, Loc_Cor e Loc_Proprietario.

select nr_placa, desc_cor, nm_proprietario
	from loc_veiculo v
	inner join loc_cor c
        on v.cd_cor = c.cd_cor
	inner join loc_proprietario p
        on v.cd_proprietario = p.cd_proprietario
        where c.cd_cor <= 5 and p.cd_proprietario <=5;


-- 5- Crie uma instrução SQL que exiba todos os dados da tabela de Clientes. Exiba essa consulta em ordem de código de cliente. Tabela Loc_Cliente.

select * from loc_cliente
	order by Cd_cliente


-- 6- Listar Número do Pedido, Nome do Cliente e Número da Placa  de pedidos da CARLOCA cujo valor seja maior que 100. Tabelas Loc_Pedido_Locacao, Loc_Item_Locacao e Loc_Cliente.

select p.nr_pedido, nm_cliente, nr_placa
	from loc_pedido_locacao p
	inner join loc_cliente c
        on p.cd_cliente = c.cd_cliente
	inner join loc_item_locacao i
        on p.nr_pedido = i.Nr_Pedido
        where p.nr_pedido > 100;


-- 7- Listar Número do Pedido, Nome do Cliente, Número da Placa e Quilometragem do Veículo de todos os pedidos da CARLOCA. Tabelas Loc_Pedido_Locacao, Loc_Item_Locacao, Loc_Veiculo e Loc_Cliente.

select p.nr_pedido, nm_cliente, v.nr_placa, km_atual
	from loc_pedido_locacao p
	inner join loc_cliente c
        on p.Cd_Cliente = c.Cd_cliente
	inner join loc_item_locacao i
        on p.nr_pedido = i.nr_pedido
	inner join loc_veiculo v
        on i.Nr_Placa = v.Nr_Placa;

-- 8- Listar Número da Placa, Número do Chassi, Quilometragem Atual e Descrição da Cor de veículos, desde que a quilometragem seja maior ou igual 10000 e menor ou igual a 25000. Usar as tabelas Loc_Veiculo e Loc_Cor

select nr_placa, nr_chassis, km_atual, desc_cor
	from loc_veiculo v
    inner join loc_cor c
		on v.cd_cor = c.cd_Cor
	where km_atual >= 10000 and km_atual <= 25000;