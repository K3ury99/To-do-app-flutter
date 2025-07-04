import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AppInitializer());

    // Espera a que cargue el tema/idioma
    await tester.pumpAndSettle();

    expect(find.text('Lista de Tareas!'), findsOneWidget);
  });
}
