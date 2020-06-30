import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSwitch extends FormBuilderField {
  @override
  final String attribute;
  @override
  final FormFieldValidator validator;
  @override
  final bool initialValue;
  @override
  final bool readOnly;
  @override
  final InputDecoration decoration;
  @override
  final ValueChanged onChanged;
  @override
  final ValueTransformer valueTransformer;

  final Widget title;
  final Widget subtitle;
  final Widget secondary;

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

  final EdgeInsets contentPadding;

  /// {@macro flutter.cupertino.switch.dragStartBehavior}
  final ListTileControlAffinity controlAffinity;
  @override
  final FormFieldSetter onSaved;

  FormBuilderSwitch({
    Key key,
    @required this.attribute,
    @required this.title,
    this.initialValue,
    this.validator,
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
    this.subtitle,
    this.secondary,
    this.controlAffinity = ListTileControlAffinity.trailing,
    this.onSaved,
    this.contentPadding = const EdgeInsets.all(0.0),
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          onSaved: onSaved,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderSwitchState state = field;
            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: state.readOnly,
                errorText: field.errorText,
              ),
              child: SwitchListTile(
                dense: true,
                isThreeLine: false,
                contentPadding: contentPadding,
                title: title,
                value: state.value,
                onChanged: state.readOnly
                    ? null
                    : (val) {
                        field.didChange(val);
                      },
                activeColor: activeColor,
                activeThumbImage: activeThumbImage,
                activeTrackColor: activeTrackColor,
                inactiveThumbColor: inactiveThumbColor,
                inactiveThumbImage: activeThumbImage,
                inactiveTrackColor: inactiveTrackColor,
                secondary: secondary,
                subtitle: subtitle,
              ),
            );
          },
        );

  @override
  _FormBuilderSwitchState createState() => _FormBuilderSwitchState();
}

class _FormBuilderSwitchState extends FormBuilderFieldState {
  @override
  FormBuilderSwitch get widget => super.widget;
}
