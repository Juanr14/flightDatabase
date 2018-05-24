CREATE TABLE USUARIO(
id_usuario Number(5),
nombre_usuario Varchar2(20) NOT NULL,
password Varchar2(20) NOT NULL,
CONSTRAINT usuario_id_usuario_pk PRIMARY KEY(ID_USUARIO));


CREATE TABLE TIPO_DOCUMENTO(
id_tipo Number(1),
nombre Varchar2(21) NOT NULL,
CONSTRAINT tipo_documento_id_tipo_pk PRIMARY KEY(ID_TIPO));


CREATE TABLE MEDIO_PAGO(
id_medio Number(2),
nombre Varchar2(15) NOT NULL,
CONSTRAINT medio_pago_id_medio_pk PRIMARY KEY(ID_MEDIO));


CREATE TABLE CLASE(
id_clase Number(1),
nombre Varchar2(15) NOT NULL,
CONSTRAINT clase_id_clase_pk PRIMARY KEY(ID_CLASE));


CREATE TABLE DISPONIBILIDAD(
id_disponibilidad Number(1),
nombre Varchar2(15) NOT NULL,
CONSTRAINT dispon_id_dispon_pk PRIMARY KEY(ID_DISPONIBILIDAD));

CREATE TABLE TIPO_AVION(
id_tipo Number(3),
codigo Varchar2(3) NOT NULL,
nombre Varchar2(25) NOT NULL,
capacidad Number(3) NOT NULL,
CONSTRAINT tipo_avion_id_pk PRIMARY KEY(ID_TIPO));


CREATE TABLE AEROLINEA(
id_aerolinea Number(2),
nombre Varchar2(20) NOT NULL,
CONSTRAINT aerolinea_id_aerolinea_pk PRIMARY KEY(ID_AEROLINEA));


CREATE TABLE CIUDAD(
id_ciudad Number(3),
nombre Varchar2(15) NOT NULL,
CONSTRAINT ciudad_id_ciudad_pk PRIMARY KEY(ID_CIUDAD));


CREATE TABLE AEROPUERTO(
id_aeropuerto Number(2),
iata Varchar2(3) NOT NULL,
nombre Varchar2(50) NOT NULL,
id_ciudad Number(3) NOT NULL,
CONSTRAINT aeropuerto_id_aeropuerto_pk PRIMARY KEY(ID_AEROPUERTO),
CONSTRAINT aeropuerto_ciudad_fk FOREIGN KEY(id_ciudad)
REFERENCES CIUDAD(id_ciudad));


CREATE TABLE PAGO(
id_pago Number(7),
codigo Varchar2(8) NOT NULL,
monto Number(11,3) NOT NULL,
fecha Date NOT NULL,
medio Number(2) NOT NULL,
CONSTRAINT pago_id_pago_pk PRIMARY KEY(ID_PAGO),
CONSTRAINT pago_medio_fk FOREIGN KEY(medio)
REFERENCES MEDIO_PAGO(id_medio));


CREATE TABLE CLIENTE(
id_cliente Number(7),
no_documento Number(10) NOT NULL,
nombres Varchar2(20) NOT NULL,
apellidos Varchar2(20) NOT NULL,
fecha_nacimiento Date NOT NULL, 
telefono Number(11),
email Varchar2(50) NOT NULL,
tipo_doc Number(1) NOT NULL,
id_usuario Number(5) NOT NULL,
CONSTRAINT cliente_no_documento_pk PRIMARY KEY(ID_CLIENTE),
CONSTRAINT cliente_tipo_doc_fk FOREIGN KEY(tipo_doc)
REFERENCES tipo_documento(id_tipo),
CONSTRAINT cliente_id_usuario_fk FOREIGN KEY(id_usuario)
REFERENCES USUARIO(id_usuario));


CREATE TABLE AVION(
id_avion Number(3),
matricula Varchar(8) NOT NULL,
tipo Number(3) NOT NULL,
CONSTRAINT avion_id_avion_pk PRIMARY KEY(ID_AVION),
CONSTRAINT avion_tipo_fk FOREIGN KEY(tipo)
REFERENCES TIPO_AVION(ID_TIPO));


CREATE TABLE ASIENTO(
id_asiento Number(6),
id_avion Number(3),
numero Number(3) NOT NULL, 
clase Number(1) NOT NULL,
disponibilidad Number(1),
CONSTRAINT asiento_id_asiento_pk PRIMARY KEY(id_asiento),
CONSTRAINT asiento_id_avion_fk FOREIGN KEY(id_avion)
REFERENCES AVION(id_avion),
CONSTRAINT asiento_clase_fk FOREIGN KEY(clase)
REFERENCES CLASE(id_clase),
CONSTRAINT asiento_disponibilidad_fk FOREIGN KEY(disponibilidad)
REFERENCES DISPONIBILIDAD(id_disponibilidad));


CREATE TABLE RUTA_AEROLINEA(
numero Number(5),
tarifa Number(11,3) NOT NULL,
tiempo_vuelo Number(4),
avion Number(3) NOT NULL,
aerolinea Number(2)NOT NULL,
origen Number(3) NOT NULL,
destino Number(3) NOT NULL,
CONSTRAINT ruta_aerolinea_numero_pk PRIMARY KEY(numero),
CONSTRAINT ruta_aerolinea_avion_fk FOREIGN KEY(avion)
REFERENCES AVION(id_avion),
CONSTRAINT ruta_aerolinea_aerolinea_fk FOREIGN KEY(aerolinea)
REFERENCES AEROLINEA(id_aerolinea),
CONSTRAINT ruta_aerolinea_origen_fk FOREIGN KEY(origen)
REFERENCES CIUDAD(id_ciudad),
CONSTRAINT ruta_aerolinea_destino_fk FOREIGN KEY(destino)
REFERENCES CIUDAD(id_ciudad));


CREATE TABLE VUELO(
id_vuelo Number(3),
fecha DATE NOT NULL,
hora TIMESTAMP NOT NULL,
cod_vuelo Varchar2(7) NOT NULL,
ruta Number(5) NOT NULL,
CONSTRAINT vuelo_id_vuelo_pk PRIMARY KEY(id_vuelo),
CONSTRAINT vuelo_ruta_fk FOREIGN KEY(ruta)
REFERENCES RUTA_AEROLINEA(numero));

CREATE TABLE TIQUETE(
id_tiquete Number(7),
numero Number(10) NOT NULL,
puerta Varchar2(3) NOT NULL,
vuelo Number(3) NOT NULL,
cliente Number(10) NOT NULL,
pago Number(8) NOT NULL,
CONSTRAINT tiquete_numero_pk PRIMARY KEY(id_tiquete),
CONSTRAINT tiquete_vuelo_fk FOREIGN KEY(vuelo)
REFERENCES VUELO(id_vuelo),
CONSTRAINT tiquete_cliente_fk FOREIGN KEY(cliente)
REFERENCES CLIENTE(id_cliente),
CONSTRAINT tiquete_pago_fk FOREIGN KEY(pago)
REFERENCES PAGO(id_pago));

CREATE TABLE CLIENTE_VUELO(
id_cliente Number(10),
id_vuelo Number(3),
CONSTRAINT cliente_vuelo_id_pk PRIMARY KEY(id_cliente,id_vuelo),
CONSTRAINT cliente_vuelo_cliente_fk FOREIGN KEY(id_cliente)
REFERENCES CLIENTE(id_cliente),
CONSTRAINT cliente_vuelo_vuelo_fk FOREIGN KEY(id_vuelo)
REFERENCES VUELO(id_vuelo));


