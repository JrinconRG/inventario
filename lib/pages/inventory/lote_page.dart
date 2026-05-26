import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/lote_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../utils/helpers.dart';
import '../../validators/lote_validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/lote_card.dart';

class LotePage extends StatefulWidget {
  final String insumoId;

  const LotePage({super.key, required this.insumoId});

  @override
  State<LotePage> createState() => _LotePageState();
}

class _LotePageState extends State<LotePage> {
  List<LoteModel> _lotes = [];
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
    final lotes = await inv.getLotesByInsumo(widget.insumoId);
    // FEFO sort: nearest expiry first
    lotes.sort(
        (a, b) => a.fechaVencimiento.compareTo(b.fechaVencimiento));
    if (mounted) {
      setState(() {
        _lotes = lotes;
        _insumoNombre = insumo?.nombre ?? 'Insumo';
        _isLoading = false;
      });
    }
  }

  Future<void> _showAddLoteDialog() async {
    final formKey = GlobalKey<FormState>();
    final numCtrl = TextEditingController();
    final cantCtrl = TextEditingController();
    final provCtrl = TextEditingController();
    DateTime? fechaIngreso;
    DateTime? fechaVenc;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Registrar nuevo lote'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomInput(
                    controller: numCtrl,
                    label: 'Número de lote',
                    prefixIcon: Icons.tag,
                    validator: LoteValidator.validateNumeroLote,
                  ),
                  const SizedBox(height: 12),
                  CustomInput(
                    controller: provCtrl,
                    label: 'Proveedor',
                    prefixIcon: Icons.business,
                    validator: LoteValidator.validateProveedor,
                  ),
                  const SizedBox(height: 12),
                  CustomInput(
                    controller: cantCtrl,
                    label: 'Cantidad',
                    prefixIcon: Icons.inventory,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: LoteValidator.validateCantidad,
                  ),
                  const SizedBox(height: 12),
                  DatePickerInput(
                    selectedDate: fechaIngreso,
                    label: 'Fecha de ingreso',
                    lastDate: DateTime.now(),
                    onDateSelected: (d) =>
                        setDialogState(() => fechaIngreso = d),
                    validator: LoteValidator.validateFechaIngreso,
                  ),
                  const SizedBox(height: 12),
                  DatePickerInput(
                    selectedDate: fechaVenc,
                    label: 'Fecha de vencimiento',
                    firstDate: DateTime.now()
                        .subtract(const Duration(days: 3650)),
                    onDateSelected: (d) =>
                        setDialogState(() => fechaVenc = d),
                    validator: LoteValidator.validateFechaVencimiento,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                if (fechaIngreso == null || fechaVenc == null) {
                  Helpers.showSnackBar(context,
                      'Selecciona ambas fechas', isError: true);
                  return;
                }
                Navigator.pop(ctx);
                final inv = context.read<InventoryProvider>();
                await inv.addLote(
                  insumoId: widget.insumoId,
                  numeroLote: numCtrl.text.trim(),
                  fechaIngreso: fechaIngreso!,
                  fechaVencimiento: fechaVenc!,
                  cantidad: int.parse(cantCtrl.text.trim()),
                  proveedor: provCtrl.text.trim(),
                );
                Helpers.showSnackBar(context, 'Lote registrado');
                await _load();
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteLote(LoteModel lote) async {
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: 'Eliminar lote',
      content: 'Se eliminará el lote ${lote.numeroLote} '
          'y se descontará su cantidad del stock.',
      isDestructive: true,
    );
    if (confirm == true) {
      await context
          .read<InventoryProvider>()
          .deleteLote(lote.id, lote.insumoId, lote.cantidad);
      Helpers.showSnackBar(context, 'Lote eliminado');
      await _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lotes: $_insumoNombre'),
            Text('${_lotes.length} lote(s) • FEFO activo',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
      floatingActionButton: auth.canManage
          ? FloatingActionButton.extended(
              onPressed: _showAddLoteDialog,
              icon: const Icon(Icons.add),
              label: const Text('Nuevo lote'),
            )
          : null,
      body: _isLoading
          ? const LoadingWidget()
          : _lotes.isEmpty
              ? EmptyStateWidget(
                  icon: Icons.inventory_2_outlined,
                  title: 'Sin lotes registrados',
                  subtitle:
                      'Agrega el primer lote para este insumo',
                  action: auth.canManage
                      ? FilledButton.icon(
                          onPressed: _showAddLoteDialog,
                          icon: const Icon(Icons.add),
                          label: const Text('Agregar lote'),
                        )
                      : null,
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _lotes.length,
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: LoteCard(
                        lote: _lotes[i],
                        onDelete: auth.canManage
                            ? () => _deleteLote(_lotes[i])
                            : null,
                      ),
                    ),
                  ),
                ),
    );
  }
}
