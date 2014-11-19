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

ALTER TABLE clientes MODIFY dpi varchar(100);
ALTER TABLE clientes ADD UNIQUE (dpi);
alter table clientes add nit varchar(100) not null unique;
alter table clientes add dpi varchar(100) not null unique;
alter table clientes add email varchar(100) not null unique;
alter table clientes drop dpi;

create table cuentas(
idCuenta int auto_increment,
numeroDeCuenta int,
idCliente int,
fechaApertura date,
saldo real,

PRIMARY KEY (idCuenta),
FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

alter table cuentas add bin int;

create table bin(
binId int,
bin double,
descripcion char(100),

PRIMARY KEY (binId)
);

truncate table cuentas;
drop table bin;
alter table bin add correlativo int;
select * from bin;
update cc6.bin set correlativo = 2 where bin = 4236980000000000;
update cc6.bin set saldo = 130 where bin.numeroDeCuentas = 4236980000000003;
select * from cuentas;
select * from clientes;
ALTER TABLE cuentas MODIFY bin bigint;
ALTER TABLE cuentas add unique (numeroDeCuenta);
select correlativo+1 from bin where binid = 412587;
describe cuentas;

create table tipoTransacciones(
tipoTransaccion char,
descripcion varchar(100),

PRIMARY KEY (tipoTransaccion)
);

select * from tipoTransacciones;
select * from transacciones;
select * from transacciones where numeroDeCuenta = 4236980000000003;
insert into cc6.transacciones (numeroDeCuenta, idCliente, tipoTransaccion, concepto, fechaTransaccion, monto) values ('4236980000000003', '10', 'D', 'DEPOSITO EN EFECTIVO POR Q100', now(), '100');
select saldo from cuentas where cuentas.numeroDeCuenta = 4236980000000003;
truncate transacciones;
select * from cuentas;
alter table transacciones add hora time;

create table transacciones(
autorizacion int auto_increment,
numeroDeCuenta bigint,
idCliente int,
tipoTransaccion char,
concepto varchar(100),
fechaTransaccion date,
monto float,

PRIMARY KEY (autorizacion),
FOREIGN KEY (tipoTransaccion) REFERENCES tipoTransacciones(tipoTransaccion),
FOREIGN KEY (idCliente) REFERENCES clientes(idCliente),
FOREIGN KEY (numeroDeCuenta) REFERENCES cuentas(numeroDeCuenta)
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

truncate table departamentos;
drop table municipios;
drop table clientes;

ALTER TABLE tipoUsuario ADD UNIQUE (descripcion);

select usuarios.idUsuario, usuarios.contrasenia, tipoUsuario.leer, tipoUsuario.crear, tipoUsuario.modificar, tipoUsuario.eliminar from usuarios, tipoUsuario where idUsuario = 'milaronix' AND usuarios.tipoUsuario = tipoUsuario.idTipoUsuario;

select * from departamentos;
select * from municipios;
select * from clientes;
select * from usuarios;
select * from tipousuario;

INSERT INTO `cc6`.`clientes` (nombreCliente, `dpi`, `fechaNacimiento`, `genero`, `nomenclaturaDireccion`, `zona`, `departamento`, `municipio`, `telefono1`) VALUES ('MILTON AARON GODINEZ RIVAS', '2080205510101', '1991/11/06', 'M', '38 CALLE A 4-43', '8', '1', '1', '58251533');

select usuarios.idUsuario, usuarios.contrasenia, tipoUsuario.leer, tipoUsuario.crear, tipoUsuario.modificar, tipoUsuario.eliminar from usuarios, tipoUsuario where idUsuario = 'milaronix' AND usuarios.tipoUsuario = tipoUsuario.idTipoUsuario;


select * from departamentos;
ALTER TABLE `departamentos` AUTO_INCREMENT = 2;

INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('GUATEMALA');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('ALTA VERAPAZ');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('BAJA VERAPAZ');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('CHIMALTENANGO');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('CHIQUIMULA');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('EL PROGRESO');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('EL QUICHE');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('ESCUINTLA');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('HUEHUETENANGO');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('IZABAL');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('JALAPA');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('JUTIAPA');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('PETEN');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('QUETZALTENANGO');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('RETALHULEU');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('SACATEPEQUEZ');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('SAN MARCOS');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('SANTA ROSA');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('SOLOLA');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('SUCHITEPEQUEZ');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('TOTONICAPAN');
INSERT INTO `cc6`.`departamentos` (`descripcion`) VALUES ('ZACAPA');

select * from municipios;
ALTER TABLE `departamentos` AUTO_INCREMENT = 2;

INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('GUATEMALA', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CATARINA PINULA', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JOSE PINULA', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JOSE DEL GOLFO', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PALENCIA', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHINAUTLA', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PEDRO AYAMPUC', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MIXCO', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PEDRO SACATEPEQUEZ', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN SACATEPEQUEZ', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN RAYMUNDO', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHUARRANCHO', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('FRAIJANES', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('AMATITLAN', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('VILLA NUEVA', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('VILLA CANALES', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MIGUEL PETAPA ', '1');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('COBAN', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CRUZ VERAPAZ', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN CRISTOBAL VERAPAZ', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TACTIC', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TAMAHU', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MIGUEL TUCURU', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PANZOS', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SENAHU', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PEDRO CARCHA', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANJUAN CHAMELCO', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('LANQUIN', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA MARIA CAHABON', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHISEC', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHAHAL', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('FRAY BARTOLOME DE LAS CASAS', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CATARINA LA TINTA ', '2');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SALAMA', '3');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MIGUEL CHICAJ', '3');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('RABINAL', '3');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CUBULCO', '3');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('GRANADOS', '3');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CRUZ EL CHOL', '3');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JERONIMO', '3');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PURULHA ', '3');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHIMALTENANGO', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JOSE POAQUIL', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MARTIN JILOTEPEQUE', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN COMALAPA', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA APOLONIA', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TECPAN GUATEMALA', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PATZUN', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MIGUEL POCHUTA', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PATZICIA', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CRUZ BALANYA', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ACATENANGO', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PEDRO YEPOCAPA', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANDRES ITZAPA', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PARRAMOS', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ZARAGOZA', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('EL TEJAR ', '4');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHIQUIMULA', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JOSE LA ARADA', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN HERMITA', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('JOCOTAN', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CAMOTAN', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('OLOPA', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ESQUIPULAS', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CONCEPCION LAS MINAS', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('QUEZALTEPEQUE', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JACINTO', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('IPALA', '5');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('GUASTATOYA', '6');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MORAZAN', '6');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN AGUSTIN ACASAGUASTLAN', '6');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN CRISTOBAL ACASAGUASTLAN', '6');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('EL JICARO', '6');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANSARE', '6');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANARATE', '6');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANTONIO LA PAZ ', '6');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CRUZ DEL QUICHE', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHICHE', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHINIQUE', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ZACUALPA', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHAJUL', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTO TOMAS CHICHICSTENANGO', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PATZITE', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANTONIO ILOTENANGO', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PEDRO JOCOPILAS', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CUNEN', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN COTZAL', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('JOYABAJ', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA MARIA NEBAJ', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANDRES SAJCABAJA', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MIGUEL USPATAN SACAPULAS', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN BARTOLOME JOCOTENANGO', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CANILLA', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHICAMAN', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PLAYA GRNADE - IXCAN', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PACHALUM ', '7');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ESCUINTLA', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA LUCIA COTZUMALGUAPA', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('LA DEMOCRACIA', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SIQUINALA', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MASAGUA', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PUEBLO NUEVO TIQUISATE', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('LA GOMERA', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('GUANAGAZAPA', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PUERTO DE SAN JOSE', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('IZTAPA', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PALIN', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN VICENTE PACAYA NUEVA CONCEPCION ', '8');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('HUEHUETENANGO', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHIANTLA', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MALACATANCITO', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CUILCO', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('NENTON', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PEDRO NECT', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('A JACALTENANGO', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PEDRO SOLOMA', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ILDELFONSO IXTAHUAC´N', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA BARBARA', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('LA LIBERTAD', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('LA DEMOCRACIA', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MIGUEL ACATAN', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN RAFAEL LA INDEPENDENCIA', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TODOS SANTOS CHUCHCUMATAN', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN ATITAN', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA EULALIA', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MATEO IXTATAN', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('COLOTENANGO', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN SEBASTIAN HUEHUETENANGO', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TECTITAN', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CONCEPCION HUISTA', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN IXCOY', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANTONIO HUISTA', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN SEBASTIAN COATAN', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CRUZ BARILLAS', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('AGUACATAN', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN RAFAEL PETZAL', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN GASPAR IXCHIL', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTIAGO CHIMALTENANGO', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA ANA HUISTA ', '9');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PUERTO BARRIOS', '10');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('LIVINGSTON', '10');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('EL ESTOR', '10');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MORALES', '10');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('LOS AMATES', '10');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('JALAPA', '11');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PEDRO PINULA', '11');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN LUIS JILOTEPEQUE', '11');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MANUEL CHAPARRON', '11');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN CARLOS ALZATATE', '11');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MONJAS', '11');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MATAQUESCUINTLA ', '11');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('JUTIAPA', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('EL PROGRESO', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CATARINA MITA', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('AGUA BLANCA', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ASUNCION MITA', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('YUPILTEPEQUE', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ATESCATEMPA', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('JEREZ', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('EL ADELANTO', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ZAPOTITLAN', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('COMAPA', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('JALPATAGUA', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CONGUACO', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MOYUTA', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PASACO', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JOSE ACATEMPA', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('QUEZADA ', '12');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('FLORES', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JOSE', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN BENITO', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANDRES', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('LA LIBERTAD', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN FRANCISCO', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA ANA', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('DOLORES', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN LUIS', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAYAXCHE', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MELCHOR DE MENCOS', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('POPTUN ', '13');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('QUETZALTENANGO', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SALCAJA', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('OLINTEPEQUE', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN CARLOS SIJA', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SIBILIA', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CABRICAN', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CAJOLA', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MIGUEL SIGUILÇA', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN OSTUNCALCO', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MATEO', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CONCEPCION CHIQUIRICHAPA', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MARTIN SACATEPEQUEZ', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ALMOLONGA', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CANTEL', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('HUITAN', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ZUNIL', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('COLOMBA', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN FRANCISCO LA UNION', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('EL PALMAR', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('COATEPEQUE', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('GENOVA', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('FLORES COSTA CUCA LA ESPERANZA', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PALESTINA DE LOS ALTOS ', '14');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('RETALHULEU', '15');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN SEBASTIAN', '15');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CRUZ MULUA', '15');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MARTIN ZAPOTITLAN', '15');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN FELIPE RETALHULEU', '15');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANDRES VILLA SECA', '15');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHAMPERICO', '15');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('NUEVO SAN CARLOS', '15');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('EL ASINTAL ', '15');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ANTIGUA GUATEMALA', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('JOCOTENANGO', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PASTORES', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SUMPANGO', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTO DOMINGO XENACOJ', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTIAGO SACATEPEQUEZ', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN BARTOLOME MILPAS ALTAS', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN LUCAS SACATEPEQUEZ', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA LUCIA MILPAS ALTAS', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MAGDALENA MILPAS ALTAS', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA MARIA DE JESUS', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CIUDAD VIEJA', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MIGUEL DUEÑAS', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN ALOTENANGO', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANTONIO AGUAS CALIENTES', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CATARINA BARAHONA ', '16');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MARCOS', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PEDRO SACATEPEQUEZ', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('COMITANCILLO', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANTONIO SACATEPEQUEZ', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MIGUEL IXTAHUACAN', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CONCEPCION TUTUAPA', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TACANA', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SIBINAL', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TAJUMULCO', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TEJUTLA', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN RAFAEL PIE DE LA CUESTA', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('NUEVO PROGRESO', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('EL TUMBADOR', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JOSE EL RODEO', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MALACATAN', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CATARINA', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('AYUTLA', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('OCOS', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PABLO', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('EL QUETZAL', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('LA REFORMA', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PAJAPITA', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('IXCHIGUAN', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JOSE OJETENAN', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN CRISTOBAL CUCHO', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SIPACAPA', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ESQUIPULAS PALO GORDO', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('RIO BLANCO', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN LORENZO ', '17');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CUILAPA', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('BERBERENA', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ROSA DE LIMA', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CASILLAS', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN RAFAEL LAS FLORES', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ORATORIO', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN TECUACO', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHIQUIMULILLA', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TAXISCO', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA MARIA IXHUATAN', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('GUAZACAPAN', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CRUZ NARANJO', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PUEBLO NUEVO VIÑAS', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('NUEVA SANTA ROSA ', '18');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SOLOLA', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JOSE CHACAYA', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA MARIA VISITACION', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA LUCIA UTATLAN', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('NAHUALA', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CATARINA IXTAHUACAN', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CLARA LA LAGUNA', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CONCEPCION', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANDRES SEMETABAJ', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PANAJACHEL', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CATARINA PALOPO', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANTONIO PALOPO', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN LUCAS TOLIMAN', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA CRUZ LA LAGUNA', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SNA PABLO LA LAGUNA', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MARCOS LA LAGUNA', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN LA LAGUNA', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PEDRO LA LAGUNA', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTIAGO ATITLAN ', '19');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MAZATENANGO', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CUYOTENANGO', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN FRANCISCO ZAPOTITLAN', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN BERNARDINO', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JOSE EL IDOLO', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTO DOMINGO SUCHITEPEQUEZ', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN LORENZO', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAMAYAC', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN PABLO JOCOPILAS', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANTONIO SUCHITEPEQUEZ', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN MIGUEL PANAN', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN GABRIEL', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CHICACAO', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PATULUL', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA BARBARA', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN JUAN BAUTISTA', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTO TOMAS LA UNION', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ZUNILITO', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('PUEBLO NUEVO SUCHITEPEQUEZ', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('RIO BRAVO ', '20');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TOTONICAPAN', '21');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN CRISTOBAL TOTONICAPAN', '21');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN FRANCISCO EL ALTO', '21');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN ANDRES XECUL', '21');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('MOMOSTENANGO', '21');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA MARIA CHIQUIMULA', '21');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SANTA LUCIA LA REFORMA', '21');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN BARTOLO AGUAS CALIENTES ', '21');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ZACAPA', '22');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('ESTANZUELA', '22');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('RIO HONDO', '22');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('GUALAN', '22');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('TECULUTAN', '22');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('USUMATLAN', '22');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('CABAÑAS', '22');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('SAN DIEGO', '22');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('LA UNION', '22');
INSERT INTO `cc6`.`municipios` (`descripcion`, `idDepartamento`) VALUES ('HUITE', '22');

select * from cuentas;
select * from clientes where nombreCliente like'%juan%' or nit = '68253400' or dpi = '2080205510101';
select clientes.*, departamentos.descripcion, municipios.descripcion from clientes, departamentos, municipios where idCliente = 1 and clientes.departamento = departamentos.idDepartamento and clientes.municipio = municipios.idMunicipio;

select curdate();