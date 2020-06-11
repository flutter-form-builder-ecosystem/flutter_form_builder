import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  /// Callback when an image is selected.
  ///
  /// **Note**: This will work on web platform whereas [onImageSelected] will not.
  final Function(Image) onImage;

  /// Callback when an image is selected.
  ///
  /// **Warning**: This will _NOT_ work on web platform because [File] is not
  /// available.
  final Function(File) onImageSelected;

  ImageSourceSheet({
    Key key,
    this.onImage,
    this.onImageSelected,
  })  : assert(null != onImage || null != onImageSelected),
        super(key: key);

  Future<void> _onPickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: source);
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
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.camera_enhance),
            title: Text('Camera'),
            onTap: () => _onPickImage(ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: Text('Gallery'),
            onTap: () => _onPickImage(ImageSource.gallery),
          )
        ],
      ),
    );
  }
}
