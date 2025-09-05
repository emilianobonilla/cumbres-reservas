# Frontend - Sistema de Reservas

Aplicación web responsiva desarrollada con React, TypeScript y Tailwind CSS para el sistema de reservas del salón de eventos.

## Tecnologías

- **React 18** - Library UI
- **TypeScript 5** - Type safety
- **Vite 4** - Build tool y dev server
- **Tailwind CSS 3** - Styling framework
- **React Router 6** - Client-side routing
- **Zustand** - Estado global
- **React Query** - Server state management
- **React Hook Form** - Formularios
- **Zod** - Validación de esquemas

## Requisitos

- Node.js 18+
- npm 8+

## Setup de Desarrollo

### 1. Instalar dependencias
```bash
npm install
```

### 2. Configurar variables de entorno
```bash
cp .env.example .env.local
```

### 3. Ejecutar servidor de desarrollo
```bash
npm run dev
```

La aplicación estará disponible en: http://localhost:5173

## Scripts Disponibles

### Desarrollo
```bash
npm run dev          # Servidor de desarrollo
npm run build        # Build para producción
npm run preview      # Preview del build
```

### Testing
```bash
npm test             # Ejecutar tests unitarios
npm run test:ui      # Tests con interfaz visual
npm run test:coverage # Tests con coverage
npm run test:e2e     # Tests end-to-end con Playwright
```

### Code Quality
```bash
npm run lint         # Linting con ESLint
npm run lint:fix     # Fix automático de linting
npm run type-check   # Verificación de tipos
npm run format       # Formateo con Prettier
npm run format:check # Verificar formateo
```

## Estructura del Proyecto

```
frontend/
├── src/
│   ├── components/     # Componentes reutilizables
│   │   ├── ui/         # Componentes base (Button, Input, etc.)
│   │   ├── forms/      # Componentes de formularios
│   │   ├── layout/     # Componentes de layout
│   │   └── calendar/   # Componentes del calendario
│   ├── pages/          # Páginas de la aplicación
│   │   ├── auth/       # Login, registro
│   │   ├── bookings/   # Reservas
│   │   ├── admin/      # Panel administrativo
│   │   └── Home.tsx    # Página principal
│   ├── hooks/          # Custom hooks
│   ├── services/       # API calls y servicios
│   ├── stores/         # Estado global (Zustand)
│   ├── types/          # Tipos TypeScript
│   ├── utils/          # Utilidades
│   ├── App.tsx         # Componente raíz
│   └── main.tsx        # Entry point
├── public/             # Assets estáticos
├── tests/              # Tests
├── package.json        # Dependencias y scripts
├── tsconfig.json       # Configuración TypeScript
├── tailwind.config.js  # Configuración Tailwind
├── vite.config.ts      # Configuración Vite
└── README.md           # Este archivo
```

## Características Principales

### Responsivo y Mobile-First
- Diseño optimizado para móviles
- Breakpoints de Tailwind CSS
- Touch-friendly interfaces

### Progressive Web App (PWA)
- Instalable en dispositivos móviles
- Funcionalidad offline básica
- Service Worker para caching

### Performance
- Code splitting automático
- Lazy loading de rutas
- Optimización de imágenes
- Bundle size optimizado

### User Experience
- Loading states
- Error boundaries
- Optimistic updates
- Form validation en tiempo real

## Configuración de Desarrollo

### Variables de Entorno

```bash
# .env.local
VITE_API_URL=http://localhost:8000/api/v1
VITE_APP_NAME=Cumbres Reservas
VITE_APP_VERSION=1.0.0
VITE_ENVIRONMENT=development
```

### ESLint y Prettier
Configurados para mantener código consistente:
- ESLint para linting
- Prettier para formateo
- Pre-commit hooks con Husky

### Testing
- **Unit tests**: Vitest + React Testing Library
- **E2E tests**: Playwright
- **Coverage**: Configurado para reportes detallados

## Deployment

### Build de Producción
```bash
npm run build
```

### Azure Static Web Apps
El proyecto está configurado para deployment automático en Azure Static Web Apps:

```bash
# Build optimizado para Azure
npm run build

# Preview local del build
npm run preview
```

## Componentes Principales

### Calendario
- Vista mensual responsiva
- Selección de fechas y horarios
- Indicadores visuales de disponibilidad
- Navegación táctil optimizada

### Formularios
- Validación en tiempo real con Zod
- Estados de loading y error
- Campos responsivos
- Feedback visual inmediato

### Navegación
- Router con lazy loading
- Breadcrumbs automáticos
- Guards de autenticación
- Deep linking support

## Estado de la Aplicación

### Global State (Zustand)
```typescript
// stores/auth.ts - Estado de autenticación
// stores/bookings.ts - Estado de reservas
// stores/ui.ts - Estado de UI (modals, loading, etc.)
```

### Server State (React Query)
- Cache inteligente de datos
- Background refetch
- Optimistic updates
- Error handling robusto

## Estilo y Theming

### Tailwind CSS
- Utility-first approach
- Custom design system
- Dark mode support (futuro)
- Componentes consistentes

### Design System
```css
/* Colores principales */
--primary: #3B82F6
--secondary: #10B981
--accent: #F59E0B
--neutral: #6B7280

/* Espaciado consistente */
--spacing-xs: 0.25rem
--spacing-sm: 0.5rem
--spacing-md: 1rem
--spacing-lg: 1.5rem
```

## Performance Metrics

### Targets
- First Contentful Paint < 1.5s
- Largest Contentful Paint < 2.5s
- Cumulative Layout Shift < 0.1
- First Input Delay < 100ms

### Optimizaciones
- Tree shaking automático
- CSS purging
- Asset compression
- CDN ready

## Contribución

1. Fork del proyecto
2. Crear feature branch: `git checkout -b feature/nueva-funcionalidad`
3. Ejecutar tests: `npm test`
4. Verificar linting: `npm run lint`
5. Commit con formato: `feat: añadir nueva funcionalidad`
6. Push y crear Pull Request

## Roadmap

### v1.0 - MVP
- [x] Setup base del proyecto
- [ ] Autenticación y autorización
- [ ] Calendario de disponibilidad
- [ ] Formulario de reservas
- [ ] Panel de usuario

### v1.1 - Mejoras
- [ ] PWA completo
- [ ] Notificaciones push
- [ ] Modo offline avanzado
- [ ] Optimizaciones de performance

### v2.0 - Features Avanzadas
- [ ] Integración de pagos
- [ ] Chat en vivo
- [ ] Dashboard analytics
- [ ] Multi-idioma

## Licencia

MIT License - ver archivo LICENSE para detalles.
