use carloca;

select * from loc_depto;

select * from loc_funionario;

-- Join clássico full
select nm_func, nm_depto
	from loc_funcionario, loc_depto;
    
-- Join clássico interno
select nm_func, nm_depto
	from loc_funcionario, loc_depto
	where loc_funcionario.cd_depto = loc_depto.cd_depto;
    
-- Join classico interno, apenas funcionarios que ganhem > 7000
select nm_func, nm_depto, Vl_Salario
	from loc_funcionario, loc_depto
	where loc_funcionario.cd_depto = loc_depto.cd_depto
		and Vl_Salario > 7000;
        
-- Inner Join com salario > 7000
select nm_func, nm_depto, Vl_Salario
	from loc_funcionario
	inner join loc_depto 
		on loc_funcionario.cd_depto = loc_depto.cd_depto
	where Vl_Salario > 7000;

-- Quero o nome do cargo, o nome do funcionário, o departamento e quem ganha > 7000
select Nm_Func, Nm_Cargo, Nm_Depto, Vl_Salario
	from loc_funcionario
	inner join loc_depto
		on loc_funcionario.Cd_Depto = loc_depto.Cd_Depto
    inner join loc_cargo
		on loc_funcionario.Cd_Cargo = loc_cargo.Cd_Cargo
	where Vl_Salario > 7000;

-- Solução simples e errada
select Nm_Func, Nm_Cargo, Nm_Depto, Vl_Salario
	from loc_funcionario
	inner join loc_depto
		on Cd_Depto = Cd_Depto
    inner join loc_cargo
		on Cd_Cargo = Cd_Cargo
	where Vl_Salario > 7000;
    
-- Solução simples certa
select Cd_Func Cógigo, Nm_Func Nome, Nm_Cargo Cargo, Nm_Depto Departamento, Vl_Salario Salário
	from loc_funcionario f
	inner join loc_depto d
		on f.Cd_Depto = d.Cd_Depto
    inner join loc_cargo c
		on f.Cd_Cargo = c.Cd_Cargo
	where Vl_Salario > 7000;
    
-- Solução do mineiro
select Nm_Func, Nm_Cargo, Nm_Depto, Vl_Salario
	from loc_funcionario gelado
	inner join loc_depto kaykay
		on gelado.Cd_Depto = kaykay.Cd_Depto
    inner join loc_cargo lourinha
		on gelado.Cd_Cargo = lourinha.Cd_Cargo
	where Vl_Salario > 7000;
    
-- Solução simples certa (código do departamento)
select Nm_Func, d.Cd_Depto, f.Cd_Depto, Nm_Cargo, Nm_Depto, Vl_Salario
	from loc_funcionario f
	inner join loc_depto d
		on f.Cd_Depto = d.Cd_Depto
    inner join loc_cargo c
		on f.Cd_Cargo = c.Cd_Cargo
	where Vl_Salario > 7000;
    
 -- liste cidades e seus respectivos estados
 select nm_cidade nc, nm_estado ne
	from loc_estado e 
    inner join loc_cidade c
		on e.Cd_Estado = c.Cd_Estado
        order by nc asc, ne asc;
        
-- Fabricante com cliente
select pl.Nr_Pedido, Dt_Locacao, Nm_Tp_Cliente, nm_fabricante, nm_cliente, v.nr_placa, nm_modelo
	from loc_pedido_locacao pl
	inner join loc_cliente c
		on pl.cd_cliente = c.Cd_Cliente
	inner join loc_tp_cliente tpc
		on c.Cd_Tp_Cliente = tpc.cd_Tp_Cliente
	inner join loc_item_locacao il
		on pl.nr_pedido = il.Nr_Pedido
	inner join loc_veiculo v
		on il.Nr_Placa = v.Nr_Placa
	inner join loc_modelo m
		on v.cd_modelo = m.cd_Modelo
	inner join loc_fabricante f
		on m.cd_Fabricante = f.cd_Fabricante;
        
Select * from loc_funcionario;

-- Listar nome do funcionário, seu salário, nome do gerente e salário (é uma só tabela)

select f.nm_func, f.vl_salario, g.nm_func, g.vl_salario
	from loc_funcionario f
	inner join loc_funcionario g
		on f.Cd_Gerente = g.Cd_Func
    order by f.nm_func;

-- todos os subordinados, mesmo sem chefe

select f.nm_func, f.vl_salario, g.nm_func, g.vl_salario
	from loc_funcionario f
	left join loc_funcionario g
		on f.Cd_Gerente = g.Cd_Func
    order by f.nm_func;

