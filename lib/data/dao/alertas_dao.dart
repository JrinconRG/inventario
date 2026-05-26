import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/alertas_table.dart';

part 'alertas_dao.g.dart';

@DriftAccessor(tables: [Alertas])
class AlertasDao extends DatabaseAccessor<AppDatabase>
    with _$AlertasDaoMixin {
  AlertasDao(super.db);

  Future<List<DbAlerta>> getAllAlertas() =>
      (select(alertas)
            ..orderBy([(a) => OrderingTerm.desc(a.fechaCreacion)]))
          .get();

  Stream<List<DbAlerta>> watchAllAlertas() =>
      (select(alertas)
            ..orderBy([(a) => OrderingTerm.desc(a.fechaCreacion)]))
          .watch();

  Stream<List<DbAlerta>> watchUnreadAlertas() =>
      (select(alertas)
            ..where((a) => a.leida.equals(false))
            ..orderBy([(a) => OrderingTerm.desc(a.fechaCreacion)]))
          .watch();

  Future<int> countUnread() async {
    final rows = await (select(alertas)
          ..where((a) => a.leida.equals(false)))
        .get();
    return rows.length;
  }

  Future<int> insertAlerta(AlertasCompanion entry) =>
      into(alertas).insert(entry, mode: InsertMode.insertOrIgnore);

  Future<void> markAsRead(String id) =>
      (update(alertas)..where((a) => a.id.equals(id)))
          .write(const AlertasCompanion(leida: Value(true)));

  Future<void> markAllAsRead() =>
      update(alertas).write(const AlertasCompanion(leida: Value(true)));

  Future<int> deleteAlerta(String id) =>
      (delete(alertas)..where((a) => a.id.equals(id))).go();

  Future<List<DbAlerta>> getPendingSync() =>
      (select(alertas)..where((a) => a.syncStatus.equals('pending'))).get();

  Future<void> markAsSynced(String id) =>
      (update(alertas)..where((a) => a.id.equals(id)))
          .write(const AlertasCompanion(syncStatus: Value('synced')));
}
