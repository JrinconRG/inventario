import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/helpers.dart';

class BlockedPage extends StatelessWidget {
  const BlockedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AuthProvider>().usuario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceso bloqueado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.block,
              size: 96,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 24),
            Text(
              'Tu cuenta está bloqueada.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'No puedes acceder al módulo principal hasta que un administrador desbloquee tu cuenta.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (usuario != null) ...[
              const SizedBox(height: 24),
              Text(
                'Usuario: ${usuario.nombreCompleto}',
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () async {
                await context.read<AuthProvider>().logout();
                if (context.mounted) {
                  Helpers.showSnackBar(
                    context,
                    'Sesión cerrada.',
                  );
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
