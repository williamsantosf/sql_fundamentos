-- RECUPERANDO DADOS

-- RECUPERANDO DADOS
use company;
show tables;
desc departament; -- DNumber em departamento
desc dept_locations; -- Dnumber em dept_Locations

select * from departament;
select * from dept_locations;

-- Retirando ambiguidade através de Alias ou AS Statement
select * from departament, dept_locations where Dnumber = Dnumber;  -- gera erro

select Dname, Dlocation as Department_name         -- selecionando Nome do Dpto e Localização como Department_name 
	from departament as d, dept_locations as l     -- apelidando as tabelas com as iniciais
    where d.Dnumber = l.Dnumber;                   -- especificando onde os números der departamento são iguais.


select * from employee;
select concat(Fname, ' ', Lname) as Funcionarios from employee;
-- Buscando o primeiro e o ultimo nosmes, separados por um espaço, e renomeando a coluna que retnornará.


