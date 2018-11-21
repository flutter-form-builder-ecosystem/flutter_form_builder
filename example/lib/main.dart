import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter FormBuilder Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(),
    );
  }
}

class AppProfile {
  final String name;
  final String email;
  final String imageUrl;

  const AppProfile(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppProfile &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const mockResults = <AppProfile>[
      AppProfile('Stock Man', 'stock@man.com',
          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
      AppProfile('Paul', 'paul@google.com',
          'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
      AppProfile('Fred', 'fred@google.com',
          'https://media.istockphoto.com/photos/feeling-great-about-my-corporate-choices-picture-id507296326'),
      AppProfile('Bera', 'bera@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('John', 'john@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Thomas', 'thomas@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Norbert', 'norbert@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Marina', 'marina@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter FormBuilder Example'),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: FormBuilder(
          context,
          autovalidate: true,
          showResetButton: true,
          // resetButtonContent: Text("Clear Form"),
          controls: [
            FormBuilderInput.chipsInput(
              label: 'Chips',
              attribute: 'chips_test',
              require: true,
              value: [AppProfile('Stock Man', 'stock@man.com',
                  'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg')],
              suggestionsCallback: (String query) {
                if (query.length != 0) {
                  return mockResults.where((profile) {
                    return profile.name.contains(query) ||
                        profile.email.contains(query);
                  }).toList(growable: false);
                } else {
                  return const <AppProfile>[];
                }
              },
              chipBuilder: (context, state, profile) {
                return InputChip(
                  key: ObjectKey(profile),
                  label: Text(profile.name),
                  avatar: CircleAvatar(
                    backgroundImage: NetworkImage(profile.imageUrl),
                  ),
                  onDeleted: () => state.deleteChip(profile),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              },
              suggestionBuilder: (context, state, profile) {
                return ListTile(
                  key: ObjectKey(profile),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(profile.imageUrl),
                  ),
                  title: Text(profile.name),
                  subtitle: Text(profile.email),
                  onTap: () => state.selectSuggestion(profile),
                );
              },
            ),
            FormBuilderInput.textField(
              type: FormBuilderInput.TYPE_TEXT,
              attribute: "name",
              label: "Name",
              require: true,
              min: 3,
            ),
            FormBuilderInput.dropdown(
              attribute: "dropdown",
              require: true,
              label: "Dropdown",
              hint: "Select Option",
              options: [
                FormBuilderInputOption(value: "Option 1"),
                FormBuilderInputOption(value: "Option 2"),
                FormBuilderInputOption(value: "Option 3"),
              ],
            ),
            FormBuilderInput.number(
              attribute: "age",
              label: "Age",
              require: true,
              min: 18,
            ),
            FormBuilderInput.textField(
              type: FormBuilderInput.TYPE_EMAIL,
              attribute: "email",
              label: "Email",
              require: true,
            ),
            FormBuilderInput.textField(
              type: FormBuilderInput.TYPE_URL,
              attribute: "url",
              label: "URL",
              require: true,
            ),
            FormBuilderInput.textField(
                type: FormBuilderInput.TYPE_PHONE,
                attribute: "phone",
                label: "Phone",
                hint: "Including country code (+254)"
                //require: true,
                ),
            FormBuilderInput.password(
              attribute: "password",
              label: "Password",
              //require: true,
            ),
            FormBuilderInput.datePicker(
              label: "Date of Birth",
              attribute: "dob",
            ),
            FormBuilderInput.timePicker(
              label: "Appointment Time",
              attribute: "time",
            ),
            FormBuilderInput.checkboxList(
              label: "The Languages of my people",
              hint: "The Languages of my people",
              attribute: "languages",
              require: false,
              value: ["Dart"],
              options: [
                FormBuilderInputOption(value: "Dart"),
                FormBuilderInputOption(value: "Kotlin"),
                FormBuilderInputOption(value: "Java"),
                FormBuilderInputOption(value: "Swift"),
                FormBuilderInputOption(value: "Objective-C"),
              ],
            ),
            FormBuilderInput.radio(
              label: "My Best Language",
              attribute: "best_language",
              require: true,
              options: [
                FormBuilderInputOption(value: "Dart"),
                FormBuilderInputOption(value: "Kotlin"),
                FormBuilderInputOption(value: "Java"),
                FormBuilderInputOption(value: "Swift"),
                FormBuilderInputOption(value: "Objective-C"),
              ],
            ),
            /*FormBuilderInput.checkbox(
                label: "I accept the terms and conditions",
                attribute: "accept_terms",
                hint:
                    "Kindly make sure you've read all the terms and conditions",
                validator: (value) {
                  if (!value) return "Accept terms to continue";
                }),
            FormBuilderInput.switchInput(
                label: "I accept the terms and conditions",
                attribute: "accept_terms_switch",
                hint:
                    "Kindly make sure you've read all the terms and conditions",
                validator: (value) {
                  if (!value) return "Accept terms to continue";
                }),
            FormBuilderInput.slider(
              label: "Slider",
              attribute: "slider",
              hint: "Hint",
              min: 0.0,
              require: true,
              max: 100.0,
              value: 10.0,
              divisions: 20,
            ),
            FormBuilderInput.stepper(
              label: "Stepper",
              attribute: "stepper",
              value: 10,
              step: 1,
              hint: "Hint",
            ),
            FormBuilderInput.rate(
              label: "Rate",
              attribute: "rate",
              iconSize: 32.0,
              value: 1,
              max: 5,
              hint: "Hint",
            ),
            FormBuilderInput.segmentedControl(
              label: "Movie Rating (Archer)",
              attribute: "movie_rating",
              require: true,
              options: [
                FormBuilderInputOption(
                  value: 1,
                ),
                FormBuilderInputOption(
                  value: 2,
                ),
                FormBuilderInputOption(
                  value: 3,
                ),
                FormBuilderInputOption(
                  value: 4,
                ),
                FormBuilderInputOption(
                  value: 5,
                ),
                FormBuilderInputOption(
                  value: 6,
                ),
                FormBuilderInputOption(
                  value: 7,
                ),
                FormBuilderInputOption(
                  value: 8,
                ),
                FormBuilderInputOption(
                  value: 9,
                ),
                FormBuilderInputOption(
                  value: 10,
                ),
              ],
            ),*/
          ],
          onChanged: () {
            print("Form value changed");
          },
          onSubmit: (formValue) {
            if (formValue != null) {
              print(formValue);
            } else {
              print("Form invalid");
            }
          },
        ),
      ),
    );
  }
}
