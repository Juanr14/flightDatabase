CREATE TABLE AUD_VUELO (
	fecha_transaccion VARCHAR2(21),
	usuario VARCHAR2(35),
	descripcion VARCHAR2(100),
	old_v VARCHAR2(7),
	new_v VARCHAR2(7));

CREATE OR REPLACE TRIGGER fila_vuelo
AFTER DELETE OR INSERT OR UPDATE OF cod_vuelo ON VUELO
FOR EACH ROW

DECLARE
    username VARCHAR2(35);
	fecha VARCHAR2(20);
BEGIN
	
	SELECT user INTO username
	FROM dual;
	
	SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS') INTO fecha
	FROM dual;
	
	
	IF inserting THEN
		INSERT INTO AUD_VUELO(fecha_transaccion,usuario,descripcion)
		VALUES(fecha,username,'Se ha insertado el nuevo vuelo '|| :new.cod_vuelo );
	ELSIF updating THEN
		INSERT INTO AUD_VUELO
		VALUES(fecha,username,'Se ha actualizado un código de vuelo',:old.cod_vuelo,:new.cod_vuelo);
	ELSE
		INSERT INTO AUD_VUELO(fecha_transaccion,usuario,descripcion,old_v)
		VALUES(fecha,username,'Se ha eliminado un vuelo',:old.cod_vuelo);
	END IF;
END fila_vuelo;

/