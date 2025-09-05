# Casos de Uso y Requerimientos Funcionales

## Actores del Sistema

### 1. Cliente/Usuario Final
- **Descripción**: Persona que desea reservar el salón para un evento
- **Características**: 
  - Puede ser usuario registrado o invitado
  - Accede principalmente desde dispositivo móvil
  - Busca simplicidad y rapidez en el proceso

### 2. Administrador del Salón
- **Descripción**: Propietario o encargado del salón de eventos
- **Características**:
  - Tiene acceso completo al sistema
  - Gestiona las reservas y configuraciones
  - Necesita reportes y estadísticas

### 3. Sistema de Notificaciones
- **Descripción**: Actor automático que envía notificaciones
- **Características**:
  - Envía emails y SMS automáticos
  - Procesa recordatorios programados

## Casos de Uso Detallados

### CU01: Consultar Disponibilidad
**Actor Principal**: Cliente  
**Precondiciones**: El sistema está disponible  
**Postcondiciones**: El cliente conoce la disponibilidad del salón  

**Flujo Principal**:
1. El cliente accede al calendario de disponibilidad
2. El sistema muestra los próximos 6 meses
3. El cliente selecciona una fecha
4. El sistema muestra los horarios disponibles para esa fecha
5. El cliente puede ver el precio base para cada horario

**Flujos Alternativos**:
- 3a. La fecha seleccionada no está disponible
  - 3a1. El sistema muestra fechas alternativas cercanas
- 4a. No hay horarios disponibles
  - 4a1. El sistema sugiere fechas alternativas

**Criterios de Aceptación**:
- El calendario debe cargar en menos de 2 segundos
- Debe ser responsive y usable en móvil
- Los precios deben mostrarse claramente
- Debe indicar claramente qué fechas/horarios no están disponibles

### CU02: Realizar Reserva
**Actor Principal**: Cliente  
**Precondiciones**: Hay disponibilidad en la fecha/hora deseada  
**Postcondiciones**: La reserva queda registrada en el sistema  

**Flujo Principal**:
1. El cliente selecciona fecha y horario disponible
2. El sistema solicita datos del evento (tipo, cantidad de personas, servicios adicionales)
3. El cliente completa los datos del evento
4. El sistema calcula el precio total
5. El cliente revisa el resumen de la reserva
6. El cliente ingresa sus datos personales (si no está registrado)
7. El cliente confirma la reserva
8. El sistema registra la reserva con estado "Pendiente"
9. El sistema envía email de confirmación

**Flujos Alternativos**:
- 6a. El cliente ya está registrado
  - 6a1. El sistema precarga sus datos
- 7a. El cliente cancela antes de confirmar
  - 7a1. El sistema descarta los datos temporales
- 8a. Error en el registro
  - 8a1. El sistema muestra mensaje de error y permite reintentar

**Criterios de Aceptación**:
- El proceso completo no debe tomar más de 5 minutos
- Todos los campos requeridos deben estar validados
- La reserva debe quedar registrada con un ID único
- El email de confirmación debe enviarse en menos de 1 minuto

### CU03: Modificar Reserva
**Actor Principal**: Cliente  
**Precondiciones**: El cliente tiene una reserva existente y está dentro del plazo de modificación  
**Postcondiciones**: La reserva queda modificada según los nuevos datos  

**Flujo Principal**:
1. El cliente accede a "Mis Reservas"
2. El sistema muestra las reservas del cliente
3. El cliente selecciona la reserva a modificar
4. El sistema verifica que esté dentro del plazo de modificación
5. El sistema muestra los datos actuales de la reserva
6. El cliente modifica los datos permitidos
7. El sistema valida la nueva información
8. El sistema actualiza la reserva
9. El sistema envía notificación de modificación

**Flujos Alternativos**:
- 4a. La reserva no se puede modificar (fuera de plazo)
  - 4a1. El sistema informa la razón y sugiere contactar al administrador
- 7a. Los nuevos datos no son válidos
  - 7a1. El sistema muestra errores específicos

**Criterios de Aceptación**:
- Solo se pueden modificar reservas hasta 48hs antes del evento
- Los cambios de fecha están sujetos a disponibilidad
- Se debe notificar tanto al cliente como al administrador

### CU04: Cancelar Reserva
**Actor Principal**: Cliente  
**Precondiciones**: El cliente tiene una reserva existente  
**Postcondiciones**: La reserva queda cancelada y la disponibilidad se libera  

