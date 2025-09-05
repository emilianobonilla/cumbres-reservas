# Sistema de Reservas - Salón de Eventos

## Objetivo del Proyecto
Aplicación web full-stack para la gestión de reservas de un salón de eventos, optimizada para dispositivos móviles con arquitectura moderna.

## Stack Tecnológico Definitivo

### Full-Stack Framework
- **Framework**: Next.js 14 con App Router
- **Lenguaje**: TypeScript 5
- **Styling**: Tailwind CSS 4 (móvil-first)
- **Componentes**: shadcn/ui + Radix UI

### Estado y Datos
- **Estado Global**: Zustand
- **Server State**: TanStack Query (React Query)
- **Forms**: React Hook Form + Zod
- **ORM**: Drizzle ORM + Drizzle Kit

### Base de Datos y Auth
- **Base de datos**: PostgreSQL (Supabase)
- **Autenticación**: Supabase Auth (admin) + Custom PIN (clientes)
- **Storage**: Supabase Storage

### Infraestructura (Vercel)
- **Hosting**: Vercel (Frontend + API Routes)
- **Base de datos**: Supabase PostgreSQL
- **CDN**: Vercel Edge Network
- **Analytics**: Vercel Analytics
- **CI/CD**: GitHub Actions + Vercel

### Testing
- **Unit Tests**: Vitest + React Testing Library
- **Mocking**: Vitest native mocks

## Flujo de Desarrollo Multi-Ambiente

### 🏗️ Arquitectura de Branches
```
feature/nueva-funcionalidad → develop → staging (Vercel)
                               ↓
                            main → production (Vercel)
```

### 🐳 Desarrollo Local con Docker (Recomendado)
```bash
# Setup inicial
make help                      # Ver todos los comandos
make install                   # Instalar dependencias
cp .env.example .env.local     # Configurar variables de entorno

# Desarrollo con hot reload
make dev-docker                # Inicia todos los servicios (Next.js + PostgreSQL)
# Acceder a http://localhost:3000

# Comandos útiles
make logs                      # Ver logs de la aplicación
make db-shell                  # Conectar a PostgreSQL
make shell                     # Abrir terminal en el contenedor
make stop                      # Parar todos los servicios
```

### 💻 Desarrollo Local Sin Docker
```bash
# Servidor de desarrollo
npm run dev                    # http://localhost:3000

# Base de datos (requiere PostgreSQL local)
npm run db:push               # Push schema a DB
npm run db:studio             # Drizzle Studio
```

### 🚀 Comandos de Desarrollo

#### Testing
```bash
npm run test                  # Unit tests
npm run test:watch            # Tests en modo watch
npm run test:coverage         # Coverage report
```

#### Calidad de Código
```bash
npm run lint                  # ESLint
npm run lint:fix              # Fix automático
npm run type-check            # TypeScript check
```

#### Base de Datos
```bash
npm run db:generate           # Generar migraciones
npm run db:migrate            # Aplicar migraciones
npm run db:push               # Push schema a DB
npm run db:studio             # Drizzle Studio
```

## Características Únicas del Proyecto

### PIN-based Access
- **Clientes**: Acceden con código único (sin registro)
- **Administradores**: Login tradicional con Supabase Auth

### Mobile-First
- Diseño optimizado para dispositivos móviles
- PWA ready con offline capabilities
- Touch-friendly interfaces

### Multi-Ambiente
- **Development**: Docker local con hot reload
- **Staging**: Deploy automático desde `develop` branch
- **Production**: Deploy automático desde `main` branch

## Casos de Uso Principales

### Para Clientes
1. **Acceso por PIN**: Ingresan código único para ver su reserva
2. **Ver Detalles**: Fecha, hora, tipo de evento, información de contacto
3. **Recibir Notificaciones**: SMS/WhatsApp con recordatorios