-- todos os chefes, mesmo que sem subordinado

select f.nm_func, f.vl_salario, g.nm_func, g.vl_salario
	from loc_funcionario f
	right join loc_funcionario g
		on f.Cd_Gerente = g.Cd_Func
    order by f.nm_func;
    
-- ex 1
select cd_func, nm_func, vl_salario
	from loc_funcionario;
    
-- ex 2
select * from loc_proprietario
	order by nm_proprietario;

-- ex 3
select * from loc_banco
	order by nm_banco;
    
-- Listar Código e Nome de Cidade e Estado. Tabelas Loc_Cidade e Loc_Estado. 
select c.cd_cidade, nm_cidade, e.cd_estado, nm_estado
	from loc_estado e 
    inner join loc_cidade c
		on e.Cd_Estado = c.Cd_Estado;

-- Liste Nome do Funcionário e o Salário de funcionários com salários maiores que 7000 e que pertençam ao departamento 10. Tabela Loc_Funcionario
select Nm_Func, Vl_Salario, f.cd_depto
	from loc_funcionario f
	inner join loc_depto d
		on f.Cd_Depto = d.Cd_Depto
	where Vl_Salario > 7000 and d.cd_depto = 10;
    
-- Listar Número da Chapa, Valor da Diária e Nome da Cor do Veículo para diárias acima de 920. 
-- Tabela Loc_Veiculo e Loc_Cor.

select nr_placa, vl_diaria, desc_cor
	from loc_veiculo v
	inner join loc_cor c
		on v.cd_cor = c.cd_cor
	where vl_diaria > 920;

-- Listar Veículos (Número da Chapa), Nome da Cor e Nome do Proprietário que pertençam a proprietários 
-- com códigos menores ou iguais a 5, cuja cor também tenham códigos menor ou igual a 5. 
-- Tabela Loc_Veiculo, Loc_Cor e Loc_Proprietario.
select nr_placa, desc_cor, nm_proprietario
	from loc_veiculo v
	inner join loc_cor c
        on v.cd_cor = c.cd_cor
	inner join loc_proprietario p
        on v.cd_proprietario = p.cd_proprietario
        where c.cd_cor <= 5 and p.cd_proprietario <=5;
	
-- 5- Crie uma instrução SQL que exiba todos os dados da tabela de Clientes. 
-- Exiba essa consulta em ordem de código de cliente. Tabela Loc_Cliente.

select * from loc_cliente
	order by Cd_cliente;

-- Listar Número do Pedido, Nome do Cliente e Número da Placa  de pedidos da CARLOCA 
-- cujo valor seja maior que 100. Tabelas Loc_Pedido_Locacao, Loc_Item_Locacao e Loc_Cliente.
select p.nr_pedido, nm_cliente, nr_placa
	from loc_pedido_locacao p
	inner join loc_cliente c
        on p.cd_cliente = c.cd_cliente
	inner join loc_item_locacao i
        on p.nr_pedido = i.Nr_Pedido
        where p.nr_pedido > 100;

-- Listar Número do Pedido, Nome do Cliente, Número da Placa e Quilometragem do Veículo de todos os 
-- pedidos da CARLOCA. Tabelas Loc_Pedido_Locacao, Loc_Item_Locacao, Loc_Veiculo e Loc_Cliente.

select p.nr_pedido, nm_cliente, v.nr_placa, km_atual
	from loc_pedido_locacao p
	inner join loc_cliente c
        on p.Cd_Cliente = c.Cd_cliente
	inner join loc_item_locacao i
        on p.nr_pedido = i.nr_pedido
	inner join loc_veiculo v
        on i.Nr_Placa = v.Nr_Placa;

-- Listar Número da Placa, Número do Chassi, Quilometragem Atual e Descrição da Cor de veículos, 
-- desde que a quilometragem seja maior ou igual 10000 e menor ou igual a 25000. 
-- Usar as tabelas Loc_Veiculo e Loc_Cor

select nr_placa, nr_chassis, km_atual, desc_cor
	from loc_veiculo v
    inner join loc_cor c
		on v.cd_cor = c.cd_Cor
	where km_atual >= 10000 and km_atual <= 25000;
    

-- AULA DE 30/04


select Nm_Func, Vl_Salario from loc_funcionario;

-- Qual a soma dos salários do carloca?

select sum(Vl_Salario) from loc_funcionario;

select sum(Vl_Salario) 'Soma de Salários' from loc_funcionario;

