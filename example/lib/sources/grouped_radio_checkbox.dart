import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class GroupedRadioCheckbox extends StatefulWidget {
  const GroupedRadioCheckbox({super.key});

  @override
  State<GroupedRadioCheckbox> createState() {
    return _GroupedRadioCheckbox();
  }
}

class _GroupedRadioCheckbox extends State<GroupedRadioCheckbox> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  List<String> genderOptions = <String>['Male', 'Female', 'Other'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FormBuilder(
            key: _formKey,
            // enabled: false,
            onChanged: () {
              _formKey.currentState!.save();
              debugPrint(_formKey.currentState!.value.toString());
            },
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: const <String, dynamic>{
              'movie_rating': 5,
              'best_language': 'Dart',
              'age': '13',
              'gender': 'Male',
              'languages_filter': <String>['Dart']
            },
            skipDisabled: true,
            child: Column(
              children: <Widget>[
                //
                const SizedBox(height: 15),
                FormBuilderRadioGroup<String>(
                  decoration: const InputDecoration(
                    labelText: 'My chosen language',
                  ),
                  initialValue: null,
                  name: 'best_language_horiz',
                  onChanged: _onChanged,
                  separator: const SizedBox(
                    width: 8.0,
                    height: 8.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                  ),
                  validator: FormBuilderValidators.compose(<FormFieldValidator<
                      String>>[FormBuilderValidators.required()]),
                  options:
                      <String>['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                          .map((String lang) => FormBuilderFieldOption<String>(
                                value: lang,
                                child: Text(lang),
                              ))
                          .toList(growable: false),
                  controlAffinity: ControlAffinity.leading,
                  orientation: OptionsOrientation.wrap,
                ),
                //
                const SizedBox(height: 15),
                FormBuilderRadioGroup<String>(
                  decoration: const InputDecoration(
                    labelText: 'My chosen language',
                  ),
                  initialValue: null,
                  name: 'best_language_vert',
                  onChanged: _onChanged,
                  separator: const SizedBox(
                    width: 8.0,
                    height: 8.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                  ),
                  validator: FormBuilderValidators.compose(<FormFieldValidator<
                      String>>[FormBuilderValidators.required()]),
                  options:
                      <String>['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                          .map((String lang) => FormBuilderFieldOption<String>(
                                value: lang,
                                child: Text(lang),
                              ))
                          .toList(growable: false),
                  controlAffinity: ControlAffinity.leading,
                  orientation: OptionsOrientation.vertical,
                ),
                //
                const SizedBox(height: 15),
                FormBuilderCheckboxGroup<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: 'The language of my people'),
                  name: 'languages_horiz',
                  // initialValue: const ['Dart'],
                  options: const <FormBuilderFieldOption<String>>[
                    FormBuilderFieldOption<String>(value: 'Dart'),
                    FormBuilderFieldOption<String>(value: 'Kotlin'),
                    FormBuilderFieldOption<String>(value: 'Java'),
                    FormBuilderFieldOption<String>(value: 'Swift'),
                    FormBuilderFieldOption<String>(value: 'Objective-C'),
                  ],
                  onChanged: _onChanged,
                  separator: const SizedBox(
                    width: 8.0,
                    height: 8.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                  ),
                  validator: FormBuilderValidators
                      .compose(<FormFieldValidator<List<String>>>[
                    FormBuilderValidators.minLength(1),
                    FormBuilderValidators.maxLength(3),
                  ]),
                  orientation: OptionsOrientation.wrap,
                ),
                //
                const SizedBox(height: 15),
                FormBuilderCheckboxGroup<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: 'The language of my people'),
                  name: 'languages_vert',
                  // initialValue: const ['Dart'],
                  options: const <FormBuilderFieldOption<String>>[
                    FormBuilderFieldOption<String>(value: 'Dart'),
                    FormBuilderFieldOption<String>(value: 'Kotlin'),
                    FormBuilderFieldOption<String>(value: 'Java'),
                    FormBuilderFieldOption<String>(value: 'Swift'),
                    FormBuilderFieldOption<String>(value: 'Objective-C'),
                  ],
                  onChanged: _onChanged,
                  separator: const SizedBox(
                    width: 8.0,
                    height: 8.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                  ),
                  validator: FormBuilderValidators
                      .compose(<FormFieldValidator<List<String>>>[
                    FormBuilderValidators.minLength(1),
                    FormBuilderValidators.maxLength(3),
                  ]),
                  orientation: OptionsOrientation.vertical,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
