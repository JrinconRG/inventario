import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/enums.dart';
import '../../validators/login_validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _apellidoCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _showPassword = false;
  UserRole _rol = UserRole.docente;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<AuthProvider>().register(
          email: _emailCtrl.text,
          password: _passwordCtrl.text,
          nombre: _nombreCtrl.text,
          apellido: _apellidoCtrl.text,
          rol: _rol,
        );
    if (!mounted) return;
    final error = context.read<AuthProvider>().errorMessage;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'Crear cuenta',
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Completa tu información para registrarte',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6))),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomInput(
                              controller: _nombreCtrl,
                              label: 'Nombre',
                              prefixIcon: Icons.person_outline,
                              validator: LoginValidator.validateNombre,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomInput(
                              controller: _apellidoCtrl,
                              label: 'Apellido',
                              validator: LoginValidator.validateNombre,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        controller: _emailCtrl,
                        label: 'Correo electrónico',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        validator: LoginValidator.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      CustomDropdown<UserRole>(
                        value: _rol,
                        items: UserRole.values,
                        label: 'Rol',
                        itemLabel: (r) => r.displayName,
                        prefixIcon: Icons.badge_outlined,
                        onChanged: (v) => setState(() => _rol = v!),
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        controller: _passwordCtrl,
                        label: 'Contraseña',
                        prefixIcon: Icons.lock_outlined,
                        obscureText: !_showPassword,
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () =>
                              setState(() => _showPassword = !_showPassword),
                        ),
                        validator: LoginValidator.validatePasswordStrong,
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        controller: _confirmCtrl,
                        label: 'Confirmar contraseña',
                        prefixIcon: Icons.lock_outlined,
                        obscureText: !_showPassword,
                        validator: (v) => LoginValidator.validateConfirmPassword(
                            v, _passwordCtrl.text),
                      ),
                      const SizedBox(height: 28),
                      CustomButton(
                        label: 'Registrarse',
                        onPressed: _register,
                        isLoading: auth.isLoading,
                        icon: Icons.person_add,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('¿Ya tienes cuenta? Inicia sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
