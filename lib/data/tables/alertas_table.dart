import 'package:drift/drift.dart';

@DataClassName('DbAlerta')
class Alertas extends Table {
  TextColumn get id => text()();
  TextColumn get tipo => text()();
  TextColumn get titulo => text()();
  TextColumn get mensaje => text()();
  TextColumn get insumoId => text().nullable()();
  TextColumn get loteId => text().nullable()();
  BoolColumn get leida => boolean().withDefault(const Constant(false))();
  DateTimeColumn get fechaCreacion => dateTime()();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}
