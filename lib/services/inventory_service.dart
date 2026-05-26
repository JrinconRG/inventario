import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../data/app_database.dart';
import '../models/insumo_model.dart';
import '../models/lote_model.dart';
import '../models/movimiento_model.dart';
import '../utils/enums.dart';
import 'firebase_service.dart';

class InventoryService {
  final AppDatabase _db;
  final FirebaseService _firebase;
  final _uuid = const Uuid();

  InventoryService(this._db, this._firebase);

  // ─── Insumos ─────────────────────────────────────────────────────────────

  Future<List<InsumoModel>> getAllInsumos() async {
    final rows = await _db.insumosDao.getAllInsumos();
    return rows.map(_dbToInsumo).toList();
  }

  Stream<List<InsumoModel>> watchInsumos() =>
      _db.insumosDao.watchAllInsumos().map((rows) => rows.map(_dbToInsumo).toList());

  Future<InsumoModel?> getInsumoById(String id) async {
    final row = await _db.insumosDao.getInsumoById(id);
    return row == null ? null : _dbToInsumo(row);
  }

  Future<List<InsumoModel>> searchInsumos(String query) async {
    final rows = await _db.insumosDao.searchInsumos(query);
    return rows.map(_dbToInsumo).toList();
  }

  Future<List<InsumoModel>> getInsumosCriticos() async {
    final rows = await _db.insumosDao.getInsumosCriticos();
    return rows.map(_dbToInsumo).toList();
  }

