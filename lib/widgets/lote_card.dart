import 'package:flutter/material.dart';
import '../models/lote_model.dart';
import '../utils/date_formatter.dart';

class LoteCard extends StatelessWidget {
  final LoteModel lote;
  final VoidCallback? onDelete;

  const LoteCard({super.key, required this.lote, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color statusColor;
    String statusLabel;

    if (lote.isVencido) {
      statusColor = Colors.red;
      statusLabel = 'Vencido';
    } else if (lote.isProximoAVencer) {
      statusColor = Colors.orange;
      statusLabel = 'Por vencer';
    } else {
      statusColor = Colors.green;
      statusLabel = 'Vigente';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Lote: ${lote.numeroLote}',
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                _StatusChip(label: statusLabel, color: statusColor),
              ],
            ),
            const SizedBox(height: 12),
            _InfoRow(
                icon: Icons.business,
                label: 'Proveedor',
                value: lote.proveedor),
            const SizedBox(height: 6),
            _InfoRow(
                icon: Icons.calendar_today,
                label: 'Ingreso',
                value: DateFormatter.formatDate(lote.fechaIngreso)),
            const SizedBox(height: 6),
            _InfoRow(
              icon: Icons.event_busy,
              label: 'Vencimiento',
              value: DateFormatter.formatDate(lote.fechaVencimiento),
              valueColor: statusColor,
            ),
            const SizedBox(height: 6),
            _InfoRow(
                icon: Icons.inventory_2,
                label: 'Cantidad',
                value: '${lote.cantidad}'),
            const SizedBox(height: 6),
            _InfoRow(
              icon: Icons.timelapse,
              label: 'Estado',
              value: DateFormatter.diasParaVencer(lote.fechaVencimiento),
              valueColor: statusColor,
            ),
            if (onDelete != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton.outlined(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline,
                      size: 18, color: Colors.red),
                  style: IconButton.styleFrom(
                      minimumSize: const Size(32, 32), padding: EdgeInsets.zero),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon,
            size: 14,
            color: theme.colorScheme.onSurface.withOpacity(0.4)),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5)),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: valueColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
