# Backend - Sistema de Reservas

API REST desarrollada con FastAPI y Python 3.12 para el sistema de gestión de reservas del salón de eventos.

## Requisitos

- Python 3.12
- PostgreSQL 15+
- Redis 7+

## Setup de Desarrollo

### 1. Activar el entorno virtual
```bash
source venv/bin/activate
```

### 2. Instalar dependencias
```bash
pip install -r requirements.txt
```

### 3. Configurar variables de entorno
Copiar `.env.example` a `.env` y configurar:
```bash
cp .env.example .env
```

### 4. Configurar base de datos
```bash
# Crear la base de datos
createdb cumbres_dev

# Ejecutar migraciones
alembic upgrade head
```

### 5. Ejecutar servidor de desarrollo
```bash
uvicorn app.main:app --reload --port 8000
```

La API estará disponible en: http://localhost:8000
Documentación automática: http://localhost:8000/docs

## Estructura del Proyecto

```
backend/
├── app/
│   ├── api/           # Endpoints de la API
│   │   ├── auth/      # Autenticación
│   │   ├── bookings/  # Gestión de reservas
│   │   ├── users/     # Gestión de usuarios
│   │   └── admin/     # Panel administrativo
│   ├── core/          # Configuración y utilidades
│   │   ├── config.py  # Configuración de la app
│   │   ├── security.py # JWT y autenticación
│   │   └── database.py # Conexión a DB
│   ├── db/            # Migraciones y scripts
│   ├── models/        # Modelos SQLAlchemy
│   ├── schemas/       # Esquemas Pydantic
│   ├── services/      # Lógica de negocio
│   └── main.py        # Entrada de la aplicación
├── tests/             # Tests automatizados
├── alembic/           # Migraciones Alembic
├── requirements.txt   # Dependencias Python
└── .env.example       # Variables de entorno ejemplo
```

## API Endpoints

### Autenticación
- `POST /auth/register` - Registro de usuario
- `POST /auth/login` - Inicio de sesión
- `POST /auth/refresh` - Renovar token

### Reservas
- `GET /availability` - Consultar disponibilidad
- `POST /bookings` - Crear reserva
- `GET /bookings` - Listar reservas del usuario
- `GET /bookings/{id}` - Obtener reserva específica
- `PUT /bookings/{id}` - Modificar reserva
- `DELETE /bookings/{id}` - Cancelar reserva

### Administración
- `GET /admin/bookings` - Listar todas las reservas
- `POST /admin/bookings/{id}/approve` - Aprobar reserva
- `POST /admin/bookings/{id}/reject` - Rechazar reserva
- `GET /admin/stats` - Estadísticas del sistema

## Testing

```bash
# Ejecutar todos los tests
pytest

# Tests con coverage
pytest --cov=app

# Tests de un módulo específico
pytest tests/test_auth.py
```

## Deployment

### Docker
```bash
# Build
docker build -t cumbres-backend .

# Run
docker run -p 8000:8000 cumbres-backend
```

### Azure Functions
El backend está preparado para deployment en Azure Functions. Ver documentación en `/infrastructure/`.

## Desarrollo

### Pre-commit hooks
```bash
pre-commit install
```

### Formateo de código
```bash
# Black formatting
black .

# Imports sorting
isort .

# Linting
flake8 .
```

### Migraciones
```bash
# Crear nueva migración
alembic revision --autogenerate -m "description"

# Aplicar migraciones
alembic upgrade head

# Rollback
alembic downgrade -1
```

## Variables de Entorno

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `DATABASE_URL` | URL de PostgreSQL | `postgresql://user:pass@localhost/cumbres` |
| `REDIS_URL` | URL de Redis | `redis://localhost:6379` |
| `JWT_SECRET_KEY` | Clave secreta para JWT | `your-secret-key` |
| `JWT_ALGORITHM` | Algoritmo JWT | `HS256` |
| `SMTP_HOST` | Servidor SMTP | `smtp.gmail.com` |
| `SMTP_PORT` | Puerto SMTP | `587` |
| `SMTP_USER` | Usuario SMTP | `your-email@gmail.com` |
| `SMTP_PASSWORD` | Password SMTP | `your-app-password` |

## Contribución

1. Fork del proyecto
2. Crear feature branch (`git checkout -b feature/nueva-funcionalidad`)
3. Commit de cambios (`git commit -am 'Add nueva funcionalidad'`)
4. Push al branch (`git push origin feature/nueva-funcionalidad`)
5. Crear Pull Request

## Licencia

MIT License - ver archivo LICENSE para detalles.
