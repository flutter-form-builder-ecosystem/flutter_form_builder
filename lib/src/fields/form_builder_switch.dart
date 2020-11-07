import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    this.contentPadding = const EdgeInsets.all(0.0),
    this.mouseCursor,
    this.autofocus = false,
    this.focusNode,
    this.hoverColor,
    this.focusColor,
    this.onActiveThumbImageError,
    this.onInactiveThumbImageError,
  }) : super(key: key);

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
        ((_formState?.initialValue?.containsKey(widget.attribute) ?? false)
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
    _readOnly = _formState?.readOnly == true || widget.readOnly;

    return FormField(
        key: _fieldKey,
        enabled: !_readOnly,
        initialValue: _initialValue ?? false,
        validator: (val) =>
            FormBuilderValidators.validateValidators(val, widget.validators),
        onSaved: (val) {
          var transformed;
          if (widget.valueTransformer != null) {
            transformed = widget.valueTransformer(val);
            _formState?.setAttributeValue(widget.attribute, transformed);
          } else {
            _formState?.setAttributeValue(widget.attribute, val);
          }
          widget.onSaved?.call(transformed ?? val);
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
              contentPadding: widget.contentPadding,
              title: widget.label,
              trailing: Switch(
                value: field.value,
                onChanged: _readOnly
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
              onTap: _readOnly
                  ? null
                  : () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final newValue = !(field.value ?? false);
                      field.didChange(newValue);
                      widget.onChanged?.call(newValue);
                    },
            ),
          );
        });
  }
}
