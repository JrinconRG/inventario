import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../config/constants.dart';
import '../data/app_database.dart';
import '../models/alerta_model.dart';
import '../models/insumo_model.dart';
import '../models/lote_model.dart';
import '../utils/enums.dart';
import 'firebase_service.dart';

class AlertService {
  final AppDatabase _db;
  final _uuid = const Uuid();

  AlertService(this._db);

  Stream<List<AlertaModel>> watchAlertas() =>
      _db.alertasDao.watchAllAlertas()
          .map((rows) => rows.map(_dbToModel).toList());

  Stream<List<AlertaModel>> watchUnreadAlertas() =>
      _db.alertasDao.watchUnreadAlertas()
          .map((rows) => rows.map(_dbToModel).toList());

  Future<int> countUnread() => _db.alertasDao.countUnread();

  Future<void> markAsRead(String id) => _db.alertasDao.markAsRead(id);

  Future<void> markAllAsRead() => _db.alertasDao.markAllAsRead();

  Future<void> deleteAlerta(String id) => _db.alertasDao.deleteAlerta(id);

  /// Analiza el inventario y genera alertas automáticas.
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
        await _saveAlerta(alerta);
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
        await _saveAlerta(alerta);
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
        await _saveAlerta(alerta);
        nuevas.add(alerta);
      }
    }

    return nuevas;
  }

  Future<void> _saveAlerta(AlertaModel alerta) async {
    await _db.alertasDao.insertAlerta(AlertasCompanion.insert(
      id: alerta.id,
      tipo: alerta.tipo.name,
      titulo: alerta.titulo,
      mensaje: alerta.mensaje,
      insumoId: Value(alerta.insumoId),
      loteId: Value(alerta.loteId),
      leida: Value(alerta.leida),
      fechaCreacion: alerta.fechaCreacion,
      syncStatus: const Value('pending'),
    ));
  }

  AlertaModel _dbToModel(DbAlerta row) => AlertaModel(
        id: row.id,
        tipo: AlertaTipo.fromString(row.tipo),
        titulo: row.titulo,
        mensaje: row.mensaje,
        insumoId: row.insumoId,
        loteId: row.loteId,
        leida: row.leida,
        fechaCreacion: row.fechaCreacion,
      );
}
