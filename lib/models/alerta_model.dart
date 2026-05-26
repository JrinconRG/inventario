import '../utils/enums.dart';

class AlertaModel {
  final String id;
  final AlertaTipo tipo;
  final String titulo;
  final String mensaje;
  final String? insumoId;
  final String? loteId;
  final bool leida;
  final DateTime fechaCreacion;

  const AlertaModel({
    required this.id,
    required this.tipo,
    required this.titulo,
    required this.mensaje,
    this.insumoId,
    this.loteId,
    this.leida = false,
    required this.fechaCreacion,
  });

  AlertaModel copyWith({
    String? id,
    AlertaTipo? tipo,
    String? titulo,
    String? mensaje,
    String? insumoId,
    String? loteId,
    bool? leida,
    DateTime? fechaCreacion,
  }) {
    return AlertaModel(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      titulo: titulo ?? this.titulo,
      mensaje: mensaje ?? this.mensaje,
      insumoId: insumoId ?? this.insumoId,
      loteId: loteId ?? this.loteId,
      leida: leida ?? this.leida,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'tipo': tipo.name,
        'titulo': titulo,
        'mensaje': mensaje,
        'insumoId': insumoId,
        'loteId': loteId,
        'leida': leida,
        'fechaCreacion': fechaCreacion.toIso8601String(),
      };

  factory AlertaModel.fromMap(Map<String, dynamic> map) => AlertaModel(
        id: map['id'] as String,
        tipo: AlertaTipo.fromString(map['tipo'] as String),
        titulo: map['titulo'] as String,
        mensaje: map['mensaje'] as String,
        insumoId: map['insumoId'] as String?,
        loteId: map['loteId'] as String?,
        leida: map['leida'] as bool? ?? false,
        fechaCreacion: DateTime.parse(map['fechaCreacion'] as String),
      );
}
