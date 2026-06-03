import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../data/app_database.dart';
import '../data/tables/solicitudes_table.dart';
import '../models/solicitud_model.dart';
import '../utils/enums.dart';
import 'firebase_service.dart';
import 'inventory_service.dart';
import 'sync_service.dart';

class SolicitudService {
  final FirebaseService _firebase;
  final AppDatabase _db;
  final SyncService _syncService;
  final _uuid = const Uuid();

  SolicitudService(this._firebase, this._db, this._syncService);

  Future<List<SolicitudModel>> getAllSolicitudes() async {
    // Obtener de la DB local primero
    final local = await _db.solicitudesDao.getAllSolicitudes();
    return local
        .map((row) => SolicitudModel(
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
            ))
        .toList();
  }

  Stream<List<SolicitudModel>> watchSolicitudes() {
    return _db.solicitudesDao.watchAllSolicitudes().map(
          (rows) => rows
              .map((row) => SolicitudModel(
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
                  ))
              .toList(),
        );
  }

  Future<List<SolicitudModel>> getSolicitudesByEstado(
      SolicitudEstado estado) async {
    final local = await _db.solicitudesDao.getSolicitudesByEstado(estado.name);
    return local
        .map((row) => SolicitudModel(
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
            ))
        .toList();
  }

  Future<List<SolicitudModel>> getMisSolicitudes(String userId) async {
    final local = await _db.solicitudesDao.getSolicitudesByUser(userId);
    return local
        .map((row) => SolicitudModel(
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
            ))
        .toList();
  }

  Future<SolicitudModel?> getSolicitudById(String id) async {
    final row = await _db.solicitudesDao.getSolicitudById(id);
    if (row == null) return null;

    return SolicitudModel(
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
  }

  /// Crear solicitud de forma OFFLINE-FIRST
  /// 1. Guarda localmente (SIEMPRE)
  /// 2. Intenta sincronizar si hay conexión
  Future<SolicitudModel> createSolicitud({
    required String insumoId,
    required String insumoNombre,
    required int cantidadSolicitada,
    required String solicitanteId,
    required String solicitanteNombre,
    required String motivo,
  }) async {
    final solicitud = SolicitudModel(
      id: _uuid.v4(),
      insumoId: insumoId,
      insumoNombre: insumoNombre,
      cantidadSolicitada: cantidadSolicitada,
      solicitanteId: solicitanteId,
      solicitanteNombre: solicitanteNombre,
      estado: SolicitudEstado.pendiente,
      motivo: motivo,
      fechaSolicitud: DateTime.now(),
      syncStatus: 'pending', // Marcado como pendiente de sincronizar
    );

    // 1. GUARDAR LOCALMENTE (SIEMPRE, sin necesidad de conexión)
    await _db.solicitudesDao.insertSolicitud(SolicitudesCompanion(
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
      syncStatus: const Value('pending'),
    ));

    // 2. INTENTAR SINCRONIZAR SI HAY CONEXIÓN
    final isOnline = await _syncService.isOnline();
    if (isOnline) {
      try {
        await _firebase.saveSolicitud(solicitud);
        await _db.solicitudesDao.markAsSynced(solicitud.id);
      } catch (_) {
        // Si falla, dejar como 'pending' para reintentar luego
        // El SyncService lo intentará automáticamente cuando hay conexión
      }
    }

    return solicitud;
  }

  Future<void> aprobarSolicitud(
    String id, {
    required String observaciones,
    required InventoryService inventoryService,
    required String adminId,
    required String adminNombre,
  }) async {
    final solicitud = await getSolicitudById(id);
    if (solicitud == null) throw Exception('Solicitud no encontrada');

    await inventoryService.registrarMovimiento(
      insumoId: solicitud.insumoId,
      tipo: MovimientoTipo.salida,
      cantidad: solicitud.cantidadSolicitada,
      responsableId: adminId,
      responsableNombre: adminNombre,
      observaciones: 'Aprobación de solicitud #${id.substring(0, 8)}',
    );

    final updated = solicitud.copyWith(
      estado: SolicitudEstado.aprobada,
      observacionesAdmin: observaciones,
      fechaRespuesta: DateTime.now(),
      syncStatus: 'pending',
    );

    // Guardar localmente
    await _db.solicitudesDao.updateSolicitud(SolicitudesCompanion(
      id: Value(updated.id),
      insumoId: Value(updated.insumoId),
      insumoNombre: Value(updated.insumoNombre),
      cantidadSolicitada: Value(updated.cantidadSolicitada),
      solicitanteId: Value(updated.solicitanteId),
      solicitanteNombre: Value(updated.solicitanteNombre),
      estado: Value(updated.estado.name),
      motivo: Value(updated.motivo),
      observacionesAdmin: Value(updated.observacionesAdmin),
      fechaSolicitud: Value(updated.fechaSolicitud),
      fechaRespuesta: Value(updated.fechaRespuesta),
      syncStatus: const Value('pending'),
    ));

    // Intentar sincronizar
    final isOnline = await _syncService.isOnline();
    if (isOnline) {
      try {
        await _firebase.saveSolicitud(updated);
        await _db.solicitudesDao.markAsSynced(updated.id);
      } catch (_) {
        // Dejar como pending para sincronizar después
      }
    }
  }

  Future<void> rechazarSolicitud(String id,
      {required String observaciones}) async {
    final solicitud = await getSolicitudById(id);
    if (solicitud == null) throw Exception('Solicitud no encontrada');

    final updated = solicitud.copyWith(
      estado: SolicitudEstado.rechazada,
      observacionesAdmin: observaciones,
      fechaRespuesta: DateTime.now(),
      syncStatus: 'pending',
    );

    // Guardar localmente
    await _db.solicitudesDao.updateSolicitud(SolicitudesCompanion(
      id: Value(updated.id),
      insumoId: Value(updated.insumoId),
      insumoNombre: Value(updated.insumoNombre),
      cantidadSolicitada: Value(updated.cantidadSolicitada),
      solicitanteId: Value(updated.solicitanteId),
      solicitanteNombre: Value(updated.solicitanteNombre),
      estado: Value(updated.estado.name),
      motivo: Value(updated.motivo),
      observacionesAdmin: Value(updated.observacionesAdmin),
      fechaSolicitud: Value(updated.fechaSolicitud),
      fechaRespuesta: Value(updated.fechaRespuesta),
      syncStatus: const Value('pending'),
    ));

    // Intentar sincronizar
    final isOnline = await _syncService.isOnline();
    if (isOnline) {
      try {
        await _firebase.saveSolicitud(updated);
        await _db.solicitudesDao.markAsSynced(updated.id);
      } catch (_) {
        // Dejar como pending
      }
    }
  }

  Future<int> countPendientes() async {
    return await _db.solicitudesDao.countPendientes();
  }
}
