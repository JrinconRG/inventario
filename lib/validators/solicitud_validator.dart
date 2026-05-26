class SolicitudValidator {
  SolicitudValidator._();

  static String? validateMotivo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El motivo es requerido';
    }
    if (value.trim().length < 10) {
      return 'Describe el motivo con al menos 10 caracteres';
    }
    return null;
  }

  static String? validateCantidad(String? value, {int? stockDisponible}) {
    if (value == null || value.trim().isEmpty) {
      return 'La cantidad es requerida';
    }
    final n = int.tryParse(value.trim());
    if (n == null) return 'Debe ser un número entero';
    if (n <= 0) return 'Debe ser mayor a cero';
    if (stockDisponible != null && n > stockDisponible) {
      return 'No hay suficiente stock (disponible: $stockDisponible)';
    }
    return null;
  }

  static String? validateObservacionAdmin(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Agrega una observación para la respuesta';
    }
    return null;
  }
}
