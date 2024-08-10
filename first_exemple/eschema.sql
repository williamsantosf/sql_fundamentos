--CRIAÇÃO DE UM BANCO DE DADOS

create database if not exists first_example; --criando a base caso não exista

CREATE TABLE person (
	person_id smallint unsigned, --smallint para delimitar o número de caracteres
    fname varchar (20),
    lname varchar (20),
    gender enum('M','F'),
    birth_date date,
    street varchar (30),
    city varchar (20),
    state varchar (20),
    country varchar (20),
    postal_code varchar (20),
    constraint pk_person primary key(person_id) --nomeando a chave primária
);

desc person;

--CRIAÇÃO DE TABELA COM CHAVE PRIMÁRIA COMPOSTA

create table favorite_food (
	person_id smallint unsigned,
    food varchar (20),
    constraint pk_favorite_food primary key (person_id, food),
    constraint fk_favorite_food_person_id foreign key (person_id) references person(person_id)
);

-- Nesse caso, criamos uma chave primária composta pelos atributos person_id e food 
-- a chave estrangeira faz referência a chave primária person_id da tabela person.

--CONSULTANDO AS CHAVES DE TODOS OS BANCOS
desc favorite_food;
show databases;
select * from information_schema.table_constraints where constraint_schema = 'first_example';
--NO EXEMPLO information_schema é o banco de dados e .table_constranits é a tabela requerida

--INSERINDO UM REGISTRO
insert into person values ('1', 'Carolina', 'Francisco', 'F', '1996-07-26', 
							'Rua 29', 'Rio de Janeiro','RJ', 'Brazil', '21000-000');


--INSERINDO VÁRIOS REGISTROS
insert into person values ('2', 'William', 'Francisco', 'M', '1987-07-08', 
							'Rua Lindolfo Luiz Boell', 'Araucária', 'PR', 'Brazil', '83708-320'),
                          ('3', 'Jakson', 'Paes', 'M', '1982-04-29', 
							'Rua da Gostosa', 'Colombo', 'PR', 'Brazil', '83000-000');