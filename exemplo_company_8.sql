-- case statement
use company;
show tables;

UPDATE EMPLOYEE
SET Salary =
	CASE WHEN Dno = 5 THEN Salary + 2000
	WHEN Dno = 4 THEN Salary + 1500
	WHEN Dno = 1 THEN Salary + 3000
	ELSE (Salary + 0) 
	END;
    
--
-- join statement
--
--

select e.Fname, e.Lname, d.Dname 
	from employee e join departament d;
select Fname, Lname, Address 
	from (employee e join departament d on Dno=Dnumber);

select Fname, Lname, Address 
	from 
		(employee e join departament d on Dno=Dnumber) 
	where Dname = 'Research';

SELECT Fname, Lname, Address
	FROM (
    EMPLOYEE NATURAL JOIN
	(departament AS dept))
WHERE Dname = 'Research';

--
--
-- inner join
--
--
show tables;
desc departament;
desc dept_locations;

select Fname, Lname, Dname 
	from employee
		join departament
        on Dnumber = Dno;


-- utilizando using para o atributo de junção
select * from departament
		join dept_locations
        using(Dnumber);
        
SELECT *
FROM employee INNER JOIN dependent
ON SSN = Essn;

SELECT Fname, Lname, count(*)
FROM employee INNER JOIN dependent
ON SSN = Essn
group by SSN;

select Sex, count(*) from dependent group by Sex;

--
--
-- Junção de três ou mais tabelas
--
--

desc project;
desc departament;

SELECT *
FROM departament 
	INNER JOIN project
	ON Dnumber = Dnum;

SELECT *
FROM departament 
	INNER JOIN project
	ON Dnumber = Dnum
	INNER JOIN employee
    ON Mgr_ssn = Ssn;

--
-- com employee
--
desc employee;
SELECT *
FROM departament 
	INNER JOIN project
	ON Dnumber = Dnum
	INNER JOIN employee
    ON Dno = Dnumber;
    

--
-- com works_on
--
SELECT *
FROM departament 
	INNER JOIN project
	ON Dnumber = Dnum
	INNER JOIN employee
    ON Dno = Dnumber;


desc works_on;
SELECT *
FROM works_on 
	INNER JOIN project
	ON Pno = Pnumber
	INNER JOIN employee
    ON Essn = Ssn;
    
    
SELECT sum(hours),Pname
FROM works_on
	INNER JOIN project p
	ON Pno = Pnumber
	INNER JOIN employee e
    ON Essn = Ssn
group by Pname;


--
--
-- Join em subqueries
--
--

desc departament;
show tables;

SELECT a.Fname, a.Lname, a.Salary
	FROM employee a INNER JOIN
		(SELECT Dname, Dnumber, Mgr_ssn
		FROM departament
		WHERE Mgr_start_date < '1980-01-01' AND Mgr_start_date > '1960-01-01') e
		ON a.Ssn = e.Mgr_ssn
	INNER JOIN
		(SELECT *
		FROM project
		WHERE Plocation like '%Houston%') b
		ON e.Dnumber = b.Dnum;


-- gerentes que começaram a atuar a partir de 1980 dentro de Houston
SELECT a.Fname, a.Lname, a.Salary
	FROM employee a INNER JOIN
		(SELECT Dname, Dnumber, Mgr_ssn
		FROM departament
		WHERE Mgr_start_date > '1980-01-01') e
		ON a.Ssn = e.Mgr_ssn
	INNER JOIN
		(SELECT *
		FROM project
		WHERE Plocation like '%Houston%') b
		ON e.Dnumber = b.Dnum;

--
-- Tabela sendo utilizada mais de uma vez na query
--


--
-- Outer JOIN
--


SELECT E.Lname AS Employee_name,
S.Lname AS Supervisor_name
FROM (EMPLOYEE AS E LEFT OUTER JOIN EMPLOYEE AS S
ON E.Super_ssn = S.Ssn);

-- left outer join = left join
-- MYSQL não permite o uso do full outer join

SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM ((PROJECT OUTER JOIN DEPARTMENT ON Dnum = Dnumber)
JOIN EMPLOYEE ON Mgr_ssn = Ssn)
WHERE Plocation = ‘Stafford’;

SELECT E.Lname, S.Lname
FROM EMPLOYEE E, EMPLOYEE S
WHERE E.Super_ssn >= S.Ssn;

use company;

-- JOIN Statement
desc employee;
desc works_on;

select * from employee, works_on where Ssn = Essn;

-- JOIN
select * from employee JOIN works_on;

-- JOIN ON -> INNER JOIN ON

show tables;
desc departament; -- Dnumber

select * from employee JOIN works_on on Ssn = Essn;
select * from employee JOIN departament on Ssn = Mgr_ssn;

select Fname, Lname, Address
	from (employee join departament on Dno=Dnumber)
    where Dname = 'Research';

select * from dept_locations;  -- address e Dnumber
select * from departament;     -- Dname, Dept_create_date

select Dname as Department, Dept_create_date as StartDate, Dlocation as Location
	from departament INNER JOIN dept_locations using(Dnumber)
    order by StartDate; 

-- CROSS JOIN - produto cartesiano
select * from employee cross join dependent;

--
--
-- JOIN com mais de 3 tabelas
--
--
desc employee;
-- project, works_on e employee
select concat(Fname,' ', Lname) as Complete_name, Dno as DeptNumber, Pname as ProjectName, 
		Pno as ProjectNumber, Plocation as Location from employee
	inner join works_on on Ssn = Essn
    inner join project on Pno = Pnumber
    where Pname like 'Product%'
	order by Pnumber;

-- departament, dept_location, employee

select Dnumber, Dname, concat(Fname,' ',Lname) as Manager, Salary, round(Salary*0.05,2) as Bonus from departament
		inner join dept_locations using(Dnumber)
        inner join employee on Ssn = Mgr_ssn
        group by Dnumber;


select Dnumber, Dname, concat(Fname,' ',Lname) as Manager, Salary, round(Salary*0.05,2) as Bonus from departament
		inner join dept_locations using(Dnumber)
        inner join employee on Ssn = Mgr_ssn
        group by Dnumber
        having count(*)>1;
        
select Dnumber, Dname, concat(Fname,' ',Lname) as Manager, Salary, round(Salary*0.05,2) as Bonus from departament
		inner join dept_locations using(Dnumber)
        inner join (dependent inner join employee on Ssn = Essn) on Ssn = Mgr_ssn
        group by Dnumber;

--
--
-- OUTER JOIN
--
--

select * from employee;
select * from dependent;

select * from employee inner join dependent on Ssn = Essn;
select * from employee left join dependent on Ssn = Essn;

select * from employee left outer join dependent on Ssn = Essn;

select e.Lname as Employee, s.Lname as Manager 
	from (employee as e left outer join employee as s on e.Ssn = s.Super_ssn);


-- case statement

show databases;
use company_constraints;


show tables;

select Fname, Salary, Dno from employee;

-- desabilitar o safe mode
update employee set Salary =
		case 
			when Dno=5 then Salary+ 2000
            when Dno=4 then Salary+ 1500
            when Dno=1 then Salary+ 3000
            else Salary + 0
        end;