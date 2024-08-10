-- RECUPERANDO DADOS
use company;
show tables;
desc departament; -- DNumber em departamento
desc dept_locations; -- Dnumber em dept_Locations

select * from departament;
select * from dept_locations;

-- Retirando ambiguidade através de Alias ou AS Statement
select * from departament, dept_locations where Dnumber = Dnumber;  -- gera erro

select Dname, Dlocation as Department_name
	from departament as d, dept_locations as l
    where d.Dnumber = l.Dnumber;

select * from employee;
select concat(Fname, ' ', Lname) as Funcionarios from employee;
select * from dependent;





