# Arquitectura del Sistema

## Patrón: Clean Architecture

El sistema aplica una separación estricta de responsabilidades en capas:

```
┌─────────────────────────────────────────────────────┐
│                 Presentation Layer                   │
│         pages/ · widgets/ · providers/               │
├─────────────────────────────────────────────────────┤
│                  Business Layer                      │
│      services/ · validators/ · utils/               │
├─────────────────────────────────────────────────────┤
│                   Data Layer                         │
│     data/dao/ · data/tables/ · models/              │
├─────────────────────────────────────────────────────┤
│                Infrastructure Layer                  │
│     Firebase Auth · Firestore · Drift SQLite        │
└─────────────────────────────────────────────────────┘
```

## Flujo de datos

```
UI (pages) → Provider (state) → Service (logic) → DAO (local DB)
                                                 ↓
                                           Firebase (remote)
```

## Sincronización Offline-First

```
Usuario realiza acción
       │
       ▼
SQLite local (siempre)  ──syncStatus: 'pending'──►  Cola de sync
       │                                                  │
       ▼                                                  ▼
UI actualiza inmediatamente              SyncService (cuando hay conexión)
                                                  │
                                                  ▼
                                           Firestore
                                      syncStatus: 'synced'
```

## Diagrama de base de datos

```
usuarios ──┐
           │
insumos ───┼──── lotes ──────── movimientos
           │       │
solicitudes┘       └──── alertas
```

## Decisiones de diseño

| Decisión | Razón |
|---|---|
| Provider sobre Riverpod | Menor curva de aprendizaje, suficiente para el alcance |
| Drift sobre Hive | Soporte SQL completo, consultas complejas (FEFO) |
| GoRouter | Soporte nativo para web y deep linking |
| UUID como PK | Compatible con Firestore y evita colisiones offline |
| syncStatus field | Permite cola de sync simple sin librerías adicionales |

## Principios SOLID aplicados

- **S** – Cada clase tiene una responsabilidad (Service ≠ DAO ≠ Provider)
- **O** – Servicios extensibles por herencia o composición
- **L** – Modelos intercambiables por implementaciones compatibles  
- **I** – DAOs específicos por tabla (no un DAO genérico)
- **D** – Services dependen de abstracciones (AppDatabase, FirebaseService)
