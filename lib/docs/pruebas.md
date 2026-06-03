# Pruebas del Proyecto - Gestión de Inventario de Laboratorio

**Equipo 6**
**Fecha de última actualización:** 01/06/2026



---

## 1. Pruebas manuales por rol

### Rol: Docente

| # | Caso de prueba | Pasos | Resultado esperado | Resultado obtenido | Estado |
|---|---|---|---|---|---|
| 1 | Login con usuario docente activo | Ingresar credenciales válidas de docente | Redirige al home de docente | [completar] | ✅ / ❌ |
| 2 | Ver lista de insumos disponibles | Navegar a módulo de insumos | Se muestran insumos con stock disponible | [completar] | ✅ / ❌ |
| 3 | Crear solicitud de insumo | Seleccionar insumo, ingresar cantidad y confirmar | Solicitud creada con estado "Solicitado" | [completar] | ✅ / ❌ |
| 4 | Ver solo sus propias solicitudes | Navegar a "Mis solicitudes" | Solo aparecen solicitudes del docente autenticado | [completar] | ✅ / ❌ |
| 5 | Intentar acceder a gestión de insumos | Navegar o forzar acceso a pantalla de creación de insumos | Acceso denegado o botón no visible | [completar] | ✅ / ❌ |
| 6 | Ver alertas de stock bajo o vencimiento | Navegar a módulo de alertas | Se muestran alertas activas | [completar] | ✅ / ❌ |

### Rol: Auxiliar

| # | Caso de prueba | Pasos | Resultado esperado | Resultado obtenido | Estado |
|---|---|---|---|---|---|
| 1 | Login con usuario auxiliar activo | Ingresar credenciales válidas de auxiliar | Redirige al home de auxiliar | [completar] | ✅ / ❌ |
| 2 | Crear un nuevo insumo | Completar formulario de insumo y guardar | Insumo creado y visible en lista | [completar] | ✅ / ❌ |
| 3 | Agregar lote a un insumo existente | Seleccionar insumo, agregar lote con cantidad y fecha de vencimiento | Lote registrado y stock del insumo actualizado | [completar] | ✅ / ❌ |
| 4 | Ver todas las solicitudes pendientes | Navegar a módulo de solicitudes | Se muestran solicitudes de todos los docentes | [completar] | ✅ / ❌ |
| 5 | Intentar aprobar una solicitud | Buscar botón de aprobación en solicitud | Botón no visible o acción denegada | [completar] | ✅ / ❌ |
| 6 | Ver alertas del inventario | Navegar a módulo de alertas | Se muestran alertas de stock bajo y vencimientos | [completar] | ✅ / ❌ |

### Rol: Administrador

| # | Caso de prueba | Pasos | Resultado esperado | Resultado obtenido | Estado |
|---|---|---|---|---|---|
| 1 | Login con usuario administrador activo | Ingresar credenciales válidas de admin | Redirige al home de administrador | [completar] | ✅ / ❌ |
| 2 | Aprobar una solicitud | Seleccionar solicitud pendiente y aprobar | Estado cambia a "Aprobado" y stock se descuenta | [completar] | ✅ / ❌ |
| 3 | Rechazar una solicitud con motivo | Seleccionar solicitud y rechazar con motivo obligatorio | Estado cambia a "Rechazado", stock sin cambios | [completar] | ✅ / ❌ |
| 4 | Cambiar estado de un insumo | Seleccionar insumo y cambiar estado (activo/inactivo/agotado) | Estado actualizado en Firestore y en UI | [completar] | ✅ / ❌ |
| 5 | Eliminar un insumo | Seleccionar insumo y confirmar eliminación | Insumo eliminado de lista y de Firestore | [completar] | ✅ / ❌ |
| 6 | Gestionar usuarios (cambiar estado de cuenta) | Navegar a gestión de usuarios y cambiar estado | Estado actualizado correctamente | [completar] | ✅ / ❌ |

---

## 2. Flujo principal

**Flujo:** Login → Consultar insumos → Crear solicitud → Validar stock → Enviar solicitud → Ver estado pendiente

| Paso | Acción | Resultado esperado | Estado |
|---|---|---|---|
| 1 | Docente inicia sesión | Redirige al home según rol | ✅ / ❌ |
| 2 | Docente consulta insumos disponibles | Lista de insumos con stock visible | ✅ / ❌ |
| 3 | Docente selecciona insumo y crea solicitud | Formulario de solicitud disponible | ✅ / ❌ |
| 4 | App valida que el stock es suficiente | Si stock insuficiente, muestra error; si no, continúa | ✅ / ❌ |
| 5 | Docente confirma la solicitud | Solicitud creada con estado "Solicitado" | ✅ / ❌ |
| 6 | Administrador visualiza solicitud pendiente | Solicitud aparece en lista del admin | ✅ / ❌ |
| 7 | Administrador aprueba la solicitud | Estado cambia a "Aprobado", stock descontado | ✅ / ❌ |

---

## 3. Pruebas de estados de cuenta

### Usuario bloqueado (blocked)

