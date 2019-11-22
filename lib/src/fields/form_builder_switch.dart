import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSwitch extends StatefulWidget {
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
  });

  @override
  _FormBuilderSwitchState createState() => _FormBuilderSwitchState();
}

class _FormBuilderSwitchState extends State<FormBuilderSwitch> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  bool _initialValue;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        (_formState.initialValue.containsKey(widget.attribute)
            ? _formState.initialValue[widget.attribute]
            : null);
    super.initState();
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = (_formState?.readOnly == true) ? true : widget.readOnly;

    return FormField(
        key: _fieldKey,
        enabled: !_readOnly,
        initialValue: _initialValue ?? false,
        validator: (val) {
          for (int i = 0; i < widget.validators.length; i++) {
            if (widget.validators[i](val) != null)
              return widget.validators[i](val);
          }
          return null;
        },
        onSaved: (val) {
          var transformed;
          if (widget.valueTransformer != null) {
            transformed = widget.valueTransformer(val);
            _formState?.setAttributeValue(widget.attribute, transformed);
          } else
            _formState?.setAttributeValue(widget.attribute, val);
          if (widget.onSaved != null) {
            widget.onSaved(transformed ?? val);
          }
        },
        builder: (FormFieldState<dynamic> field) {
          return InputDecorator(
            decoration: widget.decoration.copyWith(
              enabled: !_readOnly,
              errorText: field.errorText,
            ),
            child: ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: EdgeInsets.all(0.0),
              title: widget.label,
              trailing: Switch(
                value: field.value,
                onChanged: _readOnly
                    ? null
                    : (bool value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        field.didChange(value);
                        if (widget.onChanged != null) widget.onChanged(value);
                      },
                activeColor: widget.activeColor,
                activeThumbImage: widget.activeThumbImage,
                activeTrackColor: widget.activeTrackColor,
                dragStartBehavior: widget.dragStartBehavior,
                inactiveThumbColor: widget.inactiveThumbColor,
                inactiveThumbImage: widget.activeThumbImage,
                inactiveTrackColor: widget.inactiveTrackColor,
                materialTapTargetSize: widget.materialTapTargetSize,
              ),
              onTap: _readOnly
                  ? null
                  : () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      bool newValue = !(field.value ?? false);
                      field.didChange(newValue);
                      if (widget.onChanged != null) widget.onChanged(newValue);
                    },
            ),
          );
        });
  }
}
