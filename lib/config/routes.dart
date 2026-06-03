import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../utils/enums.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/auth/pending_approval_page.dart';
import '../pages/auth/blocked_page.dart';
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
        final isPendingApproval = authProvider.isAccountPendingApproval;
        final isBlocked = authProvider.isAccountBlocked;
        final isStatusRoute = state.matchedLocation == '/pending-approval' ||
            state.matchedLocation == '/blocked';

        if (isUnknown) return null;
        if (!isAuth && !isAuthRoute) return '/login';
        if (isAuth) {
          if (isPendingApproval &&
              state.matchedLocation != '/pending-approval') {
            return '/pending-approval';
          }
          if (isBlocked && state.matchedLocation != '/blocked') {
            return '/blocked';
          }
          if (!isPendingApproval && !isBlocked && isAuthRoute) return '/';
          if (isStatusRoute && authProvider.isAccountActive) return '/';
          if (state.matchedLocation == '/solicitudes/create' &&
              authProvider.userRole != UserRole.docente) {
            return '/solicitudes';
          }
        }
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
        GoRoute(
          path: '/pending-approval',
          builder: (_, __) => const PendingApprovalPage(),
        ),

        GoRoute(
          path: '/blocked',
          builder: (_, __) => const BlockedPage(),
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
