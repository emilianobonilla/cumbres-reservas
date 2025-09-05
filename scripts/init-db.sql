-- Inicialización de base de datos para desarrollo
-- Este script se ejecuta automáticamente cuando se crea el contenedor PostgreSQL

-- Crear extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Crear usuario específico para la aplicación (opcional)
-- CREATE USER cumbres_app WITH PASSWORD 'dev_password';
-- GRANT ALL PRIVILEGES ON DATABASE cumbres_reservas_dev TO cumbres_app;
