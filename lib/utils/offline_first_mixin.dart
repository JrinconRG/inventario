import '../data/app_database.dart';
import '../services/sync_service.dart';

/// Mixin para facilitar operaciones offline-first en cualquier servicio
mixin OfflineFirstMixin {
  AppDatabase get db;
  SyncService get syncService;

  /// Crear un registro de forma offline-first
  ///
  /// El registro se guarda localmente primero (siempre), luego intenta sincronizar
  /// si hay conexión disponible.
  Future<void> createOfflineFirst({
    required Future<void> Function() saveLocal,
    required String recordType,
  }) async {
    try {
      // 1. Guardar localmente (SIEMPRE, sin excepciones)
      await saveLocal();

      // 2. Intentar sincronizar si hay conexión
      final isOnline = await syncService.isOnline();
      if (isOnline) {
        await syncService.syncAll();
      }
    } catch (e) {
      // Si falla el guardado local, es un error crítico
      rethrow;
    }
  }

  /// Verificar estado de sincronización de un registro
  Future<String> getSyncStatus({
    required String id,
    required String table,
  }) async {
    // Este método requeriría una implementación más específica
    // por tabla, pero aquí va el concepto
    switch (table) {
      case 'insumos':
        final insumo = await db.insumosDao.getInsumoById(id);
        return insumo?.syncStatus ?? 'unknown';
      case 'solicitudes':
        final solicitud = await db.solicitudesDao.getSolicitudById(id);
        return solicitud?.syncStatus ?? 'unknown';
      case 'movimientos':
        // Implementar según sea necesario
        return 'unknown';
      default:
        return 'unknown';
    }
  }

  /// Obtener todos los registros pendientes de sincronizar
  Future<int> getPendingCount() => syncService.getPendingCount();

  /// Obtener todos los registros con error de sincronización
  Future<int> getFailedCount() => syncService.getFailedCount();

  /// Forzar sincronización inmediata
  Future<void> syncNow() => syncService.syncAll();

  /// Reintentar registros con error
  Future<void> retryFailed() async {
    // Cambiar failed a pending
    final failedInsumos = await db.insumosDao.getFailedSync();
    for (final insumo in failedInsumos) {
      await db.insumosDao.markAsPending(insumo.id);
    }

    final failedLotes = await db.lotesDao.getFailedSync();
    for (final lote in failedLotes) {
      await db.lotesDao.markAsPending(lote.id);
    }

    final failedMovimientos = await db.movimientosDao.getFailedSync();
    for (final movimiento in failedMovimientos) {
      await db.movimientosDao.markAsPending(movimiento.id);
    }

    final failedSolicitudes = await db.solicitudesDao.getFailedSync();
    for (final solicitud in failedSolicitudes) {
      await db.solicitudesDao.markAsPending(solicitud.id);
    }

    // Intentar sincronizar
    await syncService.syncAll();
  }
}
