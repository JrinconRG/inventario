import 'package:flutter_test/flutter_test.dart';
import 'package:lab_inventory/models/insumo_model.dart';
import 'package:lab_inventory/models/lote_model.dart';
import 'package:lab_inventory/utils/enums.dart';
import 'package:lab_inventory/utils/helpers.dart';

void main() {
  group('InsumoModel', () {
    late InsumoModel insumo;

    setUp(() {
      insumo = InsumoModel(
        id: 'test-id',
        nombre: 'Ácido Sulfúrico',
        descripcion: 'Reactivo de laboratorio',
        categoria: Categoria.reactivo,
        stockTotal: 10,
        stockMinimo: 5,
        unidadMedida: UnidadMedida.l,
        estado: InsumoEstado.activo,
        createdAt: DateTime.now(),
      );
    });

    test('isCritico returns true when stock <= minimum', () {
      final insumoLow = insumo.copyWith(stockTotal: 5);
      expect(insumoLow.isCritico, isTrue);
    });

    test('isCritico returns false when stock > minimum', () {
      expect(insumo.isCritico, isFalse);
    });

    test('copyWith preserves unchanged fields', () {
      final copy = insumo.copyWith(nombre: 'Nuevo nombre');
      expect(copy.id, equals(insumo.id));
      expect(copy.nombre, equals('Nuevo nombre'));
      expect(copy.stockTotal, equals(insumo.stockTotal));
    });

    test('toMap and fromMap roundtrip', () {
      final map = insumo.toMap();
      final restored = InsumoModel.fromMap(map);
      expect(restored.id, equals(insumo.id));
      expect(restored.nombre, equals(insumo.nombre));
      expect(restored.categoria, equals(insumo.categoria));
      expect(restored.stockTotal, equals(insumo.stockTotal));
    });
  });

  group('LoteModel', () {
    test('isVencido returns true for past date', () {
      final lote = LoteModel(
        id: 'lot-1',
        insumoId: 'ins-1',
        numeroLote: 'L001',
        fechaIngreso: DateTime.now().subtract(const Duration(days: 100)),
        fechaVencimiento:
            DateTime.now().subtract(const Duration(days: 1)),
        cantidad: 50,
        proveedor: 'Proveedor XYZ',
      );
      expect(lote.isVencido, isTrue);
      expect(lote.isProximoAVencer, isFalse);
    });

    test('isProximoAVencer returns true for expiry within 30 days', () {
      final lote = LoteModel(
        id: 'lot-2',
        insumoId: 'ins-1',
        numeroLote: 'L002',
        fechaIngreso: DateTime.now().subtract(const Duration(days: 10)),
        fechaVencimiento:
            DateTime.now().add(const Duration(days: 15)),
        cantidad: 30,
        proveedor: 'Proveedor ABC',
      );
      expect(lote.isVencido, isFalse);
      expect(lote.isProximoAVencer, isTrue);
    });

    test('diasParaVencer calculates correctly', () {
      final futureDate = DateTime.now().add(const Duration(days: 10));
      final lote = LoteModel(
        id: 'lot-3',
        insumoId: 'ins-1',
        numeroLote: 'L003',
        fechaIngreso: DateTime.now(),
        fechaVencimiento: futureDate,
        cantidad: 20,
        proveedor: 'Test',
      );
      expect(lote.diasParaVencer, greaterThanOrEqualTo(9));
      expect(lote.diasParaVencer, lessThanOrEqualTo(10));
    });
  });

  group('Helpers', () {
    test('isStockCritico returns true when stock equals minimum', () {
      expect(Helpers.isStockCritico(5, 5), isTrue);
    });

    test('isStockCritico returns true when stock below minimum', () {
      expect(Helpers.isStockCritico(3, 5), isTrue);
    });

    test('isStockCritico returns false when stock above minimum', () {
      expect(Helpers.isStockCritico(10, 5), isFalse);
    });

    test('isLoteVencido returns true for past date', () {
      final past = DateTime.now().subtract(const Duration(days: 1));
      expect(Helpers.isLoteVencido(past), isTrue);
    });

    test('isLoteVencido returns false for future date', () {
      final future = DateTime.now().add(const Duration(days: 1));
      expect(Helpers.isLoteVencido(future), isFalse);
    });
  });

  group('Enums', () {
    test('UserRole.fromString returns correct enum value', () {
      expect(UserRole.fromString('administrador'), equals(UserRole.administrador));
      expect(UserRole.fromString('laboratorista'), equals(UserRole.laboratorista));
      expect(UserRole.fromString('docente'), equals(UserRole.docente));
    });

    test('UserRole.fromString returns default for unknown value', () {
      expect(UserRole.fromString('unknown'), equals(UserRole.docente));
    });

    test('InsumoEstado.displayName returns correct string', () {
      expect(InsumoEstado.activo.displayName, equals('Activo'));
      expect(InsumoEstado.agotado.displayName, equals('Agotado'));
    });
  });
}
