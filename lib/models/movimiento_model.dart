import '../utils/enums.dart';

class MovimientoModel {
  final String id;
  final String insumoId;
  final String? loteId;
  final MovimientoTipo tipo;
  final int cantidad;
  final String responsableId;
  final String responsableNombre;
  final String observaciones;
  final DateTime fecha;

  const MovimientoModel({
    required this.id,
    required this.insumoId,
    this.loteId,
    required this.tipo,
    required this.cantidad,
    required this.responsableId,
    required this.responsableNombre,
    this.observaciones = '',
    required this.fecha,
  });

  MovimientoModel copyWith({
    String? id,
    String? insumoId,
    String? loteId,
    MovimientoTipo? tipo,
    int? cantidad,
    String? responsableId,
    String? responsableNombre,
    String? observaciones,
    DateTime? fecha,
  }) {
    return MovimientoModel(
      id: id ?? this.id,
      insumoId: insumoId ?? this.insumoId,
      loteId: loteId ?? this.loteId,
      tipo: tipo ?? this.tipo,
      cantidad: cantidad ?? this.cantidad,
      responsableId: responsableId ?? this.responsableId,
      responsableNombre: responsableNombre ?? this.responsableNombre,
      observaciones: observaciones ?? this.observaciones,
      fecha: fecha ?? this.fecha,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'insumoId': insumoId,
        'loteId': loteId,
        'tipo': tipo.name,
        'cantidad': cantidad,
        'responsableId': responsableId,
        'responsableNombre': responsableNombre,
        'observaciones': observaciones,
        'fecha': fecha.toIso8601String(),
      };

  factory MovimientoModel.fromMap(Map<String, dynamic> map) => MovimientoModel(
        id: map['id'] as String,
        insumoId: map['insumoId'] as String,
        loteId: map['loteId'] as String?,
        tipo: MovimientoTipo.fromString(map['tipo'] as String),
        cantidad: map['cantidad'] as int,
        responsableId: map['responsableId'] as String,
        responsableNombre: map['responsableNombre'] as String,
        observaciones: map['observaciones'] as String? ?? '',
        fecha: DateTime.parse(map['fecha'] as String),
      );
}
