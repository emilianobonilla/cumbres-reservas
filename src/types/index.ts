// Base types
export interface Customer {
  id: string
  nombre: string
  telefono: string
  instagram?: string
  email?: string
  createdAt: Date
  updatedAt: Date
}

export interface Reservation {
  id: string
  customerId: string
  fecha: Date
  horaInicio: string
  horaFin: string
  tipoEvento: string
  cantidadPersonas: number
  precioBase: number
  descuento?: number
  tipoDescuento: 'porcentaje' | 'monto'
  montoTotal: number
  seña: number
  saldoPendiente: number
  estado: ReservationStatus
  pin: string
  notas?: string
  createdAt: Date
  updatedAt: Date
  
  // Relationships
  customer?: Customer
}

export type ReservationStatus = 
  | 'pendiente'
  | 'confirmada'
  | 'completada'
  | 'cancelada'

export interface AvailabilityRule {
  id: string
  diaSemana: number // 0 = domingo, 1 = lunes, etc.
  horaInicio: string
  horaFin: string
  precioBase: number
  activo: boolean
}

export interface BlackoutDate {
  id: string
  fecha: Date
  motivo: string
  activo: boolean
}

// Form types
export interface CreateReservationData {
  customerId?: string
  customerData?: {
    nombre: string
    telefono: string
    instagram?: string
    email?: string
  }
  fecha: Date
  horaInicio: string
  horaFin: string
  tipoEvento: string
  cantidadPersonas: number
  precioBase: number
  descuento?: number
  tipoDescuento: 'porcentaje' | 'monto'
  seña: number
  notas?: string
}

export interface UpdateReservationData extends Partial<CreateReservationData> {
  id: string
  estado?: ReservationStatus
}

// API Response types
export interface ApiResponse<T> {
  data?: T
  error?: string
  message?: string
}

export interface PaginatedResponse<T> {
  data: T[]
  totalCount: number
  page: number
  limit: number
  totalPages: number
}

// Auth types
export interface AdminUser {
  id: string
  email: string
  name?: string
  role: 'admin' | 'super_admin'
  createdAt: Date
}

// Calendar types
export interface CalendarDay {
  date: Date
  isAvailable: boolean
  hasReservation: boolean
  price?: number
  reservations: Reservation[]
}

export interface TimeSlot {
  inicio: string
  fin: string
  disponible: boolean
  precio: number
}
