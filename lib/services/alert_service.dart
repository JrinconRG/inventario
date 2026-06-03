import '../models/alerta_model.dart';
import '../models/insumo_model.dart';
import '../models/lote_model.dart';
import '../utils/enums.dart';
import 'firebase_service.dart';

class AlertService {
  final FirebaseService _firebase;

  AlertService(this._firebase);

  Stream<List<AlertaModel>> watchAlertas() => _firebase.watchAlertas();

  Stream<List<AlertaModel>> watchUnreadAlertas() =>
      _firebase.watchUnreadAlertas();

  Future<int> countUnread() => _firebase.countUnreadAlertas();

  Future<void> markAsRead(String id) => _firebase.markAlertaAsRead(id);

  Future<void> markAllAsRead() => _firebase.markAllAlertasAsRead();

  Future<void> deleteAlerta(String id) => _firebase.deleteAlerta(id);

  Future<List<AlertaModel>> generateAlerts({
    required List<InsumoModel> insumos,
    required List<LoteModel> lotes,
  }) async {
    final nuevas = <AlertaModel>[];

    for (final insumo in insumos) {
      if (insumo.isCritico) {
        final alerta = AlertaModel(
          id: 'stock_${insumo.id}',
          tipo: AlertaTipo.stockBajo,
          titulo: 'Stock crítico: ${insumo.nombre}',
          mensaje:
              'El insumo "${insumo.nombre}" tiene stock ${insumo.stockTotal} '
              '(mínimo: ${insumo.stockMinimo} ${insumo.unidadMedida.displayName})',
          insumoId: insumo.id,
          leida: false,
          fechaCreacion: DateTime.now(),
        );
        await _firebase.saveAlerta(alerta);
        nuevas.add(alerta);
      }
    }

    for (final lote in lotes) {
      if (lote.isVencido) {
        final alerta = AlertaModel(
          id: 'vencido_${lote.id}',
          tipo: AlertaTipo.loteVencido,
          titulo: 'Lote vencido: ${lote.numeroLote}',
          mensaje:
              'El lote ${lote.numeroLote} venció el '
              '${lote.fechaVencimiento.toLocal().toString().split(' ')[0]}.',
          insumoId: lote.insumoId,
          loteId: lote.id,
          leida: false,
          fechaCreacion: DateTime.now(),
        );
        await _firebase.saveAlerta(alerta);
        nuevas.add(alerta);
      } else if (lote.isProximoAVencer) {
        final alerta = AlertaModel(
          id: 'prox_${lote.id}',
          tipo: AlertaTipo.loteProximoVencer,
          titulo: 'Lote próximo a vencer: ${lote.numeroLote}',
          mensaje:
              'El lote ${lote.numeroLote} vence en ${lote.diasParaVencer} '
              'día(s) (${lote.fechaVencimiento.toLocal().toString().split(' ')[0]}).',
          insumoId: lote.insumoId,
          loteId: lote.id,
          leida: false,
          fechaCreacion: DateTime.now(),
        );
        await _firebase.saveAlerta(alerta);
        nuevas.add(alerta);
      }
    }

    return nuevas;
  }
}
