import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'full_name',
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  key: _emailFieldKey,
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.email(context),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 6),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'confirm_password',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: ((_formKey.currentState
                                ?.fields['confirm_password']?.hasError ??
                            false))
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    /*FormBuilderValidators.equal(
                        context,
                        _formKey.currentState != null
                            ? _formKey.currentState.fields['password'].value
                            : null),*/
                    /*(val) {
                      if (val !=
                          _formKey.currentState?.fields['password']?.value) {
                        return 'Passwords do not match';
                      }
                      return null;
                    }*/
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderField<bool>(
                  name: 'test',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.equal(context, true),
                  ]),
                  // initialValue: true,
                  decoration: const InputDecoration(labelText: 'Accept Terms?'),
                  builder: (FormFieldState<bool?> field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        errorText: field.errorText,
                      ),
                      child: SwitchListTile(
                        title: const Text(
                            'I have read and accept the terms of service.'),
                        onChanged: (bool value) {
                          field.didChange(value);
                        },
                        value: field.value ?? false,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      if (true) {
                        // Either invalidate using Form Key
                        _formKey.currentState?.invalidateField(
                            name: 'email', errorText: 'Email already taken.');
                        // OR invalidate using Field Key
                        // _emailFieldKey.currentState?.invalidate('Email already taken.');
                      }

                      debugPrint('Valid');
                    } else {
                      debugPrint('Invalid');
                    }
                    debugPrint(_formKey.currentState?.value.toString());
                  },
                  child: const Text('Signup',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
