part of 'alertas_dao.dart';

// ignore_for_file: type=lint
mixin _$AlertasDaoMixin on DatabaseAccessor<AppDatabase> {
  $AlertasTable get alertas => attachedDatabase.alertas;
  AlertasDaoManager get managers => AlertasDaoManager(this);
}

class AlertasDaoManager {
  final _$AlertasDaoMixin _db;
  AlertasDaoManager(this._db);
  $$AlertasTableTableManager get alertas =>
      $$AlertasTableTableManager(_db.attachedDatabase, _db.alertas);
}
