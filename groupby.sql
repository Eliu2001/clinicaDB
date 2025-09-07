-- Total de citas por profesional en el mes actual
SELECT pr.id_profesional,
       pr.nombre || ' ' || pr.apellido AS profesional,
       COUNT(*) AS total_citas
FROM citas c
JOIN profesionales pr ON pr.id_profesional = c.id_profesional
WHERE date_trunc('month', c.fecha_hora) = date_trunc('month', CURRENT_DATE)
GROUP BY pr.id_profesional, profesional
ORDER BY total_citas DESC;

-- Estados por profesional en el mes actual
SELECT pr.id_profesional,
       pr.nombre || ' ' || pr.apellido AS profesional,
       c.estado,
       COUNT(*) AS total
FROM citas c
JOIN profesionales pr ON pr.id_profesional = c.id_profesional
WHERE date_trunc('month', c.fecha_hora) = date_trunc('month', CURRENT_DATE)
GROUP BY pr.id_profesional, profesional, c.estado
ORDER BY profesional, c.estado;