  Future<InsumoModel> createInsumo({
    required String nombre,
    required String descripcion,
    required Categoria categoria,
    required int stockTotal,
    required int stockMinimo,
    required UnidadMedida unidadMedida,
  }) async {
    final now = DateTime.now();
    final insumo = InsumoModel(
      id: _uuid.v4(),
      nombre: nombre,
      descripcion: descripcion,
      categoria: categoria,
      stockTotal: stockTotal,
      stockMinimo: stockMinimo,
      unidadMedida: unidadMedida,
      estado: InsumoEstado.activo,
      createdAt: now,
    );
    await _db.insumosDao.insertInsumo(InsumosCompanion.insert(
      id: insumo.id,
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
    _trySyncInsumo(insumo);
    return insumo;
  }

  Future<void> updateInsumo(InsumoModel insumo) async {
    final updated = insumo.copyWith(updatedAt: DateTime.now());
    await _db.insumosDao.updateInsumo(InsumosCompanion(
      id: Value(updated.id),
      nombre: Value(updated.nombre),
      descripcion: Value(updated.descripcion),
      categoria: Value(updated.categoria.name),
      stockTotal: Value(updated.stockTotal),
      stockMinimo: Value(updated.stockMinimo),
      unidadMedida: Value(updated.unidadMedida.name),
      estado: Value(updated.estado.name),
      updatedAt: Value(updated.updatedAt),
      syncStatus: const Value('pending'),
    ));
    _trySyncInsumo(updated);
  }

  Future<void> deleteInsumo(String id) async {
    await _db.insumosDao.deleteInsumo(id);
    try {
      await _firebase.deleteInsumo(id);
    } catch (_) {}
  }

  // ─── Lotes ───────────────────────────────────────────────────────────────

  Future<List<LoteModel>> getLotesByInsumo(String insumoId) async {
    final rows = await _db.lotesDao.getLotesByInsumo(insumoId);
    return rows.map(_dbToLote).toList();
  }

  Stream<List<LoteModel>> watchLotesByInsumo(String insumoId) =>
      _db.lotesDao.watchLotesByInsumo(insumoId)
          .map((rows) => rows.map(_dbToLote).toList());

  /// Retorna lotes ordenados por FEFO (primero el que vence antes).
  Future<List<LoteModel>> getLotesFEFO(String insumoId) async {
    final rows = await _db.lotesDao.getLotesFEFO(insumoId);
    return rows.map(_dbToLote).toList();
  }

  Future<LoteModel> addLote({
    required String insumoId,
    required String numeroLote,
    required DateTime fechaIngreso,
    required DateTime fechaVencimiento,
    required int cantidad,
    required String proveedor,
  }) async {
    final lote = LoteModel(
      id: _uuid.v4(),
      insumoId: insumoId,
      numeroLote: numeroLote,
      fechaIngreso: fechaIngreso,
      fechaVencimiento: fechaVencimiento,
      cantidad: cantidad,
      proveedor: proveedor,
    );
    await _db.lotesDao.insertLote(LotesCompanion.insert(
      id: lote.id,
      insumoId: insumoId,
      numeroLote: numeroLote,
      fechaIngreso: fechaIngreso,
      fechaVencimiento: fechaVencimiento,
      cantidad: cantidad,
      proveedor: proveedor,
      syncStatus: const Value('pending'),
    ));
    // Aumentar stock del insumo
    final insumo = await _db.insumosDao.getInsumoById(insumoId);
    if (insumo != null) {
      await _db.insumosDao.updateStock(
          insumoId, insumo.stockTotal + cantidad);
    }
    _trySyncLote(lote);
    return lote;
  }

  Future<void> deleteLote(String id, String insumoId, int cantidad) async {
    await _db.lotesDao.deleteLote(id);
    final insumo = await _db.insumosDao.getInsumoById(insumoId);
    if (insumo != null) {
      final nuevoStock = (insumo.stockTotal - cantidad).clamp(0, 999999);
      await _db.insumosDao.updateStock(insumoId, nuevoStock);
    }
    try {
      await _firebase.deleteLote(id);
    } catch (_) {}
  }

  // ─── Movimientos ─────────────────────────────────────────────────────────

  Future<List<MovimientoModel>> getMovimientosByInsumo(
      String insumoId) async {
    final rows = await _db.movimientosDao.getMovimientosByInsumo(insumoId);
    return rows.map(_dbToMovimiento).toList();
  }

  Future<List<MovimientoModel>> getRecentMovimientos({int limit = 10}) async {
    final rows =
        await _db.movimientosDao.getRecentMovimientos(limit: limit);
    return rows.map(_dbToMovimiento).toList();
  }

  /// Registra un movimiento aplicando FEFO para salidas.
  Future<void> registrarMovimiento({
    required String insumoId,
    required MovimientoTipo tipo,
    required int cantidad,
    required String responsableId,
    required String responsableNombre,
    String observaciones = '',
  }) async {
    final now = DateTime.now();
    String? loteIdUsado;

    if (tipo == MovimientoTipo.salida) {
      // Aplicar FEFO: descontar del lote que vence primero
      final lotes = await _db.lotesDao.getLotesFEFO(insumoId);
      int restante = cantidad;
      for (final lote in lotes) {
        if (restante <= 0) break;
        if (lote.cantidad <= 0) continue;
        loteIdUsado = lote.id;
        final descontar = restante.clamp(0, lote.cantidad);
        await _db.lotesDao.updateCantidad(lote.id, lote.cantidad - descontar);
        restante -= descontar;
      }
    }

    final mov = MovimientoModel(
      id: _uuid.v4(),
      insumoId: insumoId,
      loteId: loteIdUsado,
      tipo: tipo,
      cantidad: cantidad,
      responsableId: responsableId,
      responsableNombre: responsableNombre,
      observaciones: observaciones,
      fecha: now,
    );

    await _db.movimientosDao.insertMovimiento(MovimientosCompanion.insert(
      id: mov.id,
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

    // Actualizar stock total del insumo
    final insumo = await _db.insumosDao.getInsumoById(insumoId);
    if (insumo != null) {
      int nuevoStock = insumo.stockTotal;
      if (tipo == MovimientoTipo.entrada) nuevoStock += cantidad;
      if (tipo == MovimientoTipo.salida) {
        nuevoStock = (nuevoStock - cantidad).clamp(0, 999999);
      }
      await _db.insumosDao.updateStock(insumoId, nuevoStock);
    }

    _trySyncMovimiento(mov);
  }

  // ─── Sync helpers ────────────────────────────────────────────────────────

  void _trySyncInsumo(InsumoModel insumo) async {
    try {
      await _firebase.saveInsumo(insumo);
      await _db.insumosDao.markAsSynced(insumo.id);
    } catch (_) {}
  }

  void _trySyncLote(LoteModel lote) async {
    try {
      await _firebase.saveLote(lote);
      await _db.lotesDao.markAsSynced(lote.id);
    } catch (_) {}
  }

  void _trySyncMovimiento(MovimientoModel mov) async {
    try {
      await _firebase.saveMovimiento(mov);
      await _db.movimientosDao.markAsSynced(mov.id);
    } catch (_) {}
  }

  // ─── Mappers ─────────────────────────────────────────────────────────────

  InsumoModel _dbToInsumo(DbInsumo row) => InsumoModel(
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
      );

  LoteModel _dbToLote(DbLote row) => LoteModel(
        id: row.id,
        insumoId: row.insumoId,
        numeroLote: row.numeroLote,
        fechaIngreso: row.fechaIngreso,
        fechaVencimiento: row.fechaVencimiento,
        cantidad: row.cantidad,
        proveedor: row.proveedor,
        updatedAt: row.updatedAt,
      );

  MovimientoModel _dbToMovimiento(DbMovimiento row) => MovimientoModel(
        id: row.id,
        insumoId: row.insumoId,
        loteId: row.loteId,
        tipo: MovimientoTipo.fromString(row.tipo),
        cantidad: row.cantidad,
        responsableId: row.responsableId,
        responsableNombre: row.responsableNombre,
        observaciones: row.observaciones,
        fecha: row.fecha,
      );
}
