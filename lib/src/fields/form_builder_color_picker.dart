import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

extension on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  /*static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }*/

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0').toUpperCase()}'
      '${red.toRadixString(16).padLeft(2, '0').toUpperCase()}'
      '${green.toRadixString(16).padLeft(2, '0').toUpperCase()}'
      '${blue.toRadixString(16).padLeft(2, '0').toUpperCase()}';
}

enum ColorPickerType { ColorPicker, MaterialPicker, BlockPicker }

class FormBuilderColorPickerField extends FormBuilderField<Color> {
  //TODO: Add documentation
  final TextEditingController controller;
  final ColorPickerType colorPickerType;
  final TextCapitalization textCapitalization;

  final TextAlign textAlign;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final bool autofocus;

  final bool obscureText;
  final bool autocorrect;
  final bool maxLengthEnforced;

  final int maxLines;
  final bool expands;

  final bool showCursor;
  final int minLines;
  final int maxLength;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final double cursorWidth ;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding ;
  final bool enableInteractiveSelection ;
  final InputCounterWidgetBuilder buildCounter;

  FormBuilderColorPickerField({
    Key key,
    @required String name,
    Color initialValue,
    FormFieldValidator validator,
    bool enabled = true,
    bool autovalidate = false,
    ValueTransformer valueTransformer,
    ValueChanged onChanged,
    FormFieldSetter<Color> onSaved,
    VoidCallback onReset,
    this.controller,
    InputDecoration decoration = const InputDecoration(),
    FocusNode focusNode,
    bool readOnly = false,
    this.colorPickerType = ColorPickerType.ColorPicker,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this. textDirection,
    this. autofocus = false,
    this. obscureText = false,
    this. autocorrect = true,
    this. maxLengthEnforced = true,
    this. maxLines = 1,
    this. expands = false,
    this. showCursor,
    this. minLines,
    this. maxLength,
    this. onEditingComplete,
    this. onFieldSubmitted,
    // FormFieldValidator<String> validator,
    this. inputFormatters,
    this. cursorWidth = 2.0,
    this. cursorRadius,
    this. cursorColor,
    this. keyboardAppearance,
    this. scrollPadding = const EdgeInsets.all(20.0),
    this. enableInteractiveSelection = true,
    this. buildCounter,
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
            final _FormBuilderColorPickerFieldState state = field;
            return TextField(
              style: style,
              decoration: decoration.copyWith(
                errorText: decoration?.errorText ?? field.errorText,
                enabled: !state.readOnly,
                suffixIcon: LayoutBuilder(
                  key: ObjectKey(state.value),
                  builder: (context, constraints) {
                    return Container(
                      key: ObjectKey(state.value),
                      height: constraints.minHeight,
                      width: constraints.minHeight,
                      decoration: BoxDecoration(
                        color: state.value,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
              enabled: !state.readOnly,
              readOnly: state.readOnly,
              controller: state.effectiveController,
              focusNode: state.effectiveFocusNode,
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

  @override
  _FormBuilderColorPickerFieldState createState() =>
      _FormBuilderColorPickerFieldState();
}

class _FormBuilderColorPickerFieldState extends FormBuilderFieldState<Color> {
  @override
  FormBuilderColorPickerField get widget =>
      super.widget as FormBuilderColorPickerField;

  TextEditingController _effectiveController;

  TextEditingController get effectiveController => _effectiveController;

  String get valueString => value?.toHex();

  Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _effectiveController = widget.controller ?? TextEditingController();
    _effectiveController.text = valueString;
    effectiveFocusNode.addListener(_handleFocus);
  }

  Future<void> _handleFocus() async {
    if (effectiveFocusNode.hasFocus && !readOnly) {
      await Future.microtask(
          () => FocusScope.of(context).requestFocus(FocusNode()));
      var selected = await showDialog(
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
        didChange(_selectedColor);
      }
    }
  }

  Widget _buildColorPicker() {
    switch (widget.colorPickerType) {
      case ColorPickerType.ColorPicker:
        return ColorPicker(
          pickerColor: value ?? Colors.transparent,
          onColorChanged: _colorChanged,
          // enableLabel: true,
          colorPickerWidth: 300,
          displayThumbColor: true,
          enableAlpha: true,
          paletteType: PaletteType.hsl,
          pickerAreaHeightPercent: 1.0,
        );
      case ColorPickerType.MaterialPicker:
        return MaterialPicker(
          pickerColor: value ?? Colors.transparent,
          onColorChanged: _colorChanged,
          enableLabel: true, // only on portrait mode
        );
      case ColorPickerType.BlockPicker:
        return BlockPicker(
          pickerColor: value ?? Colors.transparent,
          onColorChanged: _colorChanged,
          /*availableColors: [],
          itemBuilder: ,
          layoutBuilder: ,*/
        );
      default:
        throw 'Unknown ColorPickerType';
    }
  }

  void _colorChanged(Color color) {
    _selectedColor = color;
  }

  void _setTextFieldString() {
    _effectiveController.text = valueString ?? '';
  }

  @override
  void didChange(Color value) {
    super.didChange(value);
    _setTextFieldString();
  }

  @override
  void reset() {
    super.reset();
    _setTextFieldString();
  }
}
