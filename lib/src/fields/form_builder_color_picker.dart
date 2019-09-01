import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/hsv_picker.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum ColorPickerType { ColorPicker, MaterialPicker, BlockPicker }

class FormBuilderColorPickerField extends FormBuilderField<Color> {
  FormBuilderColorPickerField({
    Key key,
    @required String attribute,
    Color initialValue,
    List<FormFieldValidator> validators = const [],
    bool enabled = true,
    bool autovalidate = false,
    ValueTransformer valueTransformer,
    ValueChanged onChanged,
    FormFieldSetter<Color> onSaved,
    //
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.colorPickerType = ColorPickerType.ColorPicker,
    InputDecoration decoration = const InputDecoration(),
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextAlign textAlign = TextAlign.start,
    TextInputType keyboardType,
    TextInputAction textInputAction,
    TextStyle style,
    StrutStyle strutStyle,
    TextDirection textDirection,
    bool autofocus = false,
    bool obscureText = false,
    bool autocorrect = true,
    bool maxLengthEnforced = true,
    int maxLines = 1,
    bool expands = false,
    bool showCursor,
    int minLines,
    int maxLength,
    VoidCallback onEditingComplete,
    ValueChanged<String> onFieldSubmitted,
    // FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder buildCounter,
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validators: validators,
          enabled: enabled,
          autovalidate: autovalidate,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          onSaved: onSaved,
          builder: (field) {
            final _FormBuilderColorPickerFieldState state = field;

            return TextField(
              style: style,
              decoration: decoration.copyWith(
                errorText: field.errorText,
                suffixIcon: LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    height: constraints.minHeight,
                    width: constraints.minHeight,
                    decoration: BoxDecoration(
                      color: field.value,
                      borderRadius: BorderRadius.all(
                          Radius.circular(constraints.minHeight / 2)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  );
                }),
              ),
              enabled: enabled,
              readOnly: state.readOnly,
              controller: state._effectiveController,
              focusNode: state._effectiveFocusNode,
              textAlign: textAlign,
              autofocus: autofocus,
              expands: expands,
              scrollPadding: scrollPadding,
              autocorrect: autocorrect,
              textCapitalization: textCapitalization,
              keyboardType: keyboardType,
              obscureText: obscureText,
              buildCounter: buildCounter,
              cursorColor: cursorColor,
              cursorRadius: cursorRadius,
              cursorWidth: cursorWidth,
              enableInteractiveSelection: enableInteractiveSelection,
              inputFormatters: inputFormatters,
              keyboardAppearance: keyboardAppearance,
              maxLength: maxLength,
              maxLengthEnforced: maxLengthEnforced,
              maxLines: maxLines,
              minLines: minLines,
              onEditingComplete: onEditingComplete,
              // onFieldSubmitted: onFieldSubmitted,
              showCursor: showCursor,
              strutStyle: strutStyle,
              textDirection: textDirection,
              textInputAction: textInputAction,
            );
          },
        );
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;
  final ColorPickerType colorPickerType;

  @override
  _FormBuilderColorPickerFieldState createState() =>
      _FormBuilderColorPickerFieldState();
}

class _FormBuilderColorPickerFieldState extends FormBuilderFieldState<Color> {
  FormBuilderColorPickerField get widget => super.widget;

  FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController;

  TextEditingController get _effectiveController =>
      widget.controller ?? _textEditingController;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  Color _pickedColor;

  String get valueString => value?.toString();

  @override
  void initState() {
    super.initState();
    _pickedColor = value ?? Colors.blue;
    _textEditingController = TextEditingController(text: valueString);
    if (widget.focusNode != null) {
      widget.focusNode.addListener(_handleFocus);
    }
    _focusNode.addListener(_handleFocus);
  }

  void setColor() {
    didChange(_pickedColor);
    if (widget.onChanged != null) widget.onChanged(value);
    _effectiveController.text = valueString;
  }

  _handleFocus() async {
    if (_effectiveFocusNode.hasFocus && !readOnly) {
      Future.microtask(() => FocusScope.of(context).requestFocus(FocusNode()));
      bool selected = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: null, //const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: _buildColorPicker(),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
      if (selected != null && selected == true) {
        setColor();
      } else {
        if (value != null) _colorChanged(value);
      }
    }
  }

  _buildColorPicker() {
    switch (widget.colorPickerType) {
      case ColorPickerType.ColorPicker:
        return ColorPicker(
          pickerColor: _pickedColor,
          onColorChanged: _colorChanged,
          enableLabel: true,
          colorPickerWidth: 300,
          displayThumbColor: true,
          enableAlpha: true,
          paletteType: PaletteType.hsl,
          pickerAreaHeightPercent: 1.0,
        );
      case ColorPickerType.MaterialPicker:
        return MaterialPicker(
          pickerColor: _pickedColor,
          onColorChanged: _colorChanged,
          enableLabel: true, // only on portrait mode
        );
      case ColorPickerType.BlockPicker:
        return BlockPicker(
          pickerColor: _pickedColor,
          onColorChanged: _colorChanged,
          /*availableColors: [],
          itemBuilder: ,
          layoutBuilder: ,*/
        );
      default:
        throw "Unknown ColorPickerType";
    }
  }

  _colorChanged(Color color) {
    setState(() {
      _pickedColor = color;
    });
  }
}
