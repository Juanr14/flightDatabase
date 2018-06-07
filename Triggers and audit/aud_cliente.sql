CREATE TABLE AUD_CLIENTE (
	fecha_transaccion VARCHAR2(21),
	usuario VARCHAR2(35),
	descripcion VARCHAR2(100),
	old_v VARCHAR2(50),
	new_v VARCHAR2(50));

CREATE OR REPLACE TRIGGER fila_cliente
AFTER DELETE OR INSERT OR UPDATE OF email ON CLIENTE
FOR EACH ROW

DECLARE
    username VARCHAR2(35);
    fecha VARCHAR2(20);
BEGIN
	SELECT user INTO username FROM dual;
	
	SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') INTO fecha FROM dual;
	
	IF inserting THEN
		INSERT INTO AUD_CLIENTE(fecha_transaccion,usuario,descripcion)
		VALUES(fecha,username,'Se ha insertado un nuevo cliente identificado por: ' || :new.no_documento);
	ELSIF updating THEN
		INSERT INTO AUD_CLIENTE
		VALUES(fecha,username,'Se actualizo el email del cliente identificado por: '|| :old.no_documento,:old.email,:new.email);
	ELSE
		INSERT INTO AUD_CLIENTE(fecha_transaccion,usuario,descripcion,old_v)
		VALUES(fecha,username,'Se ha eliminado un cliente identificado por: '|| :old.no_documento,:old.email);
	END IF;
END fila_cliente;

/
