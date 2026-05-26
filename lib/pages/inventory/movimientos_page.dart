import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/movimiento_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';
import '../../utils/date_formatter.dart';
import '../../validators/stock_validator.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/loading_widget.dart';

class MovimientosPage extends StatefulWidget {
  final String insumoId;

  const MovimientosPage({super.key, required this.insumoId});

  @override
  State<MovimientosPage> createState() => _MovimientosPageState();
}

class _MovimientosPageState extends State<MovimientosPage> {
  List<MovimientoModel> _movimientos = [];
  bool _isLoading = true;
  String _insumoNombre = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    final inv = context.read<InventoryProvider>();
    final insumo =
        inv.allInsumos.where((i) => i.id == widget.insumoId).firstOrNull;
    final movs = await inv.getMovimientosByInsumo(widget.insumoId);
    if (mounted) {
      setState(() {
        _movimientos = movs;
        _insumoNombre = insumo?.nombre ?? 'Insumo';
        _isLoading = false;
      });
    }
  }

  Future<void> _showMovimientoDialog() async {
    final auth = context.read<AuthProvider>();
    final inv = context.read<InventoryProvider>();
    final insumo =
        inv.allInsumos.where((i) => i.id == widget.insumoId).firstOrNull;
    if (insumo == null) return;

    final formKey = GlobalKey<FormState>();
    final cantCtrl = TextEditingController();
    final obsCtrl = TextEditingController();
    MovimientoTipo tipo = MovimientoTipo.salida;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Registrar movimiento'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Stock disponible: ${insumo.stockTotal} '
                      '${insumo.unidadMedida.displayName}'),
                  const SizedBox(height: 12),
                  SegmentedButton<MovimientoTipo>(
                    segments: MovimientoTipo.values
                        .map((t) => ButtonSegment(
                              value: t,
                              label: Text(t.displayName),
                              icon: Icon(Helpers.getMovimientoIcon(t)),
                            ))
                        .toList(),
                    selected: {tipo},
                    onSelectionChanged: (s) =>
                        setDialogState(() => tipo = s.first),
                  ),
                  const SizedBox(height: 12),
                  CustomInput(
                    controller: cantCtrl,
                    label: 'Cantidad',
                    prefixIcon: Icons.numbers,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) => StockValidator.validateCantidadMovimiento(
                      v,
                      stockDisponible:
                          tipo == MovimientoTipo.salida ? insumo.stockTotal : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomInput(
                    controller: obsCtrl,
                    label: 'Observaciones (opcional)',
                    prefixIcon: Icons.notes,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancelar')),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                Navigator.pop(ctx);
                try {
                  await inv.registrarMovimiento(
                    insumoId: widget.insumoId,
                    tipo: tipo,
                    cantidad: int.parse(cantCtrl.text.trim()),
                    responsableId: auth.usuario!.id,
                    responsableNombre: auth.usuario!.nombreCompleto,
                    observaciones: obsCtrl.text.trim(),
                  );
                  Helpers.showSnackBar(context, 'Movimiento registrado');
                  await _load();
                } catch (e) {
                  Helpers.showSnackBar(context, e.toString(),
                      isError: true);
                }
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Movimientos: $_insumoNombre'),
            Text('${_movimientos.length} registro(s)',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
      floatingActionButton: auth.canManage
          ? FloatingActionButton.extended(
              onPressed: _showMovimientoDialog,
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Registrar'),
            )
          : null,
      body: _isLoading
          ? const LoadingWidget()
          : _movimientos.isEmpty
              ? const EmptyStateWidget(
                  icon: Icons.history,
                  title: 'Sin movimientos',
                  subtitle: 'No hay movimientos registrados para este insumo',
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _movimientos.length,
                    itemBuilder: (_, i) {
                      final m = _movimientos[i];
                      final color = Helpers.getMovimientoColor(m.tipo);
                      final icon = Helpers.getMovimientoIcon(m.tipo);
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color.withOpacity(0.15),
                            child: Icon(icon, color: color, size: 20),
                          ),
                          title: Row(
                            children: [
                              Text(m.tipo.displayName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              const Spacer(),
                              Text(
                                '${m.tipo == MovimientoTipo.salida ? '-' : '+'}${m.cantidad}',
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(m.responsableNombre),
                              Text(
                                DateFormatter.formatDateTime(m.fecha),
                                style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.5)),
                              ),
                              if (m.observaciones.isNotEmpty)
                                Text(m.observaciones,
                                    style: theme.textTheme.bodySmall),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
