Pruebas Manuales — Offline / Sincronización
=========================================

Objetivo
--------
Verificar que la aplicación cumple el comportamiento offline-first y los estados UI requeridos mediante escenarios manuales integrales, respaldados por la suite de pruebas unitarias y de widgets automatizadas.
Comandos útiles
---------------
- Ejecutar la app:

```bash
flutter run
```
- Ejecutar los test:

```bash
flutter test
```


Escenario sugerido (paso a paso)
--------------------------------
1. Iniciar la app y autenticarse como usuario (docente / laboratorista / admin).
2. Verificar que la app carga datos desde la BD local inmediatamente (UI no bloqueada).
   - Estado esperado: si no hay datos locales mostrar "No hay X registrados." (Vacío).
3. Desconectar Internet (o simular fallo de Firebase).
4. Crear un registro importante según rol:
   - Docente: crear `Solicitud`.
   - Laboratorista: crear `Insumo` y `Lote`.
   - Administrador: responder/actualizar `Solicitud`.
5. Verificar que la app NO se bloquea y muestra operación exitosa localmente.
   - Estado esperado: mensaje/feedback "Registro guardado localmente y pendiente de sincronización" o badge "Pendiente".
6. Abrir `Ajustes` → ver contador de pendientes y fallidos (SyncProvider).
   - Estado esperado: contador de `pending` incrementa.
7. Recargar UI (navegar fuera/volver) sin conexión: los registros creados deben seguir apareciendo (datos locales).
8. Reconectar Internet.
9. Esperar sincronización automática o pulsar "Sincronizar ahora" en Ajustes.
10. Verificar en la UI que los registros pasan a `synced` (badge verde) y que Firestore contiene los mismos registros.

Estados UI a comprobar
-----------------------
- Cargando: indicador cuando la pantalla está consultando (local o remoto).
- Error: mostrar "Error al cargar los datos" y opción de reintentar.
- Vacío: ejemplo "No hay solicitudes registradas." cuando lista vacía.
- Datos cargados: lista con items y badges de `syncStatus`.
- Operación exitosa: snack/alerta "Registro guardado".
- Acceso restringido: si Firebase devuelve permisos denegados, mostrar "Acceso bloqueado" o similar.
- Sin conexión: mostrar banner o icono de offline cuando Connectivity indica offline.
- Pendiente de sincronización: badge o texto "Pendiente de sincronización" en el item y contador en Ajustes.

Criterios de persistencia local
-------------------------------
- La app usa Drift/SQLite como origen primario para la UI.
- Cada entidad sincronizable tiene campo `syncStatus` con valores: `synced`, `pending`, `failed`.
- Se puede consultar datos previamente guardados sin conexión.
- Los registros creados sin conexión quedan en BD local con `syncStatus='pending'`.
- Si Firebase falla, la app mantiene la información localmente y no pierde datos.

Sincronización y Firestore
--------------------------
Flujo esperado:
- Crear registro → guardar local (`pending`) → intentar enviar a Firestore → si OK marcar `synced` en local → si falla marcar `failed`.
- `SyncService.syncAll()` debe subir pendientes y después descargar cambios remotos para hacer upsert local (syncStatus='synced').
- Los datos remotos deben estar filtrados por usuario/rol cuando aplique (comprobar roles en endpoints y filtros).

Pruebas de aceptación (lista rápida)
------------------------------------
[ x] PA-001: Los datos locales en SQLite se recuperan al iniciar la app completamente desconectado.

[ x] PA-002: La creación de entidades en frío guarda localmente con estado transicional pending.

[x ] PA-003: La UI inyecta dinámicamente las etiquetas "Pendiente" sin alterar la experiencia del usuario.

[ x] PA-004: Al volver la conectividad, el SyncService despacha las colas de datos hacia Firestore de forma transparente.

[x ] PA-005: Las contraseñas vacías, correos inválidos o inconsistencias de fechas de ingreso son mitigadas por la capa analítica de validadores (LoginValidator, LoteValidator).





Notas técnicas para el equipo
-----------------------------
- Para comprobar BD local, abrir logs o usar `print` en DAOs durante pruebas.
- El `SyncService` escucha cambios de conectividad y llama a `syncAll()` automáticamente.
- Asegurarse de hacer hot-restart tras cambiar providers en `main.dart`.

