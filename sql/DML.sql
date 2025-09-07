-- Agendar nueva cita
INSERT INTO citas (fecha_hora, motivo, estado, id_paciente, id_profesional)
VALUES ('2025-09-12 10:30:00','Control post tratamiento','pendiente', 1, 1);

-- Cambiar estado (ej. marcar como realizada)
UPDATE citas
SET estado = 'realizada'
WHERE id_cita = 1;

-- Reagendar cita (cambiar fecha/hora)
UPDATE citas
SET fecha_hora = '2025-09-12 11:00:00'
WHERE id_cita = 2;

-- Cancelar cita
UPDATE citas
SET estado = 'cancelada'
WHERE id_cita = 3;

-- Eliminar cita (si procede)
DELETE FROM citas
WHERE id_cita = 6;