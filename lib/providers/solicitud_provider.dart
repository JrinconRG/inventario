import 'dart:async';
import 'package:flutter/material.dart';
import '../models/solicitud_model.dart';
import '../services/solicitud_service.dart';
import '../services/inventory_service.dart';
import '../utils/enums.dart';

class SolicitudProvider extends ChangeNotifier {
  final SolicitudService _service;
  StreamSubscription? _sub;

  List<SolicitudModel> _solicitudes = [];
  bool _isLoading = false;
  String? _error;
  SolicitudEstado? _estadoFilter;

  SolicitudProvider(this._service) {
    _subscribe();
  }

  List<SolicitudModel> get solicitudes => _filtered;
  List<SolicitudModel> get pendientes =>
      _solicitudes.where((s) => s.estado == SolicitudEstado.pendiente).toList();
  bool get isLoading => _isLoading;
  String? get error => _error;
  SolicitudEstado? get estadoFilter => _estadoFilter;
  int get pendientesCount => pendientes.length;

  List<SolicitudModel> get _filtered {
    if (_estadoFilter == null) return _solicitudes;
    return _solicitudes.where((s) => s.estado == _estadoFilter).toList();
  }

  void _subscribe() {
    _sub = _service.watchSolicitudes().listen(
      (data) {
        _solicitudes = data;
        notifyListeners();
      },
      onError: (e) {
        _error = e.toString();
        notifyListeners();
      },
    );
  }

  Future<void> createSolicitud({
    required String insumoId,
    required String insumoNombre,
    required int cantidad,
    required String solicitanteId,
    required String solicitanteNombre,
    required String motivo,
  }) async {
    _setLoading(true);
    try {
      await _service.createSolicitud(
        insumoId: insumoId,
        insumoNombre: insumoNombre,
        cantidadSolicitada: cantidad,
        solicitanteId: solicitanteId,
        solicitanteNombre: solicitanteNombre,
        motivo: motivo,
      );
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> aprobar(
    String id, {
    required String observaciones,
    required InventoryService inventoryService,
    required String adminId,
    required String adminNombre,
  }) async {
    _setLoading(true);
    try {
      await _service.aprobarSolicitud(id,
          observaciones: observaciones,
          inventoryService: inventoryService,
          adminId: adminId,
          adminNombre: adminNombre);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> rechazar(String id,
      {required String observaciones}) async {
    _setLoading(true);
    try {
      await _service.rechazarSolicitud(id, observaciones: observaciones);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  List<SolicitudModel> getMisSolicitudes(String userId) =>
      _solicitudes.where((s) => s.solicitanteId == userId).toList();

  void setFilter(SolicitudEstado? estado) {
    _estadoFilter = estado;
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
    _sub?.cancel();
    super.dispose();
  }
}
