import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Demonstrates the use of itemDecorators to wrap a box around selection items
class DecoratedRadioCheckbox extends StatefulWidget {
  const DecoratedRadioCheckbox({Key? key}) : super(key: key);

  @override
  State<DecoratedRadioCheckbox> createState() => _DecoratedRadioCheckboxState();
}

class _DecoratedRadioCheckboxState extends State<DecoratedRadioCheckbox> {
  final _formKey = GlobalKey<FormBuilderState>();
  int? option;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          // this text appears correctly if the textScaler <> 1.0
          const Text(
              'With itemDecoration- label is a column of Widgets - orientation: wrap - wrapSpacing 5.0',
              textScaler: TextScaler.linear(1.01)),
          FormBuilderCheckboxGroup(
            name: 'aCheckboxGroup1',
            options: getDemoOptionsWidgets(),
            wrapSpacing: 5.0,
            itemDecoration: BoxDecoration(
                color: Colors.orange.shade200,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          const SizedBox(height: 20),
          const Text(
              'With itemDecoration - label is a column of Widgets - orientation: wrap - wrapSpacing 5.0',
              textScaler: TextScaler.linear(1.01)),
          FormBuilderCheckboxGroup(
            name: 'aCheckboxGroup2',
            options: getDemoOptionsWidgets(),
            wrapSpacing: 5.0,
            controlAffinity: ControlAffinity.trailing,
            itemDecoration: BoxDecoration(
                color: Colors.amber.shade200,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          const SizedBox(height: 20),
          const Text(
              'With itemDecoration - label is a column of Widgets - orientation: wrap - wrapSpacing 5.0',
              textScaler: TextScaler.linear(1.01)),
          FormBuilderRadioGroup(
            name: 'aRadioGroup1',
            options: getDemoOptionsWidgets(),
            wrapSpacing: 5.0,
            itemDecoration: BoxDecoration(
                color: Colors.green.shade200,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          const SizedBox(height: 20),
          const Text(
              'With itemDecoration - label is the value - orientation: wrap - wrapSpacing 10.0',
              textScaler: TextScaler.linear(1.01)),
          FormBuilderRadioGroup(
            name: 'aRadioGroup2',
            options: getDemoOptions(),
            wrapSpacing: 10.0,
            wrapRunSpacing: 10.0,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.only(left: 20, top: 40),
                labelText: 'hello there',
                icon: const Icon(Icons.access_alarm_outlined),
                fillColor: Colors.red.shade200),
            itemDecoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          const SizedBox(height: 20),
          const Text(
              'No itemDecoration - label is the value - orientation: wrap - wrapSpacing 10.0',
              textScaler: TextScaler.linear(1.01)),
          FormBuilderRadioGroup(
            name: 'aRadioGroup3',
            options: getDemoOptions(),
            wrapSpacing: 10.0,
          ),
          const SizedBox(height: 20),
          const Text(
              'With itemDecoration - orientation: horiz - no border - wrapSpacing 5.0',
              textScaler: TextScaler.linear(1.01)),
          FormBuilderCheckboxGroup(
            name: 'aCheckboxGroup3',
            options: getDemoOptionsWidgets(),
            wrapSpacing: 5.0,
            orientation: OptionsOrientation.horizontal,
            itemDecoration: BoxDecoration(
                color: Colors.grey.shade300,
//                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          const SizedBox(height: 20),
          const Text(
              'With itemDecoration - orientation: vert - with border - wrapSpacing 5.0',
              textScaler: TextScaler.linear(1.01)),
          FormBuilderCheckboxGroup(
            name: 'aCheckboxGroup3',
            options: getDemoOptionsWidgets(),
            wrapSpacing: 5.0,
            orientation: OptionsOrientation.vertical,
            itemDecoration: BoxDecoration(
                color: Colors.red.shade100,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          const SizedBox(height: 20),
          const Text(
              'With itemDecoration - orientation: vert - with border - wrapSpacing 5.0',
              textScaler: TextScaler.linear(1.01)),
          FormBuilderRadioGroup(
            name: 'aRadioGroup4',
            options: getDemoOptionsWidgets(),
            wrapSpacing: 5.0,
            orientation: OptionsOrientation.vertical,
            itemDecoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ],
      ),
    ));
  }

  /// options using column of widgets for the label
  List<FormBuilderFieldOption> getDemoOptionsWidgets() {
    return const [
      FormBuilderFieldOption(
          value: "airplane",
          child: Column(
            children: [Text("Airplane"), Icon(Icons.airplanemode_on)],
          )),
      FormBuilderFieldOption(
          value: "fire-truck",
          child:
              Column(children: [Text("Fire Truck"), Icon(Icons.fire_truck)])),
      FormBuilderFieldOption(
          value: "bus-alert",
          child: Column(children: [Text("Bus Alert"), Icon(Icons.bus_alert)])),
      FormBuilderFieldOption(
          value: "firetruck",
          child:
              Column(children: [Text("Motorcycle"), Icon(Icons.motorcycle)])),
    ];
  }

  /// opens using just values
  List<FormBuilderFieldOption> getDemoOptions() {
    return const [
      FormBuilderFieldOption(
        value: "airplane",
      ),
      FormBuilderFieldOption(
        value: "fire-truck",
      ),
      FormBuilderFieldOption(
        value: "bus-alert",
      ),
      FormBuilderFieldOption(
        value: "firetruck",
      ),
    ];
  }
}
