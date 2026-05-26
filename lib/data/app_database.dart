import 'package:drift/drift.dart';

import 'connection/native.dart'
    if (dart.library.html) 'connection/web.dart';

import 'tables/usuarios_table.dart';
import 'tables/insumos_table.dart';
import 'tables/lotes_table.dart';
import 'tables/movimientos_table.dart';
import 'tables/solicitudes_table.dart';
import 'tables/alertas_table.dart';
import 'dao/usuarios_dao.dart';
import 'dao/insumos_dao.dart';
import 'dao/lotes_dao.dart';
import 'dao/movimientos_dao.dart';
import 'dao/solicitudes_dao.dart';
import 'dao/alertas_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Usuarios,
    Insumos,
    Lotes,
    Movimientos,
    Solicitudes,
    Alertas,
  ],
  daos: [
    UsuariosDao,
    InsumosDao,
    LotesDao,
    MovimientosDao,
    SolicitudesDao,
    AlertasDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(connect());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Agregar migraciones futuras aquí
        },
      );
}

