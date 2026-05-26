import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../models/insumo_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../providers/solicitud_provider.dart';
import '../../utils/helpers.dart';
import '../../validators/solicitud_validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';

class CreateSolicitudPage extends StatefulWidget {
  const CreateSolicitudPage({super.key});

  @override
  State<CreateSolicitudPage> createState() => _CreateSolicitudPageState();
}

class _CreateSolicitudPageState extends State<CreateSolicitudPage> {
  final _formKey = GlobalKey<FormState>();
  final _cantCtrl = TextEditingController();
  final _motivoCtrl = TextEditingController();
  InsumoModel? _insumoSeleccionado;
  bool _isLoading = false;

  @override
  void dispose() {
    _cantCtrl.dispose();
    _motivoCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_insumoSeleccionado == null) {
      Helpers.showSnackBar(context, 'Selecciona un insumo', isError: true);
      return;
    }
    setState(() => _isLoading = true);
    final auth = context.read<AuthProvider>();
    try {
      await context.read<SolicitudProvider>().createSolicitud(
            insumoId: _insumoSeleccionado!.id,
            insumoNombre: _insumoSeleccionado!.nombre,
            cantidad: int.parse(_cantCtrl.text.trim()),
            solicitanteId: auth.usuario!.id,
            solicitanteNombre: auth.usuario!.nombreCompleto,
            motivo: _motivoCtrl.text.trim(),
          );
      if (mounted) {
        Helpers.showSnackBar(context, 'Solicitud enviada correctamente');
        context.pop();
      }
    } catch (e) {
      if (mounted) Helpers.showSnackBar(context, 'Error: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final inv = context.watch<InventoryProvider>();
    final insumos = inv.allInsumos
        .where((i) => i.stockTotal > 0)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva solicitud')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropdown<InsumoModel>(
                  value: _insumoSeleccionado,
                  items: insumos,
                  label: 'Insumo a solicitar',
                  itemLabel: (i) =>
                      '${i.nombre} (Stock: ${i.stockTotal} ${i.unidadMedida.displayName})',
                  prefixIcon: Icons.science,
                  onChanged: (v) => setState(() => _insumoSeleccionado = v),
                  validator: (v) =>
                      v == null ? 'Selecciona un insumo' : null,
                ),
                if (_insumoSeleccionado != null) ...[
                  const SizedBox(height: 8),
                  Card(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Disponible: ${_insumoSeleccionado!.stockTotal} '
                            '${_insumoSeleccionado!.unidadMedida.displayName}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                CustomInput(
                  controller: _cantCtrl,
                  label: 'Cantidad solicitada',
                  prefixIcon: Icons.numbers,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) => SolicitudValidator.validateCantidad(
                    v,
                    stockDisponible: _insumoSeleccionado?.stockTotal,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInput(
                  controller: _motivoCtrl,
                  label: 'Motivo de la solicitud',
                  prefixIcon: Icons.description_outlined,
                  maxLines: 4,
                  validator: SolicitudValidator.validateMotivo,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  label: 'Enviar solicitud',
                  onPressed: _submit,
                  isLoading: _isLoading,
                  icon: Icons.send,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
