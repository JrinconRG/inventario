import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/inventory/inventory_page.dart';
import '../pages/inventory/add_insumo_page.dart';
import '../pages/inventory/lote_page.dart';
import '../pages/inventory/movimientos_page.dart';
import '../pages/solicitudes/solicitud_page.dart';
import '../pages/solicitudes/create_solicitud_page.dart';
import '../pages/solicitudes/solicitud_detail_page.dart';
import '../pages/alerts/alerts_page.dart';
import '../pages/settings/settings_page.dart';
import '../widgets/sidebar_menu.dart';

class AppRouter {
  static GoRouter createRouter(AuthProvider authProvider) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: authProvider,
      redirect: (context, state) {
        final isAuth = authProvider.isAuthenticated;
        final isUnknown = authProvider.status == AuthStatus.unknown;
        final isAuthRoute = state.matchedLocation == '/login' ||
            state.matchedLocation == '/register';

        if (isUnknown) return null;
        if (!isAuth && !isAuthRoute) return '/login';
        if (isAuth && isAuthRoute) return '/';
        return null;
      },
      routes: [
        // Auth routes (no shell)
        GoRoute(
          path: '/login',
          builder: (_, __) => const LoginPage(),
        ),
        GoRoute(
          path: '/register',
          builder: (_, __) => const RegisterPage(),
        ),

        // App shell with sidebar
        ShellRoute(
          builder: (context, state, child) => AppShell(
            currentRoute: state.matchedLocation,
            child: child,
          ),
          routes: [
            GoRoute(
              path: '/',
              builder: (_, __) => const DashboardPage(),
            ),
            GoRoute(
              path: '/inventory',
              builder: (_, __) => const InventoryPage(),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (_, __) => const AddInsumoPage(),
                ),
                GoRoute(
                  path: 'edit/:id',
                  builder: (_, state) =>
                      AddInsumoPage(insumoId: state.pathParameters['id']),
                ),
                GoRoute(
                  path: ':id/lotes',
                  builder: (_, state) =>
                      LotePage(insumoId: state.pathParameters['id']!),
                ),
                GoRoute(
                  path: ':id/movimientos',
                  builder: (_, state) =>
                      MovimientosPage(insumoId: state.pathParameters['id']!),
                ),
              ],
            ),
            GoRoute(
              path: '/solicitudes',
              builder: (_, __) => const SolicitudPage(),
              routes: [
                GoRoute(
                  path: 'create',
                  builder: (_, __) => const CreateSolicitudPage(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (_, state) => SolicitudDetailPage(
                      solicitudId: state.pathParameters['id']!),
                ),
              ],
            ),
            GoRoute(
              path: '/alerts',
              builder: (_, __) => const AlertsPage(),
            ),
            GoRoute(
              path: '/settings',
              builder: (_, __) => const SettingsPage(),
            ),
          ],
        ),
      ],
    );
  }
}
