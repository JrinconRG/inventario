class LoteValidator {
  LoteValidator._();

  static String? validateNumeroLote(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El número de lote es requerido';
    }
    if (value.trim().length < 2) return 'Mínimo 2 caracteres';
    return null;
  }

  static String? validateCantidad(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La cantidad es requerida';
    }
    final n = int.tryParse(value.trim());
    if (n == null) return 'Debe ser un número entero';
    if (n <= 0) return 'Debe ser mayor a cero';
    return null;
  }

  static String? validateProveedor(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El proveedor es requerido';
    }
    return null;
  }

  static String? validateFechaVencimiento(DateTime? fecha) {
    if (fecha == null) return 'La fecha de vencimiento es requerida';
    // Advertencia si ya venció, pero no bloqueamos el registro
    return null;
  }

  static String? validateFechaIngreso(DateTime? fecha) {
    if (fecha == null) return 'La fecha de ingreso es requerida';
    if (fecha.isAfter(DateTime.now())) {
      return 'La fecha de ingreso no puede ser futura';
    }
    return null;
  }

  static String? validateFechas(DateTime? ingreso, DateTime? vencimiento) {
    if (ingreso == null || vencimiento == null) return null;
    if (vencimiento.isBefore(ingreso)) {
      return 'El vencimiento debe ser posterior al ingreso';
    }
    return null;
  }
}
