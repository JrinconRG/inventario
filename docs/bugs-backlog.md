# Bugs y Backlog - Gestión de Inventario de Laboratorio

**Equipo 6**
**Última actualización:** [fecha]

---

## Convenciones

**Prioridad:**
- 🔴 Alta — bloquea funcionalidad crítica o requisito obligatorio
- 🟡 Media — afecta experiencia pero tiene workaround
- 🟢 Baja — cosmético o mejora menor

**Estado:**
- `Abierto` — identificado, sin solución
- `En progreso` — se está trabajando en la solución
- `Resuelto` — corregido y verificado
- `Descartado` — no se va a corregir (con justificación)

---

## Errores encontrados y corregidos

| ID | Descripción | Módulo | Prioridad | Responsable | Fecha detección | Fecha resolución | Estado |
|---|---|---|---|---|---|---|---|
| BUG-001 | InvalidDataException en Drift al aprobar solicitud. Se enviaban companions incompletos (insumoId y numeroLote ausentes) al actualizar el stock de lotes.| Inventario / Servicios | 🔴  | Steven | 29/05/2026 | 01/06/2026 | Resuelto |
| BUG-002 |Duplicación de lógica de negocio y descuento de stock doble (se invocaba la estrategia FEFO tanto en el SolicitudProvider como en el SolicitudService). | Solicitudes / Providers | 🔴 | Jorge Bedoya | 27/05/2026 | 01/06/2026 | Resuelto |
| BUG-003 |Error de compilación en SolicitudPage por intentar definir e invocar métodos locales del Provider (_setLoading, _solicitudes) dentro de la vista (UI). | Solicitudes / UI |🟡 | Steven| 29/05/2026 | 30/05/2026 | Resuelto |

---

## Errores pendientes

| ID | Descripción | Módulo | Prioridad | Responsable | Fecha detección | Estado |
|---|---|---|---|---|---|---|
| BUG-004 | [inconsistencia de stock cuando múltiples movimientos se registran simultáneamente sobre el mismo insumo.] | [Inventario] |  🟡 | [Juana Rincón] | [03/06/2026] | Abierto |
| BUG-005 | [Los registros marcados como failed no muestran un mensaje claro al usuario para reintentar la sincronización.] | [UI / Sincronización] | 🟢 | [Juana Rincón] | [03/06/2026] | Pendiente |

---

## Backlog de mejoras

Funcionalidades deseadas que no se implementaron por tiempo o prioridad.

| ID | Descripción | Módulo | Prioridad | Motivo de no inclusión |
|---|---|---|---|---|
| MEJORA-001 | Notificaciones push cuando se aprueba una solicitud | Solicitudes | 🟡 | Fuera del alcance del curso |
| MEJORA-002 | Exportar reporte de movimientos en PDF | Reportes | 🟢 | No es requisito obligatorio |
| MEJORA-003 |Alertas automáticas en la UI (gráficos de consumo dinámicos) basadas en la proximidad de las fechas de vencimiento de los lotes. | Dashboard| 🟡| Prioridad baja frente a la estabilización de la persistencia local.|
| MEJORA-004 |Implementación de reintentos con backoff exponencial en el SyncService para la sincronización en segundo plano con Firebase. | Sincronización| 🔴| El flujo Offline-First actual cumple con el mínimo requerido para redes inestables.|

---

## Notas del equipo

Durante el ciclo de desarrollo se priorizó un enfoque estricto de Clean Architecture y patrones Offline-First, delegando las reglas complejas de negocio (como el algoritmo de asignación y despacho de lotes bajo la estrategia FEFO) directamente en la capa de servicios (InventoryService), evitando contaminar los controladores de estado (Providers).

La integración con la base de datos reactiva Drift requirió un control minucioso sobre el manejo de estados mutables y ciclos de vida (StreamSubscription). Las principales lecciones aprendidas giran en torno a la gestión estricta de estructuras Companion de Drift, asegurando el llenado de campos no nulos obligatorios durante operaciones de actualización para mitigar excepciones en tiempo de ejecución. El sistema actual se reporta como estable y listo para la validación en entornos desconectados.