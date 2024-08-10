-- VIEWS

show databases;
show tables from company_constraints;
use company_constraints;

create view employees_salary_27000_view as 
	select concat(Fname,Minit,Lname) as Name, Salary, Dno as Dept_number from employee
	where Salary > 26999;

select * from employees_salary_27000_view;

select * from employee;

create view employees_salary_view as 
	select concat(Fname,Minit,Lname) as Name, Salary, Dno as Dept_number from employee
	where Sex ='M';
    
select * from dependent;

drop view employees_salary_view;
create or replace view employees_dependent_view as 
	select concat(Fname,Minit,Lname) as Name, e.Dno as Departament, d.Dependent_name as Dependent
    from employee e
    inner join dependent d on e.Ssn = d.Essn;

select * from employees_dependent_view;

-- VIEW SAKILA

use sakila;

CREATE VIEW film_stats -- criação da view
as
select f.film_id, f.title, f.description, f.rating, -- selecionando colunas 
(select c.name from category c -- subquery: coluna category_name que é um JOIN das tabelas category e film_category
			inner join film_category fc
			on c.category_id = fc.category_id -- critério (FK) que une as tabelas.
	where fc.film_id = f.film_id) category_name, -- nome da coluna
(select count(*) from film_actor fa -- subquery: coluna com a contagem do numero de atores
	where fa.film_id = f.film_id) num_actors,
(select count(*) from inventory i -- subquery: coluna com a contagem de filmes 
	where i.film_id = f.film_id)inventory_cnt,
(select count (*) from inventory i
			inner join rental r on i.inventory_id = r.inventory_id -- o que une as tabelas
			where i.film_id = f.film_id) num_rentals -- condição d efiltragem
from film f;

-- lembrando sempre que a tabela film f, está externa. As subqueries podem referenciar 
-- colunas da consulta externa.

