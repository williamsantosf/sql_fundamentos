create database transporte;

use transporte;

CREATE TABLE viagem (
    id_viagem	INT primary key,
    placa CHAR(8),
    data_viagem date,
    motorista VARCHAR(50),
    destino	VARCHAR(50),
    peso float,
    distancia_bordo	INT,
    consumo_bordo	float,
    media_bordo	float,
    distancia_real	INT,
    consumo_real float,
    media_fogo	float,
    media_sem_fogo	float
);
desc viagem;

ALTER TABLE viagem
MODIFY COLUMN id_viagem INT NOT NULL;