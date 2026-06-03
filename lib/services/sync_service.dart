import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import '../data/app_database.dart';
import '../models/insumo_model.dart';
import '../models/lote_model.dart';
import '../models/movimiento_model.dart';
import '../models/solicitud_model.dart';
import '../utils/enums.dart';
import 'firebase_service.dart';

class SyncService {
  final AppDatabase _db;
  final FirebaseService _firebase;
  StreamSubscription<ConnectivityResult>? _connectivitySub;
  bool _isSyncing = false;

  // Callbacks para actualizar UI
  final List<void Function()> _listeners = [];

  SyncService(this._db, this._firebase);

  // Getter público para isSyncing
  bool get isSyncing => _isSyncing;

  void addListener(void Function() callback) {
    _listeners.add(callback);
  }

  void removeListener(void Function() callback) {
    _listeners.remove(callback);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  void startListening() {
    _connectivitySub = Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) syncAll();
    });
  }

  void stopListening() => _connectivitySub?.cancel();

  Future<bool> isOnline() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  // Obtener conteo de registros pendientes de sincronizar
  Future<int> getPendingCount() async {
    final insumos = await _db.insumosDao.getPendingSync();
    final lotes = await _db.lotesDao.getPendingSync();
    final movimientos = await _db.movimientosDao.getPendingSync();
    final solicitudes = await _db.solicitudesDao.getPendingSync();
    return insumos.length +
        lotes.length +
        movimientos.length +
        solicitudes.length;
  }

  // Obtener conteo de registros con error de sincronización
  Future<int> getFailedCount() async {
    final insumos = await _db.insumosDao.getFailedSync();
    final lotes = await _db.lotesDao.getFailedSync();
    final movimientos = await _db.movimientosDao.getFailedSync();
    final solicitudes = await _db.solicitudesDao.getFailedSync();
    return insumos.length +
        lotes.length +
        movimientos.length +
        solicitudes.length;
  }

  Future<void> syncAll() async {
    if (_isSyncing) return;
    _isSyncing = true;
    _notifyListeners();
    try {
      await Future.wait([
        _syncInsumos(),
        _syncLotes(),
        _syncMovimientos(),
        _syncSolicitudes(),
      ]);
      // Después de subir pendientes, traer cambios remotos y actualizar local
      await _refreshFromRemote();
    } finally {
      _isSyncing = false;
      _notifyListeners();
    }
  }

  Future<void> _refreshFromRemote() async {
    try {
      await _refreshInsumosFromRemote();
      await _refreshLotesFromRemote();
      await _refreshMovimientosFromRemote();
      await _refreshSolicitudesFromRemote();
    } catch (e) {
      // No bloquear la sincronización por errores de descarga
    }
  }

  Future<void> _refreshSolicitudesFromRemote() async {
    final remote = await _firebase.getAllSolicitudes();
    for (final solicitud in remote) {
      final existing = await _db.solicitudesDao.getSolicitudById(solicitud.id);
      final isLocalPending =
          existing?.syncStatus == 'pending' || existing?.syncStatus == 'failed';

      if (existing == null) {
        await _db.solicitudesDao.insertSolicitud(SolicitudesCompanion.insert(
          id: solicitud.id,
          insumoId: solicitud.insumoId,
          insumoNombre: solicitud.insumoNombre,
          cantidadSolicitada: solicitud.cantidadSolicitada,
          solicitanteId: solicitud.solicitanteId,
          solicitanteNombre: solicitud.solicitanteNombre,
          estado: Value(solicitud.estado.name),
          motivo: solicitud.motivo,
          observacionesAdmin: Value(solicitud.observacionesAdmin),
          fechaSolicitud: solicitud.fechaSolicitud,
          fechaRespuesta: Value(solicitud.fechaRespuesta),
          syncStatus: const Value('synced'),
        ));
      } else if (!isLocalPending) {
        await _db.solicitudesDao.updateSolicitud(SolicitudesCompanion(
          id: Value(solicitud.id),
          insumoId: Value(solicitud.insumoId),
          insumoNombre: Value(solicitud.insumoNombre),
          cantidadSolicitada: Value(solicitud.cantidadSolicitada),
          solicitanteId: Value(solicitud.solicitanteId),
          solicitanteNombre: Value(solicitud.solicitanteNombre),
          estado: Value(solicitud.estado.name),
          motivo: Value(solicitud.motivo),
          observacionesAdmin: Value(solicitud.observacionesAdmin),
          fechaSolicitud: Value(solicitud.fechaSolicitud),
          fechaRespuesta: Value(solicitud.fechaRespuesta),
          syncStatus: const Value('synced'),
        ));
      }
    }
  }

  /// Fuerza la descarga de datos remotos y actualiza la BD local.
  /// Útil para usar desde UI (pull-to-refresh).
  Future<void> fetchRemoteNow() async {
    if (_isSyncing) return;
    _isSyncing = true;
    _notifyListeners();
    try {
      await _refreshFromRemote();
    } finally {
      _isSyncing = false;
      _notifyListeners();
    }
  }

  Future<void> _refreshInsumosFromRemote() async {
    final remote = await _firebase.getAllInsumos();
    for (final ins in remote) {
      final existing = await _db.insumosDao.getInsumoById(ins.id);
      if (existing == null) {
        await _db.insumosDao.insertInsumo(InsumosCompanion.insert(
          id: ins.id,
          nombre: ins.nombre,
          descripcion: ins.descripcion,
          categoria: ins.categoria.name,
          stockTotal: Value(ins.stockTotal),
          stockMinimo: Value(ins.stockMinimo),
          unidadMedida: ins.unidadMedida.name,
          estado: Value(ins.estado.name),
          syncStatus: Value('synced'),
          createdAt: ins.createdAt,
          updatedAt: Value(ins.updatedAt),
        ));
      } else {
        await _db.insumosDao.updateInsumo(InsumosCompanion(
          id: Value(ins.id),
          nombre: Value(ins.nombre),
          descripcion: Value(ins.descripcion),
          categoria: Value(ins.categoria.name),
          stockTotal: Value(ins.stockTotal),
          stockMinimo: Value(ins.stockMinimo),
          unidadMedida: Value(ins.unidadMedida.name),
          estado: Value(ins.estado.name),
          updatedAt: Value(ins.updatedAt),
          syncStatus: Value('synced'),
        ));
      }
    }
  }

  Future<void> _refreshLotesFromRemote() async {
    final remote = await _firebase.getAllLotes();
    for (final lote in remote) {
      final existing = await _db.lotesDao.getLoteById(lote.id);
      if (existing == null) {
        await _db.lotesDao.insertLote(LotesCompanion.insert(
          id: lote.id,
          insumoId: lote.insumoId,
          numeroLote: lote.numeroLote,
          fechaIngreso: lote.fechaIngreso,
          fechaVencimiento: lote.fechaVencimiento,
          cantidad: lote.cantidad,
          proveedor: lote.proveedor,
          syncStatus: Value('synced'),
          updatedAt: Value(lote.updatedAt),
        ));
      } else {
        await _db.lotesDao.updateLote(LotesCompanion(
          id: Value(lote.id),
          insumoId: Value(lote.insumoId),
          numeroLote: Value(lote.numeroLote),
          fechaIngreso: Value(lote.fechaIngreso),
          fechaVencimiento: Value(lote.fechaVencimiento),
          cantidad: Value(lote.cantidad),
          proveedor: Value(lote.proveedor),
          updatedAt: Value(lote.updatedAt),
          syncStatus: Value('synced'),
        ));
      }
    }
  }

  Future<void> _refreshMovimientosFromRemote() async {
    final remote = await _firebase.getRecentMovimientos(limit: 1000);
    final existingAll = await _db.movimientosDao.getAllMovimientos();
    final existingIds = existingAll.map((r) => r.id).toSet();
    for (final m in remote) {
      if (!existingIds.contains(m.id)) {
        await _db.movimientosDao.insertMovimiento(MovimientosCompanion.insert(
          id: m.id,
          insumoId: m.insumoId,
          loteId: Value(m.loteId),
          tipo: m.tipo.name,
          cantidad: m.cantidad,
          responsableId: m.responsableId,
          responsableNombre: m.responsableNombre,
          observaciones: Value(m.observaciones),
          fecha: m.fecha,
          syncStatus: Value('synced'),
        ));
      }
    }
  }

  Future<void> _syncInsumos() async {
    final pending = await _db.insumosDao.getPendingSync();
    for (final row in pending) {
      try {
        final model = InsumoModel(
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
        await _firebase.saveInsumo(model);
        await _db.insumosDao.markAsSynced(row.id);
      } catch (e) {
        await _db.insumosDao.markAsFailed(row.id);
      }
    }
  }

  Future<void> _syncLotes() async {
    final pending = await _db.lotesDao.getPendingSync();
    for (final row in pending) {
      try {
        final model = LoteModel(
          id: row.id,
          insumoId: row.insumoId,
          numeroLote: row.numeroLote,
          fechaIngreso: row.fechaIngreso,
          fechaVencimiento: row.fechaVencimiento,
          cantidad: row.cantidad,
          proveedor: row.proveedor,
          updatedAt: row.updatedAt,
        );
        await _firebase.saveLote(model);
        await _db.lotesDao.markAsSynced(row.id);
      } catch (e) {
        await _db.lotesDao.markAsFailed(row.id);
      }
    }
  }

  Future<void> _syncMovimientos() async {
    final pending = await _db.movimientosDao.getPendingSync();
    for (final row in pending) {
      try {
        final model = MovimientoModel(
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
        await _firebase.saveMovimiento(model);
        await _db.movimientosDao.markAsSynced(row.id);
      } catch (e) {
        await _db.movimientosDao.markAsFailed(row.id);
      }
    }
  }

  Future<void> _syncSolicitudes() async {
    final pending = await _db.solicitudesDao.getPendingSync();
    for (final row in pending) {
      try {
        final model = SolicitudModel(
          id: row.id,
          insumoId: row.insumoId,
          insumoNombre: row.insumoNombre,
          cantidadSolicitada: row.cantidadSolicitada,
          solicitanteId: row.solicitanteId,
          solicitanteNombre: row.solicitanteNombre,
          estado: SolicitudEstado.fromString(row.estado),
          motivo: row.motivo,
          observacionesAdmin: row.observacionesAdmin,
          fechaSolicitud: row.fechaSolicitud,
          fechaRespuesta: row.fechaRespuesta,
          syncStatus: row.syncStatus,
        );
        await _firebase.saveSolicitud(model);
        await _db.solicitudesDao.markAsSynced(row.id);
      } catch (e) {
        await _db.solicitudesDao.markAsFailed(row.id);
      }
    }
  }
}
