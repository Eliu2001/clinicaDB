# Base de Datos Clínica – Agenda y Citas (PostgreSQL)

## Contenido
- `sql/clinica.sql`: Tablas, restricciones, inserts, consultas varias.
- `sql/groupsby.sql`: Agrupaciones.
- `sql/DML.sql`: INSERT/UPDATE/DELETE.
- `sql/consultas-complejas.sql`: consultas más complejas.
- `sql/06_vistas.sql`: Vistas útiles.
- `diagramas/clinica_ER.png`: Diagrama ER.

## Cómo ejecutar
1. Crear BD y conectarse en pgAdmin4.
2. Ejecutar `sql/clinica.sql`.
3. Probar consultas con `sql/03_queries_basicas.sql`, etc.

## Notas
- Se evita el doble agendamiento con UNIQUE (id_profesional, fecha_hora).
- Todo el SQL es 100% PostgreSQL.
