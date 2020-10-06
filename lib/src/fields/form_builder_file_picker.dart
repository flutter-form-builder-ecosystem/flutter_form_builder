import 'dart:async';
import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:permission_handler/permission_handler.dart';

class FormBuilderFilePicker extends FormBuilderField<List<PlatformFile>> {
  /// Maximum number of files needed for this field
  final int maxFiles;

  /// Allows picking of multiple files
  final bool allowMultiple;

  /// If set to true, a thumbnail of image files will be shown; else the default
  /// icon will be displayed depending on file type
  final bool previewImages;

  /// Widget to be tapped on by user in order to pick files
  final Widget selector;

  /// Default types of files to be picked. Default set to [FileType.any]
  final FileType type;

  /// Allowed file extensions for files to be selected
  final List<String> allowedExtensions;

  /// If you want to track picking status, for example, because some files may take some time to be
  /// cached (particularly those picked from cloud providers), you may want to set [onFileLoading] handler
  /// that will give you the current status of picking.
  final Function(FilePickerStatus) onFileLoading;

  /// Whether to allow file compression
  final bool allowCompression;

  /// If [withData] is set, picked files will have its byte data immediately available on memory as [Uint8List]
  /// which can be useful if you are picking it for server upload or similar.
  final bool withData;

  FormBuilderFilePicker({
    //From Super
    Key key,
    @required String name,
    FormFieldValidator validator,
    List<PlatformFile> initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
    this.maxFiles,
    this.withData = false,
    this.allowMultiple = true,
    this.previewImages = true,
    this.selector = const Icon(Icons.add_circle),
    this.type = FileType.any,
    this.allowedExtensions,
    this.onFileLoading,
    this.allowCompression,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState field) {
            final _FormBuilderFilePickerState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (maxFiles != null)
                        Text('${state._files.length}/${maxFiles}'),
                      InkWell(
                        child: selector,
                        onTap: (state.readOnly ||
                                (state._remainingItemCount != null &&
                                    state._remainingItemCount <= 0))
                            ? null
                            : () => state.pickFiles(field),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  state.defaultFileViewer(state._files, field),
                ],
              ),
            );
          },
        );

  @override
  _FormBuilderFilePickerState createState() => _FormBuilderFilePickerState();
}

class _FormBuilderFilePickerState
    extends FormBuilderFieldState<List<PlatformFile>> {
  List<PlatformFile> _files;

  int get _remainingItemCount =>
      widget.maxFiles == null ? null : widget.maxFiles - _files.length;

  @override
  void initState() {
    _files = widget.initialValue ?? [];
    super.initState();
  }

  @override
  FormBuilderFilePicker get widget => super.widget as FormBuilderFilePicker;

  Future<void> pickFiles(FormFieldState field) async {
    FilePickerResult resultList;

    try {
      if (await Permission.storage.request().isGranted) {
        resultList = await FilePicker.platform.pickFiles(
          type: widget.type,
          allowedExtensions: widget.allowedExtensions,
          allowCompression: widget.allowCompression,
          onFileLoading: widget.onFileLoading,
          allowMultiple: widget.allowMultiple,
          withData: widget.withData,
        );
      } else {
        throw Exception('Storage Permission not granted');
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (resultList != null) {
      setState(() => _files.addAll(resultList.files));
      // TODO: Pick only remaining number
      field.didChange(_files);
      widget.onChanged?.call(_files);
    }
  }

  void removeFileAtIndex(int index, FormFieldState field) {
    setState(() {
      _files.removeAt(index);
    });
    field.didChange(_files);
    if (widget.onChanged != null) widget.onChanged(_files);
  }

  Widget defaultFileViewer(List<PlatformFile> files, FormFieldState field) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        var count = 3;
        var spacing = 10;
        var itemSize = (constraints.biggest.width - (count * spacing)) / count;
        return Wrap(
          // scrollDirection: Axis.horizontal,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          runSpacing: 10,
          spacing: 10,
          children: List.generate(
            files.length,
            (index) {
              return Container(
                height: itemSize,
                width: itemSize,
                margin: EdgeInsets.only(right: 2),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: (['jpg', 'jpeg', 'png'].contains(
                                  files[index].extension.toLowerCase()) &&
                              widget.previewImages)
                          ? Image.file(File(files[index].path),
                              fit: BoxFit.cover)
                          : Container(
                              alignment: Alignment.center,
                              child: Icon(
                                getIconData(files[index].extension),
                                color: Colors.white,
                                size: 56,
                              ),
                              color: theme.primaryColor,
                            ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        '${files[index].name}',
                        style: theme.textTheme.caption,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                      color: Colors.white.withOpacity(.8),
                    ),
                    if (!readOnly)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () => removeFileAtIndex(index, field),
                          child: Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.7),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            height: 22,
                            width: 22,
                            child: Icon(Icons.close,
                                size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  IconData getIconData(String fileExtension) {
    switch (fileExtension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Icons.image;
      case 'xls':
      case 'xlsx':
        return CommunityMaterialIcons.file_excel;
      case 'doc':
      case 'docx':
        return CommunityMaterialIcons.file_word;
      case 'pdf':
        return CommunityMaterialIcons.file_pdf;
      case 'txt':
      case 'log':
        return CommunityMaterialIcons.script_text;
      default:
        return Icons.insert_drive_file;
    }
  }
}
