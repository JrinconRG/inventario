# Release Checklist - Gestión de Inventario de Laboratorio

**Equipo 6**
**Versión:** 1.0.0-rc1
**Fecha:** [fecha]
**Responsable de verificación:** [nombre]

---

## 1. Compilación y build

| Ítem | Estado | Notas |
|---|---|---|
| La app compila sin errores (`flutter build apk`) | ✅  | |
| La app compila sin warnings críticos | ✅ / | |
| APK generado correctamente | ✅  | |
| APK instalado y probado en dispositivo o emulador físico | ✅  | |
| `google-services.json` presente en `android/app/`| ✅  | |
| `firebase_options.dart` presente en `lib/` | ✅  |

---

## 2. Autenticación

| Ítem | Estado | Notas |
|---|---|---|
| Login con correo y contraseña funciona | ✅  | |
| Validación de campos en login funciona | ✅  |
| Cierre de sesión funciona | ✅ | |
| Al abrir la app con sesión activa, no pide login nuevamente | ✅  | |
| Usuario blocked ve pantalla de acceso bloqueado | ✅  |
| Usuario pendingApproval ve pantalla de espera | ✅  |
| Usuario active es redirigido según su rol | ✅  |

---

## 3. Roles

| Ítem | Estado | Notas |
|---|---|---|
| Docente solo ve sus propias solicitudes | ✅  |
| Docente no puede crear insumos | ✅  |
| Auxiliar puede crear insumos y agregar lotes | ✅  |
| Auxiliar no puede aprobar solicitudes | ✅ |
| Administrador puede aprobar y rechazar solicitudes | ✅  |
| Administrador puede cambiar estado de insumos | ✅ |
| Administrador puede eliminar insumos | ✅  |
| Administrador puede gestionar usuarios |  ❌  |
| PermissionService valida permisos separado de la UI |  ❌ | |

---

## 4. Firestore

| Ítem | Estado | Notas |
|---|---|---|
| Lectura de perfil de usuario desde `users/{uid}` funciona | ✅  |
| Lectura de insumos desde Firestore funciona | ✅  |
| Escritura de nuevas solicitudes en Firestore funciona | ✅  |
| Aprobación de solicitud actualiza Firestore correctamente | ✅  |
| Rechazo de solicitud no modifica el stock | ✅ |
| Datos filtrados según rol del usuario | ✅ |
| Errores de permisos o conexión son manejados sin crash | ✅ |
| `firestore.rules` configurado correctamente | ✅ | |

---

## 5. Persistencia local

| Ítem | Estado | Notas |
|---|---|---|
| Datos se guardan localmente con Drift/SQLite | ✅  |
| Al abrir la app sin conexión, se muestran datos locales | ✅  |
| Registros creados offline tienen `syncStatus = pendingSync` | ✅ | |
| La UI muestra indicador visual de registros pendientes | ✅  |

---

## 6. Sincronización

| Ítem | Estado | Notas |
|---|---|---|
| Al recuperar conexión, los registros pendientes se sincronizan | ✅ |
| Registros sincronizados cambian a `syncStatus = synced` | ✅ |
| Registros con error de sincronización quedan como `failedSync` | ✅  |
| La prueba manual offline-first fue realizada y documentada | ✅  |

---

## 7. Pruebas automatizadas

| Ítem | Estado | Notas |
|---|---|---|
| `flutter test` corre sin errores de compilación | ✅ |
| Mínimo 6 unit tests implementados | ✅ |
| Mínimo 4 widget tests implementados | ✅  |
| Todos los tests pasan (`flutter test`) | ✅  |

---

## 8. Documentación

| Ítem | Estado | Notas |
|---|---|---|
| `README.md` describe el proyecto, instalación y usuarios de prueba | ✅  |
| `docs/pruebas.md` completado con resultados reales | ✅  |
| `docs/bugs-backlog.md` actualizado | ✅  |
| `docs/rc_candidate.md` completado y con decisión del equipo | ✅  |

---

## Resultado final

| Ítems totales | Ítems aprobados | Ítems fallidos | Decisión |
|---|---|---|---|
| [45] | [43] | [2] | ✅ Listo |