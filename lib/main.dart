import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'data/app_database.dart';
import 'providers/auth_provider.dart';
import 'providers/inventory_provider.dart';
import 'providers/solicitud_provider.dart';
import 'services/auth_service.dart';
import 'services/firebase_service.dart';
import 'services/inventory_service.dart';
import 'services/solicitud_service.dart';
import 'services/alert_service.dart';
import 'services/sync_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final db = AppDatabase();

  runApp(LabInventoryApp(db: db));
}

class LabInventoryApp extends StatefulWidget {
  final AppDatabase db;

  const LabInventoryApp({super.key, required this.db});

  @override
  State<LabInventoryApp> createState() => _LabInventoryAppState();
}

class _LabInventoryAppState extends State<LabInventoryApp> {
  late final SyncService _syncService;

  @override
  void initState() {
    super.initState();
    _syncService = SyncService(widget.db, FirebaseService());
    _syncService.startListening();
  }

  @override
  void dispose() {
    _syncService.stopListening();
    widget.db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Core services
        Provider<AppDatabase>(create: (_) => widget.db),
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirebaseService>(create: (_) => FirebaseService()),
        Provider<SyncService>(create: (_) => _syncService),

        // Business services
        ProxyProvider2<AppDatabase, FirebaseService, InventoryService>(
          update: (_, db, firebase, __) => InventoryService(db, firebase),
        ),
        ProxyProvider2<AppDatabase, FirebaseService, SolicitudService>(
          update: (_, db, firebase, __) => SolicitudService(db, firebase),
        ),
        ProxyProvider<AppDatabase, AlertService>(
          update: (_, db, __) => AlertService(db),
        ),

        // State providers
        ChangeNotifierProxyProvider<AuthService, AuthProvider>(
          create: (ctx) => AuthProvider(ctx.read<AuthService>()),
          update: (_, svc, prev) => prev ?? AuthProvider(svc),
        ),
        ChangeNotifierProxyProvider<InventoryService, InventoryProvider>(
          create: (ctx) => InventoryProvider(ctx.read<InventoryService>()),
          update: (_, svc, prev) => prev ?? InventoryProvider(svc),
        ),
        ChangeNotifierProxyProvider<SolicitudService, SolicitudProvider>(
          create: (ctx) => SolicitudProvider(ctx.read<SolicitudService>()),
          update: (_, svc, prev) => prev ?? SolicitudProvider(svc),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          final router = AppRouter.createRouter(authProvider);
          return MaterialApp.router(
            title: 'Lab Inventory',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
