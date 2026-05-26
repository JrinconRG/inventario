import 'package:drift/drift.dart';

@DataClassName('DbInsumo')
class Insumos extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text()();
  TextColumn get descripcion => text()();
  TextColumn get categoria => text()();
  IntColumn get stockTotal => integer().withDefault(const Constant(0))();
  IntColumn get stockMinimo => integer().withDefault(const Constant(5))();
  TextColumn get unidadMedida => text()();
  TextColumn get estado => text().withDefault(const Constant('activo'))();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
