use cc6;

create table departamentos(
idDepartamento int auto_increment,
descripcion varchar(100) unique,

PRIMARY KEY (idDepartamento)
);

create table municipios(
idMunicipio int auto_increment,
descripcion varchar(100) unique,

PRIMARY KEY (idMunicipio)
);

alter table municipios add idDepartamento int;
alter table municipios add foreign key (idDepartamento) references departamentos(idDepartamento);

create table clientes(
idCliente int auto_increment,
nombreCliente varchar(100),
dpi int(13),
fechaNacimiento date,
genero char(1),
nomenclaturaDireccion varchar(100),
zona int(2),
colonia int,
departamento int,
municipio int,
telefono1 int(8),
telefono2 int(8),

PRIMARY KEY (idCliente),
FOREIGN KEY (departamento) REFERENCES departamentos(idDepartamento),
FOREIGN KEY (municipio) REFERENCES municipios(idMunicipio)
);

create table cuentas(
idCuenta int auto_increment,
numeroDeCuenta int,
idCliente int,
fechaApertura date,
saldo real,

PRIMARY KEY (idCuenta),
FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

create table tipoUsuario(
idTipoUsuario int auto_increment,
descripcion varchar(100),
leer char,
crear char,
modificar char,
eliminar char,

PRIMARY KEY (idTipoUsuario)
);

create table usuarios(
idUsuario varchar(100) unique,
idCliente int,
contrasenia varchar(100),
tipoUsuario int,

PRIMARY KEY (idUsuario),
FOREIGN KEY (tipoUsuario) REFERENCES tipoUsuario(idTipoUsuario)
);

drop table municipios;
drop table clientes;

ALTER TABLE tipoUsuario ADD UNIQUE (descripcion);

select usuarios.idUsuario, usuarios.contrasenia, tipoUsuario.leer, tipoUsuario.crear, tipoUsuario.modificar, tipoUsuario.eliminar from usuarios, tipoUsuario where idUsuario = 'milaronix' AND usuarios.tipoUsuario = tipoUsuario.idTipoUsuario;

select * from departamentos;
select * from municipios;
select * from clientes;
select * from usuarios;
select * from tipousuario;