enum UserRole {
  administrador,
  laboratorista,
  docente;

  String get displayName {
    switch (this) {
      case UserRole.administrador:
        return 'Administrador';
      case UserRole.laboratorista:
        return 'Laboratorista';
      case UserRole.docente:
        return 'Docente';
    }
  }

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (e) => e.name == value,
      orElse: () => UserRole.docente,
    );
  }
}

enum InsumoEstado {
  activo,
  inactivo,
  agotado;

  String get displayName {
    switch (this) {
      case InsumoEstado.activo:
        return 'Activo';
      case InsumoEstado.inactivo:
        return 'Inactivo';
      case InsumoEstado.agotado:
        return 'Agotado';
    }
  }

  static InsumoEstado fromString(String value) =>
      InsumoEstado.values.firstWhere((e) => e.name == value,
          orElse: () => InsumoEstado.activo);
}

enum MovimientoTipo {
  entrada,
  salida,
  ajuste;

  String get displayName {
    switch (this) {
      case MovimientoTipo.entrada:
        return 'Entrada';
      case MovimientoTipo.salida:
        return 'Salida';
      case MovimientoTipo.ajuste:
        return 'Ajuste';
    }
  }

  static MovimientoTipo fromString(String value) =>
      MovimientoTipo.values.firstWhere((e) => e.name == value,
          orElse: () => MovimientoTipo.entrada);
}

enum SolicitudEstado {
  pendiente,
  aprobada,
  rechazada;

  String get displayName {
    switch (this) {
      case SolicitudEstado.pendiente:
        return 'Pendiente';
      case SolicitudEstado.aprobada:
        return 'Aprobada';
      case SolicitudEstado.rechazada:
        return 'Rechazada';
    }
  }

  static SolicitudEstado fromString(String value) =>
      SolicitudEstado.values.firstWhere((e) => e.name == value,
          orElse: () => SolicitudEstado.pendiente);
}

enum AlertaTipo {
  stockBajo,
  loteVencido,
  loteProximoVencer;

  String get displayName {
    switch (this) {
      case AlertaTipo.stockBajo:
        return 'Stock Bajo';
      case AlertaTipo.loteVencido:
        return 'Lote Vencido';
      case AlertaTipo.loteProximoVencer:
        return 'Próximo a Vencer';
    }
  }

  static AlertaTipo fromString(String value) =>
      AlertaTipo.values.firstWhere((e) => e.name == value,
          orElse: () => AlertaTipo.stockBajo);
}

enum Categoria {
  reactivo,
  vidrio,
  equipo,
  material,
  otro;

  String get displayName {
    switch (this) {
      case Categoria.reactivo:
        return 'Reactivo';
      case Categoria.vidrio:
        return 'Vidrio';
      case Categoria.equipo:
        return 'Equipo';
      case Categoria.material:
        return 'Material';
      case Categoria.otro:
        return 'Otro';
    }
  }

  static Categoria fromString(String value) =>
      Categoria.values.firstWhere((e) => e.name == value,
          orElse: () => Categoria.otro);
}

enum UnidadMedida {
  ml,
  l,
  g,
  kg,
  unidad,
  caja,
  frasco;

  String get displayName {
    switch (this) {
      case UnidadMedida.ml:
        return 'ml';
      case UnidadMedida.l:
        return 'L';
      case UnidadMedida.g:
        return 'g';
      case UnidadMedida.kg:
        return 'kg';
      case UnidadMedida.unidad:
        return 'Unidad';
      case UnidadMedida.caja:
        return 'Caja';
      case UnidadMedida.frasco:
        return 'Frasco';
    }
  }

  static UnidadMedida fromString(String value) =>
      UnidadMedida.values.firstWhere((e) => e.name == value,
          orElse: () => UnidadMedida.unidad);
}

enum SyncStatus { synced, pending, error }
