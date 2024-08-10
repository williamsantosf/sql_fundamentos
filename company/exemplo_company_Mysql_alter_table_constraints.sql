-- drop database company;
create schema if not exists company;
use company;

create table employee(
	Fname varchar (15) NOT NULL,
    Minit char,
    Lname varchar(15) NOT NULL,
    Ssn char (9) NOT NULL,
    Bdate DATE,
    Adress varchar (30),
    Sex char,
    Salary decimal (10,2),
    Super_ssn char(9),
    Dno int NOT NULL,
    constraint chk_salary_employee check (Salary > 2000.00),    
    constraint pk_emplyee primary key (Ssn)
);

create table departament (
    Dname varchar (15) NOT NULL,    
    Dnumber int NOT NULL,
    Mgr_ssn char (9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept Unique (Dname),
    foreign key (Mgr_ssn) references employee (Ssn)
);

create table dept_locations (
    Dnumber int not NULL,
    Dlocation varchar (15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament (Dnumber) 
);                                                         								

create table project (
    Pname varchar (15) NOT NULL,
    Pnumber int NOT NULL,
    Plocation varchar (15),
    Dnumber int NOT NULL,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project_dnum foreign key (Dnumber) references departament(Dnumber)
);

create table works_on(
    Essn char (9) NOT NULL,
    Pno int NOT NULL,
    Hours decimal (3,1),
    primary key (Essn, Pno),                              
    constraint fk_employee_works_on foreign key (Essn) references employee (Ssn),         
    constraint fk_project_works_on foreign key (Pno) references project (Pnumber)
);

create table dependent (
    Essn char (9) NOT NULL,
    Dependent_name varchar (15) NOT NULL,
    Sex char,
    Bdate date,
    Relationship varchar (8),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
);

alter table employee                                    -- incluindo uma constraint na tabela emplyee
    add constraint fk_employee
    foreign key (Super_ssn) references employee (Ssn)
    on delete set null
    on update cascade;                                  -- atualização em todas as tabelas filhas


-- DROPANDO UMA CONSTRAINT
-- Primeiro dropamos a constraint e depois adicionamos com as alterações
alter TABLE  departament drop constraint departament_ibfk_1;
alter table departament
    add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn)
    on update cascade;


alter table dept_locations drop constraint fk_dept_locations;
alter table dept_locations
    add constraint fk_dept_locations foreign key (Dnumber) references departament (Dnumber)
    on delete cascade
    on update cascade;

show tables;

SELECT * from information_schema.table_constraints 
	where constraint_schema = 'company';   

