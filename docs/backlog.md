# Backlog de Desarrollo - Sistema de Reservas

## Metodología
- Cada tarea es atómica y testeable independientemente
- Estimaciones en puntos de historia (1-8)
- Estados: `TODO`, `IN_PROGRESS`, `TESTING`, `DONE`
- Prioridad: `HIGH`, `MEDIUM`, `LOW`

---

## FASE 1: CONFIGURACIÓN BASE Y SETUP

### FB01-001: Setup del Entorno de Desarrollo Local
**Descripción**: Configurar el entorno de desarrollo con Python 3.12 y herramientas necesarias  
**Estimación**: 3 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Python 3.12 instalado y configurado
- [ ] Virtual environment creado y activado
- [ ] Git configurado con .gitignore apropiado
- [ ] Pre-commit hooks configurados
- [ ] Documentación de setup actualizada

**Tests**:
- Verificar versión de Python con `python --version`
- Ejecutar `pip list` sin errores
- Verificar que pre-commit funciona correctamente

### FB01-002: Estructura de Directorios del Proyecto
**Descripción**: Crear la estructura completa de directorios del monorepo  
**Estimación**: 2 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Directorios `frontend/`, `backend/`, `docs/`, `tests/` creados
- [ ] Subdirectorios de backend configurados
- [ ] Archivos README.md en cada directorio principal
- [ ] Configuración de workspace para IDEs

**Tests**:
- Verificar que todos los directorios existen
- Comprobar que cada README.md tiene contenido básico

### FB01-003: Configuración de FastAPI Base
**Descripción**: Setup inicial del proyecto FastAPI con estructura básica  
**Estimación**: 3 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] FastAPI instalado con dependencias básicas
- [ ] Estructura de la aplicación creada (`app/api/`, `app/core/`, etc.)
- [ ] Endpoint de health check funcionando
- [ ] Configuración de CORS para desarrollo
- [ ] Docker configuration básica

**Tests**:
- GET `/health` retorna 200 OK
- Servidor inicia sin errores
- CORS permite requests desde localhost

### FB01-004: Configuración de Base de Datos Local
**Descripción**: Setup de PostgreSQL local con SQLAlchemy y migraciones  
**Estimación**: 4 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] PostgreSQL configurado localmente
- [ ] SQLAlchemy 2.0 configurado
- [ ] Alembic configurado para migraciones
- [ ] Database connection pool configurado
- [ ] Scripts de inicialización de DB

**Tests**:
- Conectar a la base de datos sin errores
- Ejecutar migración inicial
- Crear y rollback una migración de prueba

### FB01-005: Setup de React con Vite
**Descripción**: Configuración inicial del frontend React con TypeScript y Vite  
**Estimación**: 3 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Proyecto React + TypeScript + Vite configurado
- [ ] Tailwind CSS instalado y configurado
- [ ] Estructura de componentes básica
- [ ] Configuración de ESLint y Prettier
- [ ] Hot reload funcionando

**Tests**:
- `npm run dev` inicia sin errores
- Página de bienvenida carga correctamente
- Hot reload funciona al modificar componentes
- Linting pasa sin errores

---

## FASE 2: AUTENTICACIÓN Y AUTORIZACIÓN

### FB02-001: Modelo de Usuario en Base de Datos
**Descripción**: Crear el modelo de usuario con SQLAlchemy y migración  
**Estimación**: 3 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Modelo User con campos necesarios (email, password_hash, nombre, teléfono, rol)
- [ ] Migración de Alembic para tabla users
- [ ] Índices apropiados para email (único)
- [ ] Campos de auditoría (created_at, updated_at)

**Tests**:
- Crear usuario en base de datos
- Verificar que email es único
- Comprobar que timestamps se crean automáticamente

### FB02-002: Hash de Contraseñas y Utilities
**Descripción**: Implementar hashing seguro de contraseñas con bcrypt  
**Estimación**: 2 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Función para hashear contraseñas
- [ ] Función para verificar contraseñas
- [ ] Configuración de bcrypt con salt rounds apropiados
- [ ] Utilities para validación de contraseña segura

**Tests**:
- Hashear contraseña y verificar que no es igual al texto plano
- Verificar contraseña correcta retorna True
- Verificar contraseña incorrecta retorna False
- Verificar que el hash es diferente cada vez

### FB02-003: JWT Token Management
**Descripción**: Implementar generación y validación de JWT tokens  
**Estimación**: 3 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Generar JWT access tokens
- [ ] Generar JWT refresh tokens
- [ ] Validar y decodificar tokens
- [ ] Configuración de expiración de tokens
- [ ] Secret key configuration

