import 'package:material_ui/material_ui.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SubmitButtonForm extends StatefulWidget {
  const SubmitButtonForm({super.key});

  @override
  State<SubmitButtonForm> createState() => _SubmitButtonFormState();
}

class _SubmitButtonFormState extends State<SubmitButtonForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _canSubmit = false;
  bool _subscribe = false;
  bool _submitted = false;

  void _updateSubmitButton() {
    final formState = _formKey.currentState;
    if (formState == null) return;

    final isSubscribed = formState.instantValue['subscribe'] == true;
    final isValid = formState.validate(focusOnInvalid: false);

    setState(() {
      _canSubmit = isValid;
      _subscribe = isSubscribed;
      _submitted = false;
    });
  }

  String? _validateEmail(String? value) {
    final emailRequired =
        _formKey.currentState?.instantValue['subscribe'] == true;
    final hasEmail = value?.isNotEmpty ?? false;

    if (!emailRequired && !hasEmail) return null;

    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.email(),
    ])(value);
  }

  void _submit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      debugPrint(_formKey.currentState?.value.toString());
      setState(() {
        _submitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: const {'subscribe': false},
        onChanged: _updateSubmitButton,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'name',
              decoration: const InputDecoration(labelText: 'Name'),
              validator: FormBuilderValidators.required(),
            ),
            const SizedBox(height: 10),
            FormBuilderSwitch(
              name: 'subscribe',
              title: const Text('Receive product updates'),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'email',
              enabled: _subscribe,
              decoration: InputDecoration(
                labelText: _subscribe ? 'Email' : 'Email (optional)',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _canSubmit ? _submit : null,
              child: const Text('Submit'),
            ),
            if (_submitted) ...[
              const SizedBox(height: 10),
              Text('Submitted values: ${_formKey.currentState?.value}'),
            ],
          ],
        ),
      ),
    );
  }
}
