import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/insumos_table.dart';

part 'insumos_dao.g.dart';

@DriftAccessor(tables: [Insumos])
class InsumosDao extends DatabaseAccessor<AppDatabase>
    with _$InsumosDaoMixin {
  InsumosDao(super.db);

  Future<List<DbInsumo>> getAllInsumos() => select(insumos).get();

  Stream<List<DbInsumo>> watchAllInsumos() => select(insumos).watch();

  Future<DbInsumo?> getInsumoById(String id) =>
      (select(insumos)..where((i) => i.id.equals(id))).getSingleOrNull();

  Future<List<DbInsumo>> searchInsumos(String query) =>
      (select(insumos)..where((i) => i.nombre.like('%$query%'))).get();

  Future<List<DbInsumo>> getInsumosPorCategoria(String categoria) =>
      (select(insumos)..where((i) => i.categoria.equals(categoria))).get();

  Future<List<DbInsumo>> getInsumosCriticos() => (select(insumos)
        ..where((i) => i.stockTotal.isSmallerOrEqualValue(i.stockMinimo)))
      .get();

  Future<int> insertInsumo(InsumosCompanion entry) =>
      into(insumos).insert(entry);

  Future<bool> updateInsumo(InsumosCompanion entry) =>
      update(insumos).replace(entry);

  Future<int> deleteInsumo(String id) =>
      (delete(insumos)..where((i) => i.id.equals(id))).go();

  Future<void> updateStock(String id, int nuevoStock) =>
      (update(insumos)..where((i) => i.id.equals(id))).write(
        InsumosCompanion(
          stockTotal: Value(nuevoStock),
          updatedAt: Value(DateTime.now()),
          syncStatus: const Value('pending'),
        ),
      );

  Future<List<DbInsumo>> getPendingSync() =>
      (select(insumos)..where((i) => i.syncStatus.equals('pending'))).get();

  Future<void> markAsSynced(String id) =>
      (update(insumos)..where((i) => i.id.equals(id)))
          .write(const InsumosCompanion(syncStatus: Value('synced')));
}
