import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../data/app_database.dart';
import '../models/insumo_model.dart';
import '../models/lote_model.dart';
import '../models/movimiento_model.dart';
import '../models/solicitud_model.dart';
import '../models/alerta_model.dart';
import '../utils/enums.dart';
import 'firebase_service.dart';

class SyncService {
  final AppDatabase _db;
  final FirebaseService _firebase;
  StreamSubscription<ConnectivityResult>? _connectivitySub;
  bool _isSyncing = false;

  SyncService(this._db, this._firebase);

  void startListening() {
    _connectivitySub = Connectivity()
        .onConnectivityChanged
        .listen((result) {
      if (result != ConnectivityResult.none) syncAll();
    });
  }

  void stopListening() => _connectivitySub?.cancel();

  Future<bool> isOnline() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<void> syncAll() async {
    if (_isSyncing) return;
    _isSyncing = true;
    try {
      await Future.wait([
        _syncInsumos(),
        _syncLotes(),
        _syncMovimientos(),
        _syncSolicitudes(),
        _syncAlertas(),
      ]);
    } finally {
      _isSyncing = false;
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
      } catch (_) {}
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
      } catch (_) {}
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
      } catch (_) {}
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
        );
        await _firebase.saveSolicitud(model);
        await _db.solicitudesDao.markAsSynced(row.id);
      } catch (_) {}
    }
  }

  Future<void> _syncAlertas() async {
    final pending = await _db.alertasDao.getPendingSync();
    for (final row in pending) {
      try {
        final model = AlertaModel(
          id: row.id,
          tipo: AlertaTipo.fromString(row.tipo),
          titulo: row.titulo,
          mensaje: row.mensaje,
          insumoId: row.insumoId,
          loteId: row.loteId,
          leida: row.leida,
          fechaCreacion: row.fechaCreacion,
        );
        await _firebase.saveAlerta(model);
        await _db.alertasDao.markAsSynced(row.id);
      } catch (_) {}
    }
  }
}
