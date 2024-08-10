-- SUBMETENDO QUERIES SQL COM EXPRESSOES AO BANCO DE DADOS

select Fname, Lname from employee, departament where Dname = 'Research' and Dnumber=dno;
select concat(Fname,Lname) as Complete_Name from employee, departament where Dname = 'Research' and Dnumber=dno;

--
--
-- Expressoes Alias
--
--

select Fname, Lname, Salary, Salary*0.011 from employee;
select Fname, Lname, Salary, Salary*0.11 as INSS from employee;

