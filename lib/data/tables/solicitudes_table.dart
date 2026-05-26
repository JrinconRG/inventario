import 'package:drift/drift.dart';

@DataClassName('DbSolicitud')
class Solicitudes extends Table {
  TextColumn get id => text()();
  TextColumn get insumoId => text()();
  TextColumn get insumoNombre => text()();
  IntColumn get cantidadSolicitada => integer()();
  TextColumn get solicitanteId => text()();
  TextColumn get solicitanteNombre => text()();
  TextColumn get estado =>
      text().withDefault(const Constant('pendiente'))();
  TextColumn get motivo => text()();
  TextColumn get observacionesAdmin => text().nullable()();
  DateTimeColumn get fechaSolicitud => dateTime()();
  DateTimeColumn get fechaRespuesta => dateTime().nullable()();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}
