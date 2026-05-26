import 'package:flutter/material.dart';
import '../models/solicitud_model.dart';
import '../utils/enums.dart';
import '../utils/helpers.dart';
import '../utils/date_formatter.dart';

class SolicitudCard extends StatelessWidget {
  final SolicitudModel solicitud;
  final VoidCallback? onTap;
  final VoidCallback? onAprobar;
  final VoidCallback? onRechazar;
  final bool showActions;

  const SolicitudCard({
    super.key,
    required this.solicitud,
    this.onTap,
    this.onAprobar,
    this.onRechazar,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Helpers.getSolicitudColor(solicitud.estado);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      solicitud.insumoNombre,
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      solicitud.estado.displayName,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 14),
                  const SizedBox(width: 4),
                  Text(solicitud.solicitanteNombre,
                      style: theme.textTheme.bodySmall),
                  const Spacer(),
                  Text(
                    'Cantidad: ${solicitud.cantidadSolicitada}',
                    style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    DateFormatter.formatDateTime(solicitud.fechaSolicitud),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                solicitud.motivo,
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (showActions &&
                  solicitud.estado == SolicitudEstado.pendiente &&
                  (onAprobar != null || onRechazar != null)) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onRechazar != null)
                      OutlinedButton.icon(
                        onPressed: onRechazar,
                        icon: const Icon(Icons.close, size: 16),
                        label: const Text('Rechazar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      ),
                    if (onAprobar != null) ...[
                      const SizedBox(width: 8),
                      FilledButton.icon(
                        onPressed: onAprobar,
                        icon: const Icon(Icons.check, size: 16),
                        label: const Text('Aprobar'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          textStyle: const TextStyle(fontSize: 12),
                          minimumSize: Size.zero,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
