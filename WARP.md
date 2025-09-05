# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

Sistema de Reservas - Salón de Eventos: A mobile-first web application for managing event venue reservations with separate frontend and backend applications.

**Key Business Context:**
- Event venue reservation system
- Mobile-first design for customers
- Admin panel for venue owner
- Customers access reservations via unique PIN codes (no login required)
- PostgreSQL database hosted on Supabase
- Target deployment on Azure infrastructure

## Architecture

This is a full-stack Next.js application with integrated frontend and backend:

### Full-Stack Framework (Next.js)
- **Location**: `src/app/`
- **Framework**: Next.js 14 with App Router
- **Language**: TypeScript 5
- **API**: Next.js API Routes (backend)
- **Frontend**: React 19 with RSC (React Server Components)
- **Styling**: Tailwind CSS 4 with mobile-first approach
- **Components**: shadcn/ui + Radix UI primitives

### State & Data Management
- **Global State**: Zustand
- **Server State**: TanStack Query (React Query)
- **Forms**: React Hook Form + Zod validation
- **ORM**: Drizzle ORM + Drizzle Kit
- **Database**: PostgreSQL (Supabase)
- **Authentication**: Supabase Auth

### Key Architectural Patterns
- **Monorepo**: Frontend and backend in separate directories
- **API-first**: REST API with OpenAPI documentation
- **Event-driven**: Background tasks for notifications
- **Mobile-first**: Responsive design prioritizing mobile UX
- **PIN-based access**: Customers use unique codes instead of traditional auth

## Development Commands

### Setup
```bash
# Install dependencies
npm install

# Configure environment variables
cp .env.example .env.local

# Setup database
npm run db:push               # Push schema to Supabase
```

### Development
```bash
# Development server (includes frontend + API)
npm run dev                   # Start dev server (http://localhost:3000)

# Database operations
npm run db:generate           # Generate migrations
npm run db:migrate            # Apply migrations
npm run db:push               # Push schema to database
npm run db:studio             # Open Drizzle Studio

# Build and deployment
npm run build                 # Production build
npm run start                 # Start production server
```

### Testing
```bash
npm run test                  # Unit tests with Vitest
npm run test:watch            # Tests in watch mode
npm run test:coverage         # Coverage report
```

### Code Quality
```bash
npm run lint                  # ESLint check
npm run lint:fix              # Auto-fix linting issues
npm run type-check            # TypeScript validation
```

## Key Business Logic

### User Types & Access Patterns
- **Customers**: Access via PIN codes, view their reservations only
- **Administrators**: Full CRUD access, manage all reservations and system configuration

### Core Entities
- **Reservations**: Date, time, event details, customer info, pricing, payment status
- **Customers**: Name, phone, Instagram profile (optional)
- **Availability**: Calendar-based with configurable pricing and blackout dates
- **Discounts**: Percentage or fixed amount discounts

### Important Workflows
1. **Reservation Creation**: Admin creates reservation → System generates PIN → Customer receives notification
2. **Customer Access**: Customer enters PIN → Views reservation details
3. **Payment Tracking**: Admin records payments/deposits → Updates reservation status
4. **Availability Management**: Admin configures available dates, pricing, and restrictions

## Testing Strategy

### Frontend Testing
- **Unit Tests**: Components and utilities with Vitest
- **Integration Tests**: React Testing Library for user interactions
- **E2E Tests**: Playwright for critical user journeys
- **Visual Tests**: Component stories and visual regression

### Backend Testing
- **Unit Tests**: Business logic and utilities with pytest
- **API Tests**: FastAPI TestClient for endpoint testing
- **Database Tests**: Test database with fixtures
- **Integration Tests**: Full workflow testing

### Test Data
- Use factories/fixtures for consistent test data
- Separate test database (cumbres_test)
- Mock external services (email, SMS)

## Environment Setup

### Required Services
- **Node.js 18+**: Runtime for Next.js
- **Supabase Account**: Database and authentication
- **Vercel Account**: Deployment (optional for local dev)

### Environment Variables
Root (`.env.local`):
```
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-supabase-service-role-key

# Database
DATABASE_URL=postgresql://postgres:password@localhost:5432/cumbres_reservas

# App Configuration  
NEXT_PUBLIC_APP_NAME=Cumbres Reservas
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

## Common Development Tasks

### Adding New API Endpoints
1. Create Pydantic schema in `backend/app/schemas/`
2. Add database model in `backend/app/models/`
3. Implement business logic in `backend/app/services/`
4. Create API endpoint in `backend/app/api/`
5. Add tests in `backend/tests/`

### Adding New Frontend Features  
1. Create TypeScript types in `frontend/src/types/`
2. Implement API service in `frontend/src/services/`
3. Create components in `frontend/src/components/`
4. Add pages/routes in `frontend/src/pages/`
5. Update global state if needed in `frontend/src/stores/`
6. Add tests in `frontend/tests/`

### Database Schema Changes
1. Create migration: `alembic revision --autogenerate -m "description"`
2. Review generated migration file
3. Apply migration: `alembic upgrade head`
4. Update models and schemas accordingly
5. Add tests for new schema

## Deployment Notes

- **Target Platform**: Vercel (Frontend + API Routes)
- **Database**: Supabase PostgreSQL
- **CI/CD**: GitHub Actions + Vercel (automatic deployment)
- **Monitoring**: Vercel Analytics and observability
- **CDN**: Vercel Edge Network

## Development Guidelines

- **Mobile-First**: Always design for mobile screens first
- **PIN Security**: Ensure PIN generation is cryptographically secure
- **Spanish Language**: UI text and error messages in Spanish
- **Performance**: Optimize for slow mobile connections
- **Accessibility**: Follow WCAG guidelines for inclusive design
- **Data Privacy**: Handle customer data according to privacy requirements