| Paso | Acción | Resultado esperado | Estado |
|---|---|---|---|
| 1 | Iniciar sesión con usuario bloqueado | Login exitoso en Firebase Auth | ✅ / ❌ |
| 2 | App consulta perfil en Firestore | Estado leído como "blocked" | ✅ / ❌ |
| 3 | Redirección automática | Muestra pantalla "Acceso bloqueado" | ✅ / ❌ |
| 4 | Usuario intenta navegar al home | No puede acceder al módulo principal | ✅ / ❌ |

### Usuario pendiente de aprobación (pendingApproval)

| Paso | Acción | Resultado esperado | Estado |
|---|---|---|---|
| 1 | Iniciar sesión con usuario pendiente | Login exitoso en Firebase Auth | ✅ / ❌ |
| 2 | App consulta perfil en Firestore | Estado leído como "pendingApproval" | ✅ / ❌ |
| 3 | Redirección automática | Muestra pantalla "Cuenta pendiente de aprobación" | ✅ / ❌ |
| 4 | Usuario intenta crear una solicitud | Acción denegada | ✅ / ❌ |

---

## 4. Pruebas de estados de UI

| Estado UI | Cómo se probó | Resultado esperado | Estado |
|---|---|---|---|
| Estado vacío | Iniciar sesión con usuario sin solicitudes | Se muestra mensaje "No hay solicitudes registradas" | ✅ / ❌ |
| Estado de carga | Abrir módulo con conexión lenta | Se muestra indicador de carga | ✅ / ❌ |
| Estado de error | Simular fallo en lectura de Firestore | Se muestra mensaje de error con opción de reintentar | ✅ / ❌ |
| Operación exitosa | Crear solicitud correctamente | Se muestra mensaje de confirmación | ✅ / ❌ |
| Acceso restringido | Intentar acceder a pantalla sin permiso | Se muestra pantalla de acceso restringido | ✅ / ❌ |
| Sin conexión | Desactivar internet y crear registro | Se muestra etiqueta "Pendiente de sincronización" | ✅ / ❌ |
| Pendiente de sincronización | Crear registro offline | El registro muestra indicador visual de syncStatus | ✅ / ❌ |

---

## 5. Prueba sin conexión / Firebase fallando

**Objetivo:** Verificar que la app no se bloquea si no hay conexión y que los registros quedan como pendingSync.

**Pasos ejecutados:**

1. El usuario inicia sesión con conexión activa.
2. La app carga los datos previamente guardados localmente.
3. Se desactiva la conexión a internet del dispositivo.
4. El docente crea una solicitud de insumo.
5. La app no se bloquea ni lanza excepción no controlada.
6. El registro se guarda localmente con `syncStatus = pendingSync`.
7. La UI muestra la etiqueta "Pendiente de sincronización" junto al registro.
8. Se reactiva la conexión a internet.
9. La app detecta registros pendientes y lanza el proceso de sincronización.
10. El registro queda con `syncStatus = synced` y se refleja en Firestore.

**Resultado obtenido:** [completar]
**Fecha de prueba:** [fecha]
**Responsable:** [nombre]

---

## 6. Evidencia de pruebas automatizadas

### Unit tests ejecutados

| Archivo | Test | Resultado |
|---|---|---|
| `test/unit/permission_service_test.dart` | Usuario active + rol docente puede crear solicitud | ✅ / ❌ |
| `test/unit/permission_service_test.dart` | Usuario pendingApproval no puede crear solicitud | ✅ / ❌ |
| `test/unit/permission_service_test.dart` | Usuario blocked no puede entrar al módulo principal | ✅ / ❌ |
| `test/unit/permission_service_test.dart` | Solo administrador puede aprobar solicitudes | ✅ / ❌ |
| `test/unit/business_rules_test.dart` | No se puede retirar más cantidad de la disponible | ✅ / ❌ |
| `test/unit/business_rules_test.dart` | Lote vencido no puede usarse en una solicitud | ✅ / ❌ |
| `test/unit/business_rules_test.dart` | Solicitud rechazada requiere motivo obligatorio | ✅ / ❌ |

**Comando ejecutado:** `flutter test test/unit/`
**Resultado general:** [X/7 tests pasaron]

### Widget tests ejecutados

| Archivo | Test | Resultado |
|---|---|---|
| `test/widget/empty_state_test.dart` | Sin solicitudes se muestra estado vacío | ✅ / ❌ |
| `test/widget/blocked_screen_test.dart` | Usuario blocked ve pantalla de acceso bloqueado | ✅ / ❌ |
| `test/widget/pending_approval_test.dart` | Usuario pendingApproval ve pantalla de espera | ✅ / ❌ |
| `test/widget/admin_options_test.dart` | Administrador ve opciones de gestión de usuarios | ✅ / ❌ |
| `test/widget/sync_badge_test.dart` | Registro pendingSync muestra etiqueta visual | ✅ / ❌ |

**Comando ejecutado:** `flutter test test/widget/`
**Resultado general:** [X/5 tests pasaron]