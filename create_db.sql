-- creacion de tablas

create database if not exists proyecto_coder;

use proyecto_coder;

-- tables
-- Table: provincia
create table if not exists provincia (
    id_prov int not null auto_increment,
    nombre varchar(100) not null,
    primary key (id_prov)
);

-- Table: departamento
 -- drop table departamento;
create table if not exists departamento (
    id_departamento int not null,
    nombre varchar(200) not null,
    id_prov int not null,
    primary key (id_prov, id_departamento),
    constraint fk_id_prov foreign key (id_prov) references provincia(id_prov)
);

-- drop table localidad;
create table if not exists localidad (
    id_localidad int not null,
    nombre varchar(200) not null,
    id_prov int not null,
    id_departamento int not null, 
    primary key (id_prov, id_departamento, id_localidad),
    constraint fk_id_prov_dpto foreign key (id_prov, id_departamento) references departamento(id_prov, id_departamento)
  --  foreign key (id_prov) references departamento(id_prov)
    );
    
create table if not exists tipo_organismo (
  id_tipo int not null auto_increment,
  nombre varchar(60) not null,
  nivel enum('nacional', 'provincial', 'subprovincial') not null,
  primary key (id_tipo)
);

create table if not exists organismo (
  id_organismo int not null auto_increment,
  nombre varchar(200) not null,
  id_tipo int not null,
  primary key (id_organismo),
  constraint fk_id_tipo foreign key (id_tipo) references tipo_organismo(id_tipo)
);
