# Sistema de Gestión de Inventario de Laboratorio

## Nombre del proyecto

**Inventario de Laboratorio** (`lab_inventory`)

## Descripción del problema

Este proyecto resuelve la necesidad de gestionar inventario de laboratorio académico con control de lotes, control de stock y procesos de solicitud y aprobación. Permite operar en modo offline, almacenar datos localmente, y sincronizar con Firebase cuando hay conexión.

## Integrantes del equipo

- Juana Rincon
- Steven Ceballos
- Jorge Bedoya
- Brahian

## Roles implementados

- **Administrador**
- **Laboratorista**
- **Docente**

## Usuarios de prueba


- **Administrador**
  - Email: `admin@example.com`
  - Contraseña: `Admin12345`
  -estado: Activo

- **Laboratorista**
  - Email: `laboratorista@gmail.com`
  - Contraseña: `12345678C`
  - estado:  pending-approval
  -Que permite validar : Acceso restringido

- **Laboratorista**
- Email: `laboratorista@test.com`
  - Contraseña: `12345678C`
  - estado:  activo
 

- **Docente**
  - Email: `docente@example.com`
  - Contraseña: `Docente1234`

  -Email: bloqueado@test.com
  - estado:  blocked
  -Que permite validar : Acceso bloqueado


## Entidades principales

- `UsuarioModel` — datos de usuario, rol y estado de cuenta.
- `InsumoModel` — insumo de laboratorio con stock, categoría, unidad y estado.
- `LoteModel` — lote asociado a un insumo con fechas de ingreso y vencimiento.
- `SolicitudModel` — solicitud de insumos, estado, motivo, observaciones y sincronización.
- `MovimientoModel` — entradas, salidas y ajustes de stock.

## Explicación del modelo en Firestore

La aplicación utiliza las siguientes colecciones principales en Firestore:

- `users/{uid}`
  - `id`, `email`, `nombre`, `apellido`, `rol`, `activo`, `createdAt`, `updatedAt`
- `insumos/{id}`
  - `nombre`, `categoria`, `stockTotal`, `stockMinimo`, `unidadMedida`, `estado`, `syncStatus`
- `lotes/{id}`
  - `insumoId`, `numeroLote`, `fechaIngreso`, `fechaVencimiento`, `cantidad`, `proveedor`, `syncStatus`
- `movimientos/{id}`
  - `insumoId`, `tipo`, `cantidad`, `motivo`, `fecha`, `syncStatus`
- `solicitudes/{id}`
  - `insumoId`, `insumoNombre`, `cantidadSolicitada`, `solicitanteId`, `solicitanteNombre`, `estado`, `motivo`, `observacionesAdmin`, `fechaSolicitud`, `fechaRespuesta`, `syncStatus`

Cada entidad localizada en SQLite mantiene el campo `syncStatus` para indicar si el registro está sincronizado o pendiente.

## Reglas de negocio

- Solo un **docente** puede crear solicitudes de insumos.
- Solo un **administrador** puede aprobar o rechazar solicitudes.
- Una solicitud rechazada debe incluir un motivo válido y no puede aprobarse sin él.
- El sistema valida que la cantidad solicitada no exceda el stock disponible.
- El stock se descuenta automáticamente al aprobar una solicitud.
- El usuario con `activo = false` está bloqueado y no puede acceder al módulo principal.
- El usuario pendiente de aprobación no puede crear solicitudes.
- Lotes vencidos se consideran en alertas y no deben usarse para salida activa.
- Cada registro creado sin conexión queda marcado como pendiente de sincronización.

## Estados de negocio

### Usuario
estadoCuenta:
- `activo` — usuario autorizado para operar.
- `blocked`  — acceso bloqueado.
- `pendingApproval` — usuario en espera de autorización.

### Solicitud

- `pendiente` — solicitud en espera de revisión.
- `aprobada` — solicitud aceptada y stock descontado.
- `rechazada` — solicitud denegada con motivo.

### Sincronización

