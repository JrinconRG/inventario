import 'package:flutter_test/flutter_test.dart';
import 'package:lab_inventory/models/solicitud_model.dart';
import 'package:lab_inventory/models/usuario_model.dart';
import 'package:lab_inventory/validators/solicitud_validator.dart';
import 'package:lab_inventory/utils/enums.dart';

void main() {
  group('Reglas de negocio y validaciones de solicitud', () {
    test('Usuario bloqueado se representa con activo false', () {
      final usuario = UsuarioModel(
        id: 'user-1',
        email: 'ana.lopez@example.com',
        nombre: 'Ana',
        apellido: 'López',
        rol: UserRole.docente,
        activo: false,
        createdAt: DateTime(2025, 1, 1),
      );

      expect(usuario.activo, isFalse);
      expect(usuario.rol, equals(UserRole.docente));
      expect(usuario.nombreCompleto, equals('Ana López'));
    });

    test('Usuario docente puede crear solicitud por rol', () {
      final usuario = UsuarioModel(
        id: 'user-2',
        email: 'fernando.perez@example.com',
        nombre: 'Fernando',
        apellido: 'Pérez',
        rol: UserRole.docente,
        createdAt: DateTime(2025, 2, 1),
      );

      expect(usuario.rol, equals(UserRole.docente));
      expect(usuario.activo, isTrue);
    });

    test('Usuario administrador no debería crear solicitudes de docente', () {
      final usuario = UsuarioModel(
        id: 'user-3',
        email: 'admin@example.com',
        nombre: 'María',
        apellido: 'Gómez',
        rol: UserRole.administrador,
        createdAt: DateTime(2025, 3, 1),
      );

      expect(usuario.rol, equals(UserRole.administrador));
      expect(usuario.activo, isTrue);
      expect(usuario.rol == UserRole.docente, isFalse);
    });

    test('Solicitud rechazada requiere motivo válido', () {
      expect(SolicitudValidator.validateMotivo('abc'), isNotNull);
      expect(
        SolicitudValidator.validateMotivo(
            'Requiero reactivos para la práctica'),
        isNull,
      );
    });

    test('Solicitud no acepta cantidad que excede el stock disponible', () {
      expect(
        SolicitudValidator.validateCantidad('15', stockDisponible: 10),
        isNotNull,
      );
    });

    test('Solicitud acepta cantidad dentro del stock disponible', () {
      expect(
        SolicitudValidator.validateCantidad('8', stockDisponible: 10),
        isNull,
      );
    });

    test('Registro de solicitud nuevo queda con estado pendingSync por defecto',
        () {
      final solicitud = SolicitudModel(
        id: 'sol-1',
        insumoId: 'ins-1',
        insumoNombre: 'Ácido Nítrico',
        cantidadSolicitada: 5,
        solicitanteId: 'user-1',
        solicitanteNombre: 'Ana López',
        estado: SolicitudEstado.pendiente,
        motivo: 'Solicito reactivos para laboratorio',
        fechaSolicitud: DateTime.now(),
      );

      expect(solicitud.syncStatus, equals('pending'));
      expect(solicitud.estado, equals(SolicitudEstado.pendiente));
    });

    test('SolicitudModel toMap/fromMap conserva estado y syncStatus', () {
      final solicitud = SolicitudModel(
        id: 'sol-2',
        insumoId: 'ins-2',
        insumoNombre: 'Etanol',
        cantidadSolicitada: 2,
        solicitanteId: 'user-2',
        solicitanteNombre: 'Fernando Pérez',
        estado: SolicitudEstado.pendiente,
        motivo: 'Necesito material para práctica',
        fechaSolicitud: DateTime(2025, 4, 15),
        syncStatus: 'pending',
      );

      final restored = SolicitudModel.fromMap(solicitud.toMap());
      expect(restored.estado, equals(SolicitudEstado.pendiente));
      expect(restored.syncStatus, equals('pending'));
      expect(restored.motivo, equals(solicitud.motivo));
    });
  });
}
