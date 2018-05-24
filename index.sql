CREATE INDEX ruta_aero_idx
ON RUTA_AEROLINEA(tarifa);

CREATE INDEX vuelo_fecha_idx
ON VUELO(fecha);

CREATE INDEX cliente_no_doc_idx
ON CLIENTE(no_documento);

CREATE INDEX pago_fecha_idx
ON PAGO(fecha);

CREATE INDEX tiquete_numero_idx
ON tiquete(numero);