import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../data/app_database.dart';
import '../models/insumo_model.dart';
import '../models/lote_model.dart';
import '../models/movimiento_model.dart';
import '../utils/enums.dart';
import 'firebase_service.dart';
import 'sync_service.dart';

class InventoryService {
  final AppDatabase _db;
  final FirebaseService _firebase;
  final SyncService? _syncService;
  final _uuid = const Uuid();

  InventoryService(this._db, this._firebase, {SyncService? syncService})
      : _syncService = syncService;

  // ─── Insumos ─────────────────────────────────────────────────────────────
  // TODOS los métodos de lectura ahora leen de BD local, no de Firebase

  /// Lee TODOS los insumos desde la BD local
  Future<List<InsumoModel>> getAllInsumos() async {
    final rows = await _db.insumosDao.getAllInsumos();
    return rows
        .map((row) => InsumoModel(
              id: row.id,
              nombre: row.nombre,
              descripcion: row.descripcion,
              categoria: Categoria.fromString(row.categoria),
              stockTotal: row.stockTotal,
              stockMinimo: row.stockMinimo,
              unidadMedida: UnidadMedida.fromString(row.unidadMedida),
              estado: InsumoEstado.fromString(row.estado),
              createdAt: row.createdAt,
              updatedAt: row.updatedAt,
              syncStatus: row.syncStatus,
            ))
        .toList();
  }

  /// Stream de insumos desde BD local (actualiza cuando hay cambios locales)
  Stream<List<InsumoModel>> watchInsumos() {
    return _db.insumosDao.watchAllInsumos().map((rows) => rows
        .map((row) => InsumoModel(
              id: row.id,
              nombre: row.nombre,
              descripcion: row.descripcion,
              categoria: Categoria.fromString(row.categoria),
              stockTotal: row.stockTotal,
              stockMinimo: row.stockMinimo,
              unidadMedida: UnidadMedida.fromString(row.unidadMedida),
              estado: InsumoEstado.fromString(row.estado),
              createdAt: row.createdAt,
              updatedAt: row.updatedAt,
              syncStatus: row.syncStatus,
            ))
        .toList());
  }

  /// Obtiene un insumo específico desde BD local
  Future<InsumoModel?> getInsumoById(String id) async {
    final row = await _db.insumosDao.getInsumoById(id);
    if (row == null) return null;
    return InsumoModel(
      id: row.id,
      nombre: row.nombre,
      descripcion: row.descripcion,
      categoria: Categoria.fromString(row.categoria),
      stockTotal: row.stockTotal,
      stockMinimo: row.stockMinimo,
      unidadMedida: UnidadMedida.fromString(row.unidadMedida),
      estado: InsumoEstado.fromString(row.estado),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: row.syncStatus,
    );
  }

