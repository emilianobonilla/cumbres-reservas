# Especificación del Stack Tecnológico

## Resumen Ejecutivo
Stack moderno basado en Python 3.12 para backend, React con TypeScript para frontend, desplegado en Azure con arquitectura serverless y microservicios.

---

## BACKEND

### Runtime y Framework
- **Python**: 3.12 (obligatorio por Azure Functions)
- **Framework**: FastAPI 0.104+
  - Alto rendimiento con async/await
  - Documentación automática con OpenAPI
  - Validación automática con Pydantic
  - Soporte nativo para WebSockets (futuro)

### Librerías Core Backend
```python
# requirements.txt principales
fastapi==0.104.*
uvicorn[standard]==0.24.*
sqlalchemy==2.0.*
alembic==1.12.*
pydantic==2.4.*
pydantic-settings==2.0.*
python-jose[cryptography]==3.3.*
passlib[bcrypt]==1.7.*
python-multipart==0.0.6
python-dateutil==2.8.*
```

### Base de Datos y ORM
- **Base de datos principal**: PostgreSQL 15+
  - **Desarrollo**: PostgreSQL local via Docker/Homebrew
  - **Producción**: Azure Database for PostgreSQL Flexible Server
- **ORM**: SQLAlchemy 2.0
  - Core y ORM moderno con async support
  - Type hints completos
  - Lazy loading optimizado
- **Migraciones**: Alembic
  - Migraciones automáticas y manuales
  - Rollback capability
  - Environment específicos (dev, staging, prod)

### Cache y Session Storage
- **Cache principal**: Redis 7+
  - **Desarrollo**: Redis local via Docker
  - **Producción**: Azure Cache for Redis
- **Uso**: 
  - Session storage
  - Cache de consultas frecuentes
  - Queue de background jobs
  - Rate limiting

### Validación y Serialización
- **Pydantic v2**: Modelos de datos con validación automática
- **Schemas**:
  - Request/Response models
  - Database models con SQLAlchemy
  - Configuration models
  - Validation rules centralizados

### Autenticación y Seguridad
- **JWT Tokens**: python-jose con algoritmo RS256
- **Password hashing**: bcrypt via passlib
- **OAuth2**: FastAPI OAuth2 con Password Bearer
- **CORS**: FastAPI CORS middleware
- **Rate limiting**: slowapi (Redis-based)
- **Environment variables**: pydantic-settings

### Background Jobs y Tasks
- **Desarrollo**: APScheduler para jobs simples
- **Producción**: Azure Functions con Timer Triggers
- **Queue**: Redis-based task queue
- **Uso**: 
  - Envío de emails
  - Recordatorios automáticos
  - Cleanup de datos
  - Reports generación

### Email y Notificaciones
- **Email**: aiosmtplib + jinja2 para templates
- **Servicio**: Azure Communication Services Email
- **Templates**: HTML + plain text fallback
- **Queue**: Async processing con Redis

---

## FRONTEND

### Framework y Build Tools
- **Framework**: React 18 con TypeScript 5+
- **Build tool**: Vite 4+ (desarrollo y build)
- **Package manager**: npm (consistency con team)

### Librerías Core Frontend
```json
{
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "typescript": "^5.0.0",
    "react-router-dom": "^6.15.0",
    "zustand": "^4.4.0",
    "@tanstack/react-query": "^4.35.0",
    "axios": "^1.5.0",
    "react-hook-form": "^7.47.0",
    "@hookform/resolvers": "^3.3.0",
    "zod": "^3.22.0",
    "date-fns": "^2.30.0"
  }
}
```

### Styling y UI Components
- **CSS Framework**: Tailwind CSS 3+
- **Component Library**: Headless UI + custom components
- **Icons**: Lucide React (consistent, tree-shakable)
- **Responsive**: Mobile-first approach
- **Theme**: CSS custom properties para consistency

### Estado y Data Fetching
- **Estado Global**: Zustand 4+
  - Simple, performante
  - TypeScript-first
  - Devtools integration
- **Server State**: TanStack Query (React Query)
  - Cache inteligente
  - Background updates
  - Optimistic updates
  - Error handling robusto

### Formularios y Validación
- **Formularios**: React Hook Form 7+
  - Performance optimizado
  - Validación async
  - Minimal re-renders
- **Validación**: Zod schemas
  - Type-safe validation
  - Reutilizable en frontend y backend
  - Error messages personalizados

### Date Handling y Utils
- **Fechas**: date-fns (tree-shakable, functional)
- **HTTP Client**: Axios con interceptors
- **Routing**: React Router v6
- **Utils**: Custom hooks para lógica compartida

### Progressive Web App (PWA)
- **Service Worker**: Workbox via Vite plugin
- **Manifest**: Configurado para instalación
- **Offline**: Cache estratégico para funcionalidad básica
- **Push notifications**: Web Push API (future)

---

## DESARROLLO Y TOOLING

### Code Quality
```json
{
  "devDependencies": {
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "eslint": "^8.45.0",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.3",
    "prettier": "^3.0.0",
    "vitest": "^0.34.0",
    "@testing-library/react": "^13.4.0",
    "@testing-library/jest-dom": "^5.16.5"
  }
}
```

### Testing
- **Backend Testing**: pytest + pytest-asyncio + httpx
- **Frontend Testing**: Vitest + React Testing Library
- **E2E Testing**: Playwright (cross-browser)
- **Coverage**: Built-in con pytest y vitest

### Development Environment
- **Python**: pyenv para manejo de versiones
- **Virtual Environment**: venv (built-in Python)
- **Node**: nvm para manejo de versiones
- **Database**: Docker Compose para servicios locales
- **Environment**: .env files con python-decouple

### Version Control
- **Git**: Conventional commits
- **Branches**: GitFlow simplificado (main, develop, feature/*)
- **Pre-commit hooks**: pre-commit framework
  - Black (Python formatting)
  - isort (Python imports)
  - Prettier (JS/TS formatting)
  - ESLint
  - Type checking

---

## INFRAESTRUCTURA AZURE

### Compute Services
- **Backend**: Azure Functions Premium Plan
  - Python 3.12 runtime
  - Auto-scaling basado en demanda
  - Cold start minimizado con Premium
  - VNET integration para seguridad

- **Frontend**: Azure Static Web Apps
  - Global CDN distribution
  - Automatic HTTPS
  - Custom domains
  - Pull request previews

### Database y Storage
- **Primary Database**: Azure Database for PostgreSQL Flexible Server
  - Compute tier: Burstable B1ms (development), General Purpose D2s_v3 (production)
  - Storage: 32GB SSD con auto-growth
  - Backup: 7 days automated backup
  - High availability: Zone-redundant para production

- **Cache**: Azure Cache for Redis
  - Tier: Basic C1 (development), Standard C2 (production)
  - Data persistence habilitado
  - SSL-only access

- **File Storage**: Azure Blob Storage
  - Hot tier para archivos frecuentes
  - Integration con CDN
  - Lifecycle policies para archivos antiguos

### Networking y Security
- **Application Gateway**: Load balancing y SSL termination
- **VNET**: Network isolation para servicios
- **Key Vault**: Secretos y connection strings
- **Managed Identity**: Service-to-service authentication

### Monitoring y Observability
- **Application Insights**: APM y error tracking
- **Log Analytics**: Centralized logging
- **Azure Monitor**: Alerting y dashboards
- **Custom metrics**: Business KPIs tracking

---

## DEPLOYMENT Y CI/CD

### Containerization
```dockerfile
# Backend Dockerfile
FROM python:3.12-slim
# Multi-stage build para optimizar size
# Health checks incluidos
# Non-root user para seguridad
```

### GitHub Actions Pipeline
```yaml
# .github/workflows/main.yml
name: CI/CD Pipeline
on: [push, pull_request]
jobs:
  test:
    # Backend: pytest con coverage
    # Frontend: vitest + E2E con Playwright
  
  build:
    # Docker images para backend
    # Build optimizado para frontend
  
  deploy:
    # Deploy automático a Azure
    # Blue-green deployment strategy
    # Rollback automático en caso de falla
```

### Environment Management
- **Development**: Local environment con Docker Compose
- **Staging**: Azure environment con datos de prueba
- **Production**: Azure environment con alta disponibilidad

### Infrastructure as Code
- **Terraform**: Manejo de recursos Azure
- **Modules**: Reutilizables para diferentes environments
- **State**: Remote state en Azure Storage Account

---

## CONFIGURACIÓN DE DESARROLLO

### Requisitos del Sistema
- **macOS**: Big Sur+ (Apple Silicon optimizado)
- **Python**: 3.12 via pyenv
- **Node.js**: 18+ via nvm
- **PostgreSQL**: 15+ local o Docker
- **Redis**: 7+ local o Docker

### Setup Script
```bash
#!/bin/bash
# scripts/setup.sh
# Automated setup for development environment
# Python virtual environment
# Node.js dependencies
# Database initialization
# Pre-commit hooks
```

### Environment Variables
```bash
# .env.example
# Database
DATABASE_URL=postgresql://user:pass@localhost/cumbres_dev
REDIS_URL=redis://localhost:6379

# Auth
JWT_SECRET_KEY=your-secret-key
JWT_ALGORITHM=HS256

# Email
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password

# Azure (production)
AZURE_STORAGE_CONNECTION_STRING=
AZURE_APPLICATION_INSIGHTS_KEY=
```

---

## CRITERIOS DE SELECCIÓN

### ¿Por qué este stack?

**FastAPI + Python 3.12**:
- Rendimiento superior a Django/Flask
- Azure Functions soporte nativo
- Type hints nativo
- Documentación automática
- Async/await para operaciones I/O

**React + TypeScript**:
- Ecosistema maduro y robusto
- Type safety en todo el frontend
- Performance excelente
- Mobile-first development
- PWA capabilities

**PostgreSQL**:
- ACID compliance
- JSON support para flexibilidad
- Excellent performance
- Azure managed service disponible

**Azure**:
- Serverless cost-efficiency
- Integrated monitoring
- High availability options
- Compliance y security

### Performance Targets
- **Frontend**: Lighthouse score >90
- **Backend**: Response time <500ms p95
- **Database**: Query time <100ms p95
- **Uptime**: 99.9% SLA target

### Escalabilidad
- **Horizontal**: Azure Functions auto-scaling
- **Database**: Read replicas para queries pesadas
- **Cache**: Redis cluster para high load
- **CDN**: Global distribution via Azure

---

*Stack definido: 04/09/2024*  
*Target deployment: Azure Cloud*  
*Development: Apple Silicon Mac*
