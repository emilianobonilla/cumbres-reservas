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

## Arquitectura del Proyecto

### Características Únicas
- **PIN-based Access**: Clientes acceden con código único (sin registro)
- **Admin Panel**: Gestión completa para propietarios
- **Mobile-First**: Diseño optimizado para dispositivos móviles
- **Real-time**: Actualizaciones en tiempo real con Supabase

### Estructura de Directorios
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

## Comandos de Desarrollo

### Setup Inicial
```bash
# Instalar dependencias
npm install

# Configurar variables de entorno
cp .env.example .env.local

# Configurar base de datos
npm run db:push
```

### Desarrollo
```bash
# Servidor de desarrollo
npm run dev                    # http://localhost:3000

# Base de datos
npm run db:generate           # Generar migraciones
npm run db:migrate            # Aplicar migraciones
npm run db:push               # Push schema a DB
npm run db:studio             # Drizzle Studio
```

### Testing
```bash
npm run test                  # Unit tests
npm run test:watch            # Tests en modo watch
npm run test:coverage         # Coverage report
```

### Calidad de Código
```bash
npm run lint                  # ESLint
npm run lint:fix              # Fix automático
npm run type-check            # TypeScript check
```

### Deployment
```bash
npm run build                 # Build para producción
npm run start                 # Servidor producción
```

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

## Variables de Entorno

Ver `.env.example` para configuración completa. Variables críticas:

- `NEXT_PUBLIC_SUPABASE_URL`: URL de tu proyecto Supabase
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`: Clave anónima de Supabase
- `SUPABASE_SERVICE_ROLE_KEY`: Clave de servicio (para API routes)
- `DATABASE_URL`: URL de conexión a PostgreSQL

## Próximos Pasos

1. ✅ **Setup inicial completado**
2. 🔄 **Configurar Supabase proyecto**
3. ⏳ **Implementar schema de base de datos**
4. ⏳ **Crear componentes base**
5. ⏳ **Implementar autenticación**
6. ⏳ **Desarrollar funcionalidades core**

## Deployment en Vercel

1. **Push a GitHub**: El código debe estar en repositorio Git
2. **Conectar Vercel**: Importar proyecto desde GitHub
3. **Variables de Entorno**: Configurar en Vercel Dashboard
4. **Deploy Automático**: Push a main = deploy automático

---

*Proyecto creado con Next.js 14 + TypeScript*  
*Stack: Next.js, Supabase, Vercel, Drizzle ORM*
