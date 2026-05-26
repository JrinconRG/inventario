import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/movimientos_table.dart';

part 'movimientos_dao.g.dart';

@DriftAccessor(tables: [Movimientos])
class MovimientosDao extends DatabaseAccessor<AppDatabase>
    with _$MovimientosDaoMixin {
  MovimientosDao(super.db);

  Future<List<DbMovimiento>> getAllMovimientos() =>
      (select(movimientos)
            ..orderBy([(m) => OrderingTerm.desc(m.fecha)]))
          .get();

  Stream<List<DbMovimiento>> watchAllMovimientos() =>
      (select(movimientos)
            ..orderBy([(m) => OrderingTerm.desc(m.fecha)]))
          .watch();

  Future<List<DbMovimiento>> getMovimientosByInsumo(String insumoId) =>
      (select(movimientos)
            ..where((m) => m.insumoId.equals(insumoId))
            ..orderBy([(m) => OrderingTerm.desc(m.fecha)]))
          .get();

  Future<List<DbMovimiento>> getRecentMovimientos({int limit = 10}) =>
      (select(movimientos)
            ..orderBy([(m) => OrderingTerm.desc(m.fecha)])
            ..limit(limit))
          .get();

  Future<int> insertMovimiento(MovimientosCompanion entry) =>
      into(movimientos).insert(entry);

  Future<List<DbMovimiento>> getPendingSync() =>
      (select(movimientos)
            ..where((m) => m.syncStatus.equals('pending')))
          .get();

  Future<void> markAsSynced(String id) =>
      (update(movimientos)..where((m) => m.id.equals(id)))
          .write(const MovimientosCompanion(syncStatus: Value('synced')));
}
