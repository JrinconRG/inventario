import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/solicitud_provider.dart';
import '../../services/inventory_service.dart';
import '../../services/sync_service.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/solicitud_card.dart';

class SolicitudPage extends StatelessWidget {
  const SolicitudPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sol = context.watch<SolicitudProvider>();
    final auth = context.watch<AuthProvider>();

    final canCreate = auth.canCreateSolicitudes;
    final solicitudes = auth.isDocente
        ? sol.getMisSolicitudes(auth.usuario?.id ?? '')
        : sol.solicitudes;

    final emptySubtitle = sol.estadoFilter != null
        ? 'No hay solicitudes ${sol.estadoFilter!.displayName.toLowerCase()}'
        : canCreate
            ? 'Crea tu primera solicitud de insumos'
            : 'No hay solicitudes registradas';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refrescar solicitudes',
            onPressed: () => _refresh(context),
          ),
          const SizedBox(width: 8),
          _FilterChips(
            current: sol.estadoFilter,
            onChanged: sol.setFilter,
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: canCreate
          ? FloatingActionButton.extended(
              onPressed: () => context.go('/solicitudes/create'),
              icon: const Icon(Icons.add),
              label: const Text('Nueva solicitud'),
            )
          : null,
      body: sol.isLoading
          ? const LoadingWidget()
          : solicitudes.isEmpty
              ? EmptyStateWidget(
                  icon: Icons.assignment_outlined,
                  title: 'Sin solicitudes',
                  subtitle: emptySubtitle,
                  action: canCreate
                      ? FilledButton.icon(
                          onPressed: () => context.go('/solicitudes/create'),
                          icon: const Icon(Icons.add),
                          label: const Text('Nueva solicitud'),
                        )
                      : null,
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: solicitudes.length,
                  itemBuilder: (_, i) {
                    final s = solicitudes[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SolicitudCard(
                        solicitud: s,
                        onTap: () => context.go('/solicitudes/${s.id}'),
                        showActions: auth.isAdmin,
                        onAprobar: auth.isAdmin &&
                                s.estado == SolicitudEstado.pendiente
                            ? () => _aprobar(context, s.id)
                            : null,
                        onRechazar: auth.isAdmin &&
                                s.estado == SolicitudEstado.pendiente
                            ? () => _rechazar(context, s.id)
                            : null,
                      ),
                    );
                  },
                ),
    );
  }

  Future<void> _aprobar(BuildContext context, String id) async {
    final obsCtrl = TextEditingController();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Aprobar solicitud'),
        content: TextField(
          controller: obsCtrl,
          decoration:
              const InputDecoration(labelText: 'Observación (opcional)'),
          maxLines: 2,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogCtx, false),
              child: const Text('Cancelar')),
          FilledButton(
            onPressed: () => Navigator.pop(dialogCtx, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Aprobar'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final sol = context.read<SolicitudProvider>();
    final auth = context.read<AuthProvider>();
    final inv = context.read<InventoryService>();

    try {
      await sol.aprobar(id,
          observaciones:
              obsCtrl.text.trim().isEmpty ? 'Aprobado' : obsCtrl.text.trim(),
          inventoryService: inv,
          adminId: auth.usuario!.id,
          adminNombre: auth.usuario!.nombreCompleto);
      Helpers.showSnackBar(context, 'Solicitud aprobada y stock descontado');
    } catch (e) {
      Helpers.showSnackBar(context, 'Error: $e', isError: true);
    }
  }

  Future<void> _rechazar(BuildContext context, String id) async {
    final obsCtrl = TextEditingController();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Rechazar solicitud'),
        content: TextField(
          controller: obsCtrl,
          decoration: const InputDecoration(
            labelText: 'Motivo del rechazo *',
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogCtx, false),
              child: const Text('Cancelar')),
          FilledButton(
            onPressed: () {
              if (obsCtrl.text.trim().isEmpty) return;
              Navigator.pop(dialogCtx, true);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Rechazar'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await context
          .read<SolicitudProvider>()
          .rechazar(id, observaciones: obsCtrl.text.trim());
      Helpers.showSnackBar(context, 'Solicitud rechazada');
    } catch (e) {
      Helpers.showSnackBar(context, 'Error: $e', isError: true);
    }
  }

  Future<void> _refresh(BuildContext context) async {
    try {
      final sync = context.read<SyncService>();
      await sync.fetchRemoteNow();
      if (context.mounted) {
        Helpers.showSnackBar(
            context, 'Solicitudes actualizadas desde Firebase');
      }
    } catch (e) {
      if (context.mounted) {
        Helpers.showSnackBar(context, 'Error al refrescar solicitudes: $e',
            isError: true);
      }
    }
  }
}

class _FilterChips extends StatelessWidget {
  final SolicitudEstado? current;
  final void Function(SolicitudEstado?) onChanged;

  const _FilterChips({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SolicitudEstado?>(
      icon: Badge(
        isLabelVisible: current != null,
        child: const Icon(Icons.filter_list),
      ),
      onSelected: onChanged,
      itemBuilder: (_) => [
        const PopupMenuItem(value: null, child: Text('Todas')),
        ...SolicitudEstado.values.map((s) => PopupMenuItem(
              value: s,
              child: Text(s.displayName),
            )),
      ],
    );
  }
}
