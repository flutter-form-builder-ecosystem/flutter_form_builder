import 'package:example/code_page.dart';
import 'package:example/sources/signup_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sources/complete_form.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form Builder'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Complete Form'),
            trailing: const Icon(CupertinoIcons.right_chevron),
            onTap: () {
              return Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CodePage(
                      title: 'Complete Form',
                      child: CompleteForm(),
                      sourceFilePath: 'lib/sources/complete_form.dart',
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
              return Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CodePage(
                      title: 'Signup Form',
                      child: SignupForm(),
                      sourceFilePath: 'lib/sources/signup_form.dart',
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