**Tests**:
- Generar token válido para usuario
- Decodificar token y obtener usuario correcto
- Token expirado debe fallar validación
- Token con signature inválida debe fallar

### FB02-004: Endpoints de Autenticación
**Descripción**: Crear endpoints para registro, login y refresh de tokens  
**Estimación**: 4 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] POST `/auth/register` - registro de usuario
- [ ] POST `/auth/login` - login con email/password
- [ ] POST `/auth/refresh` - refresh de access token
- [ ] Validación de datos de entrada con Pydantic
- [ ] Manejo de errores apropiado

**Tests**:
- Registrar usuario nuevo exitosamente
- Login con credenciales válidas retorna tokens
- Login con credenciales inválidas retorna 401
- Refresh token válido retorna nuevo access token
- Datos inválidos retornan 422 con detalles

### FB02-005: Middleware de Autenticación
**Descripción**: Implementar middleware para proteger endpoints autenticados  
**Estimación**: 3 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Middleware que valida JWT en header Authorization
- [ ] Extracción de usuario actual desde token
- [ ] Manejo de tokens expirados
- [ ] Decorador para endpoints que requieren auth
- [ ] Distinción entre roles (Cliente/Admin)

**Tests**:
- Endpoint protegido sin token retorna 401
- Endpoint protegido con token válido permite acceso
- Token expirado retorna 401
- Usuario extraído correctamente del token

### FB02-006: Frontend - Páginas de Login/Registro
**Descripción**: Crear interfaces de usuario para autenticación  
**Estimación**: 5 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Página de login responsiva
- [ ] Página de registro responsiva
- [ ] Validación de formularios en tiempo real
- [ ] Manejo de estados de carga y errores
- [ ] Navegación apropiada post-autenticación

**Tests**:
- Formularios renderizan correctamente en móvil
- Validación funciona antes de submit
- Login exitoso redirige al dashboard
- Errores se muestran apropiadamente

### FB02-007: Frontend - Gestión de Estado de Autenticación
**Descripción**: Implementar gestión de estado global para autenticación  
**Estimación**: 4 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Store de autenticación con Zustand
- [ ] Persistencia de tokens en localStorage
- [ ] Auto-refresh de tokens
- [ ] Logout automático en token expirado
- [ ] Route guards para páginas protegidas

**Tests**:
- Estado de auth persiste después de refresh
- Auto-refresh funciona correctamente
- Logout limpia estado y localStorage
- Route guards redirigen correctamente

---

## FASE 3: CORE BUSINESS LOGIC

### FB03-001: Modelo de Configuración de Disponibilidad
**Descripción**: Crear modelo para configurar horarios y disponibilidad del salón  
**Estimación**: 4 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Modelo AvailabilityConfig con horarios por día de semana
- [ ] Modelo de días bloqueados/no laborables
- [ ] Configuración de precios por horario
- [ ] Validación de solapamientos de horarios
- [ ] Migración de base de datos

**Tests**:
- Crear configuración de disponibilidad válida
- Validar que no se permitan solapamientos
- Obtener horarios disponibles para un día específico

### FB03-002: Modelo de Reservas
**Descripción**: Crear el modelo principal de reservas con todas las relaciones  
**Estimación**: 5 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Modelo Booking con todos los campos necesarios
- [ ] Relaciones con User y AvailabilityConfig
- [ ] Estados de reserva (Pendiente, Confirmada, Cancelada)
- [ ] Campos de auditoría y metadatos
- [ ] Validación de fechas futuras

**Tests**:
- Crear reserva con datos válidos
- Validar que fecha sea futura
- Verificar cálculo de precio total
- Comprobar transiciones de estado válidas

### FB03-003: Lógica de Verificación de Disponibilidad
**Descripción**: Implementar algoritmo para verificar disponibilidad del salón  
**Estimación**: 4 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Función que verifica disponibilidad por fecha/hora
- [ ] Considera configuración de horarios
- [ ] Considera días bloqueados
- [ ] Considera reservas existentes
- [ ] Retorna slots disponibles con precios

**Tests**:
- Verificar disponibilidad en día normal
- Verificar que día bloqueado no está disponible
- Horario ocupado no aparece como disponible
- Precio correcto para cada slot

### FB03-004: API de Consulta de Disponibilidad
**Descripción**: Endpoint para consultar disponibilidad del salón  
**Estimación**: 3 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] GET `/availability` con parámetros de fecha
- [ ] Respuesta con slots disponibles y precios
- [ ] Filtros por rango de fechas
- [ ] Optimización para consultas frecuentes
- [ ] Cache de resultados

