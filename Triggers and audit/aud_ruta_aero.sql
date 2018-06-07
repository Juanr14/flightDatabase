CREATE TABLE AUD_RUTA_AERO (
	fecha_transaccion VARCHAR2(21),
	usuario VARCHAR2(35),
	descripcion VARCHAR2(100),
	old_v NUMBER(11,3),
	new_v NUMBER(11,3));

CREATE OR REPLACE TRIGGER fila_ruta_aero
AFTER DELETE OR INSERT OR UPDATE OF tarifa ON RUTA_AEROLINEA
FOR EACH ROW

DECLARE
    username VARCHAR2(35);
	fecha VARCHAR2(20);
BEGIN
	SELECT user INTO username FROM dual;
	
	SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS') INTO fecha FROM dual;
	
	IF inserting THEN
		INSERT INTO AUD_RUTA_AERO(fecha_transaccion,usuario,descripcion)
		VALUES(fecha,username,'Se ha insertado la nueva ruta '||:new.numero);
	ELSIF updating THEN
		INSERT INTO AUD_RUTA_AERO
		VALUES(fecha,username,'Se ha actualizado la tarifa de la ruta '||:new.numero,:old.tarifa,:new.tarifa);
	ELSE
		INSERT INTO AUD_RUTA_AERO(fecha_transaccion,usuario,descripcion,old_v)
		VALUES(fecha,username,'Se ha eliminado la  ruta '||:old.numero,:old.tarifa);
	END IF;
END fila_ruta_aero;

/