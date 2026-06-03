import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/sync_provider.dart';
import '../../services/sync_service.dart';
import '../../utils/helpers.dart';
import '../../config/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    // Cargar conteos iniciales
    Future.microtask(() {
      if (mounted) context.read<SyncProvider>().loadCounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final syncProvider = context.watch<SyncProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User info card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      auth.usuario?.nombre.substring(0, 1).toUpperCase() ?? '?',
                      style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.usuario?.nombreCompleto ?? '',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(auth.usuario?.email ?? '',
                            style: theme.textTheme.bodySmall),
                        const SizedBox(height: 4),
                        Chip(
                          label: Text(auth.usuario?.rol.displayName ?? ''),
                          padding: EdgeInsets.zero,
                          labelStyle: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          Text('Sincronización',
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: theme.colorScheme.primary)),
          const SizedBox(height: 8),

          // Estado de sincronización
          if (syncProvider.hasPendingOrFailed)
            Card(
              color: syncProvider.failedCount > 0
                  ? Colors.red.shade50
                  : Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      syncProvider.failedCount > 0
                          ? Icons.error_outline
                          : Icons.cloud_upload,
                      color: syncProvider.failedCount > 0
                          ? Colors.red
                          : Colors.orange,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (syncProvider.pendingCount > 0)
                            Text(
                              '${syncProvider.pendingCount} registro(s) pendiente(s)',
                              style: theme.textTheme.bodyMedium,
                            ),
                          if (syncProvider.failedCount > 0)
                            Text(
                              '${syncProvider.failedCount} registro(s) con error',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (syncProvider.lastError != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              syncProvider.lastError!,
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: Colors.red),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.sync),
                  title: const Text('Sincronizar ahora'),
                  subtitle: const Text('Sube los cambios locales a Firebase'),
                  trailing: syncProvider.isSyncing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.chevron_right),
                  onTap: syncProvider.isSyncing ? null : syncProvider.syncNow,
                ),
                if (syncProvider.failedCount > 0) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.refresh, color: Colors.orange),
                    title: const Text('Reintentar registros fallidos',
                        style: TextStyle(color: Colors.orange)),
                    subtitle:
                        Text('${syncProvider.failedCount} registros con error'),
                    trailing: syncProvider.isSyncing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.chevron_right),
                    onTap: syncProvider.isSyncing
                        ? null
                        : syncProvider.retrySyncFailed,
                  ),
                ],
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Versión de la aplicación'),
                  trailing: Text(AppConstants.appVersion,
                      style: theme.textTheme.bodySmall),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('Base de datos local'),
                  subtitle: Text('Drift SQLite v${AppConstants.dbVersion}'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Text('Cuenta',
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: theme.colorScheme.primary)),
          const SizedBox(height: 8),

          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Cerrar sesión',
                  style: TextStyle(color: Colors.red)),
              onTap: () async {
                final confirm = await Helpers.showConfirmDialog(
                  context,
                  title: 'Cerrar sesión',
                  content: '¿Deseas salir de tu cuenta?',
                  confirmText: 'Salir',
                  isDestructive: true,
                );
                if (confirm == true && mounted) {
                  await context.read<AuthProvider>().logout();
                }
              },
            ),
          ),

          const SizedBox(height: 40),
          Center(
            child: Text(
              '${AppConstants.appName} v${AppConstants.appVersion}\n'
              'Proyecto universitario · Gestión de inventario de laboratorio',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.4)),
            ),
          ),
        ],
      ),
    );
  }
}
