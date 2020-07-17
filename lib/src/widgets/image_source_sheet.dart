import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  /// Optional maximum height of image
  final double maxHeight;

  /// Optional maximum width of image
  final double maxWidth;

  /// The imageQuality argument modifies the quality of the image, ranging from
  /// 0-100 where 100 is the original/max quality. If imageQuality is null, the
  /// image with the original quality will be returned.
  final int imageQuality;

  /// Use preferredCameraDevice to specify the camera to use when the source is
  /// `ImageSource.camera`. The preferredCameraDevice is ignored when source is
  /// `ImageSource.gallery`. It is also ignored if the chosen camera is not
  /// supported on the device. Defaults to `CameraDevice.rear`.
  final CameraDevice preferredCameraDevice;

  /// Callback when an image is selected.
  ///
  /// **Note**: This will work on web platform whereas [onImageSelected] will not.
  final Function(Image) onImage;

  /// Callback when an image is selected.
  ///
  /// **Warning**: This will _NOT_ work on web platform because [File] is not
  /// available.
  final Function(File) onImageSelected;

  final Widget cameraIcon;
  final Widget galleryIcon;
  final Widget cameraLabel;
  final Widget galleryLabel;
  final EdgeInsets bottomSheetPadding;

  ImageSourceBottomSheet({
    Key key,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
    this.onImage,
    this.onImageSelected,
    this.cameraIcon,
    this.galleryIcon,
    this.cameraLabel,
    this.galleryLabel,
    this.bottomSheetPadding,
  })  : assert(null != onImage || null != onImageSelected),
        super(key: key);

  Future<void> _onPickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(
      source: source,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
    );
    if (null != pickedFile) {
      if (null != onImage) {
        final image = Image.memory(await pickedFile.readAsBytes());
        onImage(image);
      }

      if (null != onImageSelected) {
        // Warning:  this will not work on the web platform because pickedFile
        // will instead point to a network resource.
        assert(!kIsWeb);

        final imageFile = File(pickedFile.path);
        assert(null != imageFile);
        onImageSelected(imageFile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: bottomSheetPadding,
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: cameraIcon,
            title: cameraLabel,
            onTap: () => _onPickImage(ImageSource.camera),
          ),
          ListTile(
            leading: galleryIcon,
            title: galleryLabel,
            onTap: () => _onPickImage(ImageSource.gallery),
          )
        ],
      ),
    );
  }
}
