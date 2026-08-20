import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../form_builder_tester.dart';

void main() {
  group('FormBuilderField -', () {
    group('custom error -', () {
      testWidgets('Should show custom error when invalidate field', (
        tester,
      ) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const textFieldName = 'text2';
        const errorTextField = 'error text field';
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        // Set custom error
        textFieldKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();
        expect(find.text(errorTextField), findsOneWidget);
      });
      testWidgets(
        'Should persist custom error when autovalidateMode is onUserInteraction',
        (tester) async {
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          const textFieldName = 'text';
          const errorTextField = 'custom error';
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            key: textFieldKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));

          // Set custom error
          textFieldKey.currentState?.invalidate(errorTextField);
          await tester.pumpAndSettle();
          expect(find.text(errorTextField), findsOneWidget);

          // Simulate framework call (e.g. build again)
          tester.binding.scheduleFrame();
          await tester.pumpAndSettle();

          // Should still be there
          expect(find.text(errorTextField), findsOneWidget);

          // Should clear when value changes
          await tester.enterText(find.byType(TextField), 'test');
          await tester.pumpAndSettle();
          expect(find.text(errorTextField), findsNothing);
        },
      );
    });

    group('transformedValue -', () {
      testWidgets('Should return raw value when valueTransformer is null', (
        tester,
      ) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const textFieldName = 'text';
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final widgetFinder = find.byWidget(testWidget);
        await tester.enterText(widgetFinder, '123');
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.transformedValue, '123');
      });

      testWidgets(
        'Should return transformed value when valueTransformer is provided',
        (tester) async {
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          const textFieldName = 'text';
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            key: textFieldKey,
            valueTransformer: (text) => int.tryParse(text ?? ''),
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));

          final widgetFinder = find.byWidget(testWidget);
          await tester.enterText(widgetFinder, '123');
          await tester.pumpAndSettle();

          expect(textFieldKey.currentState?.transformedValue, 123);
        },
      );
    });

    group('isValid -', () {
      testWidgets('Should invalid when set custom error', (tester) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const textFieldName = 'text';
        const errorTextField = 'error text field';
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        // Set custom error
        textFieldKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.isValid, isFalse);
      });
      testWidgets(
        'Should valid when no has error and autovalidateMode is always',
        (tester) async {
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          const textFieldName = 'text';
          const errorTextField = 'error text field';
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            key: textFieldKey,
            autovalidateMode: AutovalidateMode.always,
            validator: (value) =>
                value == null || value.isEmpty ? errorTextField : null,
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));

          expect(textFieldKey.currentState?.isValid, isFalse);

          final widgetFinder = find.byWidget(testWidget);
          await tester.enterText(widgetFinder, 'test');
          await tester.pumpAndSettle();

          expect(textFieldKey.currentState?.isValid, isTrue);
        },
      );
      testWidgets(
        'Should invalid when has error and autovalidateMode is always',
        (tester) async {
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          const textFieldName = 'text';
          const errorTextField = 'error text field';
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            key: textFieldKey,
            autovalidateMode: AutovalidateMode.always,
            validator: (value) =>
                value == null || value.length < 10 ? errorTextField : null,
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));

          expect(textFieldKey.currentState?.isValid, isFalse);

          final widgetFinder = find.byWidget(testWidget);
          await tester.enterText(widgetFinder, 'test');
          await tester.pumpAndSettle();

          expect(textFieldKey.currentState?.isValid, isFalse);
        },
      );
    });

    group('hasErrors -', () {
      testWidgets('Should has errors when set custom error', (tester) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const textFieldName = 'text';
        const errorTextField = 'error text field';
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        // Set custom error
        textFieldKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.hasError, isTrue);
      });
      testWidgets('Should no has errors when is empty and no has validators', (
        tester,
      ) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const textFieldName = 'text';
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        // Set custom error
        textFieldKey.currentState?.validate();
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.hasError, isFalse);
      });
    });

    group('valueIsValid -', () {
      testWidgets(
        'Should value is valid when validator passes, despite set custom error',
        (tester) async {
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          const textFieldName = 'text';
          const errorTextField = 'error text field';
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            key: textFieldKey,
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));

          // Set custom error
          textFieldKey.currentState?.invalidate(errorTextField);
          await tester.pumpAndSettle();

          expect(textFieldKey.currentState?.valueIsValid, isTrue);
        },
      );
    });

    group('valueHasError -', () {
      testWidgets('Should value is invalid when validator passes', (
        tester,
      ) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const textFieldName = 'text';
        const invalidValue = 'invalid';
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: invalidValue,
          validator: (value) => (value == invalidValue) ? 'error' : null,
          autovalidateMode: AutovalidateMode.always,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(textFieldKey.currentState?.valueHasError, isTrue);
      });
    });
    group('autovalidateMode -', () {
      testWidgets(
        'Should show error when init form and AutovalidateMode is always',
        (tester) async {
          const textFieldName = 'text4';
          const errorTextField = 'error text field';
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            validator: (value) =>
                value == null || value.isEmpty ? errorTextField : null,
            autovalidateMode: AutovalidateMode.always,
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));
          await tester.pumpAndSettle();

          expect(find.text(errorTextField), findsOneWidget);
        },
      );
      testWidgets(
        'Should not show error when init form and AutovalidateMode is disabled',
        (tester) async {
          const textFieldName = 'text4';
          const errorTextField = 'error text field';
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            autovalidateMode: AutovalidateMode.disabled,
            validator: (value) => errorTextField,
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));
          await tester.pumpAndSettle();

          expect(find.text(errorTextField), findsNothing);
        },
      );
      testWidgets(
        'Should show error when AutovalidateMode is onUserInteraction and change field',
        (tester) async {
          const textFieldName = 'text4';
          const errorTextField = 'error text field';
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => errorTextField,
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));
          expect(find.text(errorTextField), findsNothing);

          await tester.enterText(find.byWidget(testWidget), 'hola');
          await tester.pumpAndSettle();

          expect(find.text(errorTextField), findsOneWidget);
        },
      );
      testWidgets(
        'Should show error when init form and AutovalidateMode is onUnfocus',
        (tester) async {
          const textFieldName = 'text4';
          const errorTextField = 'error text field';
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (value) => errorTextField,
          );
          final widgetFinder = find.byWidget(testWidget);

          // Init form
          await tester.pumpWidget(
            buildTestableFieldWidget(
              Column(
                children: [
                  testWidget,
                  ElevatedButton(onPressed: () {}, child: const Text('Submit')),
                ],
              ),
              autovalidateMode: AutovalidateMode.onUnfocus,
            ),
          );
          await tester.pumpAndSettle();
          final focusNode =
              formKey.currentState?.fields[textFieldName]?.effectiveFocusNode;
          expect(find.text(errorTextField), findsNothing);
          expect(Focus.of(tester.element(widgetFinder)).hasFocus, false);
          expect(focusNode?.hasFocus, false);

          // Focus input and write text
          await tester.enterText(widgetFinder, 'test');
          await tester.pumpAndSettle();
          expect(Focus.of(tester.element(widgetFinder)).hasFocus, true);
          expect(focusNode?.hasFocus, true);
          expect(find.text(errorTextField), findsNothing);

          // Unfocus input and show error
          await tester.sendKeyEvent(LogicalKeyboardKey.tab);
          await tester.pumpAndSettle();
          expect(find.text(errorTextField), findsOneWidget);
        },
      );
    });
    group('isDirty - ', () {
      testWidgets('Should not dirty by default', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(textFieldKey.currentState?.isDirty, false);
      });
      testWidgets('Should dirty when update field value by user', (
        tester,
      ) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final widgetFinder = find.byWidget(testWidget);
        await tester.enterText(widgetFinder, 'test');

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets('Should dirty when update field value by method', (
        tester,
      ) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets('Should dirty when update field with initial value by user', (
        tester,
      ) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: 'hi',
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final widgetFinder = find.byWidget(testWidget);
        await tester.enterText(widgetFinder, 'test');

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets(
        'Should dirty when update field with initial value by method',
        (tester) async {
          const textFieldName = 'text';
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            key: textFieldKey,
            initialValue: 'hi',
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));

          textFieldKey.currentState?.setValue('test');
          await tester.pumpAndSettle();

          expect(textFieldKey.currentState?.isDirty, true);
        },
      );
      testWidgets('Should not dirty when value returns to initial by user', (
        tester,
      ) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: 'hi',
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final widgetFinder = find.byWidget(testWidget);
        await tester.enterText(widgetFinder, 'test');
        await tester.pumpAndSettle();
        expect(textFieldKey.currentState?.isDirty, true);

        await tester.enterText(widgetFinder, 'hi');
        await tester.pumpAndSettle();
        expect(textFieldKey.currentState?.isDirty, false);
      });
      testWidgets('Should not dirty when reset field value', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();
        textFieldKey.currentState?.reset();

        expect(textFieldKey.currentState?.isDirty, false);
      });
      testWidgets('Should not dirty when reset field with initial value', (
        tester,
      ) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: 'hi',
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();
        textFieldKey.currentState?.reset();

        expect(textFieldKey.currentState?.isDirty, false);
      });
    });
    group('isTouched - ', () {
      testWidgets('Should not touched by default', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(textFieldKey.currentState?.isTouched, false);
      });
      testWidgets('Should touched when focus input', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final widgetFinder = find.byWidget(testWidget);
        await tester.tap(widgetFinder);

        expect(textFieldKey.currentState?.isTouched, true);
      });
    });
    group('reset -', () {
      testWidgets(
        'Should avoid reset recursion when value returns to initial in onChanged',
        (tester) async {
          const textFieldName = 'text';
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          var onChangedCalls = 0;
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            key: textFieldKey,
            initialValue: 'hi',
            onChanged: (value) {
              onChangedCalls++;
              final state = textFieldKey.currentState;
              if (value == state?.initialValue && state?.isDirty == true) {
                state?.reset();
              }
            },
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));

          final widgetFinder = find.byWidget(testWidget);
          await tester.enterText(widgetFinder, 'test');
          await tester.pumpAndSettle();
          await tester.enterText(widgetFinder, 'hi');
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          expect(textFieldKey.currentState?.isDirty, false);
          expect(onChangedCalls, equals(2));
        },
      );
      testWidgets('Should reset to null when call reset', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();
        textFieldKey.currentState?.reset();

        expect(textFieldKey.currentState?.value, null);
      });
      testWidgets('Should reset to initial when call reset', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const initialValue = 'test';
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: initialValue,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('hello');
        await tester.pumpAndSettle();
        textFieldKey.currentState?.reset();

        expect(textFieldKey.currentState?.value, equals(initialValue));
      });
      testWidgets(
        'Should reset custom error when invalidate field and then reset',
        (tester) async {
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          const textFieldName = 'text';
          const errorTextField = 'error text field';
          final testWidget = FormBuilderTextField(
            name: textFieldName,
            key: textFieldKey,
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));

          textFieldKey.currentState?.invalidate(errorTextField);
          await tester.pumpAndSettle();

          // Reset custom error
          textFieldKey.currentState?.reset();
          await tester.pumpAndSettle();
          expect(find.text(errorTextField), findsNothing);
        },
      );
    });
    group('focus -', () {
      testWidgets('Should focus on field when invalidate it', (tester) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const widgetName = 'text';
        const errorTextField = 'error text field';
        final testWidget = FormBuilderTextField(
          name: widgetName,
          key: textFieldKey,
        );
        final widgetFinder = find.byWidget(testWidget);

        await tester.pumpWidget(buildTestableFieldWidget(testWidget));
        final focusNode =
            formKey.currentState?.fields[widgetName]?.effectiveFocusNode;

        expect(Focus.of(tester.element(widgetFinder)).hasFocus, false);
        expect(focusNode?.hasFocus, false);

        textFieldKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();

        expect(Focus.of(tester.element(widgetFinder)).hasFocus, true);
        expect(focusNode?.hasFocus, true);
      });
      testWidgets(
        'Should not focus on field when invalidate field and is disabled',
        (tester) async {
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          const widgetName = 'text';
          const errorTextField = 'error text field';
          final testWidget = FormBuilderTextField(
            name: widgetName,
            key: textFieldKey,
            enabled: false,
          );
          final widgetFinder = find.byWidget(testWidget);

          await tester.pumpWidget(buildTestableFieldWidget(testWidget));
          final focusNode =
              formKey.currentState?.fields[widgetName]?.effectiveFocusNode;

          expect(Focus.of(tester.element(widgetFinder)).hasFocus, false);
          expect(focusNode?.hasFocus, false);

          textFieldKey.currentState?.invalidate(errorTextField);
          await tester.pumpAndSettle();

          expect(Focus.of(tester.element(widgetFinder)).hasFocus, false);
          expect(focusNode?.hasFocus, false);
        },
      );
    });
    group('forceErrorText -', () {
      testWidgets('Should show error when forceErrorText is set', (
        tester,
      ) async {
        const errorText = 'Force error message';
        final testWidget = FormBuilderTextField(
          name: 'text',
          forceErrorText: errorText,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));
        await tester.pumpAndSettle();

        expect(find.text(errorText), findsOneWidget);
      });

      testWidgets(
        'Should override validator error when forceErrorText is set',
        (tester) async {
          const forceError = 'Force error';
          const validatorError = 'Validator error';
          final testWidget = FormBuilderTextField(
            name: 'text',
            forceErrorText: forceError,
            validator: (value) => validatorError,
            autovalidateMode: AutovalidateMode.always,
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));
          await tester.pumpAndSettle();

          expect(find.text(forceError), findsOneWidget);
          expect(find.text(validatorError), findsNothing);
        },
      );
    });
    group('asyncValidator -', () {
      group('autovalidateMode -', () {
        testWidgets('runs on initial build when field mode is always', (
          tester,
        ) async {
          var calls = 0;
          final testWidget = FormBuilderTextField(
            name: 'text',
            autovalidateMode: AutovalidateMode.always,
            asyncValidator: (value) async {
              calls++;
              return 'Async Error';
            },
          );

          await tester.pumpWidget(buildTestableFieldWidget(testWidget));
          await tester.pumpAndSettle();

          expect(calls, 1);
          expect(find.text('Async Error'), findsOneWidget);
        });

        testWidgets(
          'runs after a change when field mode is onUserInteraction',
          (tester) async {
            var calls = 0;
            final testWidget = FormBuilderTextField(
              name: 'text',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              asyncValidator: (value) async {
                calls++;
                return null;
              },
            );

            await tester.pumpWidget(buildTestableFieldWidget(testWidget));
            await tester.pumpAndSettle();
            expect(calls, 0);

            await tester.enterText(find.byType(TextField), 'changed');
            await tester.pumpAndSettle();

            expect(calls, 1);
          },
        );

        testWidgets('does not run automatically when mode is disabled', (
          tester,
        ) async {
          var calls = 0;
          final fieldKey = GlobalKey<FormBuilderFieldState>();
          final testWidget = FormBuilderTextField(
            key: fieldKey,
            name: 'text',
            autovalidateMode: AutovalidateMode.disabled,
            asyncValidator: (value) async {
              calls++;
              return null;
            },
          );

          await tester.pumpWidget(buildTestableFieldWidget(testWidget));
          await tester.enterText(find.byType(TextField), 'changed');
          await tester.pumpAndSettle();
          expect(calls, 0);

          final validation = fieldKey.currentState!.validateAsync();
          await tester.pump();
          expect(await validation, isTrue);
          expect(calls, 1);
        });

        testWidgets('inherits onUserInteraction from FormBuilder', (
          tester,
        ) async {
          var firstCalls = 0;
          var secondCalls = 0;

          await tester.pumpWidget(
            buildTestableFieldWidget(
              Column(
                children: [
                  FormBuilderTextField(
                    name: 'first',
                    asyncValidator: (value) async {
                      firstCalls++;
                      return null;
                    },
                  ),
                  FormBuilderTextField(
                    name: 'second',
                    asyncValidator: (value) async {
                      secondCalls++;
                      return null;
                    },
                  ),
                ],
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          );
          await tester.pumpAndSettle();
          expect(firstCalls, 0);
          expect(secondCalls, 0);

          await tester.enterText(find.byType(TextField).first, 'changed');
          await tester.pumpAndSettle();

          expect(firstCalls, 1);
          expect(secondCalls, 1);
        });

        testWidgets('inherits always from FormBuilder on initial build', (
          tester,
        ) async {
          var calls = 0;
          final testWidget = FormBuilderTextField(
            name: 'text',
            asyncValidator: (value) async {
              calls++;
              return 'Async Error';
            },
          );

          await tester.pumpWidget(
            buildTestableFieldWidget(
              testWidget,
              autovalidateMode: AutovalidateMode.always,
            ),
          );
          await tester.pumpAndSettle();

          expect(calls, 1);
          expect(find.text('Async Error'), findsOneWidget);
        });

        testWidgets('runs when a field with onUnfocus loses focus', (
          tester,
        ) async {
          var calls = 0;
          final testWidget = FormBuilderTextField(
            name: 'text',
            autovalidateMode: AutovalidateMode.onUnfocus,
            asyncValidator: (value) async {
              calls++;
              return null;
            },
          );

          await tester.pumpWidget(
            buildTestableFieldWidget(
              Column(
                children: [
                  testWidget,
                  ElevatedButton(onPressed: () {}, child: const Text('Next')),
                ],
              ),
            ),
          );
          await tester.enterText(find.byType(TextField), 'changed');
          await tester.pumpAndSettle();
          expect(calls, 0);

          await tester.sendKeyEvent(LogicalKeyboardKey.tab);
          await tester.pumpAndSettle();

          expect(calls, 1);
        });

        testWidgets(
          'onUserInteractionIfError runs only after an existing error',
          (tester) async {
            final mode = AutovalidateMode.values
                .where((mode) => mode.name == 'onUserInteractionIfError')
                .firstOrNull;
            if (mode == null) {
              return;
            }

            var calls = 0;
            final fieldKey = GlobalKey<FormBuilderFieldState>();
            final testWidget = FormBuilderTextField(
              key: fieldKey,
              name: 'text',
              autovalidateMode: mode,
              asyncValidator: (value) async {
                calls++;
                return 'Async Error';
              },
            );

            await tester.pumpWidget(buildTestableFieldWidget(testWidget));
            await tester.enterText(find.byType(TextField), 'first');
            await tester.pumpAndSettle();
            expect(calls, 0);

            final validation = fieldKey.currentState!.validateAsync();
            await tester.pump();
            expect(await validation, isFalse);
            expect(calls, 1);

            await tester.enterText(find.byType(TextField), 'second');
            await tester.pumpAndSettle();
            expect(calls, 2);
          },
        );

        testWidgets('skips async validation when sync validation fails', (
          tester,
        ) async {
          var calls = 0;
          final testWidget = FormBuilderTextField(
            name: 'text',
            autovalidateMode: AutovalidateMode.always,
            validator: (value) => 'Sync Error',
            asyncValidator: (value) async {
              calls++;
              return null;
            },
          );

          await tester.pumpWidget(buildTestableFieldWidget(testWidget));
          await tester.pumpAndSettle();

          expect(calls, 0);
          expect(find.text('Sync Error'), findsOneWidget);
        });
      });

      testWidgets('Should validate asynchronously and update errorText', (
        tester,
      ) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const errorText = 'async error';
        final testWidget = FormBuilderTextField(
          name: 'text',
          key: textFieldKey,
          asyncValidator: (value) async {
            await Future.delayed(const Duration(milliseconds: 50));
            return value == 'invalid' ? errorText : null;
          },
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));
        await tester.pump();

        // 1. Initial State: valid
        expect(textFieldKey.currentState?.isValid, isTrue);
        expect(textFieldKey.currentState?.isValidating, isFalse);

        // 2. Validate to 'invalid'
        await tester.enterText(find.byType(TextField), 'invalid');
        await tester.pump();

        final validationFuture = textFieldKey.currentState!.validateAsync();

        // Advance past the 50ms async validator delay
        await tester.pump(const Duration(milliseconds: 60));

        final result = await validationFuture;
        expect(result, isFalse);
        await tester.pump();

        expect(textFieldKey.currentState?.isValidating, isFalse);
        expect(textFieldKey.currentState?.isValid, isFalse);
        expect(find.text(errorText), findsOneWidget);

        // 3. Validate to 'valid'
        await tester.enterText(find.byType(TextField), 'valid');
        await tester.pump();

        final validationFuture2 = textFieldKey.currentState!.validateAsync();

        // Advance past the 50ms async validator delay
        await tester.pump(const Duration(milliseconds: 60));

        final result2 = await validationFuture2;
        expect(result2, isTrue);
        await tester.pump();

        expect(textFieldKey.currentState?.isValidating, isFalse);
        expect(textFieldKey.currentState?.isValid, isTrue);
        expect(find.text(errorText), findsNothing);
      });

      testWidgets(
        'Should discard stale validations when value changes rapidly',
        (tester) async {
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          final testWidget = FormBuilderTextField(
            name: 'text',
            key: textFieldKey,
            asyncValidator: (value) async {
              if (value == 'first') {
                await Future.delayed(const Duration(milliseconds: 100));
                return 'first error';
              } else {
                await Future.delayed(const Duration(milliseconds: 10));
                return 'second error';
              }
            },
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));

          // Run validation for 'first' (long delay)
          await tester.enterText(find.byType(TextField), 'first');
          await tester.pump();
          final fut1 = textFieldKey.currentState?.validateAsync();

          // Run validation for 'second' (short delay) — supersedes 'first'
          await tester.enterText(find.byType(TextField), 'second');
          await tester.pump();
          final fut2 = textFieldKey.currentState?.validateAsync();

          // Advance past both delays
          await tester.pump(const Duration(milliseconds: 20));
          await tester.pump(const Duration(milliseconds: 100));

          await fut1;
          await fut2;
          await tester.pump();

          expect(textFieldKey.currentState?.errorText, 'second error');
        },
      );

      testWidgets('Should discard a result after the value changes', (
        tester,
      ) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: 'text',
          key: textFieldKey,
          asyncValidator: (value) async {
            await Future.delayed(const Duration(milliseconds: 50));
            return 'stale error';
          },
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        await tester.enterText(find.byType(TextField), 'first');
        await tester.pump();
        final validation = textFieldKey.currentState!.validateAsync();

        await tester.enterText(find.byType(TextField), 'second');
        await tester.pump(const Duration(milliseconds: 60));
        expect(await validation, isFalse);
        await tester.pump();

        expect(textFieldKey.currentState?.errorText, isNull);
        expect(textFieldKey.currentState?.isValidating, isFalse);
      });

      testWidgets('Should handle asyncValidator throwing exception', (
        tester,
      ) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: 'text',
          key: textFieldKey,
          asyncValidator: (value) async {
            await Future.delayed(const Duration(milliseconds: 10));
            throw Exception('Async failure');
          },
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));
        await tester.enterText(find.byType(TextField), 'trigger');
        await tester.pump();

        final fut = textFieldKey.currentState?.validateAsync();
        await tester.pump(const Duration(milliseconds: 20));
        final res = await fut;

        expect(res, isFalse);
        expect(
          textFieldKey.currentState?.errorText,
          'Exception: Async failure',
        );
      });

      testWidgets(
        'Should clear custom and async errors if clearCustomError is true',
        (tester) async {
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          final testWidget = FormBuilderTextField(
            name: 'text',
            key: textFieldKey,
            asyncValidator: (value) async => null,
          );
          await tester.pumpWidget(buildTestableFieldWidget(testWidget));

          textFieldKey.currentState?.invalidate('Custom Error');
          await tester.pump();
          expect(textFieldKey.currentState?.errorText, 'Custom Error');

          final fut = textFieldKey.currentState?.validateAsync(
            clearCustomError: true,
          );
          await tester.pump(const Duration(milliseconds: 10));
          await fut;

          expect(textFieldKey.currentState?.errorText, isNull);
        },
      );

      testWidgets(
        'Should stop async validation and auto-scroll if sync validation fails',
        (tester) async {
          final textFieldKey = GlobalKey<FormBuilderFieldState>();
          final testWidget = FormBuilderTextField(
            name: 'text',
            key: textFieldKey,
            validator: (value) => 'Sync Error',
            asyncValidator: (value) async => 'Async Error',
          );
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 1000,
                      ), // Push out of view to test scroll
                      FormBuilder(key: formKey, child: testWidget),
                    ],
                  ),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          // Sync validation fails, async validation should not run, autoScroll should be triggered
          final fut = textFieldKey.currentState?.validateAsync(
            autoScrollWhenFocusOnInvalid: true,
          );
          await tester.pump(const Duration(milliseconds: 10));
          final res = await fut;
          await tester.pumpAndSettle(); // Wait for scroll animation

          expect(res, isFalse);
          expect(textFieldKey.currentState?.errorText, 'Sync Error');
        },
      );
    });
  });
}
