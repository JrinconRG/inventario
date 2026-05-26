import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/constants.dart';
import '../models/usuario_model.dart';
import '../utils/enums.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UsuarioModel?> getCurrentUserModel() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return getUserProfile(user.uid);
  }

  Future<UsuarioModel?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.colUsers)
          .doc(uid)
          .get();
      if (!doc.exists || doc.data() == null) return null;
      return UsuarioModel.fromMap({'id': doc.id, ...doc.data()!});
    } catch (_) {
      return null;
    }
  }

  Future<UsuarioModel> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final profile = await getUserProfile(credential.user!.uid);
    if (profile == null) throw Exception('Perfil de usuario no encontrado.');
    return profile;
  }

  Future<UsuarioModel> register({
    required String email,
    required String password,
    required String nombre,
    required String apellido,
    UserRole rol = UserRole.docente,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final now = DateTime.now();
    final usuario = UsuarioModel(
      id: credential.user!.uid,
      email: email.trim(),
      nombre: nombre.trim(),
      apellido: apellido.trim(),
      rol: rol,
      createdAt: now,
    );
    await _firestore
        .collection(AppConstants.colUsers)
        .doc(usuario.id)
        .set(usuario.toMap());
    return usuario;
  }

  Future<void> logout() => _auth.signOut();

  Future<void> resetPassword(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());

  Future<void> updateUserRole(String uid, UserRole rol) async {
    await _firestore
        .collection(AppConstants.colUsers)
        .doc(uid)
        .update({'rol': rol.name});
  }
}
