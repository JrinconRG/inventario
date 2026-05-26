// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movimientos_dao.dart';

// ignore_for_file: type=lint
mixin _$MovimientosDaoMixin on DatabaseAccessor<AppDatabase> {
  $MovimientosTable get movimientos => attachedDatabase.movimientos;
  MovimientosDaoManager get managers => MovimientosDaoManager(this);
}

class MovimientosDaoManager {
  final _$MovimientosDaoMixin _db;
  MovimientosDaoManager(this._db);
  $$MovimientosTableTableManager get movimientos =>
      $$MovimientosTableTableManager(_db.attachedDatabase, _db.movimientos);
}
