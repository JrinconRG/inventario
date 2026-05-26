import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/solicitudes_table.dart';

part 'solicitudes_dao.g.dart';

@DriftAccessor(tables: [Solicitudes])
class SolicitudesDao extends DatabaseAccessor<AppDatabase>
    with _$SolicitudesDaoMixin {
  SolicitudesDao(super.db);

  Future<List<DbSolicitud>> getAllSolicitudes() =>
      (select(solicitudes)
            ..orderBy([(s) => OrderingTerm.desc(s.fechaSolicitud)]))
          .get();

  Stream<List<DbSolicitud>> watchAllSolicitudes() =>
      (select(solicitudes)
            ..orderBy([(s) => OrderingTerm.desc(s.fechaSolicitud)]))
          .watch();

  Future<List<DbSolicitud>> getSolicitudesByEstado(String estado) =>
      (select(solicitudes)
            ..where((s) => s.estado.equals(estado))
            ..orderBy([(s) => OrderingTerm.desc(s.fechaSolicitud)]))
          .get();

  Future<List<DbSolicitud>> getSolicitudesByUser(String userId) =>
      (select(solicitudes)
            ..where((s) => s.solicitanteId.equals(userId))
            ..orderBy([(s) => OrderingTerm.desc(s.fechaSolicitud)]))
          .get();

  Future<DbSolicitud?> getSolicitudById(String id) =>
      (select(solicitudes)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<int> insertSolicitud(SolicitudesCompanion entry) =>
      into(solicitudes).insert(entry);

  Future<bool> updateSolicitud(SolicitudesCompanion entry) =>
      update(solicitudes).replace(entry);

  Future<int> countPendientes() async {
    final rows = await (select(solicitudes)
          ..where((s) => s.estado.equals('pendiente')))
        .get();
    return rows.length;
  }

  Future<List<DbSolicitud>> getPendingSync() =>
      (select(solicitudes)
            ..where((s) => s.syncStatus.equals('pending')))
          .get();

  Future<void> markAsSynced(String id) =>
      (update(solicitudes)..where((s) => s.id.equals(id)))
          .write(const SolicitudesCompanion(syncStatus: Value('synced')));
}