**Tests**:
- Obtener disponibilidad para fecha específica
- Filtrar por rango de fechas
- Verificar formato de respuesta
- Comprobar performance de queries

### FB03-005: API de Gestión de Reservas
**Descripción**: Endpoints CRUD para manejo de reservas  
**Estimación**: 5 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] POST `/bookings` - crear reserva
- [ ] GET `/bookings` - listar reservas (paginado)
- [ ] GET `/bookings/{id}` - obtener reserva específica
- [ ] PUT `/bookings/{id}` - modificar reserva
- [ ] DELETE `/bookings/{id}` - cancelar reserva

**Tests**:
- Crear reserva válida
- Listar reservas con paginación
- Modificar reserva dentro del plazo
- Cancelar reserva libera disponibilidad
- Validar permisos por rol de usuario

### FB03-006: Frontend - Calendario de Disponibilidad
**Descripción**: Componente visual para mostrar disponibilidad del salón  
**Estimación**: 6 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Calendario mensual responsivo
- [ ] Indicadores visuales de disponibilidad
- [ ] Selección de fecha y horario
- [ ] Mostrar precios por slot
- [ ] Navegación entre meses
- [ ] Carga optimizada de datos

**Tests**:
- Calendario renderiza correctamente en móvil
- Fechas no disponibles están deshabilitadas
- Selección de fecha carga horarios
- Precios se muestran correctamente

### FB03-007: Frontend - Formulario de Reserva
**Descripción**: Formulario completo para crear nueva reserva  
**Estimación**: 5 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Formulario multi-step responsivo
- [ ] Validación en tiempo real
- [ ] Cálculo automático de precio total
- [ ] Resumen antes de confirmar
- [ ] Manejo de errores de servidor

**Tests**:
- Formulario funciona en pantallas pequeñas
- Validación previene envío de datos inválidos
- Precio se calcula correctamente
- Errores se muestran apropiadamente

### FB03-008: Frontend - Dashboard de Mis Reservas
**Descripción**: Página para que el cliente vea y gestione sus reservas  
**Estimación**: 4 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Lista de reservas del usuario actual
- [ ] Filtros por estado y fecha
- [ ] Acciones de modificar/cancelar
- [ ] Estados visuales claros
- [ ] Paginación si es necesario

**Tests**:
- Lista carga reservas del usuario correcto
- Filtros funcionan apropiadamente
- Acciones están disponibles según el estado
- Responsive en móvil

---

## FASE 4: PANEL ADMINISTRATIVO

### FB04-001: Dashboard Administrativo - Vista General
**Descripción**: Panel principal para administradores con métricas clave  
**Estimación**: 4 puntos  
**Prioridad**: MEDIUM  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Métricas básicas (reservas del mes, ingresos, ocupación)
- [ ] Gráficos simples de estadísticas
- [ ] Lista de reservas recientes
- [ ] Acciones rápidas
- [ ] Actualización en tiempo real

**Tests**:
- Métricas se calculan correctamente
- Gráficos renderizan con datos reales
- Dashboard carga rápidamente

### FB04-002: Gestión de Reservas Administrativas
**Descripción**: Interface para que admin gestione todas las reservas  
**Estimación**: 5 puntos  
**Prioridad**: MEDIUM  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Tabla con todas las reservas y filtros avanzados
- [ ] Acciones inline para aprobar/rechazar/modificar
- [ ] Modal de detalles de reserva
- [ ] Bulk actions para múltiples reservas
- [ ] Export de datos

**Tests**:
- Filtros funcionan correctamente
- Acciones modifican estado apropiadamente
- Bulk actions procesan múltiples items
- Export genera archivo correcto

### FB04-003: Configuración de Disponibilidad y Precios
**Descripción**: Interface para configurar horarios, precios y días bloqueados  
**Estimación**: 6 puntos  
**Prioridad**: MEDIUM  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Formulario para configurar horarios por día de semana
- [ ] Gestión de precios por horario
- [ ] Calendario para bloquear días específicos
- [ ] Vista previa de como se verá para clientes
- [ ] Validación de configuraciones

**Tests**:
- Configuración se guarda correctamente
- Validaciones previenen conflictos
- Vista previa muestra datos correctos

### FB04-004: Gestión de Usuarios
**Descripción**: CRUD de usuarios para administradores  
**Estimación**: 4 puntos  
**Prioridad**: LOW  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Lista de todos los usuarios
- [ ] Filtros y búsqueda
- [ ] Ver historial de reservas por usuario
- [ ] Habilitar/deshabilitar usuarios
- [ ] Cambiar roles de usuario

