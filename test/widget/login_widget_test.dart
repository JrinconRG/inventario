import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_inventory/validators/login_validator.dart';
import 'package:lab_inventory/validators/stock_validator.dart';
import 'package:lab_inventory/validators/lote_validator.dart';
import 'package:lab_inventory/validators/solicitud_validator.dart';

void main() {
  group('LoginValidator', () {
    test('validates empty email', () {
      expect(LoginValidator.validateEmail(''), isNotNull);
    });

    test('validates invalid email format', () {
      expect(LoginValidator.validateEmail('not-an-email'), isNotNull);
    });

    test('accepts valid email', () {
      expect(LoginValidator.validateEmail('user@example.com'), isNull);
    });

    test('validates short password', () {
      expect(LoginValidator.validatePassword('123'), isNotNull);
    });

    test('accepts valid password', () {
      expect(LoginValidator.validatePassword('password123'), isNull);
    });

    test('validates password confirmation mismatch', () {
      expect(
        LoginValidator.validateConfirmPassword('abc', 'xyz'),
        isNotNull,
      );
    });

    test('accepts matching passwords', () {
      expect(
        LoginValidator.validateConfirmPassword('pass123', 'pass123'),
        isNull,
      );
    });
  });

  group('StockValidator', () {
    test('rejects empty nombre', () {
      expect(StockValidator.validateNombre(''), isNotNull);
    });

    test('accepts valid nombre', () {
      expect(StockValidator.validateNombre('Ácido Clorhídrico'), isNull);
    });

    test('rejects negative stock', () {
      expect(StockValidator.validateStockTotal('-5'), isNotNull);
    });

    test('accepts zero stock', () {
      expect(StockValidator.validateStockTotal('0'), isNull);
    });

    test('validates movement quantity exceeds stock', () {
      expect(
        StockValidator.validateCantidadMovimiento('100',
            stockDisponible: 50),
        isNotNull,
      );
    });

    test('accepts movement quantity within stock', () {
      expect(
        StockValidator.validateCantidadMovimiento('30',
            stockDisponible: 50),
        isNull,
      );
    });
  });

  group('LoteValidator', () {
    test('rejects empty numero lote', () {
      expect(LoteValidator.validateNumeroLote(''), isNotNull);
    });

    test('accepts valid numero lote', () {
      expect(LoteValidator.validateNumeroLote('L-2024-001'), isNull);
    });

    test('rejects zero quantity', () {
      expect(LoteValidator.validateCantidad('0'), isNotNull);
    });

    test('rejects future fecha ingreso', () {
      final future = DateTime.now().add(const Duration(days: 5));
      expect(LoteValidator.validateFechaIngreso(future), isNotNull);
    });

    test('accepts past fecha ingreso', () {
      final past = DateTime.now().subtract(const Duration(days: 5));
      expect(LoteValidator.validateFechaIngreso(past), isNull);
    });

    test('rejects vencimiento before ingreso', () {
      final ingreso = DateTime(2024, 6, 1);
      final vencimiento = DateTime(2024, 5, 1);
      expect(LoteValidator.validateFechas(ingreso, vencimiento), isNotNull);
    });
  });

  group('SolicitudValidator', () {
    test('rejects short motivo', () {
      expect(SolicitudValidator.validateMotivo('abc'), isNotNull);
    });

    test('accepts valid motivo', () {
      expect(
        SolicitudValidator.validateMotivo(
            'Necesito reactivos para la práctica de química orgánica'),
        isNull,
      );
    });

    test('rejects quantity exceeding stock', () {
      expect(
        SolicitudValidator.validateCantidad('200', stockDisponible: 100),
        isNotNull,
      );
    });
  });

  // Widget test placeholder
  group('Widget tests', () {
    testWidgets('CustomButton renders label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FilledButton(
              onPressed: () {},
              child: const Text('Iniciar sesión'),
            ),
          ),
        ),
      );
      expect(find.text('Iniciar sesión'), findsOneWidget);
    });
  });
}
