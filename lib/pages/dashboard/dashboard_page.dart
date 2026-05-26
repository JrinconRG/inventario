import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/constants.dart';
import '../../models/alerta_model.dart';
import '../../models/lote_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../providers/solicitud_provider.dart';
import '../../services/alert_service.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';
import '../../utils/date_formatter.dart';
import '../../widgets/alert_banner.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/stock_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<AlertaModel> _alertas = [];
  Timer? _alertTimer;

  @override
  void initState() {
    super.initState();
    _generateAlerts();
    _alertTimer = Timer.periodic(
      const Duration(seconds: AppConstants.syncIntervalSeconds),
      (_) => _generateAlerts(),
    );
  }

  @override
  void dispose() {
    _alertTimer?.cancel();
    super.dispose();
  }

  Future<void> _generateAlerts() async {
    final inv = context.read<InventoryProvider>();
    final alertSvc = context.read<AlertService>();
    final insumos = inv.allInsumos;
    final lotes = <LoteModel>[];
    for (final insumo in insumos) {
      final l = await inv.getLotesByInsumo(insumo.id);
      lotes.addAll(l);
    }
    final nuevas = await alertSvc.generateAlerts(
        insumos: insumos, lotes: lotes);
    if (mounted) setState(() => _alertas = nuevas);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final inv = context.watch<InventoryProvider>();
    final sol = context.watch<SolicitudProvider>();
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= AppConstants.tabletBreakpoint;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dashboard'),
            Text(
              'Bienvenido, ${auth.usuario?.nombre ?? ''}',
              style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _generateAlerts,
            tooltip: 'Actualizar',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _generateAlerts,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats grid
              _StatsGrid(
                totalInsumos: inv.totalInsumos,
                stockCritico: inv.stockCriticoCount,
                pendientes: sol.pendientesCount,
                alertas: _alertas.length,
                isWide: isWide,
              ),
              const SizedBox(height: 24),

              // Alertas recientes
              if (_alertas.isNotEmpty) ...[
                Text('Alertas activas',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ..._alertas.take(3).map((a) => AlertBanner(
                      alerta: a,
                      onTap: () => context.go('/alerts'),
                    )),
                if (_alertas.length > 3)
                  TextButton(
                    onPressed: () => context.go('/alerts'),
                    child: Text('Ver todas las alertas (${_alertas.length})'),
                  ),
                const SizedBox(height: 24),
              ],

              // Insumos críticos
              if (inv.insumosCriticos.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Stock crítico',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () => context.go('/inventory'),
                      child: const Text('Ver todo'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...inv.insumosCriticos.take(3).map((i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: StockCard(
                        insumo: i,
                        showActions: false,
                        onTap: () => context.go('/inventory/${i.id}/lotes'),
                      ),
                    )),
                const SizedBox(height: 24),
              ],

              // Movimientos recientes
              if (inv.recentMovimientos.isNotEmpty) ...[
                Text('Movimientos recientes',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Card(
                  child: Column(
                    children: inv.recentMovimientos.take(5).map((m) {
                      final color = Helpers.getMovimientoColor(m.tipo);
                      final icon = Helpers.getMovimientoIcon(m.tipo);
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: color.withOpacity(0.15),
                          child: Icon(icon, color: color, size: 20),
                        ),
                        title: Text(m.tipo.displayName),
                        subtitle: Text(
                            '${m.responsableNombre} • ${DateFormatter.formatRelative(m.fecha)}'),
                        trailing: Text(
                          '${m.tipo == MovimientoTipo.salida ? '-' : '+'}${m.cantidad}',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],

              if (inv.isLoading) const LoadingWidget(message: 'Cargando...'),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final int totalInsumos;
  final int stockCritico;
  final int pendientes;
  final int alertas;
  final bool isWide;

  const _StatsGrid({
    required this.totalInsumos,
    required this.stockCritico,
    required this.pendientes,
    required this.alertas,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    final cards = [
      StatCard(
        title: 'Total Insumos',
        value: '$totalInsumos',
        icon: Icons.inventory_2,
        color: Colors.blue,
        onTap: () => context.go('/inventory'),
      ),
      StatCard(
        title: 'Stock Crítico',
        value: '$stockCritico',
        icon: Icons.warning_amber,
        color: Colors.orange,
        subtitle: 'Por debajo del mínimo',
        onTap: () => context.go('/inventory'),
      ),
      StatCard(
        title: 'Solicitudes\nPendientes',
        value: '$pendientes',
        icon: Icons.assignment_outlined,
        color: Colors.purple,
        onTap: () => context.go('/solicitudes'),
      ),
      StatCard(
        title: 'Alertas Activas',
        value: '$alertas',
        icon: Icons.notifications_active,
        color: Colors.red,
        onTap: () => context.go('/alerts'),
      ),
    ];

    if (isWide) {
      return Row(
        children: cards
            .map((c) => Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(height: 140, child: c),
                )))
            .toList(),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: cards,
    );
  }
}
