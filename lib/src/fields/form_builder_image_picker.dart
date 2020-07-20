import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/image_source_sheet.dart';
import 'package:image_picker/image_picker.dart';

class FormBuilderImagePicker extends FormBuilderField {
  final double previewWidth;
  final double previewHeight;
  final EdgeInsets previewMargin;

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

  final Function(Image) onImage;
  final int maxImages;

  FormBuilderImagePicker({
    Key key,
    //From Super
    @required String attribute,
    FormFieldValidator validator,
    List initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    bool autovalidate = false,
    VoidCallback onReset,
    FocusNode focusNode,
    this.previewWidth = 130,
    this.previewHeight = 130,
    this.previewMargin,
    this.iconColor,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
    this.onImage,
    this.maxImages,
  })  : assert(maxImages == null || maxImages >= 0),
        super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
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
            final _FormBuilderImagePickerState state = field;
            final theme = Theme.of(state.context);
            final disabledColor = theme.disabledColor;
            final primaryColor = theme.primaryColor;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: Container(
                height: previewHeight,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (field.value != null)
                      ...(field.value.map<Widget>((item) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            Container(
                              width: previewWidth,
                              height: previewHeight,
                              margin: previewMargin,
                              child: item is String
                                  ? Image.network(item, fit: BoxFit.cover)
                                  : Image.file(item, fit: BoxFit.cover),
                            ),
                            if (!state.readOnly)
                              InkWell(
                                onTap: () {
                                  state.requestFocus();
                                  field.didChange(
                                      [...field.value]..remove(item));
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
                      }).toList()),
                    if (!state.readOnly && !state.hasMaxImages)
                      GestureDetector(
                        child: Container(
                            width: previewWidth,
                            height: previewHeight,
                            child: Icon(Icons.camera_enhance,
                                color: state.readOnly
                                    ? disabledColor
                                    : iconColor ?? primaryColor),
                            color: (state.readOnly
                                    ? disabledColor
                                    : iconColor ?? primaryColor)
                                .withAlpha(50)),
                        onTap: () {
                          showModalBottomSheet(
                            context: state.context,
                            builder: (_) {
                              return ImageSourceSheet(
                                maxHeight: maxHeight,
                                maxWidth: maxWidth,
                                imageQuality: imageQuality,
                                preferredCameraDevice: preferredCameraDevice,
                                onImageSelected: (image) {
                                  state.requestFocus();
                                  field
                                      .didChange([...field.value ?? [], image]);
                                  Navigator.of(state.context).pop();
                                },
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        );

  @override
  _FormBuilderImagePickerState createState() => _FormBuilderImagePickerState();
}

class _FormBuilderImagePickerState extends FormBuilderFieldState {
  @override
  FormBuilderImagePicker get widget => super.widget;

  bool get hasMaxImages {
    if (widget.maxImages == null || value == null) {
      return false;
    } else {
      return value.length >= widget.maxImages;
    }
  }
}
