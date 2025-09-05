#!/bin/bash

# Setup script para el entorno de desarrollo de Cumbres App
# Este script configura todo lo necesario para empezar a desarrollar

set -e  # Exit on any error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funciones de utilidad
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Verificar requisitos del sistema
check_requirements() {
    print_status "Verificando requisitos del sistema..."
    
    # Verificar Python 3.12
    if command_exists python3.12; then
        PYTHON_VERSION=$(python3.12 --version | cut -d ' ' -f 2)
        print_success "Python 3.12 encontrado: $PYTHON_VERSION"
    else
        print_error "Python 3.12 no está instalado"
        print_status "Instala Python 3.12 con: brew install python@3.12"
        exit 1
    fi
    
    # Verificar Node.js
    if command_exists node; then
        NODE_VERSION=$(node --version)
        print_success "Node.js encontrado: $NODE_VERSION"
    else
        print_error "Node.js no está instalado"
        print_status "Instala Node.js con: brew install node"
        exit 1
    fi
    
    # Verificar PostgreSQL
    if command_exists psql; then
        PSQL_VERSION=$(psql --version | cut -d ' ' -f 3)
        print_success "PostgreSQL encontrado: $PSQL_VERSION"
    else
        print_warning "PostgreSQL no está instalado localmente"
        print_status "Puedes instalarlo con: brew install postgresql@15"
        print_status "O usar Docker: docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=password postgres:15"
    fi
    
    # Verificar Redis
    if command_exists redis-server; then
        print_success "Redis encontrado"
    else
        print_warning "Redis no está instalado localmente"
        print_status "Puedes instalarlo con: brew install redis"
        print_status "O usar Docker: docker run -d -p 6379:6379 redis:7-alpine"
    fi
    
    # Verificar Git
    if command_exists git; then
        print_success "Git encontrado"
    else
        print_error "Git no está instalado"
        exit 1
    fi
}

# Setup del backend
setup_backend() {
    print_status "Configurando backend..."
    
    cd backend
    
    # Crear virtual environment si no existe
    if [ ! -d "venv" ]; then
        print_status "Creando virtual environment..."
        python3.12 -m venv venv
        print_success "Virtual environment creado"
    fi
    
    # Activar virtual environment
    print_status "Activando virtual environment..."
    source venv/bin/activate
    
    # Upgrade pip
    print_status "Actualizando pip..."
    pip install --upgrade pip
    
    # Instalar dependencias
    print_status "Instalando dependencias de Python..."
    pip install -r requirements.txt
    
    # Configurar variables de entorno
    if [ ! -f ".env" ]; then
        print_status "Creando archivo .env desde .env.example..."
        cp .env.example .env
        print_warning "Recuerda configurar las variables en backend/.env"
    fi
    
    print_success "Backend configurado correctamente"
    cd ..
}

# Setup del frontend
setup_frontend() {
    print_status "Configurando frontend..."
    
    cd frontend
    
    # Instalar dependencias
    print_status "Instalando dependencias de Node.js..."
    npm install
    
    # Configurar variables de entorno
    if [ ! -f ".env.local" ]; then
        print_status "Creando archivo .env.local..."
        cat > .env.local << EOF
VITE_API_URL=http://localhost:8000/api/v1
VITE_APP_NAME=Cumbres Reservas
VITE_APP_VERSION=1.0.0
VITE_ENVIRONMENT=development
EOF
        print_success "Archivo .env.local creado"
    fi
    
    print_success "Frontend configurado correctamente"
    cd ..
}

# Setup de Docker para servicios locales
setup_docker_services() {
    print_status "Configurando servicios con Docker..."
    
    # Crear docker-compose.yml para desarrollo
    cat > docker-compose.dev.yml << EOF
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    container_name: cumbres-postgres
    environment:
      POSTGRES_DB: cumbres_dev
      POSTGRES_USER: cumbres_user
      POSTGRES_PASSWORD: cumbres_password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U cumbres_user -d cumbres_dev"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    container_name: cumbres-redis
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
  redis_data:
EOF
    
    print_success "Docker Compose configurado para servicios de desarrollo"
}

# Setup de pre-commit hooks
setup_pre_commit() {
    print_status "Configurando pre-commit hooks..."
    
    # Crear archivo .pre-commit-config.yaml
    cat > .pre-commit-config.yaml << EOF
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-merge-conflict
      - id: check-yaml
      - id: check-json

  - repo: https://github.com/psf/black
    rev: 23.9.1
    hooks:
      - id: black
        files: ^backend/
        language_version: python3.12

  - repo: https://github.com/pycqa/isort
    rev: 5.12.0
    hooks:
      - id: isort
        files: ^backend/
        args: ["--profile", "black"]

  - repo: https://github.com/pycqa/flake8
    rev: 6.1.0
    hooks:
      - id: flake8
        files: ^backend/
        args: ["--max-line-length=88", "--extend-ignore=E203"]

  - repo: https://github.com/pre-commit/mirrors-prettier
    rev: v3.0.3
    hooks:
      - id: prettier
        files: ^frontend/
        exclude: ^frontend/dist/
EOF
    
    # Instalar pre-commit hooks
    if command_exists pre-commit; then
        pre-commit install
        print_success "Pre-commit hooks instalados"
    else
        print_warning "pre-commit no está instalado globalmente"
        print_status "Instálalo con: pip install pre-commit"
    fi
}

# Crear archivos de configuración adicionales
create_config_files() {
    print_status "Creando archivos de configuración adicionales..."
    
    # .vscode/settings.json para configuración del IDE
    mkdir -p .vscode
    cat > .vscode/settings.json << EOF
{
  "python.defaultInterpreterPath": "./backend/venv/bin/python",
  "python.terminal.activateEnvironment": true,
  "python.formatting.provider": "black",
  "python.linting.enabled": true,
  "python.linting.flake8Enabled": true,
  "typescript.preferences.importModuleSpecifier": "relative",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.organizeImports": true,
    "source.fixAll.eslint": true
  },
  "files.associations": {
    "*.css": "tailwindcss"
  },
  "emmet.includeLanguages": {
    "javascript": "javascriptreact",
    "typescript": "typescriptreact"
  }
}
EOF
    
    print_success "Configuración de VS Code creada"
}

# Función principal
main() {
    print_status "Iniciando setup del entorno de desarrollo de Cumbres App"
    echo ""
    
    check_requirements
    echo ""
    
    setup_backend
    echo ""
    
    setup_frontend
    echo ""
    
    setup_docker_services
    echo ""
    
    setup_pre_commit
    echo ""
    
    create_config_files
    echo ""
    
    print_success "Setup completado exitosamente!"
    echo ""
    print_status "Próximos pasos:"
    echo "1. Configurar las variables de entorno en backend/.env"
    echo "2. Iniciar servicios de base de datos:"
    echo "   docker-compose -f docker-compose.dev.yml up -d"
    echo "3. Ejecutar migraciones de base de datos:"
    echo "   cd backend && source venv/bin/activate && alembic upgrade head"
    echo "4. Iniciar el backend:"
    echo "   cd backend && source venv/bin/activate && uvicorn app.main:app --reload"
    echo "5. Iniciar el frontend:"
    echo "   cd frontend && npm run dev"
    echo ""
    print_status "La aplicación estará disponible en:"
    echo "- Frontend: http://localhost:5173"
    echo "- Backend API: http://localhost:8000"
    echo "- API Docs: http://localhost:8000/docs"
}

# Ejecutar función principal
main "$@"
