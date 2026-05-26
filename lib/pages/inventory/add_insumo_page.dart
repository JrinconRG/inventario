import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../models/insumo_model.dart';
import '../../providers/inventory_provider.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';
import '../../validators/stock_validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';

class AddInsumoPage extends StatefulWidget {
  final String? insumoId;

  const AddInsumoPage({super.key, this.insumoId});

  @override
  State<AddInsumoPage> createState() => _AddInsumoPageState();
}

class _AddInsumoPageState extends State<AddInsumoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  final _stockCtrl = TextEditingController();
  final _stockMinimoCtrl = TextEditingController();

  Categoria _categoria = Categoria.reactivo;
  UnidadMedida _unidad = UnidadMedida.unidad;
  InsumoEstado _estado = InsumoEstado.activo;
  InsumoModel? _insumoExistente;
  bool _isLoading = false;

  bool get isEditing => widget.insumoId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) _loadInsumo();
  }

  Future<void> _loadInsumo() async {
    setState(() => _isLoading = true);
    final inv = context.read<InventoryProvider>();
    final insumo = await inv.getLotesByInsumo(widget.insumoId!).then((_) =>
        inv.allInsumos.where((i) => i.id == widget.insumoId).firstOrNull);
    if (insumo != null && mounted) {
      _insumoExistente = insumo;
      _nombreCtrl.text = insumo.nombre;
      _descripcionCtrl.text = insumo.descripcion;
      _stockCtrl.text = insumo.stockTotal.toString();
      _stockMinimoCtrl.text = insumo.stockMinimo.toString();
      _categoria = insumo.categoria;
      _unidad = insumo.unidadMedida;
      _estado = insumo.estado;
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    _stockCtrl.dispose();
    _stockMinimoCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final inv = context.read<InventoryProvider>();
    try {
      if (isEditing && _insumoExistente != null) {
        await inv.updateInsumo(_insumoExistente!.copyWith(
          nombre: _nombreCtrl.text.trim(),
          descripcion: _descripcionCtrl.text.trim(),
          categoria: _categoria,
          stockTotal: int.parse(_stockCtrl.text.trim()),
          stockMinimo: int.parse(_stockMinimoCtrl.text.trim()),
          unidadMedida: _unidad,
          estado: _estado,
          updatedAt: DateTime.now(),
        ));
      } else {
        await inv.createInsumo(
          nombre: _nombreCtrl.text.trim(),
          descripcion: _descripcionCtrl.text.trim(),
          categoria: _categoria,
          stockTotal: int.parse(_stockCtrl.text.trim()),
          stockMinimo: int.parse(_stockMinimoCtrl.text.trim()),
          unidadMedida: _unidad,
        );
      }
      if (mounted) {
        Helpers.showSnackBar(context,
            isEditing ? 'Insumo actualizado' : 'Insumo creado correctamente');
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        Helpers.showSnackBar(context, 'Error: $e', isError: true);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar insumo' : 'Nuevo insumo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInput(
                  controller: _nombreCtrl,
                  label: 'Nombre del insumo',
                  prefixIcon: Icons.science,
                  validator: StockValidator.validateNombre,
                ),
                const SizedBox(height: 16),
                CustomInput(
                  controller: _descripcionCtrl,
                  label: 'Descripción',
                  prefixIcon: Icons.description_outlined,
                  maxLines: 3,
                  validator: StockValidator.validateDescripcion,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown<Categoria>(
                        value: _categoria,
                        items: Categoria.values,
                        label: 'Categoría',
                        itemLabel: (c) => c.displayName,
                        prefixIcon: Icons.category_outlined,
                        onChanged: (v) => setState(() => _categoria = v!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomDropdown<UnidadMedida>(
                        value: _unidad,
                        items: UnidadMedida.values,
                        label: 'Unidad',
                        itemLabel: (u) => u.displayName,
                        prefixIcon: Icons.straighten,
                        onChanged: (v) => setState(() => _unidad = v!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomInput(
                        controller: _stockCtrl,
                        label: 'Stock inicial',
                        prefixIcon: Icons.inventory,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: StockValidator.validateStockTotal,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomInput(
                        controller: _stockMinimoCtrl,
                        label: 'Stock mínimo',
                        prefixIcon: Icons.warning_amber_outlined,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: StockValidator.validateStockMinimo,
                      ),
                    ),
                  ],
                ),
                if (isEditing) ...[
                  const SizedBox(height: 16),
                  CustomDropdown<InsumoEstado>(
                    value: _estado,
                    items: InsumoEstado.values,
                    label: 'Estado',
                    itemLabel: (e) => e.displayName,
                    prefixIcon: Icons.toggle_on_outlined,
                    onChanged: (v) => setState(() => _estado = v!),
                  ),
                ],
                const SizedBox(height: 32),
                CustomButton(
                  label: isEditing ? 'Guardar cambios' : 'Crear insumo',
                  onPressed: _save,
                  isLoading: _isLoading,
                  icon: isEditing ? Icons.save : Icons.add,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
