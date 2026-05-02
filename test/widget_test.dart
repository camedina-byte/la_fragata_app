import 'package:flutter_test/flutter_test.dart';
import 'package:la_fragata_app/main.dart';

void main() {
  testWidgets('La Fragata App inicia correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(const LaFragataApp());
    expect(find.text('La Fragata App'), findsOneWidget);
  });
}