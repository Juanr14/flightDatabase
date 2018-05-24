CREATE VIEW cliente_usu_vu
(documento, correo, usuario, contraseña)
AS SELECT c.no_documento, c.email, u.nombre_usuario, u.password
FROM cliente c, usuario u
WHERE c.id_usuario = u.id_usuario;

CREATE VIEW tiquete_pago_vu
AS SELECT t.numero, m.nombre medio_de_pago 
FROM tiquete t, pago p, medio_pago m
WHERE t.pago = p.id_pago AND p.medio = m.id_medio;

CREATE VIEW ruta_ciudad_vu1
AS SELECT r.numero, c.nombre origen, d.nombre destino
FROM ruta_aerolinea r, ciudad c, ciudad d
WHERE r.origen = c.id_ciudad and r.destino = d.id_ciudad and r.aerolinea = 1;

CREATE VIEW asientovu1
AS SELECT id_asiento id, id_avion avion, numero
FROM asiento
WHERE clase = 1;

CREATE VIEW pagovumarzo
AS SELECT id_pago No_pago, monto,fecha, medio
FROM pago
WHERE fecha BETWEEN '01/03/2018' AND '31/03/2018';