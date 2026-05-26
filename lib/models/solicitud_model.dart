import '../utils/enums.dart';

class SolicitudModel {
  final String id;
  final String insumoId;
  final String insumoNombre;
  final int cantidadSolicitada;
  final String solicitanteId;
  final String solicitanteNombre;
  final SolicitudEstado estado;
  final String motivo;
  final String? observacionesAdmin;
  final DateTime fechaSolicitud;
  final DateTime? fechaRespuesta;

  const SolicitudModel({
    required this.id,
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
  });

  SolicitudModel copyWith({
    String? id,
    String? insumoId,
    String? insumoNombre,
    int? cantidadSolicitada,
    String? solicitanteId,
    String? solicitanteNombre,
    SolicitudEstado? estado,
    String? motivo,
    String? observacionesAdmin,
    DateTime? fechaSolicitud,
    DateTime? fechaRespuesta,
  }) {
    return SolicitudModel(
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
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'insumoId': insumoId,
        'insumoNombre': insumoNombre,
        'cantidadSolicitada': cantidadSolicitada,
        'solicitanteId': solicitanteId,
        'solicitanteNombre': solicitanteNombre,
        'estado': estado.name,
        'motivo': motivo,
        'observacionesAdmin': observacionesAdmin,
        'fechaSolicitud': fechaSolicitud.toIso8601String(),
        'fechaRespuesta': fechaRespuesta?.toIso8601String(),
      };

  factory SolicitudModel.fromMap(Map<String, dynamic> map) => SolicitudModel(
        id: map['id'] as String,
        insumoId: map['insumoId'] as String,
        insumoNombre: map['insumoNombre'] as String,
        cantidadSolicitada: map['cantidadSolicitada'] as int,
        solicitanteId: map['solicitanteId'] as String,
        solicitanteNombre: map['solicitanteNombre'] as String,
        estado: SolicitudEstado.fromString(map['estado'] as String),
        motivo: map['motivo'] as String,
        observacionesAdmin: map['observacionesAdmin'] as String?,
        fechaSolicitud: DateTime.parse(map['fechaSolicitud'] as String),
        fechaRespuesta: map['fechaRespuesta'] != null
            ? DateTime.parse(map['fechaRespuesta'] as String)
            : null,
      );
}
