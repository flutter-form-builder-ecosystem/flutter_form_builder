import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDropdown<T> extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator<T>> validators;
  final T initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final Widget hint;
  final List<DropdownMenuItem<T>> items;
  final bool isExpanded;
  final TextStyle style;
  final bool isDense;
  final int elevation;
  final Widget disabledHint;
  final double iconSize;
  @Deprecated('Underline in DropdownButton is ignored.')
  final Widget underline;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final bool allowClear;
  final Widget clearIcon;
  final FormFieldSetter<T> onSaved;
  final double itemHeight;
  final Color focusColor;
  final Color dropdownColor;
  final bool autofocus;
  final AutovalidateMode autovalidateMode;
  final FocusNode focusNode;
  final VoidCallback onTap;
  final List<Widget> Function(BuildContext) selectedItemBuilder;

  FormBuilderDropdown({
    Key key,
    @required this.attribute,
    @required this.items,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.isExpanded = true,
    this.isDense = true,
    this.elevation = 8,
    this.iconSize = 24.0,
    this.hint,
    this.initialValue,
    this.style,
    this.disabledHint,
    this.onChanged,
    this.valueTransformer,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.allowClear = false,
    this.clearIcon = const Icon(Icons.close),
    this.onSaved,
    this.itemHeight,
    this.focusColor,
    this.dropdownColor,
    this.autofocus = false,
    this.autovalidateMode,
    this.focusNode,
    this.onTap,
    this.selectedItemBuilder,
  }) : super(key: key) /*: assert(allowClear == true || clearIcon != null)*/;

  @override
  _FormBuilderDropdownState<T> createState() => _FormBuilderDropdownState();
}

class _FormBuilderDropdownState<T> extends State<FormBuilderDropdown<T>> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  T _initialValue;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        ((_formState?.initialValue?.containsKey(widget.attribute) ?? false)
            ? _formState?.initialValue[widget.attribute]
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
      autovalidateMode: widget.autovalidateMode,
      key: _fieldKey,
      enabled: !_readOnly,
      initialValue: _initialValue,
      validator: (val) =>
          FormBuilderValidators.validateValidators<T>(val, widget.validators),
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
      builder: (FormFieldState<T> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            errorText: field.errorText,
            floatingLabelBehavior: widget.hint == null
                ? widget.decoration.floatingLabelBehavior
                : FloatingLabelBehavior.always,
          ),
          isEmpty: field.value == null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    isExpanded: widget.isExpanded,
                    hint: widget.hint,
                    items: widget.items,
                    value: field.value,
                    style: widget.style,
                    isDense: widget.isDense,
                    disabledHint: field.value != null
                        ? (widget.items
                                .firstWhere((val) => val.value == field.value,
                                    orElse: () => null)
                                ?.child ??
                            Text(field.value.toString()))
                        : widget.disabledHint,
                    elevation: widget.elevation,
                    iconSize: widget.iconSize,
                    icon: widget.icon,
                    iconDisabledColor: widget.iconDisabledColor,
                    iconEnabledColor: widget.iconEnabledColor,
                    // ignore: deprecated_member_use_from_same_package
                    underline: widget.underline,
                    onChanged: _readOnly
                        ? null
                        : (value) {
                            _changeValue(field, value);
                          },
                    itemHeight: widget.itemHeight,
                    focusColor: widget.focusColor,
                    dropdownColor: widget.dropdownColor,
                    autofocus: widget.autofocus,
                    focusNode: widget.focusNode,
                    onTap: widget.onTap,
                    selectedItemBuilder: widget.selectedItemBuilder,
                  ),
                ),
              ),
              if (widget.allowClear &&
                  !widget.readOnly &&
                  field.value != null) ...[
                const VerticalDivider(),
                InkWell(
                  child: widget.clearIcon,
                  onTap: () {
                    _changeValue(field, null);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _changeValue(FormFieldState field, value) {
    field.didChange(value);
    widget.onChanged?.call(value);
  }

/*@override
  Widget build(BuildContext context) {
    _readOnly = _formState?.readOnly == true || widget.readOnly;

    return DropdownButtonFormField(
      key: _fieldKey,
      decoration: widget.decoration.copyWith(
        enabled: _readOnly ? false : true,
      ),
      hint: widget.hint,
      items: widget.items,
      value: _initialValue,
      onChanged: _readOnly
          ? null
          : (value) {
        FocusScope.of(context).requestFocus(FocusNode());
        widget.onChanged?.call(value);
      },
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
        return null;
      },
      onSaved: (val) {
        if (widget.valueTransformer != null) {
          var transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute, val);
      },
    );
  }*/
}
