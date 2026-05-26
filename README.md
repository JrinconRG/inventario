# Sistema de Gestión de Inventario de Laboratorio con Control de Lotes

Sistema profesional de gestión de inventario para laboratorios académicos, desarrollado con **Flutter**, **Firebase** y **Drift SQLite**.

## Tecnologías

| Componente | Tecnología |
|---|---|
| Framework | Flutter 3.x |
| Autenticación | Firebase Auth |
| Base de datos remota | Cloud Firestore |
| Base de datos local | Drift (SQLite) |
| Manejo de estado | Provider |
| Navegación | GoRouter |
| Plataformas | Android · Web · Windows |

## Funcionalidades principales

- **Autenticación** — Login, registro, recuperación de contraseña, roles (Administrador, Laboratorista, Docente)
- **Inventario** — CRUD de insumos con stock, categoría, unidad de medida y estado
- **Lotes** — Control de lotes con FEFO (*First Expire, First Out*), fechas de ingreso y vencimiento
- **Movimientos** — Registro de entradas, salidas y ajustes con trazabilidad completa
- **Solicitudes** — Flujo de solicitud → aprobación/rechazo con descuento automático de stock
- **Alertas** — Generación automática de alertas de stock bajo, lotes vencidos y próximos a vencer
- **Sincronización** — Offline-first con cola de sincronización a Firestore

## Configuración inicial

### 1. Crear el proyecto Firebase

1. Ve a [console.firebase.google.com](https://console.firebase.google.com)
2. Crea un nuevo proyecto
3. Habilita **Authentication** (Email/Password)
4. Crea la base de datos **Cloud Firestore**
5. Aplica las reglas de seguridad desde `firestore.rules`

### 2. Conectar Flutter con Firebase

```bash
# Instalar FlutterFire CLI
dart pub global activate flutterfire_cli

# Configurar el proyecto (reemplaza tu-proyecto-id)
flutterfire configure --project=tu-proyecto-id
```

Esto generará automáticamente `lib/firebase_options.dart` con tus valores reales.

### 3. Instalar dependencias

```bash
flutter pub get
```

### 4. Generar código de Drift

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Este comando genera los archivos `*.g.dart` necesarios para Drift.

### 5. Ejecutar la aplicación

```bash
# Android
flutter run -d android

# Windows
flutter run -d windows

# Web
flutter run -d chrome
```

## Estructura del proyecto

```
lib/
├── main.dart                    # Punto de entrada
├── firebase_options.dart        # Config Firebase (generado por FlutterFire)
├── config/
│   ├── routes.dart              # Navegación con GoRouter
│   ├── theme.dart               # Material 3 theme
│   └── constants.dart           # Constantes globales
├── data/
│   ├── app_database.dart        # Clase principal Drift
│   ├── tables/                  # Definición de tablas
│   └── dao/                     # Data Access Objects
├── models/                      # Modelos de dominio
├── services/                    # Lógica de negocio
├── validators/                  # Validaciones de formularios
├── providers/                   # Estado con ChangeNotifier
├── pages/                       # Pantallas de la aplicación
├── widgets/                     # Componentes reutilizables
└── utils/                       # Helpers, enums, formatters
```

## Roles de usuario

| Rol | Permisos |
|---|---|
| Administrador | Todo: CRUD inventario, aprobar/rechazar solicitudes, gestión de usuarios |
| Laboratorista | Ver y editar inventario, registrar lotes y movimientos |
| Docente | Ver inventario, crear solicitudes |

## Arquitectura FEFO

Los lotes se ordenan automáticamente por fecha de vencimiento (el que vence antes se usa primero). Al aprobar una solicitud, el sistema descuenta automáticamente del lote más próximo a vencer.

## Tests

```bash
flutter test
```

Los tests cubren:
- Validadores de formularios
- Lógica de modelos (isCritico, isVencido, isProximoAVencer)
- Helpers de utilidades
- Tests básicos de widgets
