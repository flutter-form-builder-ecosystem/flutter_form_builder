import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field for selection of a value from the `CupertinoSegmentedControl`
class FormBuilderSegmentedControl<T extends Object>
    extends FormBuilderField<T> {
  /// The color used to fill the backgrounds of unselected widgets and as the
  /// text color of the selected widget.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryContrastingColor` if null.
  final Color? unselectedColor;

  /// The color used to fill the background of the selected widget and as the text
  /// color of unselected widgets.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color? selectedColor;

  /// The color used as the border around each widget.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color? borderColor;

  /// The color used to fill the background of the widget the user is
  /// temporarily interacting with through a long press or drag.
  ///
  /// Defaults to the selectedColor at 20% opacity if null.
  final Color? pressedColor;

  /// The CupertinoSegmentedControl will be placed inside this padding
  ///
  /// Defaults to EdgeInsets.symmetric(horizontal: 16.0)
  final EdgeInsetsGeometry? padding;

  /// The list of options the user can select.
  final List<FormBuilderFieldOption<T>> options;

  /// Creates field for selection of a value from the `CupertinoSegmentedControl`
  FormBuilderSegmentedControl({
    Key? key,
    //From Super
    required String name,
    FormFieldValidator<T>? validator,
    T? initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<T?>? onChanged,
    ValueTransformer<T?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<T>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    required this.options,
    this.borderColor,
    this.selectedColor,
    this.pressedColor,
    this.padding,
    this.unselectedColor,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<T?> field) {
            final state = field as _FormBuilderSegmentedControlState<T>;
            final theme = Theme.of(state.context);

            return InputDecorator(
              decoration: state.decoration,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CupertinoSegmentedControl<T>(
                  borderColor: state.enabled
                      ? borderColor ?? theme.primaryColor
                      : theme.disabledColor,
                  selectedColor: state.enabled
                      ? selectedColor ?? theme.primaryColor
                      : theme.disabledColor,
                  pressedColor: state.enabled
                      ? pressedColor ?? theme.primaryColor
                      : theme.disabledColor,
                  groupValue: state.value,
                  children: <T, Widget>{
                    for (final option in options)
                      option.value: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: option,
                      ),
                  },
                  padding: padding,
                  unselectedColor: unselectedColor,
                  onValueChanged: (value) {
                    state.requestFocus();
                    if (state.enabled) {
                      field.didChange(value);
                    } else {
                      field.reset();
                    }
                  },
                ),
              ),
            );
          },
        );

  @override
  _FormBuilderSegmentedControlState<T> createState() =>
      _FormBuilderSegmentedControlState();
}

class _FormBuilderSegmentedControlState<T extends Object>
    extends FormBuilderFieldState<FormBuilderSegmentedControl<T>, T> {}
