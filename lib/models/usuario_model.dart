import '../utils/enums.dart';

class UsuarioModel {
  final String id;
  final String email;
  final String nombre;
  final String apellido;
  final UserRole rol;
  final AccountStatus estadoCuenta;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool? _activo;

  const UsuarioModel({
    required this.id,
    required this.email,
    required this.nombre,
    required this.apellido,
    required this.rol,
    bool? activo,
    AccountStatus? estadoCuenta,
    required this.createdAt,
    this.updatedAt,
  })  : _activo = activo,
        estadoCuenta = estadoCuenta ??
            (activo == null
                ? AccountStatus.active
                : activo
                    ? AccountStatus.active
                    : AccountStatus.blocked);

  String get nombreCompleto => '$nombre $apellido';

  bool get isActive => estadoCuenta == AccountStatus.active;
  bool get isBlocked => estadoCuenta == AccountStatus.blocked;
  bool get isPendingApproval => estadoCuenta == AccountStatus.pendingApproval;
  bool get activo => isActive;

  UsuarioModel copyWith({
    String? id,
    String? email,
    String? nombre,
    String? apellido,
    UserRole? rol,
    AccountStatus? estadoCuenta,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      rol: rol ?? this.rol,
      estadoCuenta: estadoCuenta ?? this.estadoCuenta,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'nombre': nombre,
        'apellido': apellido,
        'rol': rol.name,
        'estadoCuenta': estadoCuenta.name,
        'activo': isActive,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    final estadoCuenta = map['estadoCuenta'] != null
        ? AccountStatus.fromString(map['estadoCuenta'] as String)
        : map['activo'] is bool
            ? (map['activo'] as bool
                ? AccountStatus.active
                : AccountStatus.blocked)
            : AccountStatus.active;

    return UsuarioModel(
      id: map['id'] as String,
      email: map['email'] as String,
      nombre: map['nombre'] as String,
      apellido: map['apellido'] as String,
      rol: UserRole.fromString(map['rol'] as String),
      estadoCuenta: estadoCuenta,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }

  @override
  String toString() =>
      'UsuarioModel($id, $email, $rol, estadoCuenta=${estadoCuenta.name})';
}
