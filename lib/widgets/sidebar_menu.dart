import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../providers/auth_provider.dart';
import '../utils/enums.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final String currentRoute;

  const AppShell({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= AppConstants.tabletBreakpoint;

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            _SideBar(currentRoute: currentRoute),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      drawer: Drawer(
        child: _SideBar(currentRoute: currentRoute),
      ),
      body: child,
    );
  }
}

class _SideBar extends StatelessWidget {
  final String currentRoute;

  const _SideBar({required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final theme = Theme.of(context);

    final navItems = _buildNavItems(auth.userRole);

    return SizedBox(
      width: 240,
      child: NavigationDrawer(
        selectedIndex: _selectedIndex(navItems),
        onDestinationSelected: (i) {
          context.go(navItems[i].route);
          if (MediaQuery.of(context).size.width < AppConstants.tabletBreakpoint) {
            Navigator.pop(context);
          }
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.science,
                          color: theme.colorScheme.onPrimaryContainer),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppConstants.appName,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  auth.usuario?.nombreCompleto ?? '',
                  style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  auth.usuario?.rol.displayName ?? '',
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
          const Divider(indent: 16, endIndent: 16),
          ...navItems.map((item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.icon, color: theme.colorScheme.primary),
                label: Text(item.label),
              )),
          const Divider(indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Cerrar sesión',
                  style: TextStyle(color: Colors.red)),
              onTap: () => context.read<AuthProvider>().logout(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  List<_NavItem> _buildNavItems(UserRole role) {
    final items = [
      _NavItem('Dashboard', Icons.dashboard, '/'),
      _NavItem('Inventario', Icons.inventory_2, '/inventory'),
      _NavItem('Solicitudes', Icons.assignment, '/solicitudes'),
      _NavItem('Alertas', Icons.notifications, '/alerts'),
      _NavItem('Configuración', Icons.settings, '/settings'),
    ];
    return items;
  }

  int _selectedIndex(List<_NavItem> items) {
    for (int i = 0; i < items.length; i++) {
      if (currentRoute.startsWith(items[i].route) &&
          (items[i].route == '/' ? currentRoute == '/' : true)) {
        return i;
      }
    }
    return 0;
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final String route;

  _NavItem(this.label, this.icon, this.route);
}
