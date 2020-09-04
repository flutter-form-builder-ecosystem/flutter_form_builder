import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSegmentedControl<T> extends FormBuilderField<T> {
  /// The color used to fill the backgrounds of unselected widgets and as the
  /// text color of the selected widget.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryContrastingColor` if null.
  final Color unselectedColor;

  /// The color used to fill the background of the selected widget and as the text
  /// color of unselected widgets.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color selectedColor;

  /// The color used as the border around each widget.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color borderColor;

  /// The color used to fill the background of the widget the user is
  /// temporarily interacting with through a long press or drag.
  ///
  /// Defaults to the selectedColor at 20% opacity if null.
  final Color pressedColor;

  /// The CupertinoSegmentedControl will be placed inside this padding
  ///
  /// Defaults to EdgeInsets.symmetric(horizontal: 16.0)
  final EdgeInsetsGeometry padding;

  final List<FormBuilderFieldOption> options;

  FormBuilderSegmentedControl({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    T initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    bool autovalidate = false,
    VoidCallback onReset,
    FocusNode focusNode,
    @required this.options,
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
          readOnly: readOnly,
          autovalidate: autovalidate,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          builder: (FormFieldState field) {
            final _FormBuilderSegmentedControlState state = field;
            final theme = Theme.of(state.context);

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CupertinoSegmentedControl<T>(
                  borderColor: state.readOnly
                      ? theme.disabledColor
                      : borderColor ?? theme.primaryColor,
                  selectedColor: state.readOnly
                      ? theme.disabledColor
                      : selectedColor ?? theme.primaryColor,
                  pressedColor: state.readOnly
                      ? theme.disabledColor
                      : pressedColor ?? theme.primaryColor,
                  groupValue: state.value,
                  children: {
                    for (var option in options)
                      option.value: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: option,
                      ),
                  },
                  padding: padding,
                  unselectedColor: unselectedColor,
                  onValueChanged: (T value) {
                    state.requestFocus();
                    if (state.readOnly) {
                      field.reset();
                    } else {
                      field.didChange(value);
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

class _FormBuilderSegmentedControlState<T> extends FormBuilderFieldState<T> {
  @override
  FormBuilderSegmentedControl<T> get widget =>
      super.widget as FormBuilderSegmentedControl;
}
