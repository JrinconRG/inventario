import 'package:drift/drift.dart';

@DataClassName('DbMovimiento')
class Movimientos extends Table {
  TextColumn get id => text()();
  TextColumn get insumoId => text()();
  TextColumn get loteId => text().nullable()();
  TextColumn get tipo => text()();
  IntColumn get cantidad => integer()();
  TextColumn get responsableId => text()();
  TextColumn get responsableNombre => text()();
  TextColumn get observaciones => text().withDefault(const Constant(''))();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}
