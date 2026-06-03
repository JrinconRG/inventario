import 'package:flutter/material.dart';

class SyncStatusBadge extends StatelessWidget {
  final String syncStatus;
  final bool showLabel;

  const SyncStatusBadge({
    super.key,
    required this.syncStatus,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    switch (syncStatus) {
      case 'synced':
        return Tooltip(
          message: 'Sincronizado',
          child: Icon(
            Icons.check_circle,
            size: 16,
            color: Colors.green,
          ),
        );
      case 'failed':
        return Tooltip(
          message: 'Error en sincronización',
          child: showLabel
              ? Chip(
                  label: const Text('Error', style: TextStyle(fontSize: 11)),
                  backgroundColor: Colors.red.shade100,
                  labelStyle: const TextStyle(color: Colors.red),
                  padding: EdgeInsets.zero,
                )
              : Icon(
                  Icons.error,
                  size: 16,
                  color: Colors.red,
                ),
        );
      case 'pending':
      default:
        return Tooltip(
          message: 'Pendiente de sincronizar',
          child: showLabel
              ? Chip(
                  label:
                      const Text('Pendiente', style: TextStyle(fontSize: 11)),
                  backgroundColor: Colors.amber.shade100,
                  labelStyle: const TextStyle(color: Colors.orange),
                  padding: EdgeInsets.zero,
                )
              : Icon(
                  Icons.cloud_upload,
                  size: 16,
                  color: Colors.orange,
                ),
        );
    }
  }
}

// Widget para mostrar en una fila de lista
class SyncStatusListTile extends StatelessWidget {
  final String syncStatus;
  final Widget child;

  const SyncStatusListTile({
    super.key,
    required this.syncStatus,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = syncStatus == 'pending';
    final isFailed = syncStatus == 'failed';

    return Opacity(
      opacity: isFailed ? 0.7 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isFailed
                  ? Colors.red
                  : isPending
                      ? Colors.orange
                      : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
