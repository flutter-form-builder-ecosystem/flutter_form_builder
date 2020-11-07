import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderRating -- 3', (WidgetTester tester) async {
    const widgetName = 'r1';
    final testWidget = FormBuilderRating(
      name: widgetName,
    );
    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(1.0));
    await tester.tap(find.byWidget(testWidget));
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(3.0));
  });
}