  /// Busca insumos por nombre (BD local)
  Future<List<InsumoModel>> searchInsumos(String query) async {
    final all = await getAllInsumos();
    return all
        .where((i) => i.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Obtiene insumos con stock crítico (BD local)
  Future<List<InsumoModel>> getInsumosCriticos() async {
    final all = await getAllInsumos();
    return all.where((i) => i.isCritico).toList();
  }

  /// Crea un insumo OFFLINE-FIRST: guarda local primero, luego Firebase
  Future<InsumoModel> createInsumo({
    required String nombre,
    required String descripcion,
    required Categoria categoria,
    required int stockTotal,
    required int stockMinimo,
    required UnidadMedida unidadMedida,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();

    final insumo = InsumoModel(
      id: id,
      nombre: nombre,
      descripcion: descripcion,
      categoria: categoria,
      stockTotal: stockTotal,
      stockMinimo: stockMinimo,
      unidadMedida: unidadMedida,
      estado: InsumoEstado.activo,
      createdAt: now,
      syncStatus: 'pending', // Marcar como pendiente de sincronizar
    );

    // 1. Guardar en BD local PRIMERO
    await _db.insumosDao.insertInsumo(InsumosCompanion.insert(
      id: id,
      nombre: nombre,
      descripcion: descripcion,
      categoria: categoria.name,
      stockTotal: Value(stockTotal),
      stockMinimo: Value(stockMinimo),
      unidadMedida: unidadMedida.name,
      estado: const Value('activo'),
      syncStatus: const Value('pending'),
      createdAt: now,
    ));

    // 2. Intentar sincronizar a Firebase (si hay conexión)
    _trySync(id);

    return insumo;
  }

  Future<void> updateInsumo(InsumoModel insumo) async {
    final updated = insumo.copyWith(
      updatedAt: DateTime.now(),
      syncStatus: 'pending', // Marcar como pendiente
    );

    await _db.insumosDao.updateInsumo(InsumosCompanion(
      id: Value(updated.id),
      nombre: Value(updated.nombre),
      descripcion: Value(updated.descripcion),
      categoria: Value(updated.categoria.name),
      stockTotal: Value(updated.stockTotal),
      stockMinimo: Value(updated.stockMinimo),
      unidadMedida: Value(updated.unidadMedida.name),
      estado: Value(updated.estado.name),
      createdAt: Value(updated.createdAt),
      updatedAt: Value(updated.updatedAt),
      syncStatus: const Value('pending'),
    ));

    _trySync(updated.id);
  }

  Future<void> deleteInsumo(String id) async {
    await _db.insumosDao.deleteInsumo(id);
    await _firebase.deleteInsumo(id).catchError((_) {});
  }

  // ─── Lotes ───────────────────────────────────────────────────────────────

  /// Lee lotes de un insumo desde BD local
  Future<List<LoteModel>> getLotesByInsumo(String insumoId) async {
    final rows = await _db.lotesDao.getLotesByInsumo(insumoId);
    return rows
        .map((row) => LoteModel(
              id: row.id,
              insumoId: row.insumoId,
              numeroLote: row.numeroLote,
              fechaIngreso: row.fechaIngreso,
              fechaVencimiento: row.fechaVencimiento,
              cantidad: row.cantidad,
              proveedor: row.proveedor,
              updatedAt: row.updatedAt,
              syncStatus: row.syncStatus,
            ))
        .toList();
  }

  /// Stream de lotes desde BD local
  Stream<List<LoteModel>> watchLotesByInsumo(String insumoId) {
    return _db.lotesDao.watchLotesByInsumo(insumoId).map((rows) => rows
        .map((row) => LoteModel(
              id: row.id,
              insumoId: row.insumoId,
              numeroLote: row.numeroLote,
              fechaIngreso: row.fechaIngreso,
              fechaVencimiento: row.fechaVencimiento,
              cantidad: row.cantidad,
              proveedor: row.proveedor,
              updatedAt: row.updatedAt,
              syncStatus: row.syncStatus,
            ))
        .toList());
  }

  /// Obtiene lotes FEFO (primero vence primero) desde BD local
  Future<List<LoteModel>> getLotesFEFO(String insumoId) async {
    final lotes = await getLotesByInsumo(insumoId);
    lotes.sort((a, b) => a.fechaVencimiento.compareTo(b.fechaVencimiento));
    return lotes;
  }

  /// Agrega un lote OFFLINE-FIRST
  Future<LoteModel> addLote({
    required String insumoId,
    required String numeroLote,
    required DateTime fechaIngreso,
    required DateTime fechaVencimiento,
    required int cantidad,
    required String proveedor,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    final lote = LoteModel(
      id: id,
      insumoId: insumoId,
      numeroLote: numeroLote,
      fechaIngreso: fechaIngreso,
      fechaVencimiento: fechaVencimiento,
      cantidad: cantidad,
      proveedor: proveedor,
      syncStatus: 'pending',
    );

    // 1. Guardar en BD local
    await _db.lotesDao.insertLote(LotesCompanion.insert(
      id: id,
      insumoId: insumoId,
      numeroLote: numeroLote,
      fechaIngreso: fechaIngreso,
      fechaVencimiento: fechaVencimiento,
      cantidad: cantidad,
      proveedor: proveedor,
      syncStatus: const Value('pending'),
      updatedAt: Value(now),
    ));

    // 2. Actualizar stock del insumo localmente
    final insumo = await getInsumoById(insumoId);
    if (insumo != null) {
      await updateInsumo(insumo.copyWith(
        stockTotal: insumo.stockTotal + cantidad,
        syncStatus: 'pending',
      ));
    }

    // 3. Intentar sincronizar a Firebase
    _trySync(id);

    return lote;
  }

  /// Elimina un lote OFFLINE-FIRST
  Future<void> deleteLote(String id, String insumoId, int cantidad) async {
    // 1. Eliminar de BD local
    await _db.lotesDao.deleteLote(id);

    // 2. Actualizar stock del insumo
    final insumo = await getInsumoById(insumoId);
    if (insumo != null) {
      final nuevoStock = (insumo.stockTotal - cantidad).clamp(0, 999999);
      await updateInsumo(insumo.copyWith(
        stockTotal: nuevoStock,
        syncStatus: 'pending',
      ));
    }

    // 3. Intentar eliminar de Firebase
    await _firebase.deleteLote(id).catchError((_) {});
  }

  // ─── Movimientos ─────────────────────────────────────────────────────────

  /// Lee movimientos de un insumo desde BD local
  Future<List<MovimientoModel>> getMovimientosByInsumo(String insumoId) async {
    final rows = await _db.movimientosDao.getMovimientosByInsumo(insumoId);
    return rows
        .map((row) => MovimientoModel(
              id: row.id,
              insumoId: row.insumoId,
              loteId: row.loteId,
              tipo: MovimientoTipo.fromString(row.tipo),
              cantidad: row.cantidad,
              responsableId: row.responsableId,
              responsableNombre: row.responsableNombre,
              observaciones: row.observaciones,
              fecha: row.fecha,
              syncStatus: row.syncStatus,
            ))
        .toList();
  }

  /// Obtiene movimientos recientes desde BD local
  Future<List<MovimientoModel>> getRecentMovimientos({int limit = 10}) async {
    final rows = await _db.movimientosDao.getRecentMovimientos(limit: limit);
    return rows
        .map((row) => MovimientoModel(
              id: row.id,
              insumoId: row.insumoId,
              loteId: row.loteId,
              tipo: MovimientoTipo.fromString(row.tipo),
              cantidad: row.cantidad,
              responsableId: row.responsableId,
              responsableNombre: row.responsableNombre,
              observaciones: row.observaciones,
              fecha: row.fecha,
              syncStatus: row.syncStatus,
            ))
        .toList();
  }

  /// Registra un movimiento OFFLINE-FIRST
  Future<void> registrarMovimiento({
    required String insumoId,
    required MovimientoTipo tipo,
    required int cantidad,
    required String responsableId,
    required String responsableNombre,
    String observaciones = '',
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    String? loteIdUsado;

    // Si es salida, descontar de lotes FEFO
    //  SOLUCIÓN: Pasar todos los campos para evitar el InvalidDataException
    if (tipo == MovimientoTipo.salida) {
      final lotes = await getLotesFEFO(insumoId);
      int restante = cantidad;

      for (final lote in lotes) {
        if (restante <= 0) break;

        loteIdUsado = lote.id;
        final descontar = restante.clamp(0, lote.cantidad);

        final nuevoLote = lote.copyWith(
          cantidad: lote.cantidad - descontar,
          syncStatus: 'pending',
        );

        //  Modificamos el Companion para que incluya los campos requeridos
        await _db.lotesDao.updateLote(LotesCompanion(
          id: Value(lote.id),
          insumoId: Value(lote.insumoId),
          numeroLote: Value(lote.numeroLote),
          fechaIngreso: Value(lote.fechaIngreso),
          fechaVencimiento: Value(lote.fechaVencimiento),
          proveedor: Value(lote.proveedor),
          cantidad: Value(nuevoLote.cantidad),
          syncStatus: const Value('pending'),
          updatedAt: Value(DateTime.now()),
        ));

        restante -= descontar;
      }
    }

    // 1. Guardar movimiento en BD local (Insert directo usando Companion)
    await _db.movimientosDao.insertMovimiento(MovimientosCompanion.insert(
      id: id,
      insumoId: insumoId,
      loteId: Value(loteIdUsado),
      tipo: tipo.name,
      cantidad: cantidad,
      responsableId: responsableId,
      responsableNombre: responsableNombre,
      observaciones: Value(observaciones),
      fecha: now,
      syncStatus: const Value('pending'),
    ));

    // 2. Actualizar stock del insumo de forma segura
    final insumo = await getInsumoById(insumoId);
    if (insumo != null) {
      int nuevoStock = insumo.stockTotal;
      if (tipo == MovimientoTipo.entrada) nuevoStock += cantidad;
      if (tipo == MovimientoTipo.salida) {
        nuevoStock = (nuevoStock - cantidad).clamp(0, 999999);
      }

      // Tu método updateInsumo ya le clava el syncStatus 'pending' internamente
      await updateInsumo(insumo.copyWith(
        stockTotal: nuevoStock,
      ));
    }

    // 3. Intentar sincronizar a Firebase
    _trySync(id);
  }

  // ─── Helper Methods ──────────────────────────────────────────────────────

  /// Intenta sincronizar un registro a Firebase (sin esperar)
  Future<void> _trySync(String recordId) async {
    if (_syncService == null) return;
    // Llamar sin await para no bloquear la UI
    _syncService!.syncAll().catchError((_) {});
  }
}
