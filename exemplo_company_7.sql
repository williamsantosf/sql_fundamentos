-- LIKE E BETWEEN

use company;
select * from employee;

select Fname, Lname from employee where Address like '%Houston-TX%';

use consumo_viagem;
 select * from viagens;
 desc viagens;
 
 select placa, motorista, destino, distancia from viagens where (distancia between 500 and 600) order by destino;
 
 ALTER TABLE viagens CHANGE disntancia distancia int;