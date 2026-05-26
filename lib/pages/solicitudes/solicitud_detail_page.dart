import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/solicitud_model.dart';
import '../../providers/solicitud_provider.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';
import '../../utils/date_formatter.dart';
import '../../widgets/loading_widget.dart';

class SolicitudDetailPage extends StatelessWidget {
  final String solicitudId;

  const SolicitudDetailPage({super.key, required this.solicitudId});

  @override
  Widget build(BuildContext context) {
    final sol = context.watch<SolicitudProvider>();
    final solicitud = sol.solicitudes
        .where((s) => s.id == solicitudId)
        .firstOrNull;

    if (solicitud == null) {
      return const Scaffold(
        body: LoadingWidget(message: 'Cargando solicitud...'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de solicitud'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusHeader(solicitud: solicitud),
            const SizedBox(height: 24),
            _DetailSection(
              title: 'Información del insumo',
              children: [
                _DetailRow('Insumo', solicitud.insumoNombre),
                _DetailRow(
                    'Cantidad solicitada', '${solicitud.cantidadSolicitada}'),
              ],
            ),
            const SizedBox(height: 16),
            _DetailSection(
              title: 'Solicitante',
              children: [
                _DetailRow('Nombre', solicitud.solicitanteNombre),
                _DetailRow('Fecha de solicitud',
                    DateFormatter.formatDateTime(solicitud.fechaSolicitud)),
              ],
            ),
            const SizedBox(height: 16),
            _DetailSection(
              title: 'Motivo',
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(solicitud.motivo),
                ),
              ],
            ),
            if (solicitud.estado != SolicitudEstado.pendiente) ...[
              const SizedBox(height: 16),
              _DetailSection(
                title: 'Respuesta del administrador',
                children: [
                  if (solicitud.fechaRespuesta != null)
                    _DetailRow(
                      'Fecha de respuesta',
                      DateFormatter.formatDateTime(solicitud.fechaRespuesta!),
                    ),
                  if (solicitud.observacionesAdmin != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(solicitud.observacionesAdmin!),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusHeader extends StatelessWidget {
  final SolicitudModel solicitud;

  const _StatusHeader({required this.solicitud});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Helpers.getSolicitudColor(solicitud.estado);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            solicitud.estado == SolicitudEstado.aprobada
                ? Icons.check_circle
                : solicitud.estado == SolicitudEstado.rechazada
                    ? Icons.cancel
                    : Icons.schedule,
            color: color,
            size: 32,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                solicitud.estado.displayName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ID: ${solicitud.id.substring(0, 8).toUpperCase()}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _DetailSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5)),
            ),
          ),
          Expanded(
            child: Text(value,
                style: theme.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
