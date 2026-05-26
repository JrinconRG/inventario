class StockValidator {
  StockValidator._();

  static String? validateNombre(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre del insumo es requerido';
    }
    if (value.trim().length < 3) return 'Mínimo 3 caracteres';
    return null;
  }

  static String? validateDescripcion(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La descripción es requerida';
    }
    return null;
  }

  static String? validateStockTotal(String? value) {
    if (value == null || value.trim().isEmpty) return 'El stock es requerido';
    final n = int.tryParse(value.trim());
    if (n == null) return 'Debe ser un número entero';
    if (n < 0) return 'El stock no puede ser negativo';
    return null;
  }

  static String? validateStockMinimo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El stock mínimo es requerido';
    }
    final n = int.tryParse(value.trim());
    if (n == null) return 'Debe ser un número entero';
    if (n < 0) return 'No puede ser negativo';
    return null;
  }

  static String? validateCantidadMovimiento(String? value,
      {int? stockDisponible}) {
    if (value == null || value.trim().isEmpty) {
      return 'La cantidad es requerida';
    }
    final n = int.tryParse(value.trim());
    if (n == null) return 'Debe ser un número entero';
    if (n <= 0) return 'Debe ser mayor a cero';
    if (stockDisponible != null && n > stockDisponible) {
      return 'Supera el stock disponible ($stockDisponible)';
    }
    return null;
  }
}
