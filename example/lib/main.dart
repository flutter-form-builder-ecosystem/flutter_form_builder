import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter FormBuilder Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;

  @override
  Widget build(BuildContext context) {
    const mockResults = <Contact>[
      Contact('Andrew', 'stock@man.com',
          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
      Contact('Paul', 'paul@google.com',
          'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
      Contact('Fred', 'fred@google.com',
          'https://media.istockphoto.com/photos/feeling-great-about-my-corporate-choices-picture-id507296326'),
      Contact('Brian', 'brian@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Contact('John', 'john@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Contact('Thomas', 'thomas@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Contact('Nelly', 'nelly@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Contact('Marie', 'marie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Contact('Charlie', 'charlie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Contact('Diana', 'diana@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Contact('Ernie', 'ernie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Contact('Gina', 'fred@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
    ];

    const allCountries = [
      "Afghanistan",
      "Albania",
      "Algeria",
      "American Samoa",
      "Andorra",
      "Angola",
      "Anguilla",
      "Antarctica",
      "Antigua and Barbuda",
      "Argentina",
      "Armenia",
      "Aruba",
      "Australia",
      "Austria",
      "Azerbaijan",
      "Bahamas",
      "Bahrain",
      "Bangladesh",
      "Barbados",
      "Belarus",
      "Belgium",
      "Belize",
      "Benin",
      "Bermuda",
      "Bhutan",
      "Bolivia",
      "Bosnia and Herzegowina",
      "Botswana",
      "Bouvet Island",
      "Brazil",
      "British Indian Ocean Territory",
      "Brunei Darussalam",
      "Bulgaria",
      "Burkina Faso",
      "Burundi",
      "Cambodia",
      "Cameroon",
      "Canada",
      "Cape Verde",
      "Cayman Islands",
      "Central African Republic",
      "Chad",
      "Chile",
      "China",
      "Christmas Island",
      "Cocos (Keeling) Islands",
      "Colombia",
      "Comoros",
      "Congo",
      "Congo, the Democratic Republic of the",
      "Cook Islands",
      "Costa Rica",
      "Cote d'Ivoire",
      "Croatia (Hrvatska)",
      "Cuba",
      "Cyprus",
      "Czech Republic",
      "Denmark",
      "Djibouti",
      "Dominica",
      "Dominican Republic",
      "East Timor",
      "Ecuador",
      "Egypt",
      "El Salvador",
      "Equatorial Guinea",
      "Eritrea",
      "Estonia",
      "Ethiopia",
      "Falkland Islands (Malvinas)",
      "Faroe Islands",
      "Fiji",
      "Finland",
      "France",
      "France Metropolitan",
      "French Guiana",
      "French Polynesia",
      "French Southern Territories",
      "Gabon",
      "Gambia",
      "Georgia",
      "Germany",
      "Ghana",
      "Gibraltar",
      "Greece",
      "Greenland",
      "Grenada",
      "Guadeloupe",
      "Guam",
      "Guatemala",
      "Guinea",
      "Guinea-Bissau",
      "Guyana",
      "Haiti",
      "Heard and Mc Donald Islands",
      "Holy See (Vatican City State)",
      "Honduras",
      "Hong Kong",
      "Hungary",
      "Iceland",
      "India",
      "Indonesia",
      "Iran (Islamic Republic of)",
      "Iraq",
      "Ireland",
      "Israel",
      "Italy",
      "Jamaica",
      "Japan",
      "Jordan",
      "Kazakhstan",
      "Kenya",
      "Kiribati",
      "Korea, Democratic People's Republic of",
      "Korea, Republic of",
      "Kuwait",
      "Kyrgyzstan",
      "Lao, People's Democratic Republic",
      "Latvia",
      "Lebanon",
      "Lesotho",
      "Liberia",
      "Libyan Arab Jamahiriya",
      "Liechtenstein",
      "Lithuania",
      "Luxembourg",
      "Macau",
      "Macedonia, The Former Yugoslav Republic of",
      "Madagascar",
      "Malawi",
      "Malaysia",
      "Maldives",
      "Mali",
      "Malta",
      "Marshall Islands",
      "Martinique",
      "Mauritania",
      "Mauritius",
      "Mayotte",
      "Mexico",
      "Micronesia, Federated States of",
      "Moldova, Republic of",
      "Monaco",
      "Mongolia",
      "Montserrat",
      "Morocco",
      "Mozambique",
      "Myanmar",
      "Namibia",
      "Nauru",
      "Nepal",
      "Netherlands",
      "Netherlands Antilles",
      "New Caledonia",
      "New Zealand",
      "Nicaragua",
      "Niger",
      "Nigeria",
      "Niue",
      "Norfolk Island",
      "Northern Mariana Islands",
      "Norway",
      "Oman",
      "Pakistan",
      "Palau",
      "Panama",
      "Papua New Guinea",
      "Paraguay",
      "Peru",
      "Philippines",
      "Pitcairn",
      "Poland",
      "Portugal",
      "Puerto Rico",
      "Qatar",
      "Reunion",
      "Romania",
      "Russian Federation",
      "Rwanda",
      "Saint Kitts and Nevis",
      "Saint Lucia",
      "Saint Vincent and the Grenadines",
      "Samoa",
      "San Marino",
      "Sao Tome and Principe",
      "Saudi Arabia",
      "Senegal",
      "Seychelles",
      "Sierra Leone",
      "Singapore",
      "Slovakia (Slovak Republic)",
      "Slovenia",
      "Solomon Islands",
      "Somalia",
      "South Africa",
      "South Georgia and the South Sandwich Islands",
      "Spain",
      "Sri Lanka",
      "St. Helena",
      "St. Pierre and Miquelon",
      "Sudan",
      "Suriname",
      "Svalbard and Jan Mayen Islands",
      "Swaziland",
      "Sweden",
      "Switzerland",
      "Syrian Arab Republic",
      "Taiwan, Province of China",
      "Tajikistan",
      "Tanzania, United Republic of",
      "Thailand",
      "Togo",
      "Tokelau",
      "Tonga",
      "Trinidad and Tobago",
      "Tunisia",
      "Turkey",
      "Turkmenistan",
      "Turks and Caicos Islands",
      "Tuvalu",
      "Uganda",
      "Ukraine",
      "United Arab Emirates",
      "United Kingdom",
      "United States",
      "United States Minor Outlying Islands",
      "Uruguay",
      "Uzbekistan",
      "Vanuatu",
      "Venezuela",
      "Vietnam",
      "Virgin Islands (British)",
      "Virgin Islands (U.S.)",
      "Wallis and Futuna Islands",
      "Western Sahara",
      "Yemen",
      "Yugoslavia",
      "Zambia",
      "Zimbabwe"
    ];
    GlobalKey<FormBuilderState> _fbKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter FormBuilder Example'),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: FormBuilder(
                context,
                key: _fbKey,
                autovalidate: autoValidate,
                readonly: readOnly,
                onChanged: (formValue) {
                  print(formValue);
                },
                controls: [
                  FormBuilderInput.typeAhead(
                    decoration: InputDecoration(labelText: "Country"),
                    attribute: 'country',
                    // require: true,
                    itemBuilder: (context, country) {
                      return ListTile(
                        title: Text(country),
                      );
                    },
                    suggestionsCallback: (query) {
                      if (query.length != 0) {
                        var lowercaseQuery = query.toLowerCase();
                        return allCountries.where((country) {
                          return country.toLowerCase().contains(lowercaseQuery);
                        }).toList(growable: false)
                          ..sort((a, b) => a
                              .toLowerCase()
                              .indexOf(lowercaseQuery)
                              .compareTo(
                                  b.toLowerCase().indexOf(lowercaseQuery)));
                      } else {
                        return allCountries;
                      }
                    },
                  ),
                  FormBuilderInput.chipsInput(
                    decoration: InputDecoration(labelText: "Chils"),
                    attribute: 'chips_test',
                    // require: true,
                    value: [
                      Contact('Andrew', 'stock@man.com',
                          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                    ],
                    suggestionsCallback: (String query) {
                      if (query.length != 0) {
                        var lowercaseQuery = query.toLowerCase();
                        return mockResults.where((profile) {
                          return profile.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase()) ||
                              profile.email
                                  .toLowerCase()
                                  .contains(query.toLowerCase());
                        }).toList(growable: false)
                          ..sort((a, b) => a.name
                              .toLowerCase()
                              .indexOf(lowercaseQuery)
                              .compareTo(b.name
                                  .toLowerCase()
                                  .indexOf(lowercaseQuery)));
                      } else {
                        return const <Contact>[];
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
                      decoration: InputDecoration(labelText: "Full Name"),
                      value: "John Doe",
                      // require: true,
                      // readonly: true,
                      require: true,
                      // readonly: true,
                      min: 3,
                      onChanged: (newVal) {
                        print(newVal);
                        print(_fbKey.currentState
                            .findFieldByAttribute("story")
                            .currentState
                            .value);
                        _fbKey.currentState
                            .findFieldByAttribute("story")
                            .currentState
                            .didChange(newVal);
                      }),
                  FormBuilderInput.dropdown(
                    attribute: "dropdown",
                    // require: true,
                    decoration: InputDecoration(labelText: "Select options"),
                    options: [
                      FormBuilderInputOption(value: "Option 1"),
                      FormBuilderInputOption(value: "Option 2"),
                      FormBuilderInputOption(value: "Option 3"),
                    ],
                  ),
                  FormBuilderInput.number(
                    attribute: "age",
                    decoration: InputDecoration(labelText: "Your Age"),
                    // require: true,
                    // min: 18,
                  ),
                  FormBuilderInput.textField(
                    type: FormBuilderInput.TYPE_MULTILINE_TEXT,
                    attribute: "story",
                    decoration: InputDecoration(labelText: "Story"),
                    value: "Here's my story",
                    require: false,
                    min: 25,
                    maxLines: 10,
                    autovalidate: true,
                  ),
                  FormBuilderInput.textField(
                    type: FormBuilderInput.TYPE_EMAIL,
                    attribute: "email",
                    decoration: InputDecoration(labelText: "Email"),
                    require: true,
                  ),
                  FormBuilderInput.textField(
                    type: FormBuilderInput.TYPE_URL,
                    attribute: "url",
                    decoration: InputDecoration(labelText: "Website"),
                    require: true,
                  ),
                  FormBuilderInput.textField(
                    type: FormBuilderInput.TYPE_PHONE,
                    attribute: "phone",
                    decoration: InputDecoration(labelText: "Phone Number"),
                    //require: true,
                  ),
                  FormBuilderInput.password(
                    attribute: "password",
                    decoration: InputDecoration(labelText: "Password"),
                    min: 8,
                  ),
                  FormBuilderInput.datePicker(
                    decoration: InputDecoration(labelText: "Date of Birth"),
                    readonly: true,
                    attribute: "dob",
                    firstDate: DateTime(1970),
                    value: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 1)),
                    format: 'dd, MM yyyy',
                  ),
                  FormBuilderInput.timePicker(
                    decoration: InputDecoration(labelText: "Alarm Time"),
                    attribute: "alarm",
                    require: true,
                  ),
                  FormBuilderInput.dateTimePicker(
                    decoration: InputDecoration(labelText: "Appointment Time"),
                    attribute: "appointment_time",
                    firstDate: DateTime(1970),
                    lastDate: DateTime.now().add(Duration(days: 1)),
                    // format: 'dd, MM yyyy hh:mm',
                  ),
                  FormBuilderInput.checkboxList(
                    decoration:
                        InputDecoration(labelText: "The language of my people"),
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
                    decoration:
                        InputDecoration(labelText: 'My chosen language'),
                    attribute: "best_language",
                    require: true,
                    options: ["Dart", "Kotlin", "Java", "Swift", "Objective-C"]
                        .map((lang) => FormBuilderInputOption(value: lang))
                        .toList(growable: false),
                  ),
                  FormBuilderInput.checkbox(
                      label: Text('I Accept the tems and conditions'),
                      attribute: "accept_terms",
                      validator: (value) {
                        if (!value) return "Accept terms to continue";
                      }),
                  FormBuilderInput.switchInput(
                      label: Text('I Accept the tems and conditions'),
                      attribute: "accept_terms_switch",
                      value: true,
                      validator: (value) {
                        if (!value) return "Accept terms to continue";
                      }),
                  FormBuilderInput.slider(
                    decoration: InputDecoration(labelText: "Slider"),
                    attribute: "slider",
                    min: 0.0,
                    require: true,
                    max: 100.0,
                    value: 10.0,
                    divisions: 20,
                  ),
                  FormBuilderInput.stepper(
                    decoration: InputDecoration(labelText: "Stepper"),
                    attribute: "stepper",
                    value: 10,
                    step: 1,
                  ),
                  FormBuilderInput.signaturePad(
                    decoration: InputDecoration(labelText: "Stepper"),
                    attribute: "signature",
                    require: true,
                  ),
                  FormBuilderInput.rate(
                    decoration: InputDecoration(labelText: "Rate this form"),
                    attribute: "rate",
                    iconSize: 32.0,
                    value: 1,
                    max: 5,
                  ),
                  FormBuilderInput.segmentedControl(
                    decoration:
                        InputDecoration(labelText: "Movie Rating (Archer)"),
                    attribute: "movie_rating",
                    // value: 2,
                    require: true,
                    options: List.generate(5, (i) => i + 1)
                        .map((number) => FormBuilderInputOption(value: number))
                        .toList(),
                  ),
                ],
              ),
            ),
            MaterialButton(
              child: Text('External submit'),
              onPressed: () {
                _fbKey.currentState.save();
                if (_fbKey.currentState.validate()) {
                  print('validationSucceded');
                  print(_fbKey.currentState.value);
                } else {
                  print("External FormValidation failed");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Contact {
  final String name;
  final String email;
  final String imageUrl;

  const Contact(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}
