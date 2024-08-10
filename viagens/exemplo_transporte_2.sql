-- ORDER BY
use transporte;
show tables;
desc viagem;
select id_viagem as VIAGEM, data_viagem as DATA_DA_VIAGEM, placa, motorista, destino, distancia_real from viagem
order by motorista, destino, distancia_real DESC;

-- AGRUPAMENTO (GROUP BY, COUNT, SUM, MIN, MAX, AVARAGE)
SELECT count(*) FROM viagem; -- TODAS AS VIAGENS

SELECT destino, count(*)
FROM viagem
WHERE DESTINO LIKE '%ARAPONGAS%'
group by destino; -- TODAS AS VIAGENS PARA ARAPONGAS

SELECT destino, count(*)
FROM viagem
group by destino; -- TODAS AS VIAGENS AGRUPADAS POR DESTINO

SELECT destino, count(distinct destino) AS Ocorrencia
FROM viagem
group by destino; -- QUANTOS DESTINOS DIFERENTES EXISTEM

select destino, sum(distancia_real)
from viagem
group by destino;  -- SOMA DAS DISTANCIA PARA CADA DESTINO

select destino, ROUND(avg(distancia_real),0) as Media_destino
from viagem
group by destino; -- DISTANCIA MEDIA PARA CADA DESTINO

select destino, count(*), max(distancia_bordo) as Distancia_maxima
from viagem
group by destino
order by destino; -- CONTANDO DESTINOS E A DISTÂNCIA MÁXIMA PARA CADA UM

-- HAVING (criando uma condição)
select motorista, destino, distancia_real
from viagem
having (distancia_real between 400 and 500) and destino like '%SC%'
order by distancia_real desc; -- TODAS AS VIAGENS "TENDO" DISTANCIA ENTRE 400 E 500 PARA SC.

-- VIEWS
use transporte;

show tables;

create or replace view qtd_viagens_por_motorista as
	select motorista, count(*) as Viagens from viagem
		group by motorista;

create or replace view qtd_viagens_por_destino as
	select destino, count(*) as Viagens from viagem
		group by destino;

create or replace view qtd_km_rodado_por_motorista as
	select motorista, sum(distancia_real) as 'Km Rodado' from viagem
	group by motorista;

select destino, max(media_fogo) as maior_media, min(media_fogo) as menor_media from viagem
	group by destino;

create or replace view media_maxima_por_motorista as
select distinct destino, motorista, max(media_fogo) as maior_media from viagem
	group by destino, motorista;
	
create or replace view media_minima_por_motorista as
select distinct destino, motorista, min(media_fogo) as menor_media from viagem
	group by destino, motorista;
    
select destino, motorista, max(media_fogo), min(media_fogo) from viagem
group by destino, motorista;

select destino, max(media_fogo), motorista from viagem
	group by destino, motorista;


-- trazendo a maior média poestino com o motorista
SELECT destino, motorista, media_fogo -- seleção dos campos da pesquisa
FROM viagem v1 -- chamamos de v1 a tabela resultante dessa pesquisa
WHERE media_fogo = ( -- criamos uma condição com uma subquery
    SELECT MAX(media_fogo) -- a maior média
    FROM viagem v2         -- chamamos de v2 a tabela resultante dessa sub-pesquisa
    WHERE v1.destino = v2.destino -- filtragem: compara os destinos das tabelas v1 e v2, e passa para a consulta externa
);                                -- a maior média.

-- testando a subquery
SELECT MAX(media_fogo), destino
    FROM viagem
    GROUP BY destino;
    
-- execução das views
select * from qtd_viagens_por_motorista;
select * from qtd_viagens_por_destino;
select * from qtd_km_rodado_por_motorista;
select * from media_maxima;
select * from media_minima;