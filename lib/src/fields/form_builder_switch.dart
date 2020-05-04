import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSwitch extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final bool initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final Widget label;

  /// The color to use when this switch is on.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  final Color activeColor;

  /// The color to use on the track when this switch is on.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor] with the opacity set at 50%.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final Color activeTrackColor;

  /// The color to use on the thumb when this switch is off.
  ///
  /// Defaults to the colors described in the Material design specification.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final Color inactiveThumbColor;

  /// The color to use on the track when this switch is off.
  ///
  /// Defaults to the colors described in the Material design specification.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final Color inactiveTrackColor;

  /// An image to use on the thumb of this switch when the switch is on.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final ImageProvider activeThumbImage;

  /// An image to use on the thumb of this switch when the switch is off.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final ImageProvider inactiveThumbImage;

  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [ThemeData.materialTapTargetSize].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize materialTapTargetSize;

  /// {@macro flutter.cupertino.switch.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;
  final FormFieldSetter onSaved;

  FormBuilderSwitch({
    Key key,
    @required this.attribute,
    @required this.label,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onSaved,
  }) : super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validators: validators,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            builder: (FormFieldState field) {
              final _FormBuilderSwitchState state = field;
              return InputDecorator(
                decoration: decoration.copyWith(
                  enabled: state.readOnly,
                  errorText: field.errorText,
                ),
                child: ListTile(
                  dense: true,
                  isThreeLine: false,
                  contentPadding: EdgeInsets.all(0.0),
                  title: label,
                  trailing: Switch(
                    value: field.value,
                    onChanged: state.readOnly
                        ? null
                        : (bool value) {
                            field.didChange(value);
                          },
                    activeColor: activeColor,
                    activeThumbImage: activeThumbImage,
                    activeTrackColor: activeTrackColor,
                    dragStartBehavior: dragStartBehavior,
                    inactiveThumbColor: inactiveThumbColor,
                    inactiveThumbImage: activeThumbImage,
                    inactiveTrackColor: inactiveTrackColor,
                    materialTapTargetSize: materialTapTargetSize,
                  ),
                  onTap: state.readOnly
                      ? null
                      : () {
                          bool newValue = !(field.value ?? false);
                          field.didChange(newValue);
                        },
                ),
              );
            });

  @override
  _FormBuilderSwitchState createState() => _FormBuilderSwitchState();
}

class _FormBuilderSwitchState extends FormBuilderFieldState {
  FormBuilderSwitch get widget => super.widget;
}
