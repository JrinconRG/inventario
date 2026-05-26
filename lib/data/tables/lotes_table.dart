import 'package:drift/drift.dart';

@DataClassName('DbLote')
class Lotes extends Table {
  TextColumn get id => text()();
  TextColumn get insumoId => text()();
  TextColumn get numeroLote => text()();
  DateTimeColumn get fechaIngreso => dateTime()();
  DateTimeColumn get fechaVencimiento => dateTime()();
  IntColumn get cantidad => integer()();
  TextColumn get proveedor => text()();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('pending'))();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
