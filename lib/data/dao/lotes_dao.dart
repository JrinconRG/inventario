import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/lotes_table.dart';

part 'lotes_dao.g.dart';

@DriftAccessor(tables: [Lotes])
class LotesDao extends DatabaseAccessor<AppDatabase> with _$LotesDaoMixin {
  LotesDao(super.db);

  Future<List<DbLote>> getLotesByInsumo(String insumoId) =>
      (select(lotes)..where((l) => l.insumoId.equals(insumoId))).get();

  Stream<List<DbLote>> watchLotesByInsumo(String insumoId) =>
      (select(lotes)..where((l) => l.insumoId.equals(insumoId))).watch();

  Future<DbLote?> getLoteById(String id) =>
      (select(lotes)..where((l) => l.id.equals(id))).getSingleOrNull();

  /// FEFO: retorna lotes ordenados por fecha de vencimiento más próxima.
  Future<List<DbLote>> getLotesFEFO(String insumoId) =>
      (select(lotes)
            ..where((l) => l.insumoId.equals(insumoId))
            ..orderBy([(l) => OrderingTerm.asc(l.fechaVencimiento)]))
          .get();

  Future<List<DbLote>> getLotesVencidos() => (select(lotes)
        ..where((l) => l.fechaVencimiento
            .isSmallerThanValue(DateTime.now())))
      .get();

  Future<List<DbLote>> getLotesProximosAVencer(int diasLimite) {
    final limite = DateTime.now().add(Duration(days: diasLimite));
    return (select(lotes)
          ..where((l) =>
              l.fechaVencimiento.isBiggerOrEqualValue(DateTime.now()) &
              l.fechaVencimiento.isSmallerThanValue(limite)))
        .get();
  }

  Future<int> insertLote(LotesCompanion entry) => into(lotes).insert(entry);

  Future<bool> updateLote(LotesCompanion entry) =>
      update(lotes).replace(entry);

  Future<int> deleteLote(String id) =>
      (delete(lotes)..where((l) => l.id.equals(id))).go();

  Future<void> updateCantidad(String id, int nuevaCantidad) =>
      (update(lotes)..where((l) => l.id.equals(id))).write(
        LotesCompanion(
          cantidad: Value(nuevaCantidad),
          updatedAt: Value(DateTime.now()),
          syncStatus: const Value('pending'),
        ),
      );

  Future<List<DbLote>> getPendingSync() =>
      (select(lotes)..where((l) => l.syncStatus.equals('pending'))).get();

  Future<void> markAsSynced(String id) =>
      (update(lotes)..where((l) => l.id.equals(id)))
          .write(const LotesCompanion(syncStatus: Value('synced')));
}
