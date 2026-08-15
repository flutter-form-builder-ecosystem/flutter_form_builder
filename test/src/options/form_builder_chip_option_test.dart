import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  group('FormBuilderChipOption -', () {
    testWidgets('renders the value as text when no child is provided', (
      WidgetTester tester,
    ) async {
      const option = FormBuilderChipOption<String>(value: 'dart');

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: option)));

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('dart'), findsOneWidget);
    });

    testWidgets('renders the child when provided', (WidgetTester tester) async {
      const option = FormBuilderChipOption<String>(
        value: 'dart',
        child: Text('Chip label'),
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: option)));

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Chip label'), findsOneWidget);
      expect(find.text('dart'), findsNothing);
    });

    testWidgets('exposes the avatar', (WidgetTester tester) async {
      const avatar = Icon(Icons.person);
      final option = FormBuilderChipOption<String>(
        value: 'dart',
        avatar: avatar,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: option)));

      final rendered = tester.widget<FormBuilderChipOption<String>>(
        find.byType(FormBuilderChipOption<String>),
      );
      expect(rendered.avatar, same(avatar));
    });
  });
}
