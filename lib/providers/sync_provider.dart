import 'package:flutter/material.dart';
import '../data/app_database.dart';
import '../services/sync_service.dart';

class SyncProvider extends ChangeNotifier {
  final SyncService _syncService;
  final AppDatabase _db;

  int _pendingCount = 0;
  int _failedCount = 0;
  String? _lastError;

  SyncProvider(this._syncService, this._db) {
    _syncService.addListener(_onSyncStateChanged);
    loadCounts();
  }

  int get pendingCount => _pendingCount;
  int get failedCount => _failedCount;
  bool get isSyncing => _syncService.isSyncing;
  String? get lastError => _lastError;

  bool get hasPendingOrFailed => _pendingCount > 0 || _failedCount > 0;

  void _onSyncStateChanged() {
    // Actualizar estado cuando cambia la sincronización
    notifyListeners();
  }

  Future<void> loadCounts() async {
    _pendingCount = await _syncService.getPendingCount();
    _failedCount = await _syncService.getFailedCount();
    notifyListeners();
  }

  Future<void> syncNow() async {
    _lastError = null;
    notifyListeners();

    try {
      final isOnline = await _syncService.isOnline();
      if (!isOnline) {
        _lastError = 'Sin conexión a Internet';
        notifyListeners();
        return;
      }

      await _syncService.syncAll();
      await loadCounts();
      _lastError = null;
    } catch (e) {
      _lastError = 'Error al sincronizar: ${e.toString()}';
    } finally {
      notifyListeners();
    }
  }

  Future<void> retrySyncFailed() async {
    _lastError = null;
    notifyListeners();

    try {
      final isOnline = await _syncService.isOnline();
      if (!isOnline) {
        _lastError = 'Sin conexión a Internet';
        notifyListeners();
        return;
      }

      // Cambiar registros fallidos a pendientes e intentar sincronizar
      await _retryFailedRecords();
      await _syncService.syncAll();
      await loadCounts();
      _lastError = null;
    } catch (e) {
      _lastError = 'Error al reintentar: ${e.toString()}';
    } finally {
      notifyListeners();
    }
  }

  Future<void> _retryFailedRecords() async {
    // Cambiar todos los registros 'failed' a 'pending'
    final failedInsumos = await _db.insumosDao.getFailedSync();
    for (final insumo in failedInsumos) {
      await _db.insumosDao.markAsPending(insumo.id);
    }

    final failedLotes = await _db.lotesDao.getFailedSync();
    for (final lote in failedLotes) {
      await _db.lotesDao.markAsPending(lote.id);
    }

    final failedMovimientos = await _db.movimientosDao.getFailedSync();
    for (final movimiento in failedMovimientos) {
      await _db.movimientosDao.markAsPending(movimiento.id);
    }

    final failedSolicitudes = await _db.solicitudesDao.getFailedSync();
    for (final solicitud in failedSolicitudes) {
      await _db.solicitudesDao.markAsPending(solicitud.id);
    }
  }

  @override
  void dispose() {
    _syncService.removeListener(_onSyncStateChanged);
    super.dispose();
  }
}
