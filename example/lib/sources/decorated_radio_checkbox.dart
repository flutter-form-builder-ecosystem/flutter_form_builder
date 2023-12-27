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
              'label:column of Widgets itemBorder:true orient:wrap wrapSpacing:5.0',
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
              'label:column of Widgets itemBorder:true orient:wrap wrapSpacing:5.0',
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
              'label:column of Widgets itemBorder:true orient:wrap wrapSpacing: 5.0',
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
          const Text('label:value itemBorder:true orient:wrap wrapSpacing:10.0',
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
              'itemDecoration:false label:value orient:wrap wrapSpacing:10.0',
              textScaler: TextScaler.linear(1.01)),
          FormBuilderRadioGroup(
            name: 'aRadioGroup3',
            options: getDemoOptions(),
            wrapSpacing: 10.0,
          ),
          const SizedBox(height: 20),
          const Text('orient:horiz itemBorder:false wrapSpacing:5.0',
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
          const Text('orient:vert itemBorder:true wrapSpacing:5.0',
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
              'label:w/sizebox orient:vert itemBorder:true wrapSpacing:5.0',
              textScaler: TextScaler.linear(1.01)),
          FormBuilderRadioGroup(
            name: 'aRadioGroup4',
            options: getDemoOptionsWidgets(forceMinWidth: 80.0),
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
  /// We can force a min width by creating a sized box so we don't need another parameter
  List<FormBuilderFieldOption> getDemoOptionsWidgets({forceMinWidth = 0.0}) {
    return [
      FormBuilderFieldOption(
        value: "airplane",
        child: Container(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                const Text("Airplane"),
                const Icon(Icons.airplanemode_on),
                SizedBox(width: forceMinWidth, height: 0.0),
              ],
            )),
      ),
      FormBuilderFieldOption(
        value: "fire-truck",
        child: Container(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              const Text("Fire Truck"),
              const Icon(Icons.fire_truck),
              SizedBox(width: forceMinWidth, height: 0.0),
            ])),
      ),
      FormBuilderFieldOption(
        value: "bus-alert",
        child: Container(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              const Text("Bus Alert"),
              const Icon(Icons.bus_alert),
              SizedBox(width: forceMinWidth, height: 0.0),
            ])),
      ),
      FormBuilderFieldOption(
        value: "firetruck",
        child: Container(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              const Text("Motorcycle"),
              const Icon(Icons.motorcycle),
              SizedBox(width: forceMinWidth, height: 0.0),
            ])),
      ),
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
