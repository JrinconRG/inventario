import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/constants.dart';
import '../../providers/auth_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../utils/enums.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/stock_card.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inv = context.watch<InventoryProvider>();
    final auth = context.watch<AuthProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        actions: [
          if (auth.canManage)
            FilledButton.icon(
              onPressed: () => context.go('/inventory/add'),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Agregar'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, 36),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          // Search and filter bar
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Row(
              children: [
                Expanded(
                  child: CustomInput(
                    label: 'Buscar insumo...',
                    prefixIcon: Icons.search,
                    onChanged: inv.setSearch,
                    textCapitalization: TextCapitalization.none,
                  ),
                ),
                const SizedBox(width: 12),
                _FilterButton(
                  current: inv.categoriaFilter,
                  onChanged: inv.setCategoriaFilter,
                ),
              ],
            ),
          ),

          // Category chips
          if (inv.categoriaFilter != null)
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 8),
              child: Row(
                children: [
                  Chip(
                    label: Text(inv.categoriaFilter!.displayName),
                    onDeleted: inv.clearFilters,
                  ),
                ],
              ),
            ),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingM),
            child: Row(
              children: [
                Text(
                  '${inv.insumos.length} insumo(s)',
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Insumos list
          Expanded(
            child: inv.isLoading
                ? const LoadingWidget()
                : inv.insumos.isEmpty
                    ? EmptyStateWidget(
                        icon: Icons.inventory_2_outlined,
                        title: 'Sin insumos registrados',
                        subtitle: inv.searchQuery.isNotEmpty
                            ? 'No se encontraron resultados para "${inv.searchQuery}"'
                            : 'Agrega el primer insumo al inventario',
                        action: auth.canManage
                            ? FilledButton.icon(
                                onPressed: () => context.go('/inventory/add'),
                                icon: const Icon(Icons.add),
                                label: const Text('Agregar insumo'),
                              )
                            : null,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingM),
                        itemCount: inv.insumos.length,
                        itemBuilder: (_, i) {
                          final insumo = inv.insumos[i];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: StockCard(
                              insumo: insumo,
                              onTap: () => context
                                  .go('/inventory/${insumo.id}/lotes'),
                              onEdit: auth.canManage
                                  ? () => context.go(
                                      '/inventory/edit/${insumo.id}')
                                  : null,
                              onDelete: auth.isAdmin
                                  ? () =>
                                      _confirmDelete(context, inv, insumo.id)
                                  : null,
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, InventoryProvider inv, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar insumo'),
        content: const Text(
            '¿Estás seguro? Se eliminarán también sus lotes y movimientos.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirm == true) await inv.deleteInsumo(id);
  }
}

class _FilterButton extends StatelessWidget {
  final Categoria? current;
  final void Function(Categoria?) onChanged;

  const _FilterButton({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Categoria?>(
      icon: Badge(
        isLabelVisible: current != null,
        child: const Icon(Icons.filter_list),
      ),
      tooltip: 'Filtrar por categoría',
      onSelected: onChanged,
      itemBuilder: (_) => [
        const PopupMenuItem(value: null, child: Text('Todas')),
        ...Categoria.values.map((c) => PopupMenuItem(
              value: c,
              child: Text(c.displayName),
            )),
      ],
    );
  }
}
