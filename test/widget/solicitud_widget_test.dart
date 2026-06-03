import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_inventory/models/solicitud_model.dart';
import 'package:lab_inventory/utils/enums.dart';
import 'package:lab_inventory/widgets/loading_widget.dart';
import 'package:lab_inventory/widgets/solicitud_card.dart';
import 'package:lab_inventory/widgets/sync_status_badge.dart';

void main() {
  testWidgets('SyncStatusBadge muestra etiqueta Pendiente',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SyncStatusBadge(syncStatus: 'pending'),
        ),
      ),
    );

    expect(find.text('Pendiente'), findsOneWidget);
    expect(find.byType(Chip), findsOneWidget);
  });

  testWidgets('SolicitudCard muestra acciones y estado pendiente',
      (WidgetTester tester) async {
    final solicitud = SolicitudModel(
      id: 'sol-3',
      insumoId: 'ins-3',
      insumoNombre: 'Formalina',
      cantidadSolicitada: 3,
      solicitanteId: 'user-3',
      solicitanteNombre: 'María Gómez',
      estado: SolicitudEstado.pendiente,
      motivo: 'Reactivos para práctica de microbiología',
      fechaSolicitud: DateTime(2025, 5, 20),
      syncStatus: 'pending',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SolicitudCard(
            solicitud: solicitud,
            showActions: true,
            onAprobar: () {},
            onRechazar: () {},
          ),
        ),
      ),
    );

    expect(find.text('Aprobar'), findsOneWidget);
    expect(find.text('Rechazar'), findsOneWidget);
    expect(find.byIcon(Icons.cloud_upload), findsOneWidget);
    expect(find.text('Pendiente'), findsOneWidget);
  });

  testWidgets('EmptyStateWidget muestra título, subtítulo y acción',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmptyStateWidget(
            icon: Icons.assignment_outlined,
            title: 'Sin solicitudes',
            subtitle: 'No hay solicitudes registradas',
            action: FilledButton(
              onPressed: () {},
              child: const Text('Nueva solicitud'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Sin solicitudes'), findsOneWidget);
    expect(find.text('No hay solicitudes registradas'), findsOneWidget);
    expect(find.text('Nueva solicitud'), findsOneWidget);
    expect(find.byIcon(Icons.assignment_outlined), findsOneWidget);
  });
}
