import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/image_source_sheet.dart';
import 'package:image_picker/image_picker.dart';

// TODO List<File | Uint8List> -- "ImageHolder"?
class FormBuilderImagePicker extends FormBuilderField<List<dynamic>> {
  @Deprecated('Set the `labelText` within decoration attribute')
  final String labelText;

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

  final int maxImages;
  final ImageProvider defaultImage;
  final Widget cameraIcon;
  final Widget galleryIcon;
  final Widget cameraLabel;
  final Widget galleryLabel;
  final EdgeInsets bottomSheetPadding;

  const FormBuilderImagePicker({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    List<dynamic> initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<List<dynamic>> onChanged,
    FormFieldSetter<List<dynamic>> onSaved,
    ValueTransformer<List<dynamic>> valueTransformer,
    List<FormFieldValidator<List<dynamic>>> validators = const [],
    this.defaultImage,
    this.labelText,
    this.imageWidth = 130,
    this.imageHeight = 130,
    this.imageMargin,
    this.iconColor,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
    this.maxImages,
    this.cameraIcon = const Icon(Icons.camera_enhance),
    this.galleryIcon = const Icon(Icons.image),
    this.cameraLabel = const Text('Camera'),
    this.galleryLabel = const Text('Gallery'),
    this.bottomSheetPadding = EdgeInsets.zero,
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
  _FormBuilderImagePickerState createState() => _FormBuilderImagePickerState();
}

class _FormBuilderImagePickerState extends FormBuilderFieldState<
    FormBuilderImagePicker, List<dynamic>, List<dynamic>> {
  bool get _hasMaxImages {
    if (widget.maxImages == null) {
      return false;
    } else {
      return /*_fieldKey.currentState.value != null &&*/ fieldKey
              .currentState.value.length >=
          widget.maxImages;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue ?? const [],
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (field) {
        var theme = Theme.of(context);

        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
            // ignore: deprecated_member_use_from_same_package
            labelText: widget.decoration.labelText ?? widget.labelText,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8),
              Container(
                height: widget.imageHeight,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...(field.value.map<Widget>((item) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          Container(
                            width: widget.imageWidth,
                            height: widget.imageHeight,
                            margin: widget.imageMargin,
                            /*child: kIsWeb
                                ? Image.memory(item, fit: BoxFit.cover)
                                : item is String
                                    ? Image.network(item, fit: BoxFit.cover)
                                    : Image.file(item, fit: BoxFit.cover),*/
                            child: kIsWeb
                                ? Image.memory(item, fit: BoxFit.cover)
                                : item is String
                                    ? Image.network(item, fit: BoxFit.cover)
                                    : item is File
                                        ? Image.file(item, fit: BoxFit.cover)
                                        : item,
                          ),
                          if (!readOnly)
                            InkWell(
                              onTap: () {
                                field.didChange([...field.value]..remove(item));
                                widget.onChanged?.call(field.value);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.7),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                height: 22,
                                width: 22,
                                child: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      );
                    }).toList()),
                    if (!readOnly && !_hasMaxImages)
                      GestureDetector(
                        child: widget.defaultImage != null
                            ? Image(
                                width: widget.imageWidth,
                                height: widget.imageHeight,
                                image: widget.defaultImage,
                              )
                            : Container(
                                width: widget.imageWidth,
                                height: widget.imageHeight,
                                child: Icon(Icons.camera_enhance,
                                    color: readOnly
                                        ? theme.disabledColor
                                        : widget.iconColor ??
                                            theme.primaryColor),
                                color: (readOnly
                                        ? theme.disabledColor
                                        : widget.iconColor ??
                                            theme.primaryColor)
                                    .withAlpha(50),
                              ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return ImageSourceBottomSheet(
                                maxHeight: widget.maxHeight,
                                maxWidth: widget.maxWidth,
                                imageQuality: widget.imageQuality,
                                preferredCameraDevice:
                                    widget.preferredCameraDevice,
                                cameraIcon: widget.cameraIcon,
                                galleryIcon: widget.galleryIcon,
                                cameraLabel: widget.cameraLabel,
                                galleryLabel: widget.galleryLabel,
                                onImageSelected: (image) {
                                  field.didChange([...field.value, image]);
                                  widget.onChanged?.call(field.value);
                                  Navigator.of(context).pop();
                                },
                                onImage: (image) {
                                  field.didChange([...field.value, image]);
                                  widget.onChanged?.call(field.value);
                                  Navigator.of(context).pop();
                                },
                                bottomSheetPadding: widget.bottomSheetPadding,
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