**Flujo Principal**:
1. El cliente accede a "Mis Reservas"
2. El cliente selecciona la reserva a cancelar
3. El sistema muestra los términos de cancelación y posibles penalidades
4. El cliente confirma la cancelación
5. El sistema cambia el estado de la reserva a "Cancelada"
6. El sistema libera la disponibilidad
7. El sistema procesa reembolso según política
8. El sistema notifica la cancelación

**Flujos Alternativos**:
- 4a. El cliente decide no cancelar
  - 4a1. El sistema regresa a la vista de reservas
- 7a. No aplica reembolso según política
  - 7a1. El sistema informa al cliente

**Criterios de Aceptación**:
- Las políticas de cancelación deben estar claras antes de confirmar
- La disponibilidad debe liberarse inmediatamente
- Las notificaciones deben enviarse a ambas partes

### CU05: Gestionar Reservas (Administrador)
**Actor Principal**: Administrador  
**Precondiciones**: El administrador está autenticado  
**Postcondiciones**: Las reservas quedan gestionadas según las acciones realizadas  

**Flujo Principal**:
1. El administrador accede al panel de administración
2. El sistema muestra todas las reservas con filtros
3. El administrador puede filtrar por estado, fecha, cliente
4. El administrador selecciona una reserva específica
5. El administrador puede aprobar/rechazar/modificar la reserva
6. El sistema actualiza el estado de la reserva
7. El sistema notifica al cliente sobre los cambios

**Flujos Alternativos**:
- 5a. Rechazar reserva
  - 5a1. El administrador debe proporcionar razón del rechazo
- 5b. Modificar reserva
  - 5b1. El sistema valida que los nuevos datos sean correctos

**Criterios de Aceptación**:
- El panel debe mostrar máximo 50 reservas por página
- Todos los cambios deben quedar registrados en un log de auditoría
- Las notificaciones al cliente deben ser inmediatas

### CU06: Configurar Disponibilidad y Precios
**Actor Principal**: Administrador  
**Precondiciones**: El administrador está autenticado  
**Postcondiciones**: La configuración queda actualizada en el sistema  

**Flujo Principal**:
1. El administrador accede a "Configuración"
2. El sistema muestra las configuraciones actuales
3. El administrador puede modificar:
   - Horarios disponibles por día de semana
   - Precios base por horario/tipo de evento
   - Días no laborables/bloqueados
   - Políticas de cancelación
4. El administrador guarda los cambios
5. El sistema valida la consistencia de la configuración
6. El sistema aplica los cambios

**Flujos Alternativos**:
- 5a. Configuración inconsistente
  - 5a1. El sistema muestra errores específicos y no guarda

**Criterios de Aceptación**:
- Los cambios deben aplicarse inmediatamente
- No debe permitir configuraciones que generen conflictos
- Debe validar que los precios sean valores positivos

## Requerimientos No Funcionales

### Rendimiento
- La aplicación debe cargar en menos de 3 segundos en 3G
- Las consultas de disponibilidad deben responder en menos de 1 segundo
- El sistema debe soportar al menos 100 usuarios concurrentes

### Usabilidad
- La interfaz debe ser completamente usable en pantallas de 320px de ancho
- El proceso de reserva completo no debe requerir más de 10 toques/clics
- Los formularios deben tener validación en tiempo real

### Seguridad
- Todas las comunicaciones deben usar HTTPS
- Los datos personales deben estar encriptados
- Las sesiones deben expirar después de 2 horas de inactividad

### Disponibilidad
- El sistema debe tener 99.5% de disponibilidad
- Debe funcionar offline para consultas básicas (PWA)
- Los backups deben realizarse diariamente

### Compatibilidad
- Soporte para iOS Safari 14+, Chrome 90+, Firefox 88+
- Responsive design para pantallas de 320px a 1920px
- Funcionalidad PWA para instalación en móvil

## Casos de Uso Futuros (Fase 2)

### CU07: Procesar Pagos Online
- Integración con Mercado Pago
- Gestión de señas y pagos completos
- Facturación electrónica automática

### CU08: Sistema de Notificaciones Avanzado
- Notificaciones push
- SMS automáticos
- Recordatorios personalizables

### CU09: Reportes y Analytics
- Dashboard con métricas clave
- Reportes de ingresos
- Análisis de ocupación
- Exportación de datos

### CU10: Gestión de Lista de Espera
- Registro en lista de espera para fechas ocupadas
- Notificación automática cuando se libere cupo
- Priorización de clientes frecuentes

---

*Documento actualizado: 04/09/2024*
