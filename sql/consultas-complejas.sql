-- Total de citas realizadas por profesional en el mes anterior
SELECT pr.id_profesional,
       pr.nombre || ' ' || pr.apellido AS profesional,
       COUNT(*) AS total_realizadas
FROM citas c
JOIN profesionales pr ON pr.id_profesional = c.id_profesional
WHERE c.estado = 'realizada'
  AND date_trunc('month', c.fecha_hora) = date_trunc('month', CURRENT_DATE - INTERVAL '1 month')
GROUP BY pr.id_profesional, profesional
ORDER BY total_realizadas DESC;

-- Pacientes sin citas en los últimos 60 días
SELECT p.*
FROM pacientes p
WHERE NOT EXISTS (
  SELECT 1
  FROM citas c
  WHERE c.id_paciente = p.id_paciente
    AND c.fecha_hora >= CURRENT_DATE - INTERVAL '60 days'
);

-- Profesionales sin citas en un día específico
SELECT pr.*
FROM profesionales pr
LEFT JOIN (
  SELECT DISTINCT id_profesional
  FROM citas
  WHERE fecha_hora::date = DATE '2025-09-12'
) c ON c.id_profesional = pr.id_profesional
WHERE c.id_profesional IS NULL;