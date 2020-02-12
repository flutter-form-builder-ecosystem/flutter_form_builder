import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderColorPicker extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueTransformer valueTransformer;

  final ValueChanged<Color> onColorChanged;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;
  final PaletteType paletteType;
  final bool displayThumbColor;
  final bool enableAlpha;
  final bool enableLabel;
  final FormFieldSetter onSaved;

  FormBuilderColorPicker({
    Key key,
    @required this.attribute,
    @required this.onColorChanged,
    @required this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.colorPickerWidth = 300.0,
    this.paletteType = PaletteType.hsv,
    this.displayThumbColor = false,
    this.enableAlpha = true,
    this.enableLabel = true,
    this.pickerAreaHeightPercent = 1.0,
    this.valueTransformer,
    this.onSaved,
  });

  @override
  _FormBuilderColorPickerState createState() => _FormBuilderColorPickerState();
}

class _FormBuilderColorPickerState extends State<FormBuilderColorPicker> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  dynamic _initialValue;

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

    return FormField<Color>(
      key: _fieldKey,
      enabled: !_readOnly,
      initialValue: _initialValue,
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
        } else {
          _formState?.setAttributeValue(widget.attribute, val);
        }
        if (widget.onSaved != null) {
          widget.onSaved(transformed ?? val);
        }
      },
      builder: (FormFieldState<Color> state) {
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: ColorPicker(
                    onColorChanged: widget.onColorChanged,
                    pickerColor: _initialValue,
                    colorPickerWidth: widget.colorPickerWidth,
                    paletteType: widget.paletteType,
                    displayThumbColor: widget.displayThumbColor,
                    enableAlpha: widget.enableAlpha,
                    enableLabel: widget.enableLabel,
                    pickerAreaHeightPercent: widget.pickerAreaHeightPercent,
                  ),
                ),
              ),
            );
          },
          child: InputDecorator(
            decoration: widget.decoration.copyWith(
              errorText: state.errorText,
            ),
            child: Text(
              state.value?.value.toString() ?? "",
              style: TextStyle(color: state.value ?? Colors.black),
            ),
          ),
        );
      },
    );
  }
}
