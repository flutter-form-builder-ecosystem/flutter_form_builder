import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/image_source_sheet.dart';
import 'package:image_picker/image_picker.dart';

/// Field for picking image(s) from Gallery or Camera.
class FormBuilderImagePicker extends FormBuilderField<List<dynamic>> {
  //TODO: Add documentation
  final double previewWidth;
  final double previewHeight;
  final EdgeInsets previewMargin;
  final ImageProvider placeholderImage;

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

  final void Function(Image) onImage;
  final int maxImages;
  final Widget cameraIcon;
  final Widget galleryIcon;
  final Widget cameraLabel;
  final Widget galleryLabel;
  final EdgeInsets bottomSheetPadding;

  /// Creates field for picking image(s) from Gallery or Camera.
  FormBuilderImagePicker({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator<List<dynamic>> validator,
    List<dynamic> initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<List<dynamic>> onChanged,
    ValueTransformer<List<dynamic>> valueTransformer,
    bool enabled = true,
    FormFieldSetter<List<dynamic>> onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
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
    this.cameraIcon = const Icon(Icons.camera_enhance),
    this.galleryIcon = const Icon(Icons.image),
    this.cameraLabel = const Text('Camera'),
    this.galleryLabel = const Text('Gallery'),
    this.bottomSheetPadding = EdgeInsets.zero,
    this.placeholderImage,
  })  : assert(maxImages == null || maxImages >= 0),
        super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<List<dynamic>> field) {
            final state = field as _FormBuilderImagePickerState;
            final theme = Theme.of(state.context);
            final disabledColor = theme.disabledColor;
            final primaryColor = theme.primaryColor;

            return InputDecorator(
              decoration: state.decoration(),
              child: Container(
                height: previewHeight,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (field.value != null)
                      ...field.value.map<Widget>((dynamic item) {
                        assert(item is File ||
                            item is String ||
                            item is Uint8List);
                        return Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            Container(
                              width: previewWidth,
                              height: previewHeight,
                              margin: previewMargin,
                              child: kIsWeb
                                  ? Image.memory(item as Uint8List,
                                      fit: BoxFit.cover)
                                  : item is String
                                      ? Image.network(item, fit: BoxFit.cover)
                                      : Image.file(item as File,
                                          fit: BoxFit.cover),
                            ),
                            if (state.enabled)
                              InkWell(
                                onTap: () {
                                  state.requestFocus();
                                  field.didChange(
                                      <dynamic>[...field.value]..remove(item));
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
                      }),
                    if (state.enabled && !state.hasMaxImages)
                      GestureDetector(
                        child: placeholderImage != null
                            ? Image(
                                width: previewWidth,
                                height: previewHeight,
                                image: placeholderImage,
                              )
                            : Container(
                                width: previewWidth,
                                height: previewHeight,
                                child: Icon(
                                  Icons.camera_enhance,
                                  color: state.enabled
                                      ? iconColor ?? primaryColor
                                      : disabledColor,
                                ),
                                color: (state.enabled
                                        ? iconColor ?? primaryColor
                                        : disabledColor)
                                    .withAlpha(50)),
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: state.context,
                            builder: (_) {
                              return ImageSourceBottomSheet(
                                maxHeight: maxHeight,
                                maxWidth: maxWidth,
                                imageQuality: imageQuality,
                                preferredCameraDevice: preferredCameraDevice,
                                bottomSheetPadding: bottomSheetPadding,
                                cameraIcon: cameraIcon,
                                cameraLabel: cameraLabel,
                                galleryIcon: galleryIcon,
                                galleryLabel: galleryLabel,
                                onImageSelected: (image) {
                                  state.requestFocus();
                                  field.didChange(
                                      <dynamic>[...field.value, image]);
                                  Navigator.pop(state.context);
                                },
                                onImage: (image) {
                                  field.didChange(
                                      <dynamic>[...field.value, image]);
                                  onChanged?.call(field.value);
                                  Navigator.pop(state.context);
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

class _FormBuilderImagePickerState
    extends FormBuilderFieldState<FormBuilderImagePicker, List<dynamic>> {
  bool get hasMaxImages =>
      widget.maxImages != null &&
      value != null &&
      value.length >= widget.maxImages;
}
