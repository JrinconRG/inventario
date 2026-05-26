import 'package:drift/drift.dart';

@DataClassName('DbUsuario')
class Usuarios extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get nombre => text()();
  TextColumn get apellido => text()();
  TextColumn get rol => text().withDefault(const Constant('docente'))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
