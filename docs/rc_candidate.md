# Release Candidate - Gestión de Inventario de Laboratorio

**Equipo 6**
**Versión candidata:** 1.0.0-rc1
**Fecha de evaluación:** 01/06/2026
**Evaluado por:** Juana Rincon-Steven Ceballos-Jorge Bedoya- Brahian

---

## 1. Información de la versión

| Campo | Detalle |
|---|---|
| Versión | 1.0.0-rc1 |
| Branch | main / release |
| Commit | [hash del último commit] |
| APK generado | Sí  |
| Fecha de build | [03/06/2026] |

---

## 2. Funcionalidades incluidas

### Autenticación y sesión
- [x] Login con Firebase Auth (correo y contraseña)
- [x] Validación de campos en login
- [x] Cierre de sesión
- [x] Validación de sesión activa al abrir la app
- [x] Redirección según estado de cuenta (active / blocked / pendingApproval)
- [x] Redirección según rol (docente / auxiliar / administrador)

### Perfil de usuario
- [x] Consulta del perfil en Firestore (colección users/{uid})
- [x] Lectura de rol y estado de cuenta
- [x] Actualización de lastLoginAt

### Roles y permisos
- [x] Rol docente: crear solicitudes, ver insumos, ver alertas
- [x] Rol auxiliar: crear y editar insumos, agregar lotes, ver solicitudes
- [x] Rol administrador: aprobar/rechazar solicitudes, gestionar insumos, gestionar usuarios
- [x] PermissionService separado de la interfaz gráfica

### Módulo de insumos
- [x] Listado de insumos con stock y estado
- [x] Creación de insumos (auxiliar y administrador)
- [x] Edición de insumos
- [x] Cambio de estado del insumo (administrador)
- [x] Eliminación de insumos (administrador)
- [x] Agregar lotes con cantidad y fecha de vencimiento

### Módulo de solicitudes
- [x] Creación de solicitud por docente
- [x] Validación de stock disponible antes de crear solicitud
- [x] Listado de solicitudes propias (docente)
- [x] Listado de todas las solicitudes (auxiliar y administrador)
- [x] Aprobación de solicitud (administrador)
- [x] Rechazo de solicitud con motivo obligatorio (administrador)
- [x] Descuento de stock al aprobar solicitud

### Módulo de alertas
- [x] Alerta por stock bajo
- [x] Alerta por lote próximo a vencer
- [x] Alerta por lote vencido

### Persistencia local y sincronización
- [x] Almacenamiento local con Drift/SQLite
- [x] Campo syncStatus en registros (synced / pendingSync / failedSync)
- [x] Guardado local cuando Firebase falla
- [x] Sincronización al recuperar conexión
- [x] Indicador visual de registros pendientes de sincronización

### Pruebas automatizadas
- [x] Mínimo 6 unit tests implementados
- [x] Mínimo 4 widget tests implementados

### Documentación
- [x] README.md completo
- [x] docs/pruebas.md
- [x] docs/rc_candidate.md
- [x] docs/release_checklist.md
- [x] docs/bugs-backlog.md

---

## 3. Funcionalidades pendientes o incompletas

| Funcionalidad | Motivo | Impacto |
|---|---|---|
| Sincronización automática en background (segundo plano con la app cerrada) | Fuera del alcance del curso por limitaciones de tiempo y compatibilidad de plugins nativos en Android. | Bajo — la sincronización reactiva funciona inmediatamente al abrir la app o recuperar conexión con ella activa |
| [Sistema dinámico de alertas visuales en el Dashboard para lotes próximos a vencer] |Se postergó para dar prioridad absoluta a la estabilización de las transiciones de las estructuras Companion de Drift. |Bajo — la información de vencimiento es visible de igual forma dentro del detalle de cada lote. |

---

## 4. Riesgos conocidos

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| Reglas de Firestore permisivas en ambiente de pruebas | Media | Alto | Revisar firestore.rules antes de entrega |
| Sincronización puede fallar si el usuario cierra la app antes de reconectar |
| [Baja] |Medio | |El registro queda con estado pending de forma segura en SQLite y el SyncService reintenta el proceso al próximo inicio. |
| Desborde de memoria local por acumulación de logs e historial de movimientos | Baja | Baja | Implementar un script de purga automática de movimientos locales con antigüedad mayor a 90 días en futuras versiones. |

---

## 5. Decisión del equipo

**¿Está lista para entrega?**

- [ ] Sí, cumple todos los requisitos obligatorios
- [x ] Sí, con observaciones menores (ver sección de pendientes)
- [ ] No, faltan funcionalidades críticas

**Justificación:**
El sistema de Gestión de Inventario de Laboratorio ha alcanzado la madurez necesaria para su explotación en un entorno controlado de pruebas. La arquitectura Offline-First se encuentra completamente implementada y validada mediante la base de datos local Drift, garantizando que el personal de laboratorio (laboratoristas y docentes) pueda registrar insumos, lotes y solicitudes sin depender de la estabilidad de la red del campus.

Los componentes críticos de negocio, incluyendo la estrategia de despacho FEFO y la consistencia de inventario ante solicitudes aprobadas, están blindados tanto por validadores analíticos como por una robusta suite de pruebas unitarias y de widgets en verde (100% passed). Las omisiones detalladas en la sección 3 no comprometen el núcleo operativo del sistema (MVP) y los riesgos identificados cuentan con planes de contingencia claros y mitigaciones técnicas ejecutadas. El equipo dictamina de forma unánime que el entregable cumple con los estándares de calidad exigidos por la asignatura.

**Firma del equipo:**
- Juana Rincon
- Steven Ceballos
- Jorge Bedoya
-Brahian