import 'dart:async';
import 'package:flutter/material.dart';
import '../models/insumo_model.dart';
import '../models/lote_model.dart';
import '../models/movimiento_model.dart';
import '../services/inventory_service.dart';
import '../utils/enums.dart';

class InventoryProvider extends ChangeNotifier {
  final InventoryService _service;
  StreamSubscription? _insumosSub;

  List<InsumoModel> _insumos = [];
  List<MovimientoModel> _recentMovimientos = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  Categoria? _categoriaFilter;

  InventoryProvider(this._service) {
    _subscribeToInsumos();
    loadRecentMovimientos();
  }

  List<InsumoModel> get insumos => _filteredInsumos;
  List<InsumoModel> get allInsumos => _insumos;
  List<InsumoModel> get insumosCriticos =>
      _insumos.where((i) => i.isCritico).toList();
  List<MovimientoModel> get recentMovimientos => _recentMovimientos;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  Categoria? get categoriaFilter => _categoriaFilter;

  int get totalInsumos => _insumos.length;
  int get stockCriticoCount => insumosCriticos.length;

  List<InsumoModel> get _filteredInsumos {
    var list = _insumos;
    if (_searchQuery.isNotEmpty) {
      list = list
          .where((i) =>
              i.nombre.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    if (_categoriaFilter != null) {
      list = list.where((i) => i.categoria == _categoriaFilter).toList();
    }
    return list;
  }

  void _subscribeToInsumos() {
    _insumosSub = _service.watchInsumos().listen(
      (data) {
        _insumos = data;
        notifyListeners();
      },
      onError: (e) {
        _error = e.toString();
        notifyListeners();
      },
    );
  }

  Future<void> loadRecentMovimientos() async {
    try {
      _recentMovimientos = await _service.getRecentMovimientos(limit: 10);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> createInsumo({
    required String nombre,
    required String descripcion,
    required Categoria categoria,
    required int stockTotal,
    required int stockMinimo,
    required UnidadMedida unidadMedida,
  }) async {
    _setLoading(true);
    try {
      await _service.createInsumo(
        nombre: nombre,
        descripcion: descripcion,
        categoria: categoria,
        stockTotal: stockTotal,
        stockMinimo: stockMinimo,
        unidadMedida: unidadMedida,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateInsumo(InsumoModel insumo) async {
    _setLoading(true);
    try {
      await _service.updateInsumo(insumo);
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteInsumo(String id) async {
    _setLoading(true);
    try {
      await _service.deleteInsumo(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<List<LoteModel>> getLotesByInsumo(String insumoId) =>
      _service.getLotesByInsumo(insumoId);

  Future<LoteModel> addLote({
    required String insumoId,
    required String numeroLote,
    required DateTime fechaIngreso,
    required DateTime fechaVencimiento,
    required int cantidad,
    required String proveedor,
  }) async {
    final lote = await _service.addLote(
      insumoId: insumoId,
      numeroLote: numeroLote,
      fechaIngreso: fechaIngreso,
      fechaVencimiento: fechaVencimiento,
      cantidad: cantidad,
      proveedor: proveedor,
    );
    await loadRecentMovimientos();
    return lote;
  }

  Future<void> deleteLote(
      String id, String insumoId, int cantidad) async {
    await _service.deleteLote(id, insumoId, cantidad);
  }

  Future<void> registrarMovimiento({
    required String insumoId,
    required MovimientoTipo tipo,
    required int cantidad,
    required String responsableId,
    required String responsableNombre,
    String observaciones = '',
  }) async {
    _setLoading(true);
    try {
      await _service.registrarMovimiento(
        insumoId: insumoId,
        tipo: tipo,
        cantidad: cantidad,
        responsableId: responsableId,
        responsableNombre: responsableNombre,
        observaciones: observaciones,
      );
      await loadRecentMovimientos();
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<List<MovimientoModel>> getMovimientosByInsumo(
      String insumoId) =>
      _service.getMovimientosByInsumo(insumoId);

  void setSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategoriaFilter(Categoria? cat) {
    _categoriaFilter = cat;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _categoriaFilter = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  @override
  void dispose() {
    _insumosSub?.cancel();
    super.dispose();
  }
}
