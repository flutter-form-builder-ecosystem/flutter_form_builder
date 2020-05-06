import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/image_source_sheet.dart';

class FormBuilderImagePicker extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final List initialValue;
  final bool readOnly;
  final ValueTransformer valueTransformer;
  final ValueChanged onChanged;
  final InputDecoration decoration;

  final double imageWidth;
  final double imageHeight;
  final EdgeInsets imageMargin;
  final FormFieldSetter onSaved;

  FormBuilderImagePicker({
    Key key,
    @required this.attribute,
    this.initialValue,
    this.validators = const [],
    this.valueTransformer,
    this.onChanged,
    this.imageWidth = 130,
    this.imageHeight = 130,
    this.imageMargin,
    this.readOnly = false,
    this.onSaved,
    this.decoration = const InputDecoration(),
  }) : super(
          key: key,
          initialValue: initialValue ?? [],
          attribute: attribute,
          validators: validators,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderImagePickerState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: field.errorText,
              ),
              child: Container(
                height: imageHeight,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: (state.value ?? []).map<Widget>((item) {
                    return Container(
                      width: imageWidth,
                      height: imageHeight,
                      margin: imageMargin,
                      child: GestureDetector(
                        child: item is String
                            ? Image.network(item, fit: BoxFit.cover)
                            : Image.file(item, fit: BoxFit.cover),
                        onLongPress: state.readOnly
                            ? null
                            : () {
                                state.didChange(state.value..remove(item));
                              },
                      ),
                    );
                  }).toList()
                    ..add(
                      GestureDetector(
                        child: Container(
                            width: imageWidth,
                            height: imageHeight,
                            child: Icon(Icons.camera_enhance,
                                color: state.readOnly
                                    ? Theme.of(state.context).disabledColor
                                    : Theme.of(state.context).primaryColor),
                            color: (state.readOnly
                                    ? Theme.of(state.context).disabledColor
                                    : Theme.of(state.context).primaryColor)
                                .withAlpha(50)),
                        onTap: state.readOnly
                            ? null
                            : () {
                                showModalBottomSheet(
                                  context: state.context,
                                  builder: (_) {
                                    return ImageSourceSheet(
                                      onImageSelected: (image) {
                                        if (image != null) {
                                          state.didChange(
                                              [...(state.value ?? []), image]);
                                        }
                                        Navigator.of(state.context).pop();
                                      },
                                    );
                                  },
                                );
                              },
                      ),
                    ),
                ),
              ),
            );
          },
        );

  @override
  _FormBuilderImagePickerState createState() => _FormBuilderImagePickerState();
}

class _FormBuilderImagePickerState extends FormBuilderFieldState {
  FormBuilderImagePicker get widget => super.widget;
}
