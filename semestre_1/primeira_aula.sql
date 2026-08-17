use mydb;

describe aluno;

Select * 
  from aluno;
  
Insert into armario 
  (CdArmario, NmArmario)
Values 
  (10,'X1Y2');  
  
Select *
  from armario;
  
 Insert into armario 
  (CdArmario, NmArmario)
Values 
  (11,'X2Y2'); 
  
Insert into armario 
  (CdArmario, NmArmario)
Values 
  (11,'X1Y2');
-- Não insere, pois já existe

/* esse comentário
   é longão
   e bobão */
   
Insert into armario 
Values 
  (12,'X2Y2');   
  
Insert into armario
Values ('X15Y15',15);
-- erro o 1o campo não é inteiro
Insert into armario
  (NmArmario, CdArmario)
Values 
  ('X15Y15',15);

-- Alunos

Select *
  from armario;

Select *
	from aluno;

Insert into aluno
Values
	(1,'Ana Raquel',10);

Insert into aluno
	(cdAluno, cdArmario, nmAluno)
Values
	(2,11,'Beatriz');
    
Insert into aluno
Values
	(3,'Beatriz',12);
    
Insert into aluno
Values
	(2,'Carolina',13);
    
-- Não funciona pois não foi criado armário 13

Insert into aluno
Values
	(4,'Carolina',15);

update aluno
	set nmAluno = 'Bruno'
    where cdAluno = 3;

Insert into aluno
Values
	(5,'Décil',15);
    
Insert into armario
Values
	(16, 'X5Y8');
    
Insert into aluno
Values
	(100,'Excluído',16);
    
select *
	from aluno;
    
delete from aluno
	where cdAluno = 100;
    
Insert into aluno
Values
	(100,'Excluído',16);
    
delete from armario
	where cdArmario = 16;
-- Nâo pode remover só o armário caso haja alguém ocupando, pois aluno é dependente de armário