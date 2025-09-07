--ALGUNAS VISTAS
-- Agenda de hoy (vista)
CREATE OR REPLACE VIEW vw_agenda_hoy AS
SELECT 
  c.id_cita,
  c.fecha_hora,
  c.estado,
  p.nombre || ' ' || p.apellido  AS paciente,
  pr.nombre || ' ' || pr.apellido AS profesional,
  pr.especialidad
FROM citas c
JOIN pacientes p    ON p.id_paciente = c.id_paciente
JOIN profesionales pr ON pr.id_profesional = c.id_profesional
WHERE c.fecha_hora::date = CURRENT_DATE
ORDER BY c.fecha_hora;

-- Resumen mensual por profesional
CREATE OR REPLACE VIEW vw_resumen_mensual AS
SELECT 
  date_trunc('month', c.fecha_hora)::date AS mes,
  pr.id_profesional,
  pr.nombre || ' ' || pr.apellido AS profesional,
  COUNT(*) FILTER (WHERE c.estado = 'pendiente')  AS pendientes,
  COUNT(*) FILTER (WHERE c.estado = 'realizada')  AS realizadas,
  COUNT(*) FILTER (WHERE c.estado = 'cancelada')  AS canceladas,
  COUNT(*) AS total
FROM citas c
JOIN profesionales pr ON pr.id_profesional = c.id_profesional
GROUP BY mes, pr.id_profesional, profesional
ORDER BY mes DESC, profesional;