### Para Administradores
1. **Gestión de Reservas**: CRUD completo de reservas
2. **Gestión de Clientes**: Base de datos de clientes
3. **Calendario**: Vista de disponibilidad y reservas
4. **Configuración**: Precios, horarios, días no laborables
5. **Reportes**: Ingresos, ocupación, estadísticas
6. **Pagos**: Registro de señas y pagos completados

## Workflow de Desarrollo

### 1. Crear Feature Branch
```bash
make feature name=nueva-funcionalidad
# Crea feature/nueva-funcionalidad desde develop
```

### 2. Desarrollo Local
```bash
make dev-docker                # Desarrollo con Docker
# o
npm run dev                    # Desarrollo sin Docker
```

### 3. Testing y Quality Checks
```bash
make ci-test                   # Suite completa de CI
# Ejecuta: type-check, lint, test, build
```

### 4. Pull Request
```bash
git push origin feature/nueva-funcionalidad
# Crear PR hacia develop en GitHub
```

### 5. Deploy Automático
- **Merge to develop** → Deploy automático a **staging**
- **Merge to main** → Deploy automático a **production**

## Variables de Entorno

Ver `.env.example` para configuración completa. Variables críticas:

### Development
- `NEXT_PUBLIC_SUPABASE_URL_DEV`: URL de Supabase desarrollo
- `NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV`: Clave anónima desarrollo
- `DATABASE_URL`: PostgreSQL local (Docker)

### Staging
- `NEXT_PUBLIC_SUPABASE_URL_STAGING`: URL de Supabase staging
- `NEXT_PUBLIC_SUPABASE_ANON_KEY_STAGING`: Clave anónima staging

### Production
- `NEXT_PUBLIC_SUPABASE_URL_PROD`: URL de Supabase producción
- `NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD`: Clave anónima producción

## Estructura del Proyecto

```
src/
├── app/                    # Next.js App Router
│   ├── admin/             # Panel administrativo
│   ├── reserva/[pin]/     # Vista cliente por PIN
│   └── api/               # API Routes
├── components/            # Componentes reutilizables
│   ├── ui/               # shadcn/ui components
│   ├── layout/           # Layouts
│   ├── forms/            # Formularios
│   └── admin/            # Componentes admin
├── lib/                   # Librerías y utilidades
│   ├── db/               # Database schema
│   ├── auth/             # Auth helpers
│   └── validations/      # Zod schemas
├── types/                 # TypeScript types
├── hooks/                 # Custom hooks
└── stores/                # Zustand stores
```

## Deployment en Vercel

### Setup Inicial
1. **Conectar GitHub**: Importar repositorio a Vercel
2. **Configurar Ambientes**: Crear proyectos separados para staging/production
3. **Variables de Entorno**: Configurar en Vercel Dashboard por ambiente
4. **Deploy Automático**: Push a develop/main = deploy automático

### Branch Configuration
- **develop** → Proyecto Vercel "cumbres-reservas-staging"
- **main** → Proyecto Vercel "cumbres-reservas"

## Próximos Pasos

1. ✅ **Setup multi-ambiente completado**
2. 🔄 **Configurar Supabase proyectos (dev/staging/prod)**
3. ⏳ **Crear schema de base de datos**
4. ⏳ **Implementar componentes base**
5. ⏳ **Desarrollar autenticación**
6. ⏳ **Crear funcionalidades core**

## Comandos Útiles

```bash
# Desarrollo
make dev-docker            # Desarrollo con Docker
make dev                   # Desarrollo sin Docker
make help                  # Ver todos los comandos

# Testing
make test                  # Unit tests
make ci-test              # Suite completa CI

# Base de datos
make db-shell             # Conectar a PostgreSQL
make db-migrate           # Aplicar migraciones

# Docker
make clean                # Limpiar contenedores
make reset                # Reset completo
```

---

*Proyecto creado con Next.js 14 + TypeScript*  
*Stack: Next.js, Supabase, Vercel, Drizzle ORM*  
*Arquitectura: Multi-ambiente con Docker + CI/CD*
