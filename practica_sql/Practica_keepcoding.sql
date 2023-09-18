--create schema coches_de_empresa;



CREATE TABLE coches_de_empresa.marca (
    id serial PRIMARY KEY,
    Nombre_marca varchar(30) NOT NULL,
    grupo_empresarial varchar(80) NOT NULL
);

CREATE TABLE coches_de_empresa.modelo (
    id serial PRIMARY KEY,
    Nombre_modelo varchar(30) NOT NULL,
    id_marca int NOT NULL
);

CREATE TABLE coches_de_empresa.color (
    id serial PRIMARY KEY,
    Nombre_color varchar(30) NOT NULL
);

CREATE TABLE coches_de_empresa.coche (
    id serial PRIMARY KEY,
    matricula varchar(30) NOT NULL,
    km_totales int NOT NULL,
    Compañia_seguro varchar(80) NOT NULL,
    Numero_poliza int NOT NULL,
    fecha_compra varchar(30) NOT NULL,  
    id_modelo int NOT NULL,
    id_color int NOT NULL,
    marca varchar(50) not null,
    km_revision int,                   
    fecha_revision varchar(30)        
);


CREATE TABLE coches_de_empresa.revision (
    id serial PRIMARY KEY,
    id_coche int NOT NULL,
    km_revision int NOT NULL,
    importe_revision int NOT NULL,
    moneda_revision varchar(30) NOT NULL,  
    fecha_revision varchar(30)             
);


ALTER TABLE coches_de_empresa.modelo
ADD CONSTRAINT fk_id_marca
FOREIGN KEY (id_marca)
REFERENCES coches_de_empresa.marca(id);

ALTER TABLE coches_de_empresa.coche
ADD CONSTRAINT fk_id_modelo
FOREIGN KEY (id_modelo)
REFERENCES coches_de_empresa.modelo(id);

ALTER TABLE coches_de_empresa.coche
ADD CONSTRAINT fk_color
FOREIGN KEY (id_color)
REFERENCES coches_de_empresa.color(id);

ALTER TABLE coches_de_empresa.revision
ADD CONSTRAINT fk_revision
FOREIGN KEY (id_coche)
REFERENCES coches_de_empresa.coche(id);




INSERT INTO coches_de_empresa.color (Nombre_color)
SELECT DISTINCT color
FROM coches_de_empresa.coches;


INSERT INTO coches_de_empresa.marca (Nombre_marca, grupo_empresarial)
SELECT DISTINCT marca, grupo
FROM coches_de_empresa.coches;


INSERT INTO coches_de_empresa.modelo (Nombre_modelo, id_marca)
SELECT DISTINCT modelo, m.id
FROM coches_de_empresa.coches AS c
JOIN coches_de_empresa.marca AS m ON c.marca = m.Nombre_marca;


INSERT INTO coches_de_empresa.coche (matricula, km_totales, Compañia_seguro, Numero_poliza, fecha_compra, id_modelo, id_color, km_revision, fecha_revision, marca)
SELECT matricula, kms_totales, Aseguradora, n_poliza, fecha_compra, mo.id AS id_modelo, co.id AS id_color, Kms_Revision, fecha_revision, c.marca
FROM coches_de_empresa.coches AS c
JOIN coches_de_empresa.marca AS ma ON c.marca = ma.Nombre_marca
JOIN coches_de_empresa.modelo AS mo ON c.modelo = mo.Nombre_modelo
JOIN coches_de_empresa.color AS co ON c.color = co.Nombre_color;


INSERT INTO coches_de_empresa.revision (km_revision, importe_revision, moneda_revision, fecha_revision)
SELECT kms_revision, importe_revision, moneda, fecha_revision
FROM coches_de_empresa.coches ;



INSERT INTO coches_de_empresa.revision (id_coche)
SELECT id
FROM coches_de_empresa.coche;



select * from coches_de_empresa.revision r ;

--DROP TABLE coches_de_empresa.coches;
