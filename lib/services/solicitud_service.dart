import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../data/app_database.dart';
import '../models/solicitud_model.dart';
import '../utils/enums.dart';
import 'firebase_service.dart';
import 'inventory_service.dart';

class SolicitudService {
  final AppDatabase _db;
  final FirebaseService _firebase;
  final _uuid = const Uuid();

  SolicitudService(this._db, this._firebase);

  Future<List<SolicitudModel>> getAllSolicitudes() async {
    final rows = await _db.solicitudesDao.getAllSolicitudes();
    return rows.map(_dbToModel).toList();
  }

  Stream<List<SolicitudModel>> watchSolicitudes() =>
      _db.solicitudesDao.watchAllSolicitudes()
          .map((rows) => rows.map(_dbToModel).toList());

  Future<List<SolicitudModel>> getSolicitudesByEstado(
      SolicitudEstado estado) async {
    final rows =
        await _db.solicitudesDao.getSolicitudesByEstado(estado.name);
    return rows.map(_dbToModel).toList();
  }

  Future<List<SolicitudModel>> getMisSolicitudes(String userId) async {
    final rows = await _db.solicitudesDao.getSolicitudesByUser(userId);
    return rows.map(_dbToModel).toList();
  }

  Future<SolicitudModel?> getSolicitudById(String id) async {
    final row = await _db.solicitudesDao.getSolicitudById(id);
    return row == null ? null : _dbToModel(row);
  }

  Future<SolicitudModel> createSolicitud({
    required String insumoId,
    required String insumoNombre,
    required int cantidadSolicitada,
    required String solicitanteId,
    required String solicitanteNombre,
    required String motivo,
  }) async {
    final now = DateTime.now();
    final solicitud = SolicitudModel(
      id: _uuid.v4(),
      insumoId: insumoId,
      insumoNombre: insumoNombre,
      cantidadSolicitada: cantidadSolicitada,
      solicitanteId: solicitanteId,
      solicitanteNombre: solicitanteNombre,
      estado: SolicitudEstado.pendiente,
      motivo: motivo,
      fechaSolicitud: now,
    );
    await _db.solicitudesDao.insertSolicitud(SolicitudesCompanion.insert(
      id: solicitud.id,
      insumoId: insumoId,
      insumoNombre: insumoNombre,
      cantidadSolicitada: cantidadSolicitada,
      solicitanteId: solicitanteId,
      solicitanteNombre: solicitanteNombre,
      estado: const Value('pendiente'),
      motivo: motivo,
      fechaSolicitud: now,
      syncStatus: const Value('pending'),
    ));
    _trySyncSolicitud(solicitud);
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

    // Descontar stock usando FEFO
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
    );
    await _updateSolicitud(updated);
  }

  Future<void> rechazarSolicitud(String id,
      {required String observaciones}) async {
    final solicitud = await getSolicitudById(id);
    if (solicitud == null) throw Exception('Solicitud no encontrada');
    final updated = solicitud.copyWith(
      estado: SolicitudEstado.rechazada,
      observacionesAdmin: observaciones,
      fechaRespuesta: DateTime.now(),
    );
    await _updateSolicitud(updated);
  }

  Future<void> _updateSolicitud(SolicitudModel s) async {
    await _db.solicitudesDao.updateSolicitud(SolicitudesCompanion(
      id: Value(s.id),
      estado: Value(s.estado.name),
      observacionesAdmin: Value(s.observacionesAdmin),
      fechaRespuesta: Value(s.fechaRespuesta),
      syncStatus: const Value('pending'),
    ));
    _trySyncSolicitud(s);
  }

  Future<int> countPendientes() => _db.solicitudesDao.countPendientes();

  void _trySyncSolicitud(SolicitudModel s) async {
    try {
      await _firebase.saveSolicitud(s);
      await _db.solicitudesDao.markAsSynced(s.id);
    } catch (_) {}
  }

  SolicitudModel _dbToModel(DbSolicitud row) => SolicitudModel(
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
}
