import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// On/Off switch field
class FormBuilderSwitch extends FormBuilderField<bool> {
  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget? subtitle;

  /// A widget to display on the opposite side of the tile from the switch.
  ///
  /// Typically an [Icon] widget.
  final Widget? secondary;

  /// The color to use when this switch is on.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  final Color? activeColor;

  /// The color to use on the track when this switch is on.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor] with the opacity set at 50%.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final Color? activeTrackColor;

  /// The color to use on the thumb when this switch is off.
  ///
  /// Defaults to the colors described in the Material design specification.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final Color? inactiveThumbColor;

  /// The color to use on the track when this switch is off.
  ///
  /// Defaults to the colors described in the Material design specification.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final Color? inactiveTrackColor;

  /// An image to use on the thumb of this switch when the switch is on.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final ImageProvider? activeThumbImage;

  /// An image to use on the thumb of this switch when the switch is off.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final ImageProvider? inactiveThumbImage;

  /// The tile's internal padding.
  ///
  /// Insets a [SwitchListTile]'s contents: its [title], [subtitle],
  /// [secondary], and [Switch] widgets.
  ///
  /// If null, [ListTile]'s default of `EdgeInsets.symmetric(horizontal: 16.0)`
  /// is used.
  final EdgeInsets contentPadding;

  /// {@macro flutter.cupertino.switch.dragStartBehavior}
  final ListTileControlAffinity controlAffinity;

  /// Whether to render icons and text in the [activeColor].
  ///
  /// No effort is made to automatically coordinate the [selected] state and the
  /// [value] state. To have the list tile appear selected when the switch is
  /// on, pass the same value to both.
  ///
  /// Normally, this property is left to its default value, false.
  final bool selected;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Creates On/Off switch field
  FormBuilderSwitch({
    Key? key,
    //From Super
    required String name,
    FormFieldValidator<bool>? validator,
    bool? initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<bool?>? onChanged,
    ValueTransformer<bool?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<bool>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    required this.title,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.subtitle,
    this.secondary,
    this.controlAffinity = ListTileControlAffinity.trailing,
    this.contentPadding = EdgeInsets.zero,
    this.autofocus = false,
    this.selected = false,
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
          builder: (FormFieldState<bool?> field) {
            final state = field as _FormBuilderSwitchState;

            return InputDecorator(
              decoration: state.decoration,
              child: SwitchListTile(
                dense: true,
                isThreeLine: false,
                contentPadding: contentPadding,
                title: title,
                value: state.value ?? false,
                onChanged: state.enabled
                    ? (val) {
                        state.requestFocus();
                        field.didChange(val);
                      }
                    : null,
                activeColor: activeColor,
                activeThumbImage: activeThumbImage,
                activeTrackColor: activeTrackColor,
                inactiveThumbColor: inactiveThumbColor,
                inactiveThumbImage: activeThumbImage,
                inactiveTrackColor: inactiveTrackColor,
                secondary: secondary,
                subtitle: subtitle,
                autofocus: autofocus,
                selected: selected,
                controlAffinity: controlAffinity,
              ),
            );
          },
        );

  @override
  _FormBuilderSwitchState createState() => _FormBuilderSwitchState();
}

class _FormBuilderSwitchState
    extends FormBuilderFieldState<FormBuilderSwitch, bool> {}
