import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class CompleteForm extends StatefulWidget {
  const CompleteForm({Key? key}) : super(key: key);

  @override
  State<CompleteForm> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<CompleteForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _ageHasError = false;
  bool _genderHasError = false;

  var genderOptions = ['Male', 'Female', 'Other'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    InfoModalConfig config = InfoModalConfig(
      leadingIcon: const Icon(
        Icons.post_add_outlined,
        size: 40,
      ),
      description: const Opacity(
        opacity: 0.79,
        child: Text(
          'Don\'t know the skill? It\'s okay, we will teach you market-style skills too. and you can earn up to 5000 - 6000 per month.',
          style: TextStyle(
            color: Color(0xFF003B67),
            fontSize: 14,
            fontFamily: 'PP Pangram Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.30, color: Color(0x1915749D)),
        borderRadius: BorderRadius.circular(13),
      ),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x00FAF9F9), Color(0xFF94B8D2)],
      ),
    );
    InfoModalConfig config2 = InfoModalConfig(
      leadingIcon: const Icon(
        Icons.post_add_outlined,
        size: 40,
      ),
      description: const Opacity(
        opacity: 0.79,
        child: Text(
          'Don\'t know the skill? It\'s okay, we will teach you market-style skills too. ',
          style: TextStyle(
            color: Color(0xFF003B67),
            fontSize: 14,
            fontFamily: 'PP Pangram Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.30, color: Color(0x1915749D)),
        borderRadius: BorderRadius.circular(13),
      ),
      gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x00EB467A), Color(0xFFFF976E)]),
    );
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
            initialValue: const {
              'movie_rating': 5,
              'best_language': 'Dart',
              'age': '13',
              'gender': 'Male',
              'languages_filter': ['Dart'],
              'languages_choice': '5000 - 6000',
            },
            skipDisabled: true,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'text_field',
                  decoration: const InputDecoration(
                    //labelText: 'Text Field',
                    hintText: 'Hint Text',
                    filled: true,
                  ),
                  onChanged: _onChanged,
                  // valueTransformer: (text) => num.tryParse(text),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  minLines: 1,
                  maxLines: null,
                ),
                FormBuilderDateTimePicker(
                  name: 'date',
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialValue: DateTime.now(),
                  inputType: InputType.both,
                  decoration: InputDecoration(
                    labelText: 'Appointment Time',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['date']?.didChange(null);
                      },
                    ),
                  ),
                  initialTime: const TimeOfDay(hour: 8, minute: 0),
                  // locale: const Locale.fromSubtags(languageCode: 'fr'),
                ),
                FormBuilderDateRangePicker(
                  name: 'date_range',
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2030),
                  format: DateFormat('yyyy-MM-dd'),
                  onChanged: _onChanged,
                  decoration: InputDecoration(
                    labelText: 'Date Range',
                    helperText: 'Helper text',
                    hintText: 'Hint text',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['date_range']
                            ?.didChange(null);
                      },
                    ),
                  ),
                ),
                FormBuilderSlider(
                  name: 'slider',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.min(6),
                  ]),
                  onChanged: _onChanged,
                  min: 0.0,
                  max: 10.0,
                  initialValue: 7.0,
                  divisions: 20,
                  activeColor: Colors.red,
                  inactiveColor: Colors.pink[100],
                  decoration: const InputDecoration(
                    labelText: 'Number of things',
                  ),
                ),
                FormBuilderRangeSlider(
                  name: 'range_slider',
                  onChanged: _onChanged,
                  min: 0.0,
                  max: 100.0,
                  initialValue: const RangeValues(4, 7),
                  divisions: 20,
                  maxValueWidget: (max) => TextButton(
                    onPressed: () {
                      _formKey.currentState?.patchValue(
                        {'range_slider': const RangeValues(4, 100)},
                      );
                    },
                    child: Text(max),
                  ),
                  activeColor: Colors.red,
                  inactiveColor: Colors.pink[100],
                  decoration: const InputDecoration(labelText: 'Price Range'),
                ),
                FormBuilderCheckbox(
                  name: 'accept_terms',
                  initialValue: false,
                  onChanged: _onChanged,
                  title: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'I have read and agree to the ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: TextStyle(color: Colors.blue),
                          // Flutter doesn't allow a button inside a button
                          // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
                          /*
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('launch url');
                            },
                          */
                        ),
                      ],
                    ),
                  ),
                  validator: FormBuilderValidators.equal(
                    true,
                    errorText:
                        'You must accept terms and conditions to continue',
                  ),
                ),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'age',
                  decoration: InputDecoration(
                    labelText: 'Age',
                    suffixIcon: _ageHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _ageHasError =
                          !(_formKey.currentState?.fields['age']?.validate() ??
                              false);
                    });
                  },
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(70),
                  ]),
                  // initialValue: '12',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                FormBuilderDropdown<String>(
                  name: 'gender',
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    suffix: _genderHasError
                        ? const Icon(Icons.error)
                        : const Icon(Icons.check),
                    hintText: 'Select Gender',
                  ),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  items: genderOptions
                      .map((gender) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _genderHasError = !(_formKey
                              .currentState?.fields['gender']
                              ?.validate() ??
                          false);
                    });
                  },
                  valueTransformer: (val) => val?.toString(),
                ),
                FormBuilderRadioGroup<String>(
                  decoration: const InputDecoration(
                    labelText: 'My chosen language',
                  ),
                  initialValue: null,
                  name: 'best_language',
                  onChanged: _onChanged,
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                      .map((lang) => FormBuilderFieldOption(
                            value: lang,
                            child: Text(lang),
                          ))
                      .toList(growable: false),
                  controlAffinity: ControlAffinity.trailing,
                ),
                FormBuilderSwitch(
                  title: const Text('I Accept the terms and conditions'),
                  name: 'accept_terms_switch',
                  initialValue: true,
                  onChanged: _onChanged,
                ),
                FormBuilderCheckboxGroup<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: 'The language of my people'),
                  name: 'languages',
                  // initialValue: const ['Dart'],
                  options: const [
                    FormBuilderFieldOption(value: 'Dart'),
                    FormBuilderFieldOption(value: 'Kotlin'),
                    FormBuilderFieldOption(value: 'Java'),
                    FormBuilderFieldOption(value: 'Swift'),
                    FormBuilderFieldOption(value: 'Objective-C'),
                  ],
                  onChanged: _onChanged,
                  separator: const VerticalDivider(
                    width: 10,
                    thickness: 5,
                    color: Colors.red,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.minLength(1),
                    FormBuilderValidators.maxLength(3),
                  ]),
                ),
                FormBuilderFilterChip<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: 'The language of my people'),
                  name: 'languages_filter',
                  selectedColor: Colors.red,
                  options: const [
                    FormBuilderChipOption(
                      value: 'Dart',
                      avatar: CircleAvatar(child: Text('D')),
                    ),
                    FormBuilderChipOption(
                      value: 'Kotlin',
                      avatar: CircleAvatar(child: Text('K')),
                    ),
                    FormBuilderChipOption(
                      value: 'Java',
                      avatar: CircleAvatar(child: Text('J')),
                    ),
                    FormBuilderChipOption(
                      value: 'Swift',
                      avatar: CircleAvatar(child: Text('S')),
                    ),
                    FormBuilderChipOption(
                      value: 'Objective-C',
                      avatar: CircleAvatar(child: Text('O')),
                    ),
                  ],
                  onChanged: _onChanged,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.minLength(1),
                    FormBuilderValidators.maxLength(3),
                  ]),
                ),
                Builder(builder: (context) {
                  return AlippoSelectionCardGroups<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'languages_choice',
                    // initialValue: 'Java',
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 20, left: 50),
                    expanded: true,
                    spacing: 20,
                    selectedLabelStyle: const TextStyle(
                      color: Color(0xFFFAF9F9),
                      fontSize: 18,
                      fontFamily: 'PP Pangram Sans Rounded',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.36,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      color: Color(0xFF1A4F76),
                      fontSize: 18,
                      fontFamily: 'PP Pangram Sans Rounded',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.36,
                    ),
                    selectedCardColor: const Color(0xFF1A4F76),
                    defaultCardColor: const Color(0xFFFAF9F9),
                    selectedShape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: Colors.black.withOpacity(0.36000001430511475),
                      ),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    unselectedShape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: Colors.black.withOpacity(0.07000000029802322),
                      ),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    options: [
                      SelectionCardOption(
                        value: '5000 - 6000',
                        avatar: const Icon(Icons.monetization_on_outlined),
                        infoModalConfig: config,
                      ),
                      SelectionCardOption(
                        value: 'Kotlin',
                        avatar: const Icon(Icons.monetization_on_outlined),
                        infoModalConfig: config2,
                      ),
                      SelectionCardOption(
                        value: 'Java',
                        avatar: const Icon(Icons.monetization_on_outlined),
                        infoModalConfig: config,
                      ),
                      SelectionCardOption(
                        value: 'Swift',
                        avatar: const Icon(Icons.monetization_on_outlined),
                        infoModalConfig: config2,
                      ),
                      SelectionCardOption(
                        value: 'Objective-C',
                        avatar: const Icon(Icons.monetization_on_outlined),
                        infoModalConfig: config,
                      ),
                    ],
                    onChanged: _onChanged,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(1),
                    ]),
                  );
                }),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      debugPrint(_formKey.currentState?.value.toString());
                    } else {
                      debugPrint(_formKey.currentState?.value.toString());
                      debugPrint('validation failed');
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                  },
                  // color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    'Reset',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
