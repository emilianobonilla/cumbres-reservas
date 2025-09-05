# Makefile para Cumbres Reservas
# Comandos de desarrollo simplificados

.PHONY: help install dev dev-docker build test clean

# Variables
DOCKER_COMPOSE_DEV = docker-compose -f docker-compose.dev.yml
DOCKER_SERVICE = app

help: ## Mostrar ayuda
	@echo "Comandos disponibles:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Instalar dependencias
	npm ci

dev: ## Desarrollo local (sin Docker)
	npm run dev

dev-docker: ## Desarrollo con Docker (recomendado para Apple Silicon)
	$(DOCKER_COMPOSE_DEV) up --build

dev-docker-bg: ## Desarrollo con Docker en background
	$(DOCKER_COMPOSE_DEV) up --build -d

stop: ## Parar contenedores Docker
	$(DOCKER_COMPOSE_DEV) down

logs: ## Ver logs de la aplicación
	$(DOCKER_COMPOSE_DEV) logs -f $(DOCKER_SERVICE)

shell: ## Abrir shell en el contenedor de la app
	$(DOCKER_COMPOSE_DEV) exec $(DOCKER_SERVICE) /bin/sh

db-shell: ## Abrir psql en la base de datos
	$(DOCKER_COMPOSE_DEV) exec postgres psql -U postgres -d cumbres_reservas_dev

build: ## Build para producción
	npm run build

test: ## Ejecutar tests
	npm run test

test-docker: ## Ejecutar tests en Docker
	$(DOCKER_COMPOSE_DEV) exec $(DOCKER_SERVICE) npm run test

lint: ## Ejecutar linter
	npm run lint

lint-fix: ## Ejecutar linter con fix automático
	npm run lint:fix

type-check: ## Verificar tipos TypeScript
	npm run type-check

db-migrate: ## Ejecutar migraciones de base de datos
	npm run db:push

db-studio: ## Abrir Drizzle Studio
	npm run db:studio

clean: ## Limpiar contenedores y volúmenes
	$(DOCKER_COMPOSE_DEV) down -v --remove-orphans
	docker system prune -f

reset: ## Reset completo (limpiar + instalar + build)
	make clean
	make install
	make build

# Comandos para CI/CD
ci-test: ## Ejecutar suite completa de CI
	npm run type-check
	npm run lint
	npm run test
	npm run build

# Comandos Git útiles
git-setup: ## Setup inicial de git flow
	git checkout -b develop 2>/dev/null || git checkout develop
	git push -u origin develop 2>/dev/null || echo "develop branch already exists"

feature: ## Crear nueva rama feature (uso: make feature name=mi-feature)
	@if [ -z "$(name)" ]; then echo "Error: Especifica el nombre de la feature con 'make feature name=mi-feature'"; exit 1; fi
	git checkout develop
	git pull origin develop
	git checkout -b feature/$(name)
	@echo "✅ Rama feature/$(name) creada desde develop"

# Comandos de Docker para diferentes ambientes
docker-dev: ## Build imagen Docker para desarrollo
	docker build -f Dockerfile.dev -t cumbres-reservas:dev .

docker-prod: ## Build imagen Docker para producción
	docker build -f Dockerfile -t cumbres-reservas:prod .
