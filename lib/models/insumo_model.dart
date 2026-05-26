import '../utils/enums.dart';

class InsumoModel {
  final String id;
  final String nombre;
  final String descripcion;
  final Categoria categoria;
  final int stockTotal;
  final int stockMinimo;
  final UnidadMedida unidadMedida;
  final InsumoEstado estado;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const InsumoModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.categoria,
    required this.stockTotal,
    required this.stockMinimo,
    required this.unidadMedida,
    required this.estado,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isCritico => stockTotal <= stockMinimo;

  InsumoModel copyWith({
    String? id,
    String? nombre,
    String? descripcion,
    Categoria? categoria,
    int? stockTotal,
    int? stockMinimo,
    UnidadMedida? unidadMedida,
    InsumoEstado? estado,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InsumoModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      categoria: categoria ?? this.categoria,
      stockTotal: stockTotal ?? this.stockTotal,
      stockMinimo: stockMinimo ?? this.stockMinimo,
      unidadMedida: unidadMedida ?? this.unidadMedida,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
        'categoria': categoria.name,
        'stockTotal': stockTotal,
        'stockMinimo': stockMinimo,
        'unidadMedida': unidadMedida.name,
        'estado': estado.name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  factory InsumoModel.fromMap(Map<String, dynamic> map) => InsumoModel(
        id: map['id'] as String,
        nombre: map['nombre'] as String,
        descripcion: map['descripcion'] as String,
        categoria: Categoria.fromString(map['categoria'] as String),
        stockTotal: map['stockTotal'] as int,
        stockMinimo: map['stockMinimo'] as int,
        unidadMedida: UnidadMedida.fromString(map['unidadMedida'] as String),
        estado: InsumoEstado.fromString(map['estado'] as String),
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: map['updatedAt'] != null
            ? DateTime.parse(map['updatedAt'] as String)
            : null,
      );
}
