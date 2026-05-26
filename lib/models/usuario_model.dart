import '../utils/enums.dart';

class UsuarioModel {
  final String id;
  final String email;
  final String nombre;
  final String apellido;
  final UserRole rol;
  final bool activo;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UsuarioModel({
    required this.id,
    required this.email,
    required this.nombre,
    required this.apellido,
    required this.rol,
    this.activo = true,
    required this.createdAt,
    this.updatedAt,
  });

  String get nombreCompleto => '$nombre $apellido';

  UsuarioModel copyWith({
    String? id,
    String? email,
    String? nombre,
    String? apellido,
    UserRole? rol,
    bool? activo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      rol: rol ?? this.rol,
      activo: activo ?? this.activo,
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
        'activo': activo,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  factory UsuarioModel.fromMap(Map<String, dynamic> map) => UsuarioModel(
        id: map['id'] as String,
        email: map['email'] as String,
        nombre: map['nombre'] as String,
        apellido: map['apellido'] as String,
        rol: UserRole.fromString(map['rol'] as String),
        activo: map['activo'] as bool? ?? true,
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: map['updatedAt'] != null
            ? DateTime.parse(map['updatedAt'] as String)
            : null,
      );

  @override
  String toString() => 'UsuarioModel($id, $email, $rol)';
}