select sum(Vl_Salario) Soma_Salários from loc_funcionario;

-- Maior, menor, média de salários

select max(Vl_Salario), 
       min(Vl_Salario), 
       avg(Vl_Salario) 
	from loc_funcionario;
    
-- "Puxe Nm_Func a partir do caractere x"

select Nm_Func, substr(Nm_Func,1) from loc_funcionario;

select Nm_Func, substr(Nm_Func,12) from loc_funcionario;

-- "A partir do caractere x, puxe y caracteres de Nm_Func"

select Nm_Func, substr(Nm_Func, 5, 2) from loc_funcionario;

-- "Puxe o índice de Nm_Func em que aparece o primeiro caractere 'a'"

select Nm_Func, Instr(Nm_Func, 'a') from loc_funcionario;
    
-- "Puxe o resto do nome depois do primeiro 'a' encontrado"

select Nm_Func, substr(Nm_Func,instr(Nm_Func, 'a')+1) from loc_funcionario;

-- "Puxe o resto do nome depois do primeiro 'a' encontrado e diga quantos caracteres tem"

select Nm_Func,
	   substr(Nm_Func,instr(Nm_Func, 'a')+1),
       length(substr(Nm_Func,instr(Nm_Func, 'a')+1))
	from loc_funcionario;

select cd_func, vl_salario from loc_funcionario;

select cd_func, mod(cd_func,2),
	   vl_salario from loc_funcionario;
       
-- Média salarial

select avg(vl_salario)
	from loc_funcionario;
    
-- "'truncar' na terceira posição, ou seja, mostrar só os centavos"

select truncate(avg(Vl_Salario),2)
	from loc_funcionario;
    
-- "round arredonda a cada depois da que você indicou"

select round(avg(Vl_Salario),2)
	from loc_funcionario;
    
-- Quero a soma salarial por departamento

select cd_depto, sum(Vl_Salario) 
	from loc_funcionario
    group by cd_depto;
    

-- qual a media salarial dos cargos do carloca?

select nm_cargo, round(avg(Vl_Salario),2) 
	from loc_funcionario f
    inner join loc_cargo c on f.Cd_Cargo = c.Cd_Cargo
    group by nm_cargo
    order by avg(vl_salario);
    

-- qual o maior salário paga em cada departamento em ordem alfabética
select nm_depto 'Departamento', max(vl_salario) 'Maior salário'
	from loc_funcionario f
    inner join loc_depto d on f.Cd_Depto = d.Cd_Depto
    group by nm_depto
    order by Nm_Depto;
    
    
-- Vamos olhar os salários
select vl_salario from loc_funcionario order by vl_salario;

-- Arbitrariamente quero controlar altos salários (> 6000)
select vl_salario, cd_depto
	from loc_funcionario 
    where vl_salario > 6000
    order by vl_salario;
    
-- qual a média salarial de cada departamento em ordem alfabética
-- mas apenas altos salários (> 6000)
select nm_depto 'Departamento', avg(vl_salario) 'MMédia Salarial'
	from loc_funcionario f
    inner join loc_depto d on f.Cd_Depto = d.Cd_Depto
    where vl_salario > 6000
    group by nm_depto -- junta linhas com as mesmas características
    order by Nm_Depto;

-- quero somente departamentos altos pagadore, 
-- ou seja, a media salarial deve ser < 10000
select nm_depto 'Departamento', avg(vl_salario) 'Média salarial'
	from loc_funcionario f
    inner join loc_depto d on f.Cd_Depto = d.Cd_Depto
    where vl_salario > 6000 -- nunca vai função
    group by nm_depto
    having avg(Vl_Salario) > 10000 -- o "where" para grupos, sempre vai função
    order by avg(Vl_Salario);
    
-- entendendo modelos de CARLOCA
select nm_fabricante, nm_modelo, nr_placa, vl_diaria
	from loc_veiculo v
    inner join loc_modelo m on v.cd_Modelo = m.cd_Modelo
    inner join loc_fabricante f on m.cd_Fabricante = f.cd_Fabricante;

-- agrupe somas de diárias pro fabricantes e modelo
-- mas elimine veículos cuja diária seja menor que 200
select nm_fabricante, nm_modelo, sum(vl_diaria)
	from loc_veiculo v
    inner join loc_modelo m on v.cd_Modelo = m.cd_Modelo
    inner join loc_fabricante f on m.cd_Fabricante = f.cd_Fabricante
    where Vl_Diaria >= 200
    group by Nm_Fabricante, nm_modelo;


