// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios
    with TableInfo<$UsuariosTable, DbUsuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _apellidoMeta =
      const VerificationMeta('apellido');
  @override
  late final GeneratedColumn<String> apellido = GeneratedColumn<String>(
      'apellido', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
      'rol', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('docente'));
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
      'activo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("activo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        email,
        nombre,
        apellido,
        rol,
        activo,
        syncStatus,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(Insertable<DbUsuario> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('apellido')) {
      context.handle(_apellidoMeta,
          apellido.isAcceptableOrUnknown(data['apellido']!, _apellidoMeta));
    } else if (isInserting) {
      context.missing(_apellidoMeta);
    }
    if (data.containsKey('rol')) {
      context.handle(
          _rolMeta, rol.isAcceptableOrUnknown(data['rol']!, _rolMeta));
    }
    if (data.containsKey('activo')) {
      context.handle(_activoMeta,
          activo.isAcceptableOrUnknown(data['activo']!, _activoMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbUsuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbUsuario(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      apellido: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}apellido'])!,
      rol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rol'])!,
      activo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}activo'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class DbUsuario extends DataClass implements Insertable<DbUsuario> {
  final String id;
  final String email;
  final String nombre;
  final String apellido;
  final String rol;
  final bool activo;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const DbUsuario(
      {required this.id,
      required this.email,
      required this.nombre,
      required this.apellido,
      required this.rol,
      required this.activo,
      required this.syncStatus,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['nombre'] = Variable<String>(nombre);
    map['apellido'] = Variable<String>(apellido);
    map['rol'] = Variable<String>(rol);
    map['activo'] = Variable<bool>(activo);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      email: Value(email),
      nombre: Value(nombre),
      apellido: Value(apellido),
      rol: Value(rol),
      activo: Value(activo),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DbUsuario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbUsuario(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      nombre: serializer.fromJson<String>(json['nombre']),
      apellido: serializer.fromJson<String>(json['apellido']),
      rol: serializer.fromJson<String>(json['rol']),
      activo: serializer.fromJson<bool>(json['activo']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'nombre': serializer.toJson<String>(nombre),
      'apellido': serializer.toJson<String>(apellido),
      'rol': serializer.toJson<String>(rol),
      'activo': serializer.toJson<bool>(activo),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  DbUsuario copyWith(
          {String? id,
          String? email,
          String? nombre,
          String? apellido,
          String? rol,
          bool? activo,
          String? syncStatus,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      DbUsuario(
        id: id ?? this.id,
        email: email ?? this.email,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        rol: rol ?? this.rol,
        activo: activo ?? this.activo,
        syncStatus: syncStatus ?? this.syncStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  DbUsuario copyWithCompanion(UsuariosCompanion data) {
    return DbUsuario(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      apellido: data.apellido.present ? data.apellido.value : this.apellido,
      rol: data.rol.present ? data.rol.value : this.rol,
      activo: data.activo.present ? data.activo.value : this.activo,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbUsuario(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('rol: $rol, ')
          ..write('activo: $activo, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, email, nombre, apellido, rol, activo,
      syncStatus, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbUsuario &&
          other.id == this.id &&
          other.email == this.email &&
          other.nombre == this.nombre &&
          other.apellido == this.apellido &&
          other.rol == this.rol &&
          other.activo == this.activo &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsuariosCompanion extends UpdateCompanion<DbUsuario> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> nombre;
  final Value<String> apellido;
  final Value<String> rol;
  final Value<bool> activo;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellido = const Value.absent(),
    this.rol = const Value.absent(),
    this.activo = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosCompanion.insert({
    required String id,
    required String email,
    required String nombre,
    required String apellido,
    this.rol = const Value.absent(),
    this.activo = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        email = Value(email),
        nombre = Value(nombre),
        apellido = Value(apellido),
        createdAt = Value(createdAt);
  static Insertable<DbUsuario> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? nombre,
    Expression<String>? apellido,
    Expression<String>? rol,
    Expression<bool>? activo,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (nombre != null) 'nombre': nombre,
      if (apellido != null) 'apellido': apellido,
      if (rol != null) 'rol': rol,
      if (activo != null) 'activo': activo,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosCompanion copyWith(
      {Value<String>? id,
      Value<String>? email,
      Value<String>? nombre,
      Value<String>? apellido,
      Value<String>? rol,
      Value<bool>? activo,
      Value<String>? syncStatus,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return UsuariosCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      rol: rol ?? this.rol,
      activo: activo ?? this.activo,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (apellido.present) {
      map['apellido'] = Variable<String>(apellido.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('rol: $rol, ')
          ..write('activo: $activo, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InsumosTable extends Insumos with TableInfo<$InsumosTable, DbInsumo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InsumosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stockTotalMeta =
      const VerificationMeta('stockTotal');
  @override
  late final GeneratedColumn<int> stockTotal = GeneratedColumn<int>(
      'stock_total', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _stockMinimoMeta =
      const VerificationMeta('stockMinimo');
  @override
  late final GeneratedColumn<int> stockMinimo = GeneratedColumn<int>(
      'stock_minimo', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _unidadMedidaMeta =
      const VerificationMeta('unidadMedida');
  @override
  late final GeneratedColumn<String> unidadMedida = GeneratedColumn<String>(
      'unidad_medida', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('activo'));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nombre,
        descripcion,
        categoria,
        stockTotal,
        stockMinimo,
        unidadMedida,
        estado,
        syncStatus,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'insumos';
  @override
  VerificationContext validateIntegrity(Insertable<DbInsumo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (data.containsKey('stock_total')) {
      context.handle(
          _stockTotalMeta,
          stockTotal.isAcceptableOrUnknown(
              data['stock_total']!, _stockTotalMeta));
    }
    if (data.containsKey('stock_minimo')) {
      context.handle(
          _stockMinimoMeta,
          stockMinimo.isAcceptableOrUnknown(
              data['stock_minimo']!, _stockMinimoMeta));
    }
    if (data.containsKey('unidad_medida')) {
      context.handle(
          _unidadMedidaMeta,
          unidadMedida.isAcceptableOrUnknown(
              data['unidad_medida']!, _unidadMedidaMeta));
    } else if (isInserting) {
      context.missing(_unidadMedidaMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbInsumo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbInsumo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria'])!,
      stockTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock_total'])!,
      stockMinimo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock_minimo'])!,
      unidadMedida: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unidad_medida'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $InsumosTable createAlias(String alias) {
    return $InsumosTable(attachedDatabase, alias);
  }
}

class DbInsumo extends DataClass implements Insertable<DbInsumo> {
  final String id;
  final String nombre;
  final String descripcion;
  final String categoria;
  final int stockTotal;
  final int stockMinimo;
  final String unidadMedida;
  final String estado;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const DbInsumo(
      {required this.id,
      required this.nombre,
      required this.descripcion,
      required this.categoria,
      required this.stockTotal,
      required this.stockMinimo,
      required this.unidadMedida,
      required this.estado,
      required this.syncStatus,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['categoria'] = Variable<String>(categoria);
    map['stock_total'] = Variable<int>(stockTotal);
    map['stock_minimo'] = Variable<int>(stockMinimo);
    map['unidad_medida'] = Variable<String>(unidadMedida);
    map['estado'] = Variable<String>(estado);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  InsumosCompanion toCompanion(bool nullToAbsent) {
    return InsumosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      categoria: Value(categoria),
      stockTotal: Value(stockTotal),
      stockMinimo: Value(stockMinimo),
      unidadMedida: Value(unidadMedida),
      estado: Value(estado),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DbInsumo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbInsumo(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      categoria: serializer.fromJson<String>(json['categoria']),
      stockTotal: serializer.fromJson<int>(json['stockTotal']),
      stockMinimo: serializer.fromJson<int>(json['stockMinimo']),
      unidadMedida: serializer.fromJson<String>(json['unidadMedida']),
      estado: serializer.fromJson<String>(json['estado']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'categoria': serializer.toJson<String>(categoria),
      'stockTotal': serializer.toJson<int>(stockTotal),
      'stockMinimo': serializer.toJson<int>(stockMinimo),
      'unidadMedida': serializer.toJson<String>(unidadMedida),
      'estado': serializer.toJson<String>(estado),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  DbInsumo copyWith(
          {String? id,
          String? nombre,
          String? descripcion,
          String? categoria,
          int? stockTotal,
          int? stockMinimo,
          String? unidadMedida,
          String? estado,
          String? syncStatus,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      DbInsumo(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        categoria: categoria ?? this.categoria,
        stockTotal: stockTotal ?? this.stockTotal,
        stockMinimo: stockMinimo ?? this.stockMinimo,
        unidadMedida: unidadMedida ?? this.unidadMedida,
        estado: estado ?? this.estado,
        syncStatus: syncStatus ?? this.syncStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  DbInsumo copyWithCompanion(InsumosCompanion data) {
    return DbInsumo(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      stockTotal:
          data.stockTotal.present ? data.stockTotal.value : this.stockTotal,
      stockMinimo:
          data.stockMinimo.present ? data.stockMinimo.value : this.stockMinimo,
      unidadMedida: data.unidadMedida.present
          ? data.unidadMedida.value
          : this.unidadMedida,
      estado: data.estado.present ? data.estado.value : this.estado,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbInsumo(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('categoria: $categoria, ')
          ..write('stockTotal: $stockTotal, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('unidadMedida: $unidadMedida, ')
          ..write('estado: $estado, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nombre,
      descripcion,
      categoria,
      stockTotal,
      stockMinimo,
      unidadMedida,
      estado,
      syncStatus,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbInsumo &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.categoria == this.categoria &&
          other.stockTotal == this.stockTotal &&
          other.stockMinimo == this.stockMinimo &&
          other.unidadMedida == this.unidadMedida &&
          other.estado == this.estado &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InsumosCompanion extends UpdateCompanion<DbInsumo> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<String> categoria;
  final Value<int> stockTotal;
  final Value<int> stockMinimo;
  final Value<String> unidadMedida;
  final Value<String> estado;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const InsumosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.categoria = const Value.absent(),
    this.stockTotal = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    this.unidadMedida = const Value.absent(),
    this.estado = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InsumosCompanion.insert({
    required String id,
    required String nombre,
    required String descripcion,
    required String categoria,
    this.stockTotal = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    required String unidadMedida,
    this.estado = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nombre = Value(nombre),
        descripcion = Value(descripcion),
        categoria = Value(categoria),
        unidadMedida = Value(unidadMedida),
        createdAt = Value(createdAt);
  static Insertable<DbInsumo> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<String>? categoria,
    Expression<int>? stockTotal,
    Expression<int>? stockMinimo,
    Expression<String>? unidadMedida,
    Expression<String>? estado,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (categoria != null) 'categoria': categoria,
      if (stockTotal != null) 'stock_total': stockTotal,
      if (stockMinimo != null) 'stock_minimo': stockMinimo,
      if (unidadMedida != null) 'unidad_medida': unidadMedida,
      if (estado != null) 'estado': estado,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InsumosCompanion copyWith(
      {Value<String>? id,
      Value<String>? nombre,
      Value<String>? descripcion,
      Value<String>? categoria,
      Value<int>? stockTotal,
      Value<int>? stockMinimo,
      Value<String>? unidadMedida,
      Value<String>? estado,
      Value<String>? syncStatus,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return InsumosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      categoria: categoria ?? this.categoria,
      stockTotal: stockTotal ?? this.stockTotal,
      stockMinimo: stockMinimo ?? this.stockMinimo,
      unidadMedida: unidadMedida ?? this.unidadMedida,
      estado: estado ?? this.estado,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (stockTotal.present) {
      map['stock_total'] = Variable<int>(stockTotal.value);
    }
    if (stockMinimo.present) {
      map['stock_minimo'] = Variable<int>(stockMinimo.value);
    }
    if (unidadMedida.present) {
      map['unidad_medida'] = Variable<String>(unidadMedida.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InsumosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('categoria: $categoria, ')
          ..write('stockTotal: $stockTotal, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('unidadMedida: $unidadMedida, ')
          ..write('estado: $estado, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LotesTable extends Lotes with TableInfo<$LotesTable, DbLote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _insumoIdMeta =
      const VerificationMeta('insumoId');
  @override
  late final GeneratedColumn<String> insumoId = GeneratedColumn<String>(
      'insumo_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numeroLoteMeta =
      const VerificationMeta('numeroLote');
  @override
  late final GeneratedColumn<String> numeroLote = GeneratedColumn<String>(
      'numero_lote', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaIngresoMeta =
      const VerificationMeta('fechaIngreso');
  @override
  late final GeneratedColumn<DateTime> fechaIngreso = GeneratedColumn<DateTime>(
      'fecha_ingreso', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fechaVencimientoMeta =
      const VerificationMeta('fechaVencimiento');
  @override
  late final GeneratedColumn<DateTime> fechaVencimiento =
      GeneratedColumn<DateTime>('fecha_vencimiento', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _proveedorMeta =
      const VerificationMeta('proveedor');
  @override
  late final GeneratedColumn<String> proveedor = GeneratedColumn<String>(
      'proveedor', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        insumoId,
        numeroLote,
        fechaIngreso,
        fechaVencimiento,
        cantidad,
        proveedor,
        syncStatus,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lotes';
  @override
  VerificationContext validateIntegrity(Insertable<DbLote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('insumo_id')) {
      context.handle(_insumoIdMeta,
          insumoId.isAcceptableOrUnknown(data['insumo_id']!, _insumoIdMeta));
    } else if (isInserting) {
      context.missing(_insumoIdMeta);
    }
    if (data.containsKey('numero_lote')) {
      context.handle(
          _numeroLoteMeta,
          numeroLote.isAcceptableOrUnknown(
              data['numero_lote']!, _numeroLoteMeta));
    } else if (isInserting) {
      context.missing(_numeroLoteMeta);
    }
    if (data.containsKey('fecha_ingreso')) {
      context.handle(
          _fechaIngresoMeta,
          fechaIngreso.isAcceptableOrUnknown(
              data['fecha_ingreso']!, _fechaIngresoMeta));
    } else if (isInserting) {
      context.missing(_fechaIngresoMeta);
    }
    if (data.containsKey('fecha_vencimiento')) {
      context.handle(
          _fechaVencimientoMeta,
          fechaVencimiento.isAcceptableOrUnknown(
              data['fecha_vencimiento']!, _fechaVencimientoMeta));
    } else if (isInserting) {
      context.missing(_fechaVencimientoMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('proveedor')) {
      context.handle(_proveedorMeta,
          proveedor.isAcceptableOrUnknown(data['proveedor']!, _proveedorMeta));
    } else if (isInserting) {
      context.missing(_proveedorMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbLote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbLote(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      insumoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}insumo_id'])!,
      numeroLote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero_lote'])!,
      fechaIngreso: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_ingreso'])!,
      fechaVencimiento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_vencimiento'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad'])!,
      proveedor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}proveedor'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $LotesTable createAlias(String alias) {
    return $LotesTable(attachedDatabase, alias);
  }
}

class DbLote extends DataClass implements Insertable<DbLote> {
  final String id;
  final String insumoId;
  final String numeroLote;
  final DateTime fechaIngreso;
  final DateTime fechaVencimiento;
  final int cantidad;
  final String proveedor;
  final String syncStatus;
  final DateTime? updatedAt;
  const DbLote(
      {required this.id,
      required this.insumoId,
      required this.numeroLote,
      required this.fechaIngreso,
      required this.fechaVencimiento,
      required this.cantidad,
      required this.proveedor,
      required this.syncStatus,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['insumo_id'] = Variable<String>(insumoId);
    map['numero_lote'] = Variable<String>(numeroLote);
    map['fecha_ingreso'] = Variable<DateTime>(fechaIngreso);
    map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento);
    map['cantidad'] = Variable<int>(cantidad);
    map['proveedor'] = Variable<String>(proveedor);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LotesCompanion toCompanion(bool nullToAbsent) {
    return LotesCompanion(
      id: Value(id),
      insumoId: Value(insumoId),
      numeroLote: Value(numeroLote),
      fechaIngreso: Value(fechaIngreso),
      fechaVencimiento: Value(fechaVencimiento),
      cantidad: Value(cantidad),
      proveedor: Value(proveedor),
      syncStatus: Value(syncStatus),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DbLote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbLote(
      id: serializer.fromJson<String>(json['id']),
      insumoId: serializer.fromJson<String>(json['insumoId']),
      numeroLote: serializer.fromJson<String>(json['numeroLote']),
      fechaIngreso: serializer.fromJson<DateTime>(json['fechaIngreso']),
      fechaVencimiento: serializer.fromJson<DateTime>(json['fechaVencimiento']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      proveedor: serializer.fromJson<String>(json['proveedor']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'insumoId': serializer.toJson<String>(insumoId),
      'numeroLote': serializer.toJson<String>(numeroLote),
      'fechaIngreso': serializer.toJson<DateTime>(fechaIngreso),
      'fechaVencimiento': serializer.toJson<DateTime>(fechaVencimiento),
      'cantidad': serializer.toJson<int>(cantidad),
      'proveedor': serializer.toJson<String>(proveedor),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  DbLote copyWith(
          {String? id,
          String? insumoId,
          String? numeroLote,
          DateTime? fechaIngreso,
          DateTime? fechaVencimiento,
          int? cantidad,
          String? proveedor,
          String? syncStatus,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      DbLote(
        id: id ?? this.id,
        insumoId: insumoId ?? this.insumoId,
        numeroLote: numeroLote ?? this.numeroLote,
        fechaIngreso: fechaIngreso ?? this.fechaIngreso,
        fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
        cantidad: cantidad ?? this.cantidad,
        proveedor: proveedor ?? this.proveedor,
        syncStatus: syncStatus ?? this.syncStatus,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  DbLote copyWithCompanion(LotesCompanion data) {
    return DbLote(
      id: data.id.present ? data.id.value : this.id,
      insumoId: data.insumoId.present ? data.insumoId.value : this.insumoId,
      numeroLote:
          data.numeroLote.present ? data.numeroLote.value : this.numeroLote,
      fechaIngreso: data.fechaIngreso.present
          ? data.fechaIngreso.value
          : this.fechaIngreso,
      fechaVencimiento: data.fechaVencimiento.present
          ? data.fechaVencimiento.value
          : this.fechaVencimiento,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      proveedor: data.proveedor.present ? data.proveedor.value : this.proveedor,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbLote(')
          ..write('id: $id, ')
          ..write('insumoId: $insumoId, ')
          ..write('numeroLote: $numeroLote, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('cantidad: $cantidad, ')
          ..write('proveedor: $proveedor, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, insumoId, numeroLote, fechaIngreso,
      fechaVencimiento, cantidad, proveedor, syncStatus, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbLote &&
          other.id == this.id &&
          other.insumoId == this.insumoId &&
          other.numeroLote == this.numeroLote &&
          other.fechaIngreso == this.fechaIngreso &&
          other.fechaVencimiento == this.fechaVencimiento &&
          other.cantidad == this.cantidad &&
          other.proveedor == this.proveedor &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class LotesCompanion extends UpdateCompanion<DbLote> {
  final Value<String> id;
  final Value<String> insumoId;
  final Value<String> numeroLote;
  final Value<DateTime> fechaIngreso;
  final Value<DateTime> fechaVencimiento;
  final Value<int> cantidad;
  final Value<String> proveedor;
  final Value<String> syncStatus;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const LotesCompanion({
    this.id = const Value.absent(),
    this.insumoId = const Value.absent(),
    this.numeroLote = const Value.absent(),
    this.fechaIngreso = const Value.absent(),
    this.fechaVencimiento = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.proveedor = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LotesCompanion.insert({
    required String id,
    required String insumoId,
    required String numeroLote,
    required DateTime fechaIngreso,
    required DateTime fechaVencimiento,
    required int cantidad,
    required String proveedor,
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        insumoId = Value(insumoId),
        numeroLote = Value(numeroLote),
        fechaIngreso = Value(fechaIngreso),
        fechaVencimiento = Value(fechaVencimiento),
        cantidad = Value(cantidad),
        proveedor = Value(proveedor);
  static Insertable<DbLote> custom({
    Expression<String>? id,
    Expression<String>? insumoId,
    Expression<String>? numeroLote,
    Expression<DateTime>? fechaIngreso,
    Expression<DateTime>? fechaVencimiento,
    Expression<int>? cantidad,
    Expression<String>? proveedor,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (insumoId != null) 'insumo_id': insumoId,
      if (numeroLote != null) 'numero_lote': numeroLote,
      if (fechaIngreso != null) 'fecha_ingreso': fechaIngreso,
      if (fechaVencimiento != null) 'fecha_vencimiento': fechaVencimiento,
      if (cantidad != null) 'cantidad': cantidad,
      if (proveedor != null) 'proveedor': proveedor,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LotesCompanion copyWith(
      {Value<String>? id,
      Value<String>? insumoId,
      Value<String>? numeroLote,
      Value<DateTime>? fechaIngreso,
      Value<DateTime>? fechaVencimiento,
      Value<int>? cantidad,
      Value<String>? proveedor,
      Value<String>? syncStatus,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return LotesCompanion(
      id: id ?? this.id,
      insumoId: insumoId ?? this.insumoId,
      numeroLote: numeroLote ?? this.numeroLote,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      cantidad: cantidad ?? this.cantidad,
      proveedor: proveedor ?? this.proveedor,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (insumoId.present) {
      map['insumo_id'] = Variable<String>(insumoId.value);
    }
    if (numeroLote.present) {
      map['numero_lote'] = Variable<String>(numeroLote.value);
    }
    if (fechaIngreso.present) {
      map['fecha_ingreso'] = Variable<DateTime>(fechaIngreso.value);
    }
    if (fechaVencimiento.present) {
      map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (proveedor.present) {
      map['proveedor'] = Variable<String>(proveedor.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LotesCompanion(')
          ..write('id: $id, ')
          ..write('insumoId: $insumoId, ')
          ..write('numeroLote: $numeroLote, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('cantidad: $cantidad, ')
          ..write('proveedor: $proveedor, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MovimientosTable extends Movimientos
    with TableInfo<$MovimientosTable, DbMovimiento> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovimientosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _insumoIdMeta =
      const VerificationMeta('insumoId');
  @override
  late final GeneratedColumn<String> insumoId = GeneratedColumn<String>(
      'insumo_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<String> loteId = GeneratedColumn<String>(
      'lote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _responsableIdMeta =
      const VerificationMeta('responsableId');
  @override
  late final GeneratedColumn<String> responsableId = GeneratedColumn<String>(
      'responsable_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _responsableNombreMeta =
      const VerificationMeta('responsableNombre');
  @override
  late final GeneratedColumn<String> responsableNombre =
      GeneratedColumn<String>('responsable_nombre', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _observacionesMeta =
      const VerificationMeta('observaciones');
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
      'observaciones', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        insumoId,
        loteId,
        tipo,
        cantidad,
        responsableId,
        responsableNombre,
        observaciones,
        fecha,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movimientos';
  @override
  VerificationContext validateIntegrity(Insertable<DbMovimiento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('insumo_id')) {
      context.handle(_insumoIdMeta,
          insumoId.isAcceptableOrUnknown(data['insumo_id']!, _insumoIdMeta));
    } else if (isInserting) {
      context.missing(_insumoIdMeta);
    }
    if (data.containsKey('lote_id')) {
      context.handle(_loteIdMeta,
          loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('responsable_id')) {
      context.handle(
          _responsableIdMeta,
          responsableId.isAcceptableOrUnknown(
              data['responsable_id']!, _responsableIdMeta));
    } else if (isInserting) {
      context.missing(_responsableIdMeta);
    }
    if (data.containsKey('responsable_nombre')) {
      context.handle(
          _responsableNombreMeta,
          responsableNombre.isAcceptableOrUnknown(
              data['responsable_nombre']!, _responsableNombreMeta));
    } else if (isInserting) {
      context.missing(_responsableNombreMeta);
    }
    if (data.containsKey('observaciones')) {
      context.handle(
          _observacionesMeta,
          observaciones.isAcceptableOrUnknown(
              data['observaciones']!, _observacionesMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbMovimiento map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbMovimiento(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      insumoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}insumo_id'])!,
      loteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lote_id']),
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad'])!,
      responsableId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}responsable_id'])!,
      responsableNombre: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}responsable_nombre'])!,
      observaciones: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observaciones'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $MovimientosTable createAlias(String alias) {
    return $MovimientosTable(attachedDatabase, alias);
  }
}

class DbMovimiento extends DataClass implements Insertable<DbMovimiento> {
  final String id;
  final String insumoId;
  final String? loteId;
  final String tipo;
  final int cantidad;
  final String responsableId;
  final String responsableNombre;
  final String observaciones;
  final DateTime fecha;
  final String syncStatus;
  const DbMovimiento(
      {required this.id,
      required this.insumoId,
      this.loteId,
      required this.tipo,
      required this.cantidad,
      required this.responsableId,
      required this.responsableNombre,
      required this.observaciones,
      required this.fecha,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['insumo_id'] = Variable<String>(insumoId);
    if (!nullToAbsent || loteId != null) {
      map['lote_id'] = Variable<String>(loteId);
    }
    map['tipo'] = Variable<String>(tipo);
    map['cantidad'] = Variable<int>(cantidad);
    map['responsable_id'] = Variable<String>(responsableId);
    map['responsable_nombre'] = Variable<String>(responsableNombre);
    map['observaciones'] = Variable<String>(observaciones);
    map['fecha'] = Variable<DateTime>(fecha);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  MovimientosCompanion toCompanion(bool nullToAbsent) {
    return MovimientosCompanion(
      id: Value(id),
      insumoId: Value(insumoId),
      loteId:
          loteId == null && nullToAbsent ? const Value.absent() : Value(loteId),
      tipo: Value(tipo),
      cantidad: Value(cantidad),
      responsableId: Value(responsableId),
      responsableNombre: Value(responsableNombre),
      observaciones: Value(observaciones),
      fecha: Value(fecha),
      syncStatus: Value(syncStatus),
    );
  }

  factory DbMovimiento.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbMovimiento(
      id: serializer.fromJson<String>(json['id']),
      insumoId: serializer.fromJson<String>(json['insumoId']),
      loteId: serializer.fromJson<String?>(json['loteId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      responsableId: serializer.fromJson<String>(json['responsableId']),
      responsableNombre: serializer.fromJson<String>(json['responsableNombre']),
      observaciones: serializer.fromJson<String>(json['observaciones']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'insumoId': serializer.toJson<String>(insumoId),
      'loteId': serializer.toJson<String?>(loteId),
      'tipo': serializer.toJson<String>(tipo),
      'cantidad': serializer.toJson<int>(cantidad),
      'responsableId': serializer.toJson<String>(responsableId),
      'responsableNombre': serializer.toJson<String>(responsableNombre),
      'observaciones': serializer.toJson<String>(observaciones),
      'fecha': serializer.toJson<DateTime>(fecha),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  DbMovimiento copyWith(
          {String? id,
          String? insumoId,
          Value<String?> loteId = const Value.absent(),
          String? tipo,
          int? cantidad,
          String? responsableId,
          String? responsableNombre,
          String? observaciones,
          DateTime? fecha,
          String? syncStatus}) =>
      DbMovimiento(
        id: id ?? this.id,
        insumoId: insumoId ?? this.insumoId,
        loteId: loteId.present ? loteId.value : this.loteId,
        tipo: tipo ?? this.tipo,
        cantidad: cantidad ?? this.cantidad,
        responsableId: responsableId ?? this.responsableId,
        responsableNombre: responsableNombre ?? this.responsableNombre,
        observaciones: observaciones ?? this.observaciones,
        fecha: fecha ?? this.fecha,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  DbMovimiento copyWithCompanion(MovimientosCompanion data) {
    return DbMovimiento(
      id: data.id.present ? data.id.value : this.id,
      insumoId: data.insumoId.present ? data.insumoId.value : this.insumoId,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      responsableId: data.responsableId.present
          ? data.responsableId.value
          : this.responsableId,
      responsableNombre: data.responsableNombre.present
          ? data.responsableNombre.value
          : this.responsableNombre,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbMovimiento(')
          ..write('id: $id, ')
          ..write('insumoId: $insumoId, ')
          ..write('loteId: $loteId, ')
          ..write('tipo: $tipo, ')
          ..write('cantidad: $cantidad, ')
          ..write('responsableId: $responsableId, ')
          ..write('responsableNombre: $responsableNombre, ')
          ..write('observaciones: $observaciones, ')
          ..write('fecha: $fecha, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, insumoId, loteId, tipo, cantidad,
      responsableId, responsableNombre, observaciones, fecha, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbMovimiento &&
          other.id == this.id &&
          other.insumoId == this.insumoId &&
          other.loteId == this.loteId &&
          other.tipo == this.tipo &&
          other.cantidad == this.cantidad &&
          other.responsableId == this.responsableId &&
          other.responsableNombre == this.responsableNombre &&
          other.observaciones == this.observaciones &&
          other.fecha == this.fecha &&
          other.syncStatus == this.syncStatus);
}

class MovimientosCompanion extends UpdateCompanion<DbMovimiento> {
  final Value<String> id;
  final Value<String> insumoId;
  final Value<String?> loteId;
  final Value<String> tipo;
  final Value<int> cantidad;
  final Value<String> responsableId;
  final Value<String> responsableNombre;
  final Value<String> observaciones;
  final Value<DateTime> fecha;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const MovimientosCompanion({
    this.id = const Value.absent(),
    this.insumoId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.responsableId = const Value.absent(),
    this.responsableNombre = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.fecha = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MovimientosCompanion.insert({
    required String id,
    required String insumoId,
    this.loteId = const Value.absent(),
    required String tipo,
    required int cantidad,
    required String responsableId,
    required String responsableNombre,
    this.observaciones = const Value.absent(),
    required DateTime fecha,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        insumoId = Value(insumoId),
        tipo = Value(tipo),
        cantidad = Value(cantidad),
        responsableId = Value(responsableId),
        responsableNombre = Value(responsableNombre),
        fecha = Value(fecha);
  static Insertable<DbMovimiento> custom({
    Expression<String>? id,
    Expression<String>? insumoId,
    Expression<String>? loteId,
    Expression<String>? tipo,
    Expression<int>? cantidad,
    Expression<String>? responsableId,
    Expression<String>? responsableNombre,
    Expression<String>? observaciones,
    Expression<DateTime>? fecha,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (insumoId != null) 'insumo_id': insumoId,
      if (loteId != null) 'lote_id': loteId,
      if (tipo != null) 'tipo': tipo,
      if (cantidad != null) 'cantidad': cantidad,
      if (responsableId != null) 'responsable_id': responsableId,
      if (responsableNombre != null) 'responsable_nombre': responsableNombre,
      if (observaciones != null) 'observaciones': observaciones,
      if (fecha != null) 'fecha': fecha,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MovimientosCompanion copyWith(
      {Value<String>? id,
      Value<String>? insumoId,
      Value<String?>? loteId,
      Value<String>? tipo,
      Value<int>? cantidad,
      Value<String>? responsableId,
      Value<String>? responsableNombre,
      Value<String>? observaciones,
      Value<DateTime>? fecha,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return MovimientosCompanion(
      id: id ?? this.id,
      insumoId: insumoId ?? this.insumoId,
      loteId: loteId ?? this.loteId,
      tipo: tipo ?? this.tipo,
      cantidad: cantidad ?? this.cantidad,
      responsableId: responsableId ?? this.responsableId,
      responsableNombre: responsableNombre ?? this.responsableNombre,
      observaciones: observaciones ?? this.observaciones,
      fecha: fecha ?? this.fecha,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (insumoId.present) {
      map['insumo_id'] = Variable<String>(insumoId.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<String>(loteId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (responsableId.present) {
      map['responsable_id'] = Variable<String>(responsableId.value);
    }
    if (responsableNombre.present) {
      map['responsable_nombre'] = Variable<String>(responsableNombre.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovimientosCompanion(')
          ..write('id: $id, ')
          ..write('insumoId: $insumoId, ')
          ..write('loteId: $loteId, ')
          ..write('tipo: $tipo, ')
          ..write('cantidad: $cantidad, ')
          ..write('responsableId: $responsableId, ')
          ..write('responsableNombre: $responsableNombre, ')
          ..write('observaciones: $observaciones, ')
          ..write('fecha: $fecha, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SolicitudesTable extends Solicitudes
    with TableInfo<$SolicitudesTable, DbSolicitud> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SolicitudesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _insumoIdMeta =
      const VerificationMeta('insumoId');
  @override
  late final GeneratedColumn<String> insumoId = GeneratedColumn<String>(
      'insumo_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _insumoNombreMeta =
      const VerificationMeta('insumoNombre');
  @override
  late final GeneratedColumn<String> insumoNombre = GeneratedColumn<String>(
      'insumo_nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cantidadSolicitadaMeta =
      const VerificationMeta('cantidadSolicitada');
  @override
  late final GeneratedColumn<int> cantidadSolicitada = GeneratedColumn<int>(
      'cantidad_solicitada', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _solicitanteIdMeta =
      const VerificationMeta('solicitanteId');
  @override
  late final GeneratedColumn<String> solicitanteId = GeneratedColumn<String>(
      'solicitante_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _solicitanteNombreMeta =
      const VerificationMeta('solicitanteNombre');
  @override
  late final GeneratedColumn<String> solicitanteNombre =
      GeneratedColumn<String>('solicitante_nombre', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pendiente'));
  static const VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
      'motivo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _observacionesAdminMeta =
      const VerificationMeta('observacionesAdmin');
  @override
  late final GeneratedColumn<String> observacionesAdmin =
      GeneratedColumn<String>('observaciones_admin', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaSolicitudMeta =
      const VerificationMeta('fechaSolicitud');
  @override
  late final GeneratedColumn<DateTime> fechaSolicitud =
      GeneratedColumn<DateTime>('fecha_solicitud', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fechaRespuestaMeta =
      const VerificationMeta('fechaRespuesta');
  @override
  late final GeneratedColumn<DateTime> fechaRespuesta =
      GeneratedColumn<DateTime>('fecha_respuesta', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        insumoId,
        insumoNombre,
        cantidadSolicitada,
        solicitanteId,
        solicitanteNombre,
        estado,
        motivo,
        observacionesAdmin,
        fechaSolicitud,
        fechaRespuesta,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'solicitudes';
  @override
  VerificationContext validateIntegrity(Insertable<DbSolicitud> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('insumo_id')) {
      context.handle(_insumoIdMeta,
          insumoId.isAcceptableOrUnknown(data['insumo_id']!, _insumoIdMeta));
    } else if (isInserting) {
      context.missing(_insumoIdMeta);
    }
    if (data.containsKey('insumo_nombre')) {
      context.handle(
          _insumoNombreMeta,
          insumoNombre.isAcceptableOrUnknown(
              data['insumo_nombre']!, _insumoNombreMeta));
    } else if (isInserting) {
      context.missing(_insumoNombreMeta);
    }
    if (data.containsKey('cantidad_solicitada')) {
      context.handle(
          _cantidadSolicitadaMeta,
          cantidadSolicitada.isAcceptableOrUnknown(
              data['cantidad_solicitada']!, _cantidadSolicitadaMeta));
    } else if (isInserting) {
      context.missing(_cantidadSolicitadaMeta);
    }
    if (data.containsKey('solicitante_id')) {
      context.handle(
          _solicitanteIdMeta,
          solicitanteId.isAcceptableOrUnknown(
              data['solicitante_id']!, _solicitanteIdMeta));
    } else if (isInserting) {
      context.missing(_solicitanteIdMeta);
    }
    if (data.containsKey('solicitante_nombre')) {
      context.handle(
          _solicitanteNombreMeta,
          solicitanteNombre.isAcceptableOrUnknown(
              data['solicitante_nombre']!, _solicitanteNombreMeta));
    } else if (isInserting) {
      context.missing(_solicitanteNombreMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('motivo')) {
      context.handle(_motivoMeta,
          motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta));
    } else if (isInserting) {
      context.missing(_motivoMeta);
    }
    if (data.containsKey('observaciones_admin')) {
      context.handle(
          _observacionesAdminMeta,
          observacionesAdmin.isAcceptableOrUnknown(
              data['observaciones_admin']!, _observacionesAdminMeta));
    }
    if (data.containsKey('fecha_solicitud')) {
      context.handle(
          _fechaSolicitudMeta,
          fechaSolicitud.isAcceptableOrUnknown(
              data['fecha_solicitud']!, _fechaSolicitudMeta));
    } else if (isInserting) {
      context.missing(_fechaSolicitudMeta);
    }
    if (data.containsKey('fecha_respuesta')) {
      context.handle(
          _fechaRespuestaMeta,
          fechaRespuesta.isAcceptableOrUnknown(
              data['fecha_respuesta']!, _fechaRespuestaMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbSolicitud map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbSolicitud(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      insumoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}insumo_id'])!,
      insumoNombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}insumo_nombre'])!,
      cantidadSolicitada: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}cantidad_solicitada'])!,
      solicitanteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}solicitante_id'])!,
      solicitanteNombre: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}solicitante_nombre'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      motivo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}motivo'])!,
      observacionesAdmin: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}observaciones_admin']),
      fechaSolicitud: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_solicitud'])!,
      fechaRespuesta: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_respuesta']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $SolicitudesTable createAlias(String alias) {
    return $SolicitudesTable(attachedDatabase, alias);
  }
}

class DbSolicitud extends DataClass implements Insertable<DbSolicitud> {
  final String id;
  final String insumoId;
  final String insumoNombre;
  final int cantidadSolicitada;
  final String solicitanteId;
  final String solicitanteNombre;
  final String estado;
  final String motivo;
  final String? observacionesAdmin;
  final DateTime fechaSolicitud;
  final DateTime? fechaRespuesta;
  final String syncStatus;
  const DbSolicitud(
      {required this.id,
      required this.insumoId,
      required this.insumoNombre,
      required this.cantidadSolicitada,
      required this.solicitanteId,
      required this.solicitanteNombre,
      required this.estado,
      required this.motivo,
      this.observacionesAdmin,
      required this.fechaSolicitud,
      this.fechaRespuesta,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['insumo_id'] = Variable<String>(insumoId);
    map['insumo_nombre'] = Variable<String>(insumoNombre);
    map['cantidad_solicitada'] = Variable<int>(cantidadSolicitada);
    map['solicitante_id'] = Variable<String>(solicitanteId);
    map['solicitante_nombre'] = Variable<String>(solicitanteNombre);
    map['estado'] = Variable<String>(estado);
    map['motivo'] = Variable<String>(motivo);
    if (!nullToAbsent || observacionesAdmin != null) {
      map['observaciones_admin'] = Variable<String>(observacionesAdmin);
    }
    map['fecha_solicitud'] = Variable<DateTime>(fechaSolicitud);
    if (!nullToAbsent || fechaRespuesta != null) {
      map['fecha_respuesta'] = Variable<DateTime>(fechaRespuesta);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  SolicitudesCompanion toCompanion(bool nullToAbsent) {
    return SolicitudesCompanion(
      id: Value(id),
      insumoId: Value(insumoId),
      insumoNombre: Value(insumoNombre),
      cantidadSolicitada: Value(cantidadSolicitada),
      solicitanteId: Value(solicitanteId),
      solicitanteNombre: Value(solicitanteNombre),
      estado: Value(estado),
      motivo: Value(motivo),
      observacionesAdmin: observacionesAdmin == null && nullToAbsent
          ? const Value.absent()
          : Value(observacionesAdmin),
      fechaSolicitud: Value(fechaSolicitud),
      fechaRespuesta: fechaRespuesta == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaRespuesta),
      syncStatus: Value(syncStatus),
    );
  }

  factory DbSolicitud.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbSolicitud(
      id: serializer.fromJson<String>(json['id']),
      insumoId: serializer.fromJson<String>(json['insumoId']),
      insumoNombre: serializer.fromJson<String>(json['insumoNombre']),
      cantidadSolicitada: serializer.fromJson<int>(json['cantidadSolicitada']),
      solicitanteId: serializer.fromJson<String>(json['solicitanteId']),
      solicitanteNombre: serializer.fromJson<String>(json['solicitanteNombre']),
      estado: serializer.fromJson<String>(json['estado']),
      motivo: serializer.fromJson<String>(json['motivo']),
      observacionesAdmin:
          serializer.fromJson<String?>(json['observacionesAdmin']),
      fechaSolicitud: serializer.fromJson<DateTime>(json['fechaSolicitud']),
      fechaRespuesta: serializer.fromJson<DateTime?>(json['fechaRespuesta']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'insumoId': serializer.toJson<String>(insumoId),
      'insumoNombre': serializer.toJson<String>(insumoNombre),
      'cantidadSolicitada': serializer.toJson<int>(cantidadSolicitada),
      'solicitanteId': serializer.toJson<String>(solicitanteId),
      'solicitanteNombre': serializer.toJson<String>(solicitanteNombre),
      'estado': serializer.toJson<String>(estado),
      'motivo': serializer.toJson<String>(motivo),
      'observacionesAdmin': serializer.toJson<String?>(observacionesAdmin),
      'fechaSolicitud': serializer.toJson<DateTime>(fechaSolicitud),
      'fechaRespuesta': serializer.toJson<DateTime?>(fechaRespuesta),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  DbSolicitud copyWith(
          {String? id,
          String? insumoId,
          String? insumoNombre,
          int? cantidadSolicitada,
          String? solicitanteId,
          String? solicitanteNombre,
          String? estado,
          String? motivo,
          Value<String?> observacionesAdmin = const Value.absent(),
          DateTime? fechaSolicitud,
          Value<DateTime?> fechaRespuesta = const Value.absent(),
          String? syncStatus}) =>
      DbSolicitud(
        id: id ?? this.id,
        insumoId: insumoId ?? this.insumoId,
        insumoNombre: insumoNombre ?? this.insumoNombre,
        cantidadSolicitada: cantidadSolicitada ?? this.cantidadSolicitada,
        solicitanteId: solicitanteId ?? this.solicitanteId,
        solicitanteNombre: solicitanteNombre ?? this.solicitanteNombre,
        estado: estado ?? this.estado,
        motivo: motivo ?? this.motivo,
        observacionesAdmin: observacionesAdmin.present
            ? observacionesAdmin.value
            : this.observacionesAdmin,
        fechaSolicitud: fechaSolicitud ?? this.fechaSolicitud,
        fechaRespuesta:
            fechaRespuesta.present ? fechaRespuesta.value : this.fechaRespuesta,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  DbSolicitud copyWithCompanion(SolicitudesCompanion data) {
    return DbSolicitud(
      id: data.id.present ? data.id.value : this.id,
      insumoId: data.insumoId.present ? data.insumoId.value : this.insumoId,
      insumoNombre: data.insumoNombre.present
          ? data.insumoNombre.value
          : this.insumoNombre,
      cantidadSolicitada: data.cantidadSolicitada.present
          ? data.cantidadSolicitada.value
          : this.cantidadSolicitada,
      solicitanteId: data.solicitanteId.present
          ? data.solicitanteId.value
          : this.solicitanteId,
      solicitanteNombre: data.solicitanteNombre.present
          ? data.solicitanteNombre.value
          : this.solicitanteNombre,
      estado: data.estado.present ? data.estado.value : this.estado,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
      observacionesAdmin: data.observacionesAdmin.present
          ? data.observacionesAdmin.value
          : this.observacionesAdmin,
      fechaSolicitud: data.fechaSolicitud.present
          ? data.fechaSolicitud.value
          : this.fechaSolicitud,
      fechaRespuesta: data.fechaRespuesta.present
          ? data.fechaRespuesta.value
          : this.fechaRespuesta,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbSolicitud(')
          ..write('id: $id, ')
          ..write('insumoId: $insumoId, ')
          ..write('insumoNombre: $insumoNombre, ')
          ..write('cantidadSolicitada: $cantidadSolicitada, ')
          ..write('solicitanteId: $solicitanteId, ')
          ..write('solicitanteNombre: $solicitanteNombre, ')
          ..write('estado: $estado, ')
          ..write('motivo: $motivo, ')
          ..write('observacionesAdmin: $observacionesAdmin, ')
          ..write('fechaSolicitud: $fechaSolicitud, ')
          ..write('fechaRespuesta: $fechaRespuesta, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      insumoId,
      insumoNombre,
      cantidadSolicitada,
      solicitanteId,
      solicitanteNombre,
      estado,
      motivo,
      observacionesAdmin,
      fechaSolicitud,
      fechaRespuesta,
      syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbSolicitud &&
          other.id == this.id &&
          other.insumoId == this.insumoId &&
          other.insumoNombre == this.insumoNombre &&
          other.cantidadSolicitada == this.cantidadSolicitada &&
          other.solicitanteId == this.solicitanteId &&
          other.solicitanteNombre == this.solicitanteNombre &&
          other.estado == this.estado &&
          other.motivo == this.motivo &&
          other.observacionesAdmin == this.observacionesAdmin &&
          other.fechaSolicitud == this.fechaSolicitud &&
          other.fechaRespuesta == this.fechaRespuesta &&
          other.syncStatus == this.syncStatus);
}

class SolicitudesCompanion extends UpdateCompanion<DbSolicitud> {
  final Value<String> id;
  final Value<String> insumoId;
  final Value<String> insumoNombre;
  final Value<int> cantidadSolicitada;
  final Value<String> solicitanteId;
  final Value<String> solicitanteNombre;
  final Value<String> estado;
  final Value<String> motivo;
  final Value<String?> observacionesAdmin;
  final Value<DateTime> fechaSolicitud;
  final Value<DateTime?> fechaRespuesta;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const SolicitudesCompanion({
    this.id = const Value.absent(),
    this.insumoId = const Value.absent(),
    this.insumoNombre = const Value.absent(),
    this.cantidadSolicitada = const Value.absent(),
    this.solicitanteId = const Value.absent(),
    this.solicitanteNombre = const Value.absent(),
    this.estado = const Value.absent(),
    this.motivo = const Value.absent(),
    this.observacionesAdmin = const Value.absent(),
    this.fechaSolicitud = const Value.absent(),
    this.fechaRespuesta = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SolicitudesCompanion.insert({
    required String id,
    required String insumoId,
    required String insumoNombre,
    required int cantidadSolicitada,
    required String solicitanteId,
    required String solicitanteNombre,
    this.estado = const Value.absent(),
    required String motivo,
    this.observacionesAdmin = const Value.absent(),
    required DateTime fechaSolicitud,
    this.fechaRespuesta = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        insumoId = Value(insumoId),
        insumoNombre = Value(insumoNombre),
        cantidadSolicitada = Value(cantidadSolicitada),
        solicitanteId = Value(solicitanteId),
        solicitanteNombre = Value(solicitanteNombre),
        motivo = Value(motivo),
        fechaSolicitud = Value(fechaSolicitud);
  static Insertable<DbSolicitud> custom({
    Expression<String>? id,
    Expression<String>? insumoId,
    Expression<String>? insumoNombre,
    Expression<int>? cantidadSolicitada,
    Expression<String>? solicitanteId,
    Expression<String>? solicitanteNombre,
    Expression<String>? estado,
    Expression<String>? motivo,
    Expression<String>? observacionesAdmin,
    Expression<DateTime>? fechaSolicitud,
    Expression<DateTime>? fechaRespuesta,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (insumoId != null) 'insumo_id': insumoId,
      if (insumoNombre != null) 'insumo_nombre': insumoNombre,
      if (cantidadSolicitada != null) 'cantidad_solicitada': cantidadSolicitada,
      if (solicitanteId != null) 'solicitante_id': solicitanteId,
      if (solicitanteNombre != null) 'solicitante_nombre': solicitanteNombre,
      if (estado != null) 'estado': estado,
      if (motivo != null) 'motivo': motivo,
      if (observacionesAdmin != null) 'observaciones_admin': observacionesAdmin,
      if (fechaSolicitud != null) 'fecha_solicitud': fechaSolicitud,
      if (fechaRespuesta != null) 'fecha_respuesta': fechaRespuesta,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SolicitudesCompanion copyWith(
      {Value<String>? id,
      Value<String>? insumoId,
      Value<String>? insumoNombre,
      Value<int>? cantidadSolicitada,
      Value<String>? solicitanteId,
      Value<String>? solicitanteNombre,
      Value<String>? estado,
      Value<String>? motivo,
      Value<String?>? observacionesAdmin,
      Value<DateTime>? fechaSolicitud,
      Value<DateTime?>? fechaRespuesta,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return SolicitudesCompanion(
      id: id ?? this.id,
      insumoId: insumoId ?? this.insumoId,
      insumoNombre: insumoNombre ?? this.insumoNombre,
      cantidadSolicitada: cantidadSolicitada ?? this.cantidadSolicitada,
      solicitanteId: solicitanteId ?? this.solicitanteId,
      solicitanteNombre: solicitanteNombre ?? this.solicitanteNombre,
      estado: estado ?? this.estado,
      motivo: motivo ?? this.motivo,
      observacionesAdmin: observacionesAdmin ?? this.observacionesAdmin,
      fechaSolicitud: fechaSolicitud ?? this.fechaSolicitud,
      fechaRespuesta: fechaRespuesta ?? this.fechaRespuesta,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (insumoId.present) {
      map['insumo_id'] = Variable<String>(insumoId.value);
    }
    if (insumoNombre.present) {
      map['insumo_nombre'] = Variable<String>(insumoNombre.value);
    }
    if (cantidadSolicitada.present) {
      map['cantidad_solicitada'] = Variable<int>(cantidadSolicitada.value);
    }
    if (solicitanteId.present) {
      map['solicitante_id'] = Variable<String>(solicitanteId.value);
    }
    if (solicitanteNombre.present) {
      map['solicitante_nombre'] = Variable<String>(solicitanteNombre.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    if (observacionesAdmin.present) {
      map['observaciones_admin'] = Variable<String>(observacionesAdmin.value);
    }
    if (fechaSolicitud.present) {
      map['fecha_solicitud'] = Variable<DateTime>(fechaSolicitud.value);
    }
    if (fechaRespuesta.present) {
      map['fecha_respuesta'] = Variable<DateTime>(fechaRespuesta.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SolicitudesCompanion(')
          ..write('id: $id, ')
          ..write('insumoId: $insumoId, ')
          ..write('insumoNombre: $insumoNombre, ')
          ..write('cantidadSolicitada: $cantidadSolicitada, ')
          ..write('solicitanteId: $solicitanteId, ')
          ..write('solicitanteNombre: $solicitanteNombre, ')
          ..write('estado: $estado, ')
          ..write('motivo: $motivo, ')
          ..write('observacionesAdmin: $observacionesAdmin, ')
          ..write('fechaSolicitud: $fechaSolicitud, ')
          ..write('fechaRespuesta: $fechaRespuesta, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlertasTable extends Alertas with TableInfo<$AlertasTable, DbAlerta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlertasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
      'titulo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mensajeMeta =
      const VerificationMeta('mensaje');
  @override
  late final GeneratedColumn<String> mensaje = GeneratedColumn<String>(
      'mensaje', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _insumoIdMeta =
      const VerificationMeta('insumoId');
  @override
  late final GeneratedColumn<String> insumoId = GeneratedColumn<String>(
      'insumo_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<String> loteId = GeneratedColumn<String>(
      'lote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _leidaMeta = const VerificationMeta('leida');
  @override
  late final GeneratedColumn<bool> leida = GeneratedColumn<bool>(
      'leida', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("leida" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _fechaCreacionMeta =
      const VerificationMeta('fechaCreacion');
  @override
  late final GeneratedColumn<DateTime> fechaCreacion =
      GeneratedColumn<DateTime>('fecha_creacion', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tipo,
        titulo,
        mensaje,
        insumoId,
        loteId,
        leida,
        fechaCreacion,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alertas';
  @override
  VerificationContext validateIntegrity(Insertable<DbAlerta> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(_tituloMeta,
          titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta));
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('mensaje')) {
      context.handle(_mensajeMeta,
          mensaje.isAcceptableOrUnknown(data['mensaje']!, _mensajeMeta));
    } else if (isInserting) {
      context.missing(_mensajeMeta);
    }
    if (data.containsKey('insumo_id')) {
      context.handle(_insumoIdMeta,
          insumoId.isAcceptableOrUnknown(data['insumo_id']!, _insumoIdMeta));
    }
    if (data.containsKey('lote_id')) {
      context.handle(_loteIdMeta,
          loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta));
    }
    if (data.containsKey('leida')) {
      context.handle(
          _leidaMeta, leida.isAcceptableOrUnknown(data['leida']!, _leidaMeta));
    }
    if (data.containsKey('fecha_creacion')) {
      context.handle(
          _fechaCreacionMeta,
          fechaCreacion.isAcceptableOrUnknown(
              data['fecha_creacion']!, _fechaCreacionMeta));
    } else if (isInserting) {
      context.missing(_fechaCreacionMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbAlerta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbAlerta(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      titulo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}titulo'])!,
      mensaje: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mensaje'])!,
      insumoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}insumo_id']),
      loteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lote_id']),
      leida: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}leida'])!,
      fechaCreacion: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_creacion'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $AlertasTable createAlias(String alias) {
    return $AlertasTable(attachedDatabase, alias);
  }
}

class DbAlerta extends DataClass implements Insertable<DbAlerta> {
  final String id;
  final String tipo;
  final String titulo;
  final String mensaje;
  final String? insumoId;
  final String? loteId;
  final bool leida;
  final DateTime fechaCreacion;
  final String syncStatus;
  const DbAlerta(
      {required this.id,
      required this.tipo,
      required this.titulo,
      required this.mensaje,
      this.insumoId,
      this.loteId,
      required this.leida,
      required this.fechaCreacion,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tipo'] = Variable<String>(tipo);
    map['titulo'] = Variable<String>(titulo);
    map['mensaje'] = Variable<String>(mensaje);
    if (!nullToAbsent || insumoId != null) {
      map['insumo_id'] = Variable<String>(insumoId);
    }
    if (!nullToAbsent || loteId != null) {
      map['lote_id'] = Variable<String>(loteId);
    }
    map['leida'] = Variable<bool>(leida);
    map['fecha_creacion'] = Variable<DateTime>(fechaCreacion);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  AlertasCompanion toCompanion(bool nullToAbsent) {
    return AlertasCompanion(
      id: Value(id),
      tipo: Value(tipo),
      titulo: Value(titulo),
      mensaje: Value(mensaje),
      insumoId: insumoId == null && nullToAbsent
          ? const Value.absent()
          : Value(insumoId),
      loteId:
          loteId == null && nullToAbsent ? const Value.absent() : Value(loteId),
      leida: Value(leida),
      fechaCreacion: Value(fechaCreacion),
      syncStatus: Value(syncStatus),
    );
  }

  factory DbAlerta.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbAlerta(
      id: serializer.fromJson<String>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
      titulo: serializer.fromJson<String>(json['titulo']),
      mensaje: serializer.fromJson<String>(json['mensaje']),
      insumoId: serializer.fromJson<String?>(json['insumoId']),
      loteId: serializer.fromJson<String?>(json['loteId']),
      leida: serializer.fromJson<bool>(json['leida']),
      fechaCreacion: serializer.fromJson<DateTime>(json['fechaCreacion']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tipo': serializer.toJson<String>(tipo),
      'titulo': serializer.toJson<String>(titulo),
      'mensaje': serializer.toJson<String>(mensaje),
      'insumoId': serializer.toJson<String?>(insumoId),
      'loteId': serializer.toJson<String?>(loteId),
      'leida': serializer.toJson<bool>(leida),
      'fechaCreacion': serializer.toJson<DateTime>(fechaCreacion),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  DbAlerta copyWith(
          {String? id,
          String? tipo,
          String? titulo,
          String? mensaje,
          Value<String?> insumoId = const Value.absent(),
          Value<String?> loteId = const Value.absent(),
          bool? leida,
          DateTime? fechaCreacion,
          String? syncStatus}) =>
      DbAlerta(
        id: id ?? this.id,
        tipo: tipo ?? this.tipo,
        titulo: titulo ?? this.titulo,
        mensaje: mensaje ?? this.mensaje,
        insumoId: insumoId.present ? insumoId.value : this.insumoId,
        loteId: loteId.present ? loteId.value : this.loteId,
        leida: leida ?? this.leida,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  DbAlerta copyWithCompanion(AlertasCompanion data) {
    return DbAlerta(
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      mensaje: data.mensaje.present ? data.mensaje.value : this.mensaje,
      insumoId: data.insumoId.present ? data.insumoId.value : this.insumoId,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      leida: data.leida.present ? data.leida.value : this.leida,
      fechaCreacion: data.fechaCreacion.present
          ? data.fechaCreacion.value
          : this.fechaCreacion,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbAlerta(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('titulo: $titulo, ')
          ..write('mensaje: $mensaje, ')
          ..write('insumoId: $insumoId, ')
          ..write('loteId: $loteId, ')
          ..write('leida: $leida, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tipo, titulo, mensaje, insumoId, loteId,
      leida, fechaCreacion, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbAlerta &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.titulo == this.titulo &&
          other.mensaje == this.mensaje &&
          other.insumoId == this.insumoId &&
          other.loteId == this.loteId &&
          other.leida == this.leida &&
          other.fechaCreacion == this.fechaCreacion &&
          other.syncStatus == this.syncStatus);
}

class AlertasCompanion extends UpdateCompanion<DbAlerta> {
  final Value<String> id;
  final Value<String> tipo;
  final Value<String> titulo;
  final Value<String> mensaje;
  final Value<String?> insumoId;
  final Value<String?> loteId;
  final Value<bool> leida;
  final Value<DateTime> fechaCreacion;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const AlertasCompanion({
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.titulo = const Value.absent(),
    this.mensaje = const Value.absent(),
    this.insumoId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.leida = const Value.absent(),
    this.fechaCreacion = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlertasCompanion.insert({
    required String id,
    required String tipo,
    required String titulo,
    required String mensaje,
    this.insumoId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.leida = const Value.absent(),
    required DateTime fechaCreacion,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tipo = Value(tipo),
        titulo = Value(titulo),
        mensaje = Value(mensaje),
        fechaCreacion = Value(fechaCreacion);
  static Insertable<DbAlerta> custom({
    Expression<String>? id,
    Expression<String>? tipo,
    Expression<String>? titulo,
    Expression<String>? mensaje,
    Expression<String>? insumoId,
    Expression<String>? loteId,
    Expression<bool>? leida,
    Expression<DateTime>? fechaCreacion,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (titulo != null) 'titulo': titulo,
      if (mensaje != null) 'mensaje': mensaje,
      if (insumoId != null) 'insumo_id': insumoId,
      if (loteId != null) 'lote_id': loteId,
      if (leida != null) 'leida': leida,
      if (fechaCreacion != null) 'fecha_creacion': fechaCreacion,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlertasCompanion copyWith(
      {Value<String>? id,
      Value<String>? tipo,
      Value<String>? titulo,
      Value<String>? mensaje,
      Value<String?>? insumoId,
      Value<String?>? loteId,
      Value<bool>? leida,
      Value<DateTime>? fechaCreacion,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return AlertasCompanion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      titulo: titulo ?? this.titulo,
      mensaje: mensaje ?? this.mensaje,
      insumoId: insumoId ?? this.insumoId,
      loteId: loteId ?? this.loteId,
      leida: leida ?? this.leida,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (mensaje.present) {
      map['mensaje'] = Variable<String>(mensaje.value);
    }
    if (insumoId.present) {
      map['insumo_id'] = Variable<String>(insumoId.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<String>(loteId.value);
    }
    if (leida.present) {
      map['leida'] = Variable<bool>(leida.value);
    }
    if (fechaCreacion.present) {
      map['fecha_creacion'] = Variable<DateTime>(fechaCreacion.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlertasCompanion(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('titulo: $titulo, ')
          ..write('mensaje: $mensaje, ')
          ..write('insumoId: $insumoId, ')
          ..write('loteId: $loteId, ')
          ..write('leida: $leida, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $InsumosTable insumos = $InsumosTable(this);
  late final $LotesTable lotes = $LotesTable(this);
  late final $MovimientosTable movimientos = $MovimientosTable(this);
  late final $SolicitudesTable solicitudes = $SolicitudesTable(this);
  late final $AlertasTable alertas = $AlertasTable(this);
  late final UsuariosDao usuariosDao = UsuariosDao(this as AppDatabase);
  late final InsumosDao insumosDao = InsumosDao(this as AppDatabase);
  late final LotesDao lotesDao = LotesDao(this as AppDatabase);
  late final MovimientosDao movimientosDao =
      MovimientosDao(this as AppDatabase);
  late final SolicitudesDao solicitudesDao =
      SolicitudesDao(this as AppDatabase);
  late final AlertasDao alertasDao = AlertasDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [usuarios, insumos, lotes, movimientos, solicitudes, alertas];
}

typedef $$UsuariosTableCreateCompanionBuilder = UsuariosCompanion Function({
  required String id,
  required String email,
  required String nombre,
  required String apellido,
  Value<String> rol,
  Value<bool> activo,
  Value<String> syncStatus,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$UsuariosTableUpdateCompanionBuilder = UsuariosCompanion Function({
  Value<String> id,
  Value<String> email,
  Value<String> nombre,
  Value<String> apellido,
  Value<String> rol,
  Value<bool> activo,
  Value<String> syncStatus,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get apellido => $composableBuilder(
      column: $table.apellido, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rol => $composableBuilder(
      column: $table.rol, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get apellido => $composableBuilder(
      column: $table.apellido, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rol => $composableBuilder(
      column: $table.rol, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get apellido =>
      $composableBuilder(column: $table.apellido, builder: (column) => column);

  GeneratedColumn<String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UsuariosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsuariosTable,
    DbUsuario,
    $$UsuariosTableFilterComposer,
    $$UsuariosTableOrderingComposer,
    $$UsuariosTableAnnotationComposer,
    $$UsuariosTableCreateCompanionBuilder,
    $$UsuariosTableUpdateCompanionBuilder,
    (DbUsuario, BaseReferences<_$AppDatabase, $UsuariosTable, DbUsuario>),
    DbUsuario,
    PrefetchHooks Function()> {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> apellido = const Value.absent(),
            Value<String> rol = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsuariosCompanion(
            id: id,
            email: email,
            nombre: nombre,
            apellido: apellido,
            rol: rol,
            activo: activo,
            syncStatus: syncStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String email,
            required String nombre,
            required String apellido,
            Value<String> rol = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsuariosCompanion.insert(
            id: id,
            email: email,
            nombre: nombre,
            apellido: apellido,
            rol: rol,
            activo: activo,
            syncStatus: syncStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsuariosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsuariosTable,
    DbUsuario,
    $$UsuariosTableFilterComposer,
    $$UsuariosTableOrderingComposer,
    $$UsuariosTableAnnotationComposer,
    $$UsuariosTableCreateCompanionBuilder,
    $$UsuariosTableUpdateCompanionBuilder,
    (DbUsuario, BaseReferences<_$AppDatabase, $UsuariosTable, DbUsuario>),
    DbUsuario,
    PrefetchHooks Function()>;
typedef $$InsumosTableCreateCompanionBuilder = InsumosCompanion Function({
  required String id,
  required String nombre,
  required String descripcion,
  required String categoria,
  Value<int> stockTotal,
  Value<int> stockMinimo,
  required String unidadMedida,
  Value<String> estado,
  Value<String> syncStatus,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$InsumosTableUpdateCompanionBuilder = InsumosCompanion Function({
  Value<String> id,
  Value<String> nombre,
  Value<String> descripcion,
  Value<String> categoria,
  Value<int> stockTotal,
  Value<int> stockMinimo,
  Value<String> unidadMedida,
  Value<String> estado,
  Value<String> syncStatus,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$InsumosTableFilterComposer
    extends Composer<_$AppDatabase, $InsumosTable> {
  $$InsumosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stockTotal => $composableBuilder(
      column: $table.stockTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unidadMedida => $composableBuilder(
      column: $table.unidadMedida, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$InsumosTableOrderingComposer
    extends Composer<_$AppDatabase, $InsumosTable> {
  $$InsumosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stockTotal => $composableBuilder(
      column: $table.stockTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unidadMedida => $composableBuilder(
      column: $table.unidadMedida,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$InsumosTableAnnotationComposer
    extends Composer<_$AppDatabase, $InsumosTable> {
  $$InsumosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<int> get stockTotal => $composableBuilder(
      column: $table.stockTotal, builder: (column) => column);

  GeneratedColumn<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => column);

  GeneratedColumn<String> get unidadMedida => $composableBuilder(
      column: $table.unidadMedida, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$InsumosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InsumosTable,
    DbInsumo,
    $$InsumosTableFilterComposer,
    $$InsumosTableOrderingComposer,
    $$InsumosTableAnnotationComposer,
    $$InsumosTableCreateCompanionBuilder,
    $$InsumosTableUpdateCompanionBuilder,
    (DbInsumo, BaseReferences<_$AppDatabase, $InsumosTable, DbInsumo>),
    DbInsumo,
    PrefetchHooks Function()> {
  $$InsumosTableTableManager(_$AppDatabase db, $InsumosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InsumosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InsumosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InsumosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> descripcion = const Value.absent(),
            Value<String> categoria = const Value.absent(),
            Value<int> stockTotal = const Value.absent(),
            Value<int> stockMinimo = const Value.absent(),
            Value<String> unidadMedida = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InsumosCompanion(
            id: id,
            nombre: nombre,
            descripcion: descripcion,
            categoria: categoria,
            stockTotal: stockTotal,
            stockMinimo: stockMinimo,
            unidadMedida: unidadMedida,
            estado: estado,
            syncStatus: syncStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nombre,
            required String descripcion,
            required String categoria,
            Value<int> stockTotal = const Value.absent(),
            Value<int> stockMinimo = const Value.absent(),
            required String unidadMedida,
            Value<String> estado = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InsumosCompanion.insert(
            id: id,
            nombre: nombre,
            descripcion: descripcion,
            categoria: categoria,
            stockTotal: stockTotal,
            stockMinimo: stockMinimo,
            unidadMedida: unidadMedida,
            estado: estado,
            syncStatus: syncStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InsumosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InsumosTable,
    DbInsumo,
    $$InsumosTableFilterComposer,
    $$InsumosTableOrderingComposer,
    $$InsumosTableAnnotationComposer,
    $$InsumosTableCreateCompanionBuilder,
    $$InsumosTableUpdateCompanionBuilder,
    (DbInsumo, BaseReferences<_$AppDatabase, $InsumosTable, DbInsumo>),
    DbInsumo,
    PrefetchHooks Function()>;
typedef $$LotesTableCreateCompanionBuilder = LotesCompanion Function({
  required String id,
  required String insumoId,
  required String numeroLote,
  required DateTime fechaIngreso,
  required DateTime fechaVencimiento,
  required int cantidad,
  required String proveedor,
  Value<String> syncStatus,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$LotesTableUpdateCompanionBuilder = LotesCompanion Function({
  Value<String> id,
  Value<String> insumoId,
  Value<String> numeroLote,
  Value<DateTime> fechaIngreso,
  Value<DateTime> fechaVencimiento,
  Value<int> cantidad,
  Value<String> proveedor,
  Value<String> syncStatus,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$LotesTableFilterComposer extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get insumoId => $composableBuilder(
      column: $table.insumoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numeroLote => $composableBuilder(
      column: $table.numeroLote, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaIngreso => $composableBuilder(
      column: $table.fechaIngreso, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaVencimiento => $composableBuilder(
      column: $table.fechaVencimiento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get proveedor => $composableBuilder(
      column: $table.proveedor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LotesTableOrderingComposer
    extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get insumoId => $composableBuilder(
      column: $table.insumoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numeroLote => $composableBuilder(
      column: $table.numeroLote, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaIngreso => $composableBuilder(
      column: $table.fechaIngreso,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaVencimiento => $composableBuilder(
      column: $table.fechaVencimiento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get proveedor => $composableBuilder(
      column: $table.proveedor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get insumoId =>
      $composableBuilder(column: $table.insumoId, builder: (column) => column);

  GeneratedColumn<String> get numeroLote => $composableBuilder(
      column: $table.numeroLote, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaIngreso => $composableBuilder(
      column: $table.fechaIngreso, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaVencimiento => $composableBuilder(
      column: $table.fechaVencimiento, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get proveedor =>
      $composableBuilder(column: $table.proveedor, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LotesTable,
    DbLote,
    $$LotesTableFilterComposer,
    $$LotesTableOrderingComposer,
    $$LotesTableAnnotationComposer,
    $$LotesTableCreateCompanionBuilder,
    $$LotesTableUpdateCompanionBuilder,
    (DbLote, BaseReferences<_$AppDatabase, $LotesTable, DbLote>),
    DbLote,
    PrefetchHooks Function()> {
  $$LotesTableTableManager(_$AppDatabase db, $LotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> insumoId = const Value.absent(),
            Value<String> numeroLote = const Value.absent(),
            Value<DateTime> fechaIngreso = const Value.absent(),
            Value<DateTime> fechaVencimiento = const Value.absent(),
            Value<int> cantidad = const Value.absent(),
            Value<String> proveedor = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LotesCompanion(
            id: id,
            insumoId: insumoId,
            numeroLote: numeroLote,
            fechaIngreso: fechaIngreso,
            fechaVencimiento: fechaVencimiento,
            cantidad: cantidad,
            proveedor: proveedor,
            syncStatus: syncStatus,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String insumoId,
            required String numeroLote,
            required DateTime fechaIngreso,
            required DateTime fechaVencimiento,
            required int cantidad,
            required String proveedor,
            Value<String> syncStatus = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LotesCompanion.insert(
            id: id,
            insumoId: insumoId,
            numeroLote: numeroLote,
            fechaIngreso: fechaIngreso,
            fechaVencimiento: fechaVencimiento,
            cantidad: cantidad,
            proveedor: proveedor,
            syncStatus: syncStatus,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LotesTable,
    DbLote,
    $$LotesTableFilterComposer,
    $$LotesTableOrderingComposer,
    $$LotesTableAnnotationComposer,
    $$LotesTableCreateCompanionBuilder,
    $$LotesTableUpdateCompanionBuilder,
    (DbLote, BaseReferences<_$AppDatabase, $LotesTable, DbLote>),
    DbLote,
    PrefetchHooks Function()>;
typedef $$MovimientosTableCreateCompanionBuilder = MovimientosCompanion
    Function({
  required String id,
  required String insumoId,
  Value<String?> loteId,
  required String tipo,
  required int cantidad,
  required String responsableId,
  required String responsableNombre,
  Value<String> observaciones,
  required DateTime fecha,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$MovimientosTableUpdateCompanionBuilder = MovimientosCompanion
    Function({
  Value<String> id,
  Value<String> insumoId,
  Value<String?> loteId,
  Value<String> tipo,
  Value<int> cantidad,
  Value<String> responsableId,
  Value<String> responsableNombre,
  Value<String> observaciones,
  Value<DateTime> fecha,
  Value<String> syncStatus,
  Value<int> rowid,
});

class $$MovimientosTableFilterComposer
    extends Composer<_$AppDatabase, $MovimientosTable> {
  $$MovimientosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get insumoId => $composableBuilder(
      column: $table.insumoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get responsableId => $composableBuilder(
      column: $table.responsableId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get responsableNombre => $composableBuilder(
      column: $table.responsableNombre,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$MovimientosTableOrderingComposer
    extends Composer<_$AppDatabase, $MovimientosTable> {
  $$MovimientosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get insumoId => $composableBuilder(
      column: $table.insumoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get responsableId => $composableBuilder(
      column: $table.responsableId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get responsableNombre => $composableBuilder(
      column: $table.responsableNombre,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observaciones => $composableBuilder(
      column: $table.observaciones,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$MovimientosTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovimientosTable> {
  $$MovimientosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get insumoId =>
      $composableBuilder(column: $table.insumoId, builder: (column) => column);

  GeneratedColumn<String> get loteId =>
      $composableBuilder(column: $table.loteId, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get responsableId => $composableBuilder(
      column: $table.responsableId, builder: (column) => column);

  GeneratedColumn<String> get responsableNombre => $composableBuilder(
      column: $table.responsableNombre, builder: (column) => column);

  GeneratedColumn<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$MovimientosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MovimientosTable,
    DbMovimiento,
    $$MovimientosTableFilterComposer,
    $$MovimientosTableOrderingComposer,
    $$MovimientosTableAnnotationComposer,
    $$MovimientosTableCreateCompanionBuilder,
    $$MovimientosTableUpdateCompanionBuilder,
    (
      DbMovimiento,
      BaseReferences<_$AppDatabase, $MovimientosTable, DbMovimiento>
    ),
    DbMovimiento,
    PrefetchHooks Function()> {
  $$MovimientosTableTableManager(_$AppDatabase db, $MovimientosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovimientosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovimientosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovimientosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> insumoId = const Value.absent(),
            Value<String?> loteId = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<int> cantidad = const Value.absent(),
            Value<String> responsableId = const Value.absent(),
            Value<String> responsableNombre = const Value.absent(),
            Value<String> observaciones = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MovimientosCompanion(
            id: id,
            insumoId: insumoId,
            loteId: loteId,
            tipo: tipo,
            cantidad: cantidad,
            responsableId: responsableId,
            responsableNombre: responsableNombre,
            observaciones: observaciones,
            fecha: fecha,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String insumoId,
            Value<String?> loteId = const Value.absent(),
            required String tipo,
            required int cantidad,
            required String responsableId,
            required String responsableNombre,
            Value<String> observaciones = const Value.absent(),
            required DateTime fecha,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MovimientosCompanion.insert(
            id: id,
            insumoId: insumoId,
            loteId: loteId,
            tipo: tipo,
            cantidad: cantidad,
            responsableId: responsableId,
            responsableNombre: responsableNombre,
            observaciones: observaciones,
            fecha: fecha,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MovimientosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MovimientosTable,
    DbMovimiento,
    $$MovimientosTableFilterComposer,
    $$MovimientosTableOrderingComposer,
    $$MovimientosTableAnnotationComposer,
    $$MovimientosTableCreateCompanionBuilder,
    $$MovimientosTableUpdateCompanionBuilder,
    (
      DbMovimiento,
      BaseReferences<_$AppDatabase, $MovimientosTable, DbMovimiento>
    ),
    DbMovimiento,
    PrefetchHooks Function()>;
typedef $$SolicitudesTableCreateCompanionBuilder = SolicitudesCompanion
    Function({
  required String id,
  required String insumoId,
  required String insumoNombre,
  required int cantidadSolicitada,
  required String solicitanteId,
  required String solicitanteNombre,
  Value<String> estado,
  required String motivo,
  Value<String?> observacionesAdmin,
  required DateTime fechaSolicitud,
  Value<DateTime?> fechaRespuesta,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$SolicitudesTableUpdateCompanionBuilder = SolicitudesCompanion
    Function({
  Value<String> id,
  Value<String> insumoId,
  Value<String> insumoNombre,
  Value<int> cantidadSolicitada,
  Value<String> solicitanteId,
  Value<String> solicitanteNombre,
  Value<String> estado,
  Value<String> motivo,
  Value<String?> observacionesAdmin,
  Value<DateTime> fechaSolicitud,
  Value<DateTime?> fechaRespuesta,
  Value<String> syncStatus,
  Value<int> rowid,
});

class $$SolicitudesTableFilterComposer
    extends Composer<_$AppDatabase, $SolicitudesTable> {
  $$SolicitudesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get insumoId => $composableBuilder(
      column: $table.insumoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get insumoNombre => $composableBuilder(
      column: $table.insumoNombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidadSolicitada => $composableBuilder(
      column: $table.cantidadSolicitada,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get solicitanteId => $composableBuilder(
      column: $table.solicitanteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get solicitanteNombre => $composableBuilder(
      column: $table.solicitanteNombre,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get motivo => $composableBuilder(
      column: $table.motivo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacionesAdmin => $composableBuilder(
      column: $table.observacionesAdmin,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaSolicitud => $composableBuilder(
      column: $table.fechaSolicitud,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaRespuesta => $composableBuilder(
      column: $table.fechaRespuesta,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$SolicitudesTableOrderingComposer
    extends Composer<_$AppDatabase, $SolicitudesTable> {
  $$SolicitudesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get insumoId => $composableBuilder(
      column: $table.insumoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get insumoNombre => $composableBuilder(
      column: $table.insumoNombre,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidadSolicitada => $composableBuilder(
      column: $table.cantidadSolicitada,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get solicitanteId => $composableBuilder(
      column: $table.solicitanteId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get solicitanteNombre => $composableBuilder(
      column: $table.solicitanteNombre,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get motivo => $composableBuilder(
      column: $table.motivo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacionesAdmin => $composableBuilder(
      column: $table.observacionesAdmin,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaSolicitud => $composableBuilder(
      column: $table.fechaSolicitud,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaRespuesta => $composableBuilder(
      column: $table.fechaRespuesta,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$SolicitudesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SolicitudesTable> {
  $$SolicitudesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get insumoId =>
      $composableBuilder(column: $table.insumoId, builder: (column) => column);

  GeneratedColumn<String> get insumoNombre => $composableBuilder(
      column: $table.insumoNombre, builder: (column) => column);

  GeneratedColumn<int> get cantidadSolicitada => $composableBuilder(
      column: $table.cantidadSolicitada, builder: (column) => column);

  GeneratedColumn<String> get solicitanteId => $composableBuilder(
      column: $table.solicitanteId, builder: (column) => column);

  GeneratedColumn<String> get solicitanteNombre => $composableBuilder(
      column: $table.solicitanteNombre, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get motivo =>
      $composableBuilder(column: $table.motivo, builder: (column) => column);

  GeneratedColumn<String> get observacionesAdmin => $composableBuilder(
      column: $table.observacionesAdmin, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaSolicitud => $composableBuilder(
      column: $table.fechaSolicitud, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaRespuesta => $composableBuilder(
      column: $table.fechaRespuesta, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$SolicitudesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SolicitudesTable,
    DbSolicitud,
    $$SolicitudesTableFilterComposer,
    $$SolicitudesTableOrderingComposer,
    $$SolicitudesTableAnnotationComposer,
    $$SolicitudesTableCreateCompanionBuilder,
    $$SolicitudesTableUpdateCompanionBuilder,
    (
      DbSolicitud,
      BaseReferences<_$AppDatabase, $SolicitudesTable, DbSolicitud>
    ),
    DbSolicitud,
    PrefetchHooks Function()> {
  $$SolicitudesTableTableManager(_$AppDatabase db, $SolicitudesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SolicitudesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SolicitudesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SolicitudesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> insumoId = const Value.absent(),
            Value<String> insumoNombre = const Value.absent(),
            Value<int> cantidadSolicitada = const Value.absent(),
            Value<String> solicitanteId = const Value.absent(),
            Value<String> solicitanteNombre = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<String> motivo = const Value.absent(),
            Value<String?> observacionesAdmin = const Value.absent(),
            Value<DateTime> fechaSolicitud = const Value.absent(),
            Value<DateTime?> fechaRespuesta = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SolicitudesCompanion(
            id: id,
            insumoId: insumoId,
            insumoNombre: insumoNombre,
            cantidadSolicitada: cantidadSolicitada,
            solicitanteId: solicitanteId,
            solicitanteNombre: solicitanteNombre,
            estado: estado,
            motivo: motivo,
            observacionesAdmin: observacionesAdmin,
            fechaSolicitud: fechaSolicitud,
            fechaRespuesta: fechaRespuesta,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String insumoId,
            required String insumoNombre,
            required int cantidadSolicitada,
            required String solicitanteId,
            required String solicitanteNombre,
            Value<String> estado = const Value.absent(),
            required String motivo,
            Value<String?> observacionesAdmin = const Value.absent(),
            required DateTime fechaSolicitud,
            Value<DateTime?> fechaRespuesta = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SolicitudesCompanion.insert(
            id: id,
            insumoId: insumoId,
            insumoNombre: insumoNombre,
            cantidadSolicitada: cantidadSolicitada,
            solicitanteId: solicitanteId,
            solicitanteNombre: solicitanteNombre,
            estado: estado,
            motivo: motivo,
            observacionesAdmin: observacionesAdmin,
            fechaSolicitud: fechaSolicitud,
            fechaRespuesta: fechaRespuesta,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SolicitudesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SolicitudesTable,
    DbSolicitud,
    $$SolicitudesTableFilterComposer,
    $$SolicitudesTableOrderingComposer,
    $$SolicitudesTableAnnotationComposer,
    $$SolicitudesTableCreateCompanionBuilder,
    $$SolicitudesTableUpdateCompanionBuilder,
    (
      DbSolicitud,
      BaseReferences<_$AppDatabase, $SolicitudesTable, DbSolicitud>
    ),
    DbSolicitud,
    PrefetchHooks Function()>;
typedef $$AlertasTableCreateCompanionBuilder = AlertasCompanion Function({
  required String id,
  required String tipo,
  required String titulo,
  required String mensaje,
  Value<String?> insumoId,
  Value<String?> loteId,
  Value<bool> leida,
  required DateTime fechaCreacion,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$AlertasTableUpdateCompanionBuilder = AlertasCompanion Function({
  Value<String> id,
  Value<String> tipo,
  Value<String> titulo,
  Value<String> mensaje,
  Value<String?> insumoId,
  Value<String?> loteId,
  Value<bool> leida,
  Value<DateTime> fechaCreacion,
  Value<String> syncStatus,
  Value<int> rowid,
});

class $$AlertasTableFilterComposer
    extends Composer<_$AppDatabase, $AlertasTable> {
  $$AlertasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titulo => $composableBuilder(
      column: $table.titulo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mensaje => $composableBuilder(
      column: $table.mensaje, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get insumoId => $composableBuilder(
      column: $table.insumoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get leida => $composableBuilder(
      column: $table.leida, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaCreacion => $composableBuilder(
      column: $table.fechaCreacion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$AlertasTableOrderingComposer
    extends Composer<_$AppDatabase, $AlertasTable> {
  $$AlertasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titulo => $composableBuilder(
      column: $table.titulo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mensaje => $composableBuilder(
      column: $table.mensaje, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get insumoId => $composableBuilder(
      column: $table.insumoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get leida => $composableBuilder(
      column: $table.leida, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaCreacion => $composableBuilder(
      column: $table.fechaCreacion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$AlertasTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlertasTable> {
  $$AlertasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get mensaje =>
      $composableBuilder(column: $table.mensaje, builder: (column) => column);

  GeneratedColumn<String> get insumoId =>
      $composableBuilder(column: $table.insumoId, builder: (column) => column);

  GeneratedColumn<String> get loteId =>
      $composableBuilder(column: $table.loteId, builder: (column) => column);

  GeneratedColumn<bool> get leida =>
      $composableBuilder(column: $table.leida, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaCreacion => $composableBuilder(
      column: $table.fechaCreacion, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$AlertasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlertasTable,
    DbAlerta,
    $$AlertasTableFilterComposer,
    $$AlertasTableOrderingComposer,
    $$AlertasTableAnnotationComposer,
    $$AlertasTableCreateCompanionBuilder,
    $$AlertasTableUpdateCompanionBuilder,
    (DbAlerta, BaseReferences<_$AppDatabase, $AlertasTable, DbAlerta>),
    DbAlerta,
    PrefetchHooks Function()> {
  $$AlertasTableTableManager(_$AppDatabase db, $AlertasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlertasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlertasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlertasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<String> titulo = const Value.absent(),
            Value<String> mensaje = const Value.absent(),
            Value<String?> insumoId = const Value.absent(),
            Value<String?> loteId = const Value.absent(),
            Value<bool> leida = const Value.absent(),
            Value<DateTime> fechaCreacion = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlertasCompanion(
            id: id,
            tipo: tipo,
            titulo: titulo,
            mensaje: mensaje,
            insumoId: insumoId,
            loteId: loteId,
            leida: leida,
            fechaCreacion: fechaCreacion,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tipo,
            required String titulo,
            required String mensaje,
            Value<String?> insumoId = const Value.absent(),
            Value<String?> loteId = const Value.absent(),
            Value<bool> leida = const Value.absent(),
            required DateTime fechaCreacion,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlertasCompanion.insert(
            id: id,
            tipo: tipo,
            titulo: titulo,
            mensaje: mensaje,
            insumoId: insumoId,
            loteId: loteId,
            leida: leida,
            fechaCreacion: fechaCreacion,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AlertasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AlertasTable,
    DbAlerta,
    $$AlertasTableFilterComposer,
    $$AlertasTableOrderingComposer,
    $$AlertasTableAnnotationComposer,
    $$AlertasTableCreateCompanionBuilder,
    $$AlertasTableUpdateCompanionBuilder,
    (DbAlerta, BaseReferences<_$AppDatabase, $AlertasTable, DbAlerta>),
    DbAlerta,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$InsumosTableTableManager get insumos =>
      $$InsumosTableTableManager(_db, _db.insumos);
  $$LotesTableTableManager get lotes =>
      $$LotesTableTableManager(_db, _db.lotes);
  $$MovimientosTableTableManager get movimientos =>
      $$MovimientosTableTableManager(_db, _db.movimientos);
  $$SolicitudesTableTableManager get solicitudes =>
      $$SolicitudesTableTableManager(_db, _db.solicitudes);
  $$AlertasTableTableManager get alertas =>
      $$AlertasTableTableManager(_db, _db.alertas);
}
