import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderSegmentedControl -- AM,PM',
      (WidgetTester tester) async {
    const widgetName = 'sc1';
    final testWidget = FormBuilderSegmentedControl<String>(
      name: widgetName,
      options: const [
        FormBuilderFieldOption(value: 'AM'),
        FormBuilderFieldOption(value: 'PM'),
      ],
    );
    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    expect(formSave(), isTrue);
    expect(formValue(widgetName), isNull);
    await tester.tap(find.text('AM'));
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals('AM'));
    await tester.tap(find.text('PM'));
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals('PM'));
  });
}