**Tests**:
- Lista usuarios correctamente
- Filtros y búsqueda funcionan
- Cambios de estado se persisten

---

## FASE 5: NOTIFICACIONES Y FEATURES AVANZADAS

### FB05-001: Sistema de Notificaciones por Email
**Descripción**: Implementar envío de emails automáticos  
**Estimación**: 4 puntos  
**Prioridad**: MEDIUM  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Configuración de SMTP
- [ ] Templates de email para diferentes eventos
- [ ] Queue de emails con reintentos
- [ ] Logs de emails enviados
- [ ] Unsubscribe functionality

**Tests**:
- Email se envía al crear reserva
- Template renderiza correctamente
- Queue procesa emails en orden
- Reintentos funcionan en caso de falla

### FB05-002: PWA Configuration
**Descripción**: Configurar la aplicación como Progressive Web App  
**Estimación**: 3 puntos  
**Prioridad**: MEDIUM  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Manifest.json configurado
- [ ] Service worker para cache
- [ ] Funcionalidad offline básica
- [ ] Install prompt
- [ ] Icons para diferentes dispositivos

**Tests**:
- Aplicación es instalable
- Funciona offline para páginas cacheadas
- Install prompt aparece apropiadamente

### FB05-003: Sistema de Recordatorios
**Descripción**: Notificaciones automáticas antes de eventos  
**Estimación**: 4 puntos  
**Prioridad**: LOW  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Job scheduler para recordatorios
- [ ] Configuración de cuando enviar recordatorios
- [ ] Templates personalizados
- [ ] Opt-out para usuarios
- [ ] Logs de recordatorios enviados

**Tests**:
- Recordatorios se envían en el momento correcto
- Usuarios pueden optar por no recibir
- Sistema maneja zona horaria correctamente

---

## FASE 6: DEPLOYMENT Y PRODUCCIÓN

### FB06-001: Configuración de Docker
**Descripción**: Containerizar la aplicación para deployment  
**Estimación**: 3 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Dockerfile para backend optimizado
- [ ] Dockerfile para frontend optimizado
- [ ] Docker compose para desarrollo
- [ ] Multi-stage builds
- [ ] Health checks

**Tests**:
- Containers se construyen sin errores
- Aplicación funciona dentro del container
- Health checks responden correctamente

### FB06-002: Configuración de Azure Infrastructure
**Descripción**: Setup de recursos de Azure con Terraform  
**Estimación**: 5 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Azure Database for PostgreSQL
- [ ] Azure Functions para backend
- [ ] Azure Static Web Apps para frontend
- [ ] Azure Cache for Redis
- [ ] Application Insights

**Tests**:
- Recursos se crean correctamente con Terraform
- Aplicación se conecta a recursos Azure
- Monitoring captura métricas

### FB06-003: CI/CD con GitHub Actions
**Descripción**: Pipeline automatizado de deployment  
**Estimación**: 4 puntos  
**Prioridad**: HIGH  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Pipeline de testing automatizado
- [ ] Build y deploy automático en merge a main
- [ ] Environment staging y production
- [ ] Rollback capability
- [ ] Notificaciones de deploy

**Tests**:
- Tests corren automáticamente en PR
- Deploy automático funciona correctamente
- Rollback puede ejecutarse exitosamente

### FB06-004: Monitoring y Logging
**Descripción**: Implementar logging y monitoreo en producción  
**Estimación**: 3 puntos  
**Prioridad**: MEDIUM  
**Estado**: TODO  

**Criterios de Aceptación**:
- [ ] Structured logging en toda la app
- [ ] Error tracking con Application Insights
- [ ] Performance monitoring
- [ ] Alertas para errores críticos
- [ ] Dashboard de métricas

**Tests**:
- Logs se capturan correctamente
- Errores se reportan a monitoring
- Alertas se disparan apropiadamente

---

## RESUMEN DE ESTIMACIONES

### Por Fase:
- **Fase 1**: 15 puntos (Setup básico)
- **Fase 2**: 24 puntos (Autenticación)
- **Fase 3**: 32 puntos (Core business)
- **Fase 4**: 19 puntos (Panel admin)
- **Fase 5**: 11 puntos (Features avanzadas)
- **Fase 6**: 15 puntos (Deployment)

**Total**: 116 puntos de historia

### Distribución por Prioridad:
- **HIGH**: 68 puntos (59%)
- **MEDIUM**: 33 puntos (28%)
- **LOW**: 15 puntos (13%)

---

*Backlog creado: 04/09/2024*  
*Metodología: Scrum con sprints de 2 semanas*  
*Velocidad estimada: 10-15 puntos por sprint*