-- agrupe somas de diárias pro fabricantes e modelo
-- mas elimine veículos cuja diária seja menor que 200
-- só ricão bobão que paga mais que 2800
select nm_fabricante, nm_modelo, sum(vl_diaria)
	from loc_veiculo v
    inner join loc_modelo m on v.cd_Modelo = m.cd_Modelo
    inner join loc_fabricante f on m.cd_Fabricante = f.cd_Fabricante
    where Vl_Diaria >= 200
    group by Nm_Fabricante, nm_modelo
    having sum(vl_diaria) >= 2800;


-- EC4

-- 52.	Objetivo: Join
-- Desenvolva uma instrução SQL que exiba os dados dos veículos relativos aos modelos e fabricantes.

select nm_modelo, nm_fabricante
	from loc_modelo m
    inner join loc_fabricante f on m.cd_Fabricante = f.cd_Fabricante;


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


-- AULA DE 21/05

-- média salarial CARLOCA
select avg(Vl_Salario)
	from loc_funcionario f;
    
-- quem ganha mais que 7183 reais? (media salarial)
select nm_func, vl_salario
	from loc_funcionario 
    where vl_salario > 7183;
    
-- quem ganha mais que a média salarial? GENÉRICO
-- SUBQUERY é colocar uma rotina dentro de outra rotina
select nm_func, vl_salario
	from loc_funcionario 
    where vl_salario > (select avg(Vl_Salario)
							from loc_funcionario);
                            

-- AULA DE 28/05

select Nm_grupo, count(v.cd_grupo)
	from loc_grupo g
    inner join loc_veiculo v on v.cd_grupo = g.cd_Grupo
    group by v.cd_grupo;
    
	Select nm_func, vl_salario
		from loc_funcionario;
    
    Create view Portaria as
		Select nm_func, vl_salario
		from loc_funcionario;
            
	Select * from Portaria;
   
Create view Contagem_Grupos_Para_Portaria as
	select Nm_grupo, count(v.cd_grupo)
		from loc_grupo g
		inner join loc_veiculo v on v.cd_grupo = g.cd_Grupo
		group by v.cd_grupo;
        
Select * from Contagem_Grupos_Para_Portaria;

#118
select * from loc_funcionario 
where Vl_Salario >=
		(select avg(Vl_Salario)
		from loc_funcionario
		where Cd_Depto = 52);
        
#119
select * 
	from loc_depto 
	where Cd_Depto in (select Cd_Depto
							from loc_funcionario 
							group by Cd_Depto
							having count(*)<=3);


        
select Nr_Estrelas Estrelas, count(Cd_cliente) Quantidade, Nm_Tp_Cliente "Tipo do Cliente"
	from loc_cliente c
	inner join loc_tp_cliente tc
		on c.Cd_Tp_Cliente = tc.cd_Tp_Cliente
	where Nm_Tp_Cliente = "GOLDEN";
    
-- 93.	Objetivo: Grupamento
-- Desenvolva uma instrução SQL que exiba a quantidade 
-- total de veículos agrupado por cor e modelo. Exiba 
-- somente os dados que tenham 2 ou mais veículos 
-- cadastrados.

select c.desc_cor, m.nm_modelo, count(*) 
from loc_veiculo v
inner join loc_cor c on c.cd_Cor = v.cd_cor
inner join loc_modelo m on m.cd_Modelo = v.cd_Modelo
group by c.cd_cor, m.nm_modelo;

-- exemplo de substr
select nm_func, substr(nm_func, 2)
	from loc_funcionario;
    
select nm_func, substr(nm_func, 10)
	from loc_funcionario;
    
select nm_func, substr(nm_func, 5, 3)
	from loc_funcionario;
    
-- exemplo instr

select nm_func, instr(nm_func, 'a')
	from loc_funcionario;
    
select nm_func, substr(nm_func, instr(nm_func, 'a')+1)
	from loc_funcionario; -- o +1 é pra não aparecer o A
    
-- exemplo length
select nm_func,
		substr(nm_func, instr(nm_func, 'a')+1),
		length(substr(nm_func, instr(nm_func, 'a')+1))
	from loc_funcionario;

-- like(ari) irá procurar nomes com ari
-- like(%ari) ele ignorará todos os caracteres que vem antes do ari
-- like(% %) ele irá ignorar o que vem antes e o que vem depois desde que tenha espaços
-- ike(ari%) ele ignorará o que vem depois do ari


