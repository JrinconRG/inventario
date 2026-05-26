# Casos de Uso del Sistema

## CU-01: Iniciar Sesión
**Actor:** Todos los usuarios  
**Precondición:** El usuario tiene una cuenta registrada  
**Flujo principal:**
1. El usuario ingresa correo y contraseña
2. El sistema valida las credenciales con Firebase Auth
3. El sistema obtiene el perfil y rol del usuario de Firestore
4. El sistema redirige al Dashboard según el rol

**Flujo alternativo:** Contraseña incorrecta → mensaje de error  
**Flujo alternativo:** Sin conexión → se muestra mensaje de red

---

## CU-02: Registrar Insumo
**Actor:** Administrador, Laboratorista  
**Precondición:** Usuario autenticado con rol apropiado  
**Flujo principal:**
1. El usuario accede a Inventario → Agregar
2. Completa nombre, descripción, categoría, stock, stock mínimo y unidad
3. El sistema valida los campos
4. El sistema guarda en SQLite con syncStatus = pending
5. El sistema intenta sincronizar con Firestore

---

## CU-03: Registrar Lote (FEFO)
**Actor:** Administrador, Laboratorista  
**Precondición:** El insumo debe existir  
**Flujo principal:**
1. El usuario accede al insumo → Lotes → Nuevo lote
2. Ingresa número de lote, proveedor, cantidad, fecha ingreso y vencimiento
3. El sistema valida que la fecha de ingreso no sea futura
4. El sistema guarda el lote y actualiza el stock total del insumo
5. Los lotes quedan ordenados por FEFO (fecha vencimiento ascendente)

---

## CU-04: Registrar Salida de Stock
**Actor:** Administrador, Laboratorista  
**Precondición:** El insumo tiene stock disponible  
**Flujo principal:**
1. El usuario accede a Movimientos del insumo → Registrar
2. Selecciona tipo "Salida" e ingresa cantidad
3. El sistema aplica FEFO: descuenta del lote más próximo a vencer
4. El sistema registra el movimiento con responsable y fecha
5. El sistema actualiza el stock total del insumo

**Flujo alternativo:** Cantidad > stock → error de validación

---

## CU-05: Crear Solicitud de Insumo
**Actor:** Todos los usuarios autenticados  
**Precondición:** El insumo tiene stock disponible  
**Flujo principal:**
1. El usuario va a Solicitudes → Nueva solicitud
2. Selecciona el insumo, ingresa cantidad y motivo
3. El sistema valida que la cantidad no supere el stock
4. El sistema crea la solicitud en estado "Pendiente"
5. Se notifica (alerta) al administrador

---

## CU-06: Aprobar/Rechazar Solicitud
**Actor:** Administrador  
**Precondición:** Existe una solicitud en estado Pendiente  
**Flujo principal (Aprobar):**
1. El administrador accede a la solicitud pendiente
2. Presiona "Aprobar" e ingresa observación opcional
3. El sistema descuenta el stock usando FEFO
4. El sistema registra el movimiento de salida
5. La solicitud pasa a estado "Aprobada"

**Flujo principal (Rechazar):**
1. El administrador presiona "Rechazar" e ingresa motivo obligatorio
2. La solicitud pasa a estado "Rechazada"
3. No se descuenta stock

---

## CU-07: Generar Alertas Automáticas
**Actor:** Sistema (automático)  
**Trigger:** Al cargar el dashboard o cada 60 segundos  
**Flujo principal:**
1. El sistema obtiene todos los insumos y lotes locales
2. Genera alerta de **Stock Bajo** si stockTotal ≤ stockMinimo
3. Genera alerta de **Lote Vencido** si fechaVencimiento < hoy
4. Genera alerta de **Próximo a Vencer** si vence en ≤ 30 días
5. Las alertas se guardan en SQLite con ID único (evita duplicados)
6. Se sincronizan con Firestore

---

## CU-08: Sincronizar Datos
**Actor:** Sistema (automático)  
**Trigger:** Al recuperar conexión a internet  
**Flujo principal:**
1. El SyncService detecta conectividad
2. Obtiene todos los registros con syncStatus = 'pending'
3. Los sube a Firestore en paralelo
4. Marca cada registro como syncStatus = 'synced'

**Flujo alternativo:** Error de red → los registros permanecen como 'pending' para el siguiente ciclo
