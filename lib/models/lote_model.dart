class LoteModel {
  final String id;
  final String insumoId;
  final String numeroLote;
  final DateTime fechaIngreso;
  final DateTime fechaVencimiento;
  final int cantidad;
  final String proveedor;
  final DateTime? updatedAt;

  const LoteModel({
    required this.id,
    required this.insumoId,
    required this.numeroLote,
    required this.fechaIngreso,
    required this.fechaVencimiento,
    required this.cantidad,
    required this.proveedor,
    this.updatedAt,
  });

  bool get isVencido => fechaVencimiento.isBefore(DateTime.now());

  bool get isProximoAVencer {
    final limite = DateTime.now().add(const Duration(days: 30));
    return fechaVencimiento.isBefore(limite) && !isVencido;
  }

  int get diasParaVencer =>
      fechaVencimiento.difference(DateTime.now()).inDays;

  LoteModel copyWith({
    String? id,
    String? insumoId,
    String? numeroLote,
    DateTime? fechaIngreso,
    DateTime? fechaVencimiento,
    int? cantidad,
    String? proveedor,
    DateTime? updatedAt,
  }) {
    return LoteModel(
      id: id ?? this.id,
      insumoId: insumoId ?? this.insumoId,
      numeroLote: numeroLote ?? this.numeroLote,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      cantidad: cantidad ?? this.cantidad,
      proveedor: proveedor ?? this.proveedor,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'insumoId': insumoId,
        'numeroLote': numeroLote,
        'fechaIngreso': fechaIngreso.toIso8601String(),
        'fechaVencimiento': fechaVencimiento.toIso8601String(),
        'cantidad': cantidad,
        'proveedor': proveedor,
        'updatedAt': updatedAt?.toIso8601String(),
      };

  factory LoteModel.fromMap(Map<String, dynamic> map) => LoteModel(
        id: map['id'] as String,
        insumoId: map['insumoId'] as String,
        numeroLote: map['numeroLote'] as String,
        fechaIngreso: DateTime.parse(map['fechaIngreso'] as String),
        fechaVencimiento: DateTime.parse(map['fechaVencimiento'] as String),
        cantidad: map['cantidad'] as int,
        proveedor: map['proveedor'] as String,
        updatedAt: map['updatedAt'] != null
            ? DateTime.parse(map['updatedAt'] as String)
            : null,
      );
}
