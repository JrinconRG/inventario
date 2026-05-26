import 'package:flutter/material.dart';
import 'enums.dart';

class Helpers {
  Helpers._();

  static Color getEstadoColor(InsumoEstado estado) {
    switch (estado) {
      case InsumoEstado.activo:
        return Colors.green;
      case InsumoEstado.inactivo:
        return Colors.grey;
      case InsumoEstado.agotado:
        return Colors.red;
    }
  }

  static Color getSolicitudColor(SolicitudEstado estado) {
    switch (estado) {
      case SolicitudEstado.pendiente:
        return Colors.orange;
      case SolicitudEstado.aprobada:
        return Colors.green;
      case SolicitudEstado.rechazada:
        return Colors.red;
    }
  }

  static Color getAlertaColor(AlertaTipo tipo) {
    switch (tipo) {
      case AlertaTipo.stockBajo:
        return Colors.orange;
      case AlertaTipo.loteVencido:
        return Colors.red;
      case AlertaTipo.loteProximoVencer:
        return Colors.amber;
    }
  }

  static Color getMovimientoColor(MovimientoTipo tipo) {
    switch (tipo) {
      case MovimientoTipo.entrada:
        return Colors.green;
      case MovimientoTipo.salida:
        return Colors.red;
      case MovimientoTipo.ajuste:
        return Colors.blue;
    }
  }

  static IconData getMovimientoIcon(MovimientoTipo tipo) {
    switch (tipo) {
      case MovimientoTipo.entrada:
        return Icons.add_circle;
      case MovimientoTipo.salida:
        return Icons.remove_circle;
      case MovimientoTipo.ajuste:
        return Icons.swap_horiz;
    }
  }

  static IconData getAlertaIcon(AlertaTipo tipo) {
    switch (tipo) {
      case AlertaTipo.stockBajo:
        return Icons.inventory_2;
      case AlertaTipo.loteVencido:
        return Icons.dangerous;
      case AlertaTipo.loteProximoVencer:
        return Icons.warning;
    }
  }

  static bool isStockCritico(int stockActual, int stockMinimo) =>
      stockActual <= stockMinimo;

  static bool isLoteVencido(DateTime fechaVencimiento) =>
      fechaVencimiento.isBefore(DateTime.now());

  static bool isLoteProximoVencer(DateTime fechaVencimiento,
      {int diasLimite = 30}) {
    final limite = DateTime.now().add(Duration(days: diasLimite));
    return fechaVencimiento.isBefore(limite) &&
        !isLoteVencido(fechaVencimiento);
  }

  static void showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          FilledButton(
            style: isDestructive
                ? FilledButton.styleFrom(backgroundColor: Colors.red)
                : null,
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  static bool canManageInventory(UserRole role) =>
      role == UserRole.administrador || role == UserRole.laboratorista;

  static bool canApproveRequests(UserRole role) =>
      role == UserRole.administrador;
}
