import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_inventory/models/usuario_model.dart';
import 'package:lab_inventory/pages/solicitudes/create_solicitud_page.dart';
import 'package:lab_inventory/providers/auth_provider.dart' as app_auth;
import 'package:lab_inventory/services/auth_service.dart';
import 'package:lab_inventory/utils/enums.dart';
import 'package:provider/provider.dart';

class FakeAuthService implements AuthService {
  @override
  User? get currentUser => null;

  @override
  Stream<User?> get authStateChanges => const Stream.empty();

  @override
  Future<UsuarioModel?> getCurrentUserModel() async => null;

  @override
  Future<UsuarioModel?> getUserProfile(String uid) async => null;

  @override
  Future<UsuarioModel> login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<UsuarioModel> register({
    required String email,
    required String password,
    required String nombre,
    required String apellido,
    UserRole rol = UserRole.docente,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserRole(String uid, UserRole rol) {
    throw UnimplementedError();
  }
}

class FakeAuthProvider extends app_auth.AuthProvider {
  FakeAuthProvider() : super(FakeAuthService());

  @override
  bool get canCreateSolicitudes => false;

  @override
  bool get isDocente => false;

  @override
  UsuarioModel? get usuario => null;
}

void main() {
  testWidgets('CreateSolicitudPage muestra acceso restringido para no docentes',
      (WidgetTester tester) async {
    final authProvider = FakeAuthProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<app_auth.AuthProvider>.value(
        value: authProvider,
        child: const MaterialApp(
          home: CreateSolicitudPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Acceso restringido'), findsOneWidget);
    expect(find.text('Solo los docentes pueden crear solicitudes'),
        findsOneWidget);
    expect(find.byType(FilledButton), findsNothing);
  });
}
