import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/constants.dart';
import '../models/insumo_model.dart';
import '../models/lote_model.dart';
import '../models/movimiento_model.dart';
import '../models/solicitud_model.dart';
import '../models/alerta_model.dart';
import '../models/usuario_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ─── Usuarios ────────────────────────────────────────────────────────────

  Future<void> saveUsuario(UsuarioModel u) => _db
      .collection(AppConstants.colUsers)
      .doc(u.id)
      .set(u.toMap(), SetOptions(merge: true));

  Future<List<UsuarioModel>> getAllUsuarios() async {
    final snap = await _db.collection(AppConstants.colUsers).get();
    return snap.docs
        .map((d) => UsuarioModel.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }

  // ─── Insumos ─────────────────────────────────────────────────────────────

  Future<void> saveInsumo(InsumoModel insumo) => _db
      .collection(AppConstants.colInventory)
      .doc(insumo.id)
      .set(insumo.toMap(), SetOptions(merge: true));

  Future<void> deleteInsumo(String id) =>
      _db.collection(AppConstants.colInventory).doc(id).delete();

  Future<List<InsumoModel>> getAllInsumos() async {
    final snap = await _db.collection(AppConstants.colInventory).get();
    return snap.docs
        .map((d) => InsumoModel.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }

  Stream<List<InsumoModel>> watchInsumos() => _db
      .collection(AppConstants.colInventory)
      .snapshots()
      .map((snap) => snap.docs
          .map((d) => InsumoModel.fromMap({'id': d.id, ...d.data()}))
          .toList());

  // ─── Lotes ───────────────────────────────────────────────────────────────

  Future<void> saveLote(LoteModel lote) =>
      _db.collection(AppConstants.colLots).doc(lote.id).set(lote.toMap(),
          SetOptions(merge: true));

  Future<void> deleteLote(String id) =>
      _db.collection(AppConstants.colLots).doc(id).delete();

  Future<List<LoteModel>> getLotesByInsumo(String insumoId) async {
    final snap = await _db
        .collection(AppConstants.colLots)
        .where('insumoId', isEqualTo: insumoId)
        .get();
    return snap.docs
        .map((d) => LoteModel.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }

  Stream<List<LoteModel>> watchLotesByInsumo(String insumoId) => _db
      .collection(AppConstants.colLots)
      .where('insumoId', isEqualTo: insumoId)
      .snapshots()
      .map((snap) => snap.docs
          .map((d) => LoteModel.fromMap({'id': d.id, ...d.data()}))
          .toList());

  Future<List<LoteModel>> getLotesFEFO(String insumoId) async {
    final lotes = await getLotesByInsumo(insumoId);
    final activos = lotes.where((l) => l.cantidad > 0).toList();
    activos.sort((a, b) => a.fechaVencimiento.compareTo(b.fechaVencimiento));
    return activos;
  }

  Future<void> updateLoteCantidad(String id, int cantidad) =>
      _db.collection(AppConstants.colLots).doc(id).update({'cantidad': cantidad});

  Future<void> updateInsumoStock(String id, int stockTotal) =>
      _db.collection(AppConstants.colInventory).doc(id).update({
        'stockTotal': stockTotal,
        'updatedAt': DateTime.now().toIso8601String(),
      });

  Future<List<LoteModel>> getAllLotes() async {
    final snap = await _db.collection(AppConstants.colLots).get();
    return snap.docs
        .map((d) => LoteModel.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }

  // ─── Movimientos ─────────────────────────────────────────────────────────

  Future<void> saveMovimiento(MovimientoModel m) => _db
      .collection(AppConstants.colMovements)
      .doc(m.id)
      .set(m.toMap(), SetOptions(merge: true));

  Future<List<MovimientoModel>> getRecentMovimientos({int limit = 20}) async {
    final snap = await _db
        .collection(AppConstants.colMovements)
        .orderBy('fecha', descending: true)
        .limit(limit)
        .get();
    return snap.docs
        .map((d) => MovimientoModel.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }

  Future<List<MovimientoModel>> getMovimientosByInsumo(
      String insumoId) async {
    final snap = await _db
        .collection(AppConstants.colMovements)
        .where('insumoId', isEqualTo: insumoId)
        .orderBy('fecha', descending: true)
        .get();
    return snap.docs
        .map((d) => MovimientoModel.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }

  // ─── Solicitudes ─────────────────────────────────────────────────────────

  Future<void> saveSolicitud(SolicitudModel s) => _db
      .collection(AppConstants.colRequests)
      .doc(s.id)
      .set(s.toMap(), SetOptions(merge: true));

  Future<SolicitudModel?> getSolicitudById(String id) async {
    final doc = await _db.collection(AppConstants.colRequests).doc(id).get();
    if (!doc.exists) return null;
    return SolicitudModel.fromMap({'id': doc.id, ...doc.data()!});
  }

  Future<List<SolicitudModel>> getAllSolicitudes() async {
    final snap = await _db
        .collection(AppConstants.colRequests)
        .orderBy('fechaSolicitud', descending: true)
        .get();
    return snap.docs
        .map((d) => SolicitudModel.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }

  Future<List<SolicitudModel>> getSolicitudesByEstado(String estado) async {
    final snap = await _db
        .collection(AppConstants.colRequests)
        .where('estado', isEqualTo: estado)
        .orderBy('fechaSolicitud', descending: true)
        .get();
    return snap.docs
        .map((d) => SolicitudModel.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }

  Future<List<SolicitudModel>> getSolicitudesByUser(String userId) async {
    final snap = await _db
        .collection(AppConstants.colRequests)
        .where('solicitanteId', isEqualTo: userId)
        .orderBy('fechaSolicitud', descending: true)
        .get();
    return snap.docs
        .map((d) => SolicitudModel.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }

  Future<int> countSolicitudesPendientes() async {
    final snap = await _db
        .collection(AppConstants.colRequests)
        .where('estado', isEqualTo: 'pendiente')
        .count()
        .get();
    return snap.count ?? 0;
  }

  Stream<List<SolicitudModel>> watchSolicitudes() => _db
      .collection(AppConstants.colRequests)
      .orderBy('fechaSolicitud', descending: true)
      .snapshots()
      .map((snap) => snap.docs
          .map((d) => SolicitudModel.fromMap({'id': d.id, ...d.data()}))
          .toList());

  // ─── Alertas ─────────────────────────────────────────────────────────────

  Future<void> saveAlerta(AlertaModel a) => _db
      .collection(AppConstants.colAlerts)
      .doc(a.id)
      .set(a.toMap(), SetOptions(merge: true));

  Future<void> deleteAlerta(String id) =>
      _db.collection(AppConstants.colAlerts).doc(id).delete();

  Future<void> markAlertaAsRead(String id) =>
      _db.collection(AppConstants.colAlerts).doc(id).update({'leida': true});

  Future<void> markAllAlertasAsRead() async {
    final snap = await _db
        .collection(AppConstants.colAlerts)
        .where('leida', isEqualTo: false)
        .get();
    final batch = _db.batch();
    for (final doc in snap.docs) {
      batch.update(doc.reference, {'leida': true});
    }
    await batch.commit();
  }

  Future<int> countUnreadAlertas() async {
    final snap = await _db
        .collection(AppConstants.colAlerts)
        .where('leida', isEqualTo: false)
        .count()
        .get();
    return snap.count ?? 0;
  }

  Stream<List<AlertaModel>> watchAlertas() => _db
      .collection(AppConstants.colAlerts)
      .orderBy('fechaCreacion', descending: true)
      .snapshots()
      .map((snap) => snap.docs
          .map((d) => AlertaModel.fromMap({'id': d.id, ...d.data()}))
          .toList());

  Stream<List<AlertaModel>> watchUnreadAlertas() => _db
      .collection(AppConstants.colAlerts)
      .where('leida', isEqualTo: false)
      .orderBy('fechaCreacion', descending: true)
      .snapshots()
      .map((snap) => snap.docs
          .map((d) => AlertaModel.fromMap({'id': d.id, ...d.data()}))
          .toList());

  Future<List<AlertaModel>> getAllAlertas() async {
    final snap = await _db
        .collection(AppConstants.colAlerts)
        .orderBy('fechaCreacion', descending: true)
        .get();
    return snap.docs
        .map((d) => AlertaModel.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }
}
