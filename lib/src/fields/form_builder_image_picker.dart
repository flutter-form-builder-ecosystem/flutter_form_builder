import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/image_source_sheet.dart';
import 'package:image_picker/image_picker.dart';

class FormBuilderImagePicker extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final List initialValue;
  final bool readOnly;
  @Deprecated('Set the `labelText` within decoration attribute')
  final String labelText;
  final InputDecoration decoration;
  final ValueTransformer valueTransformer;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;

  final double imageWidth;
  final double imageHeight;
  final EdgeInsets imageMargin;
  final Color iconColor;

  /// Optional maximum height of image; see [ImagePicker].
  final double maxHeight;

  /// Optional maximum width of image; see [ImagePicker].
  final double maxWidth;

  /// The imageQuality argument modifies the quality of the image, ranging from
  /// 0-100 where 100 is the original/max quality. If imageQuality is null, the
  /// image with the original quality will be returned. See [ImagePicker].
  final int imageQuality;

  /// Use preferredCameraDevice to specify the camera to use when the source is
  /// `ImageSource.camera`. The preferredCameraDevice is ignored when source is
  /// `ImageSource.gallery`. It is also ignored if the chosen camera is not
  /// supported on the device. Defaults to `CameraDevice.rear`. See [ImagePicker].
  final CameraDevice preferredCameraDevice;

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
    this.onSaved,
    this.decoration = const InputDecoration(),
    this.iconColor,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
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
        if (widget.onSaved != null) {
          widget.onSaved(transformed ?? val);
        }
      },
      builder: (field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readOnly,
            errorText: field.errorText,
            // ignore: deprecated_member_use_from_same_package
            labelText: widget.decoration.labelText ?? widget.labelText,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Container(
                height: widget.imageHeight,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: field.value.map<Widget>((item) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          Container(
                            width: widget.imageWidth,
                            height: widget.imageHeight,
                            margin: widget.imageMargin,
                            child: item is String
                                ? Image.network(item, fit: BoxFit.cover)
                                : Image.file(item, fit: BoxFit.cover),
                          ),
                          if (!_readOnly)
                            InkWell(
                              onTap: () {
                                field.didChange([...field.value]..remove(item));
                              },
                              child: Container(
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.7),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                height: 22,
                                width: 22,
                                child: Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      );
                    }).toList()
                      ..add(
                        GestureDetector(
                          child: Container(
                              width: widget.imageWidth,
                              height: widget.imageHeight,
                              child: Icon(Icons.camera_enhance,
                                  color: _readOnly
                                      ? Theme.of(context).disabledColor
                                      : widget.iconColor ??
                                          Theme.of(context).primaryColor),
                              color: (_readOnly
                                      ? Theme.of(context).disabledColor
                                      : widget.iconColor ??
                                          Theme.of(context).primaryColor)
                                  .withAlpha(50)),
                          onTap: _readOnly
                              ? null
                              : () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      return ImageSourceSheet(
                                        maxHeight: widget.maxHeight,
                                        maxWidth: widget.maxWidth,
                                        imageQuality: widget.imageQuality,
                                        preferredCameraDevice:
                                            widget.preferredCameraDevice,
                                        onImageSelected: (image) {
                                          field.didChange(
                                              [...field.value, image]);
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                  );
                                },
                        ),
                      )),
              ),
            ],
          ),
        );
      },
    );
  }
}
