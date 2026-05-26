class AppConstants {
  AppConstants._();

  static const String appName = 'Lab Inventory';
  static const String appVersion = '1.0.0';

  // Firestore collections
  static const String colUsers = 'users';
  static const String colInventory = 'inventory';
  static const String colLots = 'lots';
  static const String colMovements = 'movements';
  static const String colRequests = 'requests';
  static const String colAlerts = 'alerts';

  // Local DB
  static const String dbName = 'lab_inventory.db';
  static const int dbVersion = 1;

  // Thresholds
  static const int diasAlertaVencimiento = 30;
  static const int stockMinimoDefault = 5;

  // Responsive breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Padding / spacing
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;

  // Sync interval in seconds
  static const int syncIntervalSeconds = 60;
}
