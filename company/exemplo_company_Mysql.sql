create schema if not exists company_constraints;
use company_constraints;

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
    Dname varchar (15) NOT NULL,    -- unique poderia estar aqui
    Dnumber int NOT NULL,
    Mgr_ssn char (9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept Unique (Dname),
    foreign key (Mgr_ssn) references employee (Ssn)
);

create table dept_location (
    Dnumber int not NULL,
    Dlocation varchar (15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament (Dnumber) -- Dnumber é a chave estrangeira que referencia atributo
);                                                         								-- de mesmo nome na tabela departament

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
    primary key (Essn, Pno),                              -- Chave primária composta pois está a associada a duas tabelas
    constraint fk_employee_works_on foreign key (Essn) references employee (Ssn),         -- Duas chaves estrangerias também pelas associações
    constraint fk_project_works_on foreign key (Pno) references project (Pnumber)
);

create table dependets (
    Essn char (9) NOT NULL,
    Dependent_name varchar (15) NOT NULL,
    Sex char,
    Bdate date,
    Relationship varchar (8),
    Age int NOT NULL,
    constraint chk_age_dependet check (Age < 22),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee (Ssn)
);

show tables;

SELECT * from information_schema.table_constraints 
	where constraint_schema = 'company_constraints';   
















