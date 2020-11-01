import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/grouped_checkbox.dart';

class FormBuilderCheckboxGroup<T> extends FormBuilderField<List<T>> {
  final List<FormBuilderFieldOption> options;
  final Color activeColor;
  final Color checkColor;
  final Color focusColor;
  final Color hoverColor;
  final List<T> disabled;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool tristate;
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

  FormBuilderCheckboxGroup({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    List<T> initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<List<T>> onChanged,
    ValueTransformer<List<T>> valueTransformer,
    bool enabled = true,
    FormFieldSetter<List<T>> onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
    @required this.options,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.disabled,
    this.materialTapTargetSize,
    this.tristate = false,
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
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<List<T>> field) {
            final _FormBuilderCheckboxGroupState<T> state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? state.errorText,
              ),
              child: GroupedCheckbox(
                orientation: orientation,
                value: state.value,
                options: options,
                onChanged: (val) {
                  state.requestFocus();
                  field.didChange(val);
                },
                disabled: state.readOnly
                    ? options.map((e) => e.value).toList()
                    : disabled,
                activeColor: activeColor,
                focusColor: focusColor,
                checkColor: checkColor,
                materialTapTargetSize: materialTapTargetSize,
                hoverColor: hoverColor,
                tristate: tristate,
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
  _FormBuilderCheckboxGroupState<T> createState() =>
      _FormBuilderCheckboxGroupState();
}

class _FormBuilderCheckboxGroupState<T> extends FormBuilderFieldState<List<T>> {
  @override
  FormBuilderCheckboxGroup<T> get widget =>
      super.widget as FormBuilderCheckboxGroup;
}
