import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/usuarios_table.dart';

part 'usuarios_dao.g.dart';

@DriftAccessor(tables: [Usuarios])
class UsuariosDao extends DatabaseAccessor<AppDatabase>
    with _$UsuariosDaoMixin {
  UsuariosDao(super.db);

  Future<List<DbUsuario>> getAllUsuarios() => select(usuarios).get();

  Future<DbUsuario?> getUsuarioById(String id) =>
      (select(usuarios)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<DbUsuario?> getUsuarioByEmail(String email) =>
      (select(usuarios)..where((u) => u.email.equals(email)))
          .getSingleOrNull();

  Future<int> insertUsuario(UsuariosCompanion entry) =>
      into(usuarios).insert(entry);

  Future<bool> updateUsuario(UsuariosCompanion entry) =>
      update(usuarios).replace(entry);

  Future<int> deleteUsuario(String id) =>
      (delete(usuarios)..where((u) => u.id.equals(id))).go();

  Stream<List<DbUsuario>> watchAllUsuarios() => select(usuarios).watch();

  Future<List<DbUsuario>> getPendingSync() =>
      (select(usuarios)..where((u) => u.syncStatus.equals('pending'))).get();

  Future<void> markAsSynced(String id) =>
      (update(usuarios)..where((u) => u.id.equals(id)))
          .write(const UsuariosCompanion(syncStatus: Value('synced')));
}