- `pending` / `pendingSync` — registro creado localmente, pendiente de enviar a Firebase.
- `synced` — registro sincronizado con Firebase.
- `failed` — registro con error de sincronización.

### Insumo

- `activo`
- `inactivo`
- `agotado`

## Flujo principal

1. El usuario inicia sesión con email y contraseña.
2. La app carga el perfil desde Firestore y ajusta permisos según rol.
3. El docente navega al módulo de solicitudes y crea una nueva solicitud.
4. La solicitud se guarda primero en la base local y se marca como `pending`.
5. El administrador revisa la solicitud, la aprueba o rechaza.
6. Al aprobarla, el stock se descuenta del insumo correspondiente.
7. Al reconectar, el sistema sincroniza registros locales pendientes con Firebase.

## Explicación de autenticación

- La app usa **Firebase Authentication** con proveedor de correo y contraseña.
- `AuthProvider` mantiene el estado de sesión y escucha cambios de autenticación.
- Al iniciar sesión, se carga el perfil del usuario desde Firebase Firestore.
- Si no existe el perfil de usuario, la sesión se considera no autenticada.

## Explicación de roles y permisos

- **Administrador**
  - Puede ver y gestionar todos los insumos.
  - Puede aprobar y rechazar solicitudes.
  - Puede gestionar usuarios y permisos.
- **Laboratorista**
  - Puede crear y editar insumos.
  - Puede registrar lotes y movimientos de stock.
  - Puede ver solicitudes, pero no aprobarlas.
- **Docente**
  - Puede consultar inventario.
  - Puede crear solicitudes de insumos.
  - Solo ve sus propias solicitudes.

El código define accesos usando `AuthProvider` y propiedades como `isAdmin`, `isDocente` y `canCreateSolicitudes`.

## Explicación de persistencia local

- Se utiliza **Drift** (SQLite) como base de datos local.
- La aplicación lee datos desde la BD local en primer lugar para mantener la UI responsiva.
- Cada entidad sincronizable tiene un campo `syncStatus`.
- Operaciones locales quedan guardadas aunque no haya conexión.

## Explicación de sincronización con Firebase

- `SyncService` es el componente encargado de enviar datos pendientes a Firestore.
- El flujo es:
  1. Guardar localmente con `syncStatus = pending`.
  2. Intentar subir el registro a Firestore.
  3. Si la subida tiene éxito, marcar como `synced`.
  4. Si falla, marcar como `failed` y mantener el registro local.
- Al recuperar conexión, la app reintenta sincronizar los registros pendientes.
- Las pantallas muestran indicadores visuales de sincronización (`Pendiente`, `Error`, `Sincronizado`).

## Instrucciones para ejecutar el proyecto

1. Abre una terminal en la carpeta del proyecto.
2. Instala dependencias:

```bash
flutter pub get
```

3. Genera código de Drift:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Ejecuta la aplicación:

```bash
# Android
flutter run -d android

# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

5. Para ejecutar los tests:

```bash
flutter test
```

## Instrucciones para generar o instalar el APK

1. Genera el APK de release:

```bash
flutter build apk --release
```

2. El archivo se ubicará en:

```bash
build/app/outputs/flutter-apk/app-release.apk
```

3. Instálalo en un dispositivo Android conectado:

```bash
flutter install
```


## Notas adicionales

- Si cambias las tablas de Drift, ejecuta de nuevo `build_runner`.
- Asegúrate de que `lib/firebase_options.dart` esté configurado con tu proyecto Firebase.
- El archivo `firestore.rules` debe aplicarse al proyecto para proteger las colecciones.

---

## Referencias rápidas

- `lib/main.dart` — punto de entrada
- `lib/providers/auth_provider.dart` — lógica de autenticación y roles
- `lib/services/sync_service.dart` — sincronización offline/online
- `lib/models/solicitud_model.dart` — modelo de solicitud y `syncStatus`
- `lib/widgets/sync_status_badge.dart` — indicador visual de sincronización

