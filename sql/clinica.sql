CREATE TABLE pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    rut VARCHAR(12) UNIQUE NOT NULL,
    direccion VARCHAR(150),
    telefono VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE profesionales (
    id_profesional SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE citas (
    id_cita SERIAL PRIMARY KEY,
    fecha_hora TIMESTAMP NOT NULL,
    motivo TEXT,
    estado VARCHAR(20) CHECK (estado IN ('pendiente', 'realizada', 'cancelada')),
    id_paciente INT NOT NULL REFERENCES pacientes(id_paciente),
    id_profesional INT NOT NULL REFERENCES profesionales(id_profesional)
);

--evitar dobles agendamientos
ALTER TABLE citas
ADD CONSTRAINT uq_profesional_fecha UNIQUE (id_profesional, fecha_hora);

ALTER TABLE citas
ADD CONSTRAINT uq_paciente_fecha UNIQUE (id_paciente, fecha_hora);

CREATE INDEX idx_citas_fecha ON citas (fecha_hora);
CREATE INDEX idx_citas_estado ON citas (estado);

--datos para pruebas
-- Pacientes
INSERT INTO pacientes (nombre, apellido, rut, direccion, telefono, email) VALUES
('Sofía','Morales','11.111.111-1','Av. O’Higgins 123','987111111','sofia@mail.com'),
('Pedro','Lagos','22.222.222-2','Calle Sur 55','987222222','pedro@mail.com'),
('Carla','Rivas','33.333.333-3','Pasaje Norte 77','987333333','carla@mail.com');

-- Profesionales
INSERT INTO profesionales (nombre, apellido, especialidad, email, telefono) VALUES
('Ana','Martínez','Cardiología','ana@clinica.com','934567890'),
('Luis','Rodríguez','Pediatría','luis@clinica.com','945612378'),
('Elena','Vega','Dermatología','elena@clinica.com','956789123');

-- Citas (fechas de ejemplo)
INSERT INTO citas (fecha_hora, motivo, estado, id_paciente, id_profesional) VALUES
('2025-09-10 10:00:00','Control general','pendiente', 1, 1),
('2025-09-10 10:30:00','Chequeo anual','pendiente',   2, 1),
('2025-09-11 15:30:00','Fiebre y tos','pendiente',     2, 2),
('2025-09-12 09:00:00','Lesión cutánea','pendiente',   3, 3),
('2025-09-05 11:00:00','Dolor pecho','realizada',      1, 1),
('2025-09-06 09:30:00','Controles pediátricos','cancelada', 2, 2);

--CONSULTAS BASICAS
--todas las citas proximas
SELECT * 
FROM citas 
WHERE fecha_hora >= NOW()
ORDER BY fecha_hora;

--Agenda de un profesional en un día
SELECT c.*
FROM citas c 
WHERE c.id_profesional = 1
	AND c.fecha_hora::date = DATE '2025-09-10'
ORDER BY c.fecha_hora;

--Citas de un paciente 
SELECT *
FROM citas c 
WHERE c.id_paciente = 2
ORDER BY c.fecha_hora;

--Citas por estado
SELECT estado, COUNT(*) AS total
FROM citas
GROUP BY estado;

--CONSULTAS JOIN

--Agenda detallada con nombres
SELECT 
	c.id_cita,
	to_char(c.fecha_hora, 'YYYY-MM-DD HH24:MI')AS fecha_hora,
	c.estado,
	p.nombre || ' ' || p.apellido AS paciente, 
	pr.nombre || ' ' || pr.apellido AS profesional,
	pr.especialidad
FROM citas c 
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN profesionales pr ON pr.id_profesional = c.id_profesional
ORDER BY c.fecha_hora;

--Citas de un profesional por rango de fechas 
SELECT c.*, p.nombre ||' '|| p.apellido AS paciente
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
WHERE c.id_profesional = 1 
	AND c.fecha_hora BETWEEN '2025-09-10 00:00:00' AND '2025-09-10 23:59:59'
ORDER BY c.fecha_hora;

