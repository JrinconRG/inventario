# Release Checklist — v1.0.0

## Pre-release

### Firebase
- [ ] Proyecto Firebase creado en console.firebase.google.com
- [ ] Authentication habilitado (Email/Password)
- [ ] Cloud Firestore creado en modo producción
- [ ] Reglas de Firestore (`firestore.rules`) desplegadas
- [ ] `flutterfire configure` ejecutado (genera `firebase_options.dart` real)
- [ ] Variables de Firebase verificadas en `firebase_options.dart`

### Código
- [ ] `flutter pub get` ejecutado sin errores
- [ ] `flutter pub run build_runner build --delete-conflicting-outputs` ejecutado
- [ ] Archivos `*.g.dart` generados para todas las tablas y DAOs
- [ ] `flutter analyze` sin errores críticos
- [ ] `flutter test` — todos los tests pasando

### Seguridad
- [ ] Firestore rules revisadas y desplegadas
- [ ] Ninguna clave API hardcodeada en el código fuente
- [ ] `.gitignore` incluye `google-services.json`, `GoogleService-Info.plist`

## Android
- [ ] `android/app/google-services.json` agregado
- [ ] `applicationId` configurado en `android/app/build.gradle`
- [ ] Permisos de Internet en `AndroidManifest.xml`
- [ ] `flutter build apk --release` exitoso
- [ ] APK probado en dispositivo físico

## Web
- [ ] `web/index.html` con script de Firebase (si aplica)
- [ ] `flutter build web` exitoso
- [ ] Probado en Chrome y Firefox

## Windows
- [ ] `flutter build windows` exitoso
- [ ] Probado en Windows 10/11

## Funcional
- [ ] Login con usuario administrador funciona
- [ ] Login con usuario docente funciona
- [ ] Crear insumo → aparece en inventario
- [ ] Agregar lote → stock se actualiza
- [ ] Registrar salida → FEFO aplicado correctamente
- [ ] Crear solicitud → aparece como pendiente
- [ ] Aprobar solicitud → stock descontado automáticamente
- [ ] Alertas generadas para stock bajo
- [ ] Alertas generadas para lote vencido
- [ ] Offline: crear insumo sin conexión → sube al reconectar
- [ ] Modo oscuro funciona correctamente
- [ ] Sidebar visible en pantallas anchas (>900px)

## Post-release
- [ ] Crear usuario administrador inicial en Firebase Console
- [ ] Cargar datos de ejemplo (insumos del laboratorio)
- [ ] Documentar URL de acceso web (si aplica)
- [ ] Compartir APK o link con equipo de sustentación
