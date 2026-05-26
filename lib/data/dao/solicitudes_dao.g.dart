// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitudes_dao.dart';

// ignore_for_file: type=lint
mixin _$SolicitudesDaoMixin on DatabaseAccessor<AppDatabase> {
  $SolicitudesTable get solicitudes => attachedDatabase.solicitudes;
  SolicitudesDaoManager get managers => SolicitudesDaoManager(this);
}

class SolicitudesDaoManager {
  final _$SolicitudesDaoMixin _db;
  SolicitudesDaoManager(this._db);
  $$SolicitudesTableTableManager get solicitudes =>
      $$SolicitudesTableTableManager(_db.attachedDatabase, _db.solicitudes);
}
