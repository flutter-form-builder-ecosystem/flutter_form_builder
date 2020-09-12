import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/grouped_radio.dart';

class FormBuilderRadioGroup<T> extends FormBuilderField<T> {
  final List<FormBuilderFieldOption> options;
  final Color activeColor;
  final Color focusColor;
  final Color hoverColor;
  final List<T> disabled;
  final MaterialTapTargetSize materialTapTargetSize;
  final Axis wrapDirection;
  final WrapAlignment wrapAlignment;
  final double wrapSpacing;
  final WrapAlignment wrapRunAlignment;
  final double wrapRunSpacing;
  final WrapCrossAlignment wrapCrossAxisAlignment;
  final TextDirection wrapTextDirection;
  final VerticalDirection wrapVerticalDirection;
  final Widget separator;
  final ControlAffinity controlAffinity;

  final OptionsOrientation orientation;

  FormBuilderRadioGroup({
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
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.disabled,
    this.materialTapTargetSize,
    this.wrapDirection = Axis.horizontal,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapSpacing = 0.0,
    this.wrapRunAlignment = WrapAlignment.start,
    this.wrapRunSpacing = 0.0,
    this.wrapCrossAxisAlignment = WrapCrossAlignment.start,
    this.wrapTextDirection,
    this.wrapVerticalDirection = VerticalDirection.down,
    this.separator,
    this.controlAffinity = ControlAffinity.leading,
    this.orientation = OptionsOrientation.wrap,
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
            final _FormBuilderRadioGroupState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? state.errorText,
              ),
              child: GroupedRadio(
                orientation: orientation,
                value: state.value,
                options: options,
                onChanged: (val) {
                  state.requestFocus();
                  state.didChange(val);
                },
                activeColor: activeColor,
                focusColor: focusColor,
                materialTapTargetSize: materialTapTargetSize,
                disabled: disabled,
                hoverColor: hoverColor,
                wrapAlignment: wrapAlignment,
                wrapCrossAxisAlignment: wrapCrossAxisAlignment,
                wrapDirection: wrapDirection,
                wrapRunAlignment: wrapRunAlignment,
                wrapRunSpacing: wrapRunSpacing,
                wrapSpacing: wrapSpacing,
                wrapTextDirection: wrapTextDirection,
                wrapVerticalDirection: wrapVerticalDirection,
                separator: separator,
                controlAffinity: controlAffinity,
              ),
            );
          },
        );

  @override
  _FormBuilderRadioGroupState<T> createState() => _FormBuilderRadioGroupState();
}

class _FormBuilderRadioGroupState<T> extends FormBuilderFieldState<T> {
  @override
  FormBuilderRadioGroup<T> get widget => super.widget as FormBuilderRadioGroup;
}
