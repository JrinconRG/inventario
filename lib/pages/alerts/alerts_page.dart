import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/alerta_model.dart';
import '../../services/alert_service.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';
import '../../widgets/alert_banner.dart';
import '../../widgets/loading_widget.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final alertSvc = context.read<AlertService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alertas'),
        actions: [
          TextButton.icon(
            onPressed: () => alertSvc.markAllAsRead(),
            icon: const Icon(Icons.done_all),
            label: const Text('Marcar todo'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: StreamBuilder<List<AlertaModel>>(
        stream: alertSvc.watchAlertas(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          final alertas = snap.data ?? [];
          if (alertas.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.notifications_none,
              title: 'Sin alertas',
              subtitle: 'El inventario está en buen estado',
            );
          }

          // Group by type
          final stockBajo = alertas
              .where((a) => a.tipo == AlertaTipo.stockBajo)
              .toList();
          final vencidos = alertas
              .where((a) => a.tipo == AlertaTipo.loteVencido)
              .toList();
          final proximos = alertas
              .where((a) => a.tipo == AlertaTipo.loteProximoVencer)
              .toList();

          return RefreshIndicator(
            onRefresh: () async {},
            child: ListView(
              children: [
                if (vencidos.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'Lotes vencidos (${vencidos.length})',
                    color: Colors.red,
                    icon: Icons.dangerous,
                  ),
                  ...vencidos.map((a) => AlertBanner(
                        alerta: a,
                        onTap: () => alertSvc.markAsRead(a.id),
                        onDismiss: () => alertSvc.deleteAlerta(a.id),
                      )),
                ],
                if (proximos.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'Próximos a vencer (${proximos.length})',
                    color: Colors.orange,
                    icon: Icons.warning,
                  ),
                  ...proximos.map((a) => AlertBanner(
                        alerta: a,
                        onTap: () => alertSvc.markAsRead(a.id),
                        onDismiss: () => alertSvc.deleteAlerta(a.id),
                      )),
                ],
                if (stockBajo.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'Stock bajo (${stockBajo.length})',
                    color: Colors.amber.shade800,
                    icon: Icons.inventory_2,
                  ),
                  ...stockBajo.map((a) => AlertBanner(
                        alerta: a,
                        onTap: () => alertSvc.markAsRead(a.id),
                        onDismiss: () => alertSvc.deleteAlerta(a.id),
                      )),
                ],
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;

  const _SectionHeader(
      {required this.title, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
