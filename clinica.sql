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

INSERT INTO pacientes (nombre, apellido, rut, direccion, telefono, email) VALUES
('Juan', 'Pérez', '12.345.678-9', 'Av. Central 123', '987654321', 'juan.perez@mail.com'),
('María', 'Gómez', '23.456.789-0', 'Calle Norte 45', '912345678', 'maria.gomez@mail.com');

INSERT INTO profesionales (nombre, apellido, especialidad, email, telefono) VALUES
('Ana', 'Martínez', 'Cardiología', 'ana.martinez@clinica.com', '934567890'),
('Luis', 'Rodríguez', 'Pediatría', 'luis.rodriguez@clinica.com', '945612378');

INSERT INTO citas (fecha_hora, motivo, estado, id_paciente, id_profesional) VALUES
('2025-09-10 10:00:00', 'Control general', 'pendiente', 1, 1),
('2025-09-11 15:30:00', 'Dolor de cabeza persistente', 'pendiente', 2, 2);

