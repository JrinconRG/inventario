import 'dart:async';
import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../services/auth_service.dart';
import '../utils/enums.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  StreamSubscription? _authSub;

  AuthStatus _status = AuthStatus.unknown;
  UsuarioModel? _usuario;
  String? _errorMessage;
  bool _isLoading = false;

  AuthProvider(this._authService) {
    _listenToAuthChanges();
  }

  AuthStatus get status => _status;
  UsuarioModel? get usuario => _usuario;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  UserRole get userRole => _usuario?.rol ?? UserRole.docente;
  bool get isAdmin => userRole == UserRole.administrador;
  bool get canManage =>
      userRole == UserRole.administrador ||
      userRole == UserRole.laboratorista;

  void _listenToAuthChanges() {
    _authSub = _authService.authStateChanges.listen((firebaseUser) async {
      if (firebaseUser == null) {
        _status = AuthStatus.unauthenticated;
        _usuario = null;
      } else {
        final profile = await _authService.getUserProfile(firebaseUser.uid);
        if (profile != null) {
          _usuario = profile;
          _status = AuthStatus.authenticated;
        } else {
          _status = AuthStatus.unauthenticated;
        }
      }
      notifyListeners();
    });
  }

  Future<void> login(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _usuario = await _authService.login(email, password);
      _status = AuthStatus.authenticated;
    } catch (e) {
      _errorMessage = _parseFirebaseError(e.toString());
      _status = AuthStatus.unauthenticated;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String nombre,
    required String apellido,
    UserRole rol = UserRole.docente,
  }) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _usuario = await _authService.register(
        email: email,
        password: password,
        nombre: nombre,
        apellido: apellido,
        rol: rol,
      );
      _status = AuthStatus.authenticated;
    } catch (e) {
      _errorMessage = _parseFirebaseError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _usuario = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _authService.resetPassword(email);
      return true;
    } catch (e) {
      _errorMessage = _parseFirebaseError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _parseFirebaseError(String error) {
    if (error.contains('user-not-found') ||
        error.contains('wrong-password') ||
        error.contains('invalid-credential')) {
      return 'Correo o contraseña incorrectos.';
    }
    if (error.contains('email-already-in-use')) {
      return 'Este correo ya está registrado.';
    }
    if (error.contains('network-request-failed')) {
      return 'Sin conexión a internet.';
    }
    if (error.contains('too-many-requests')) {
      return 'Demasiados intentos. Intenta más tarde.';
    }
    return 'Error inesperado. Intenta de nuevo.';
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}
