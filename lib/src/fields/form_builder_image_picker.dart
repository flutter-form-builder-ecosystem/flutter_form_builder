import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/image_source_sheet.dart';

class FormBuilderImagePicker extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final List initialValue;
  final bool readOnly;
  final String labelText;
  final ValueTransformer valueTransformer;
  final ValueChanged onChanged;

  final double imageWidth;
  final double imageHeight;
  final EdgeInsets imageMargin;
  final FormFieldSetter onSaved;

  const FormBuilderImagePicker({
    Key key,
    @required this.attribute,
    this.initialValue,
    this.validators = const [],
    this.valueTransformer,
    this.labelText,
    this.onChanged,
    this.imageWidth = 130,
    this.imageHeight = 130,
    this.imageMargin,
    this.readOnly = false,
    this.onSaved
  }) : super(key: key);

  @override
  _FormBuilderImagePickerState createState() => _FormBuilderImagePickerState();
}

class _FormBuilderImagePickerState extends State<FormBuilderImagePicker> {
  bool _readOnly = false;
  List _initialValue;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = List.of(widget.initialValue ??
        (_formState.initialValue.containsKey(widget.attribute)
            ? _formState.initialValue[widget.attribute]
            : []));
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

    return FormField<List>(
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
        } else
          _formState?.setAttributeValue(widget.attribute, val);
        if (widget.onSaved != null) {
          widget.onSaved(transformed ?? val);
        }
      },
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.labelText != null ? widget.labelText : 'Images',
            style: TextStyle(
                color: _readOnly ? Theme.of(context).disabledColor : Theme.of(context).primaryColor
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: widget.imageHeight,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: state.value.map<Widget>((item) {
                  return Container(
                    width: widget.imageWidth,
                    height: widget.imageHeight,
                    margin: widget.imageMargin,
                    child: GestureDetector(
                      child: item is String ?
                      Image.network(item, fit: BoxFit.cover) :
                      Image.file(item, fit: BoxFit.cover),
                      onLongPress: _readOnly ? null : () {
                        state.didChange(state.value..remove(item));
                      },
                    ),
                  );
                }).toList()
                  ..add(
                      GestureDetector(
                        child: Container(
                          width: widget.imageWidth,
                          height: widget.imageHeight,
                          child: Icon(
                            Icons.camera_enhance,
                              color: _readOnly ? Theme.of(context).disabledColor : Theme.of(context).primaryColor
                          ),
                            color: (_readOnly ? Theme.of(context).disabledColor : Theme.of(context).primaryColor).withAlpha(50)
                        ),
                        onTap: _readOnly ? null : () {
                          showModalBottomSheet(context: context, builder: (_) {
                            return ImageSourceSheet(
                              onImageSelected: (image) {
                                state.didChange(state.value..add(image));
                                Navigator.of(context).pop();
                              },
                            );
                          });
                        },
                      )
                  )
            ),
          ),
          state.hasError
              ? Text(
            state.errorText,
            style: TextStyle(color: Theme.of(context).errorColor, fontSize: 12),
          ) : Container()
        ],
      ),
    );
  }
}
