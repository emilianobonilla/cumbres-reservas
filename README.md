# Sistema de Reservas - Salón de Eventos

## Objetivo del Proyecto
Desarrollar una aplicación web responsiva para la gestión de reservas de un salón de eventos, optimizada para dispositivos móviles.

## Alcance del Proyecto
- Sistema de reservas online
- Gestión de disponibilidad del salón
- Panel administrativo para el propietario
- Interfaz móvil-first para clientes
- Notificaciones automáticas
- Reportes básicos

## Stack Tecnológico Propuesto

### Frontend
- **Framework**: React 18 con TypeScript
- **Styling**: Tailwind CSS (móvil-first)
- **Estado**: Zustand o React Query
- **Build**: Vite
- **PWA**: Workbox para funcionalidad offline

### Backend
- **Runtime**: Python 3.12
- **Framework**: FastAPI
- **ORM**: SQLAlchemy 2.0
- **Validación**: Pydantic v2
- **Autenticación**: JWT + OAuth2

### Base de Datos
- **Principal**: PostgreSQL (Azure Database)
- **Cache**: Redis (Azure Cache)

### Infraestructura (Azure)
- **Backend**: Azure Functions (Python 3.12)
- **Frontend**: Azure Static Web Apps
- **Base de datos**: Azure Database for PostgreSQL
- **Cache**: Azure Cache for Redis
- **Storage**: Azure Blob Storage (imágenes)
- **Monitoring**: Azure Application Insights

### DevOps
- **CI/CD**: GitHub Actions
- **Containerización**: Docker
- **Monitoreo**: Azure Monitor

## Actores del Sistema

### Cliente
- Consultar disponibilidad
- Realizar reservas
- Modificar/cancelar reservas propias
- Recibir confirmaciones por email/SMS

### Administrador
- Gestionar todas las reservas
- Configurar disponibilidad y precios
- Ver reportes y estadísticas
- Gestionar clientes y eventos

## Casos de Uso Principales

### Para Clientes
1. **Consultar Disponibilidad**
   - Ver calendario de disponibilidad
   - Filtrar por fecha y horario
   - Ver precios por tipo de evento

2. **Realizar Reserva**
   - Seleccionar fecha y horario
   - Completar datos del evento
   - Realizar pago/señar
   - Recibir confirmación

3. **Gestionar Reservas**
   - Ver mis reservas
   - Modificar reserva (dentro del plazo permitido)
   - Cancelar reserva
   - Descargar comprobante

### Para Administrador
1. **Gestión de Reservas**
   - Ver todas las reservas
   - Aprobar/rechazar reservas
   - Modificar cualquier reserva
   - Gestionar lista de espera

2. **Configuración del Sistema**
   - Configurar horarios disponibles
   - Establecer precios y promociones
   - Configurar políticas de cancelación
   - Gestionar días no laborables

3. **Reportes y Estadísticas**
   - Ingresos por período
   - Ocupación del salón
   - Clientes frecuentes
   - Análisis de demanda

## Funcionalidades Técnicas

### Autenticación y Autorización
- Registro de usuarios con email
- Login con email/password
- Reset de contraseña
- Roles: Cliente, Administrador

### Notificaciones
- Email de confirmación de reserva
- Recordatorios de evento
- Notificaciones de cambios
- Notificaciones push (PWA)

### Pagos (Fase 2)
- Integración con Mercado Pago
- Gestión de señas y pagos completos
- Facturación electrónica

## Estructura del Proyecto

```
cumbres-app/
├── frontend/                 # React app
│   ├── src/
│   ├── public/
│   ├── package.json
│   └── vite.config.ts
├── backend/                  # FastAPI app
│   ├── app/
│   │   ├── api/
│   │   ├── core/
│   │   ├── db/
│   │   ├── models/
│   │   └── services/
│   ├── requirements.txt
│   └── Dockerfile
├── infrastructure/           # Azure deployment
│   ├── terraform/
│   └── github-actions/
├── docs/                    # Documentación
├── tests/                   # Tests E2E
└── README.md
```

## Próximos Pasos

1. ✅ Crear documento de planificación
2. 🔄 Definir casos de uso detallados
3. ⏳ Especificar stack tecnológico final
4. ⏳ Crear backlog de tareas atómicas
5. ⏳ Configurar estructura inicial

---

## Backlog de Desarrollo

### Fase 1: Configuración Base
- [ ] Setup del entorno de desarrollo
- [ ] Configuración de Python 3.12 virtual env
- [ ] Setup inicial de FastAPI
- [ ] Setup inicial de React + Vite
- [ ] Configuración de base de datos local

### Fase 2: Autenticación
- [ ] Modelo de usuarios
- [ ] Endpoints de autenticación
- [ ] Frontend de login/registro
- [ ] Middleware de autorización

### Fase 3: Core Business Logic
- [ ] Modelo de reservas
- [ ] Calendario de disponibilidad
- [ ] API de reservas
- [ ] Frontend de reservas

### Fase 4: Panel Administrativo
- [ ] Dashboard de administración
- [ ] Gestión de reservas
- [ ] Configuraciones del sistema
- [ ] Reportes básicos

### Fase 5: Features Avanzadas
- [ ] Notificaciones por email
- [ ] PWA functionality
- [ ] Sistema de pagos
- [ ] Optimizaciones de performance

### Fase 6: Deployment
- [ ] Configuración de Azure
- [ ] CI/CD con GitHub Actions
- [ ] Monitoring y logging
- [ ] Testing en producción

---

*Documento creado el 04/09/2024*
*Stack: Python 3.12, FastAPI, React, PostgreSQL, Azure*
