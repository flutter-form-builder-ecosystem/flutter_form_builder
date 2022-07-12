import 'sources/custom_fields.dart';
import 'package:example/sources/signup_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'code_page.dart';
import 'sources/complete_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Form Builder')),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Complete Form'),
            trailing: const Icon(CupertinoIcons.right_chevron),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CodePage(
                      title: 'Complete Form',
                      sourceFilePath: 'lib/sources/complete_form.dart',
                      child: CompleteForm(),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Custom Fields'),
            trailing: const Icon(CupertinoIcons.right_chevron),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CodePage(
                      title: 'Custom Fields',
                      sourceFilePath: 'lib/sources/custom_fields.dart',
                      child: CustomFields(),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Signup Form'),
            trailing: const Icon(CupertinoIcons.right_chevron),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CodePage(
                      title: 'Signup Form',
                      sourceFilePath: 'lib/sources/signup_form.dart',
                      child: SignupForm(),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
