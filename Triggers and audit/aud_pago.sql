CREATE TABLE AUD_PAGO (
	fecha_transaccion VARCHAR2(21),
	usuario VARCHAR2(35),
	descripcion VARCHAR2(100),
	old_v NUMBER(11,3),
	new_v NUMBER(11,3)
);

CREATE OR REPLACE TRIGGER fila_pago
AFTER DELETE OR INSERT OR UPDATE OF monto ON PAGO
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
		INSERT INTO AUD_PAGO(fecha_transaccion,usuario,descripcion)
		VALUES(fecha,username,'Se ha insertado el pago: '|| :new.codigo);
	ELSIF updating THEN
		INSERT INTO AUD_PAGO
		VALUES(fecha,username,'Se ha actualizado el monto del pago: '|| :new.codigo, :old.monto,:new.monto);
	ELSE
		INSERT INTO AUD_PAGO(fecha_transaccion,usuario,descripcion,old_v)
		VALUES(fecha,username,'Se ha eliminado el pago: '|| :new.codigo,:old.monto);
	END IF;
END fila_pago;

/