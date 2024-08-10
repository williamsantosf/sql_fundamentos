--CRIANDO AS CONSTRAINTS

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
    primary key (Ssn),
    constraint chk_salary_employee check (Salary > 2000.00),               -- check para determinar uma restrição
    constraint pk_emplyee primary key (Ssn) -- nomeando a chave primária
);

create table departament (
    Dname varchar (15) NOT NULL, --unique poderia estar aqui
    Dnumber int NOT NULL,
    Mgr_ssn char (9),
    Mgr_start_date date,
    primary key (Dnumber),
    Unique (Dname),
    foreign key (Mgr_ssn) references employee (Ssn)
);

create table dept_location (
    Dnumber int not NULL,
    Dlocation varchar (15) not null,
    primary key (Dnumber, Dlocation),
    foreign key (Dnumber) references departament (Dnumber) -- Dnumber é a chave estrangeira que referencia atributo
);                                                         -- de mesmo nome na tabela departament

create table project (
    Pname varchar (15) NOT NULL,
    Pnumber int NOT NULL,
    Plocation varchar (15),
    Dnum int NOT NULL,
    primary key (Pnumber),
    unique (Pname),
    foreign key (Dnumber) references departament(Dnumber)
);

create table works_on(
    Essn char (9) NOT NULL,
    Pno int NOT NULL,
    Hours decimal (3,1),
    primary key (Essn, Pno),                              -- Chave primária composta pois está a associada a duas tabelas
    foreign key (Essn) references employee (Ssn),         -- Duas chaves estrangerias também pelas associações
    foreign key (Pno) references project (Pnumber)
);

create table dependets (
    Essn char (9) NOT NULL,
    Dependent_name varchar (15) NOT NULL,
    Sex char,
    Bdate date,
    Relationship varchar (8),
    primary key (Essn, Dependent_name),
    foreign key (Essn) references employee (Ssn)
);

SELECT * from information_schema.table_constraints 
	where constraint_schema = 'company';                 -- Verifcando todas as constraints do banco company


SELECT * from information_schema.referential_constraints 
	where constraint_schema = 'company';                 -- Verificando todas as constraints referenciais