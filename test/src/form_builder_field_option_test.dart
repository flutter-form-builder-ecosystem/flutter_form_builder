import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  group('FormBuilderFieldOption -', () {
    testWidgets('renders the value as text when no child is provided', (
      WidgetTester tester,
    ) async {
      const option = FormBuilderFieldOption<int>(value: 42);

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: option)));

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('renders the child when provided', (WidgetTester tester) async {
      const option = FormBuilderFieldOption<int>(
        value: 42,
        child: Text('Option label'),
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: option)));

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Option label'), findsOneWidget);
      expect(find.text('42'), findsNothing);
    });

    test('stores the option value', () {
      final option = FormBuilderFieldOption<String>(value: 'dart');

      expect(option.value, 'dart');
    });
  });
}
