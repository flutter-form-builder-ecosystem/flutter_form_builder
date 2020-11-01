import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSwitch extends FormBuilderField<bool> {
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
  final EdgeInsets contentPadding;
  final MouseCursor mouseCursor;
  final bool autofocus;
  final FocusNode focusNode;
  final Color hoverColor;
  final Color focusColor;
  final ImageErrorListener onActiveThumbImageError;
  final ImageErrorListener onInactiveThumbImageError;

  FormBuilderSwitch({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    bool initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<bool> onChanged,
    FormFieldSetter<bool> onSaved,
    ValueTransformer<bool> valueTransformer,
    List<FormFieldValidator<bool>> validators = const [],
    @required this.label,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.contentPadding = EdgeInsets.zero,
    this.mouseCursor,
    this.autofocus = false,
    this.focusNode,
    this.hoverColor,
    this.focusColor,
    this.onActiveThumbImageError,
    this.onInactiveThumbImageError,
  }) : super(
          key: key,
          attribute: attribute,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          initialValue: initialValue,
          decoration: decoration,
          onChanged: onChanged,
          onSaved: onSaved,
          valueTransformer: valueTransformer,
          validators: validators,
        );

  @override
  _FormBuilderSwitchState createState() => _FormBuilderSwitchState();
}

class _FormBuilderSwitchState
    extends FormBuilderFieldState<FormBuilderSwitch, bool, bool> {
  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
        key: fieldKey,
        enabled: widget.enabled,
        initialValue: initialValue ?? false,
        validator: (val) => validate(val),
        onSaved: (val) => save(val),
        builder: (FormFieldState<bool> field) {
          return InputDecorator(
            decoration: widget.decoration.copyWith(
              enabled: widget.enabled,
              errorText: field.errorText,
            ),
            child: ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: widget.contentPadding,
              title: widget.label,
              trailing: Switch(
                value: field.value,
                onChanged: readOnly
                    ? null
                    : (bool value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        field.didChange(value);
                        widget.onChanged?.call(value);
                      },
                activeColor: widget.activeColor,
                activeThumbImage: widget.activeThumbImage,
                activeTrackColor: widget.activeTrackColor,
                dragStartBehavior: widget.dragStartBehavior,
                inactiveThumbColor: widget.inactiveThumbColor,
                inactiveThumbImage: widget.activeThumbImage,
                inactiveTrackColor: widget.inactiveTrackColor,
                materialTapTargetSize: widget.materialTapTargetSize,
                mouseCursor: widget.mouseCursor,
                autofocus: widget.autofocus,
                focusNode: widget.focusNode,
                hoverColor: widget.hoverColor,
                focusColor: widget.focusColor,
                onActiveThumbImageError: widget.onActiveThumbImageError,
                onInactiveThumbImageError: widget.onInactiveThumbImageError,
              ),
              onTap: widget.enabled
                  ? () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final newValue = !(field.value ?? false);
                      field.didChange(newValue);
                      widget.onChanged?.call(newValue);
                    }
                  : null,
            ),
          );
        });
  }
}
