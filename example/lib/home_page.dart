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
        title: Text('Flutter Form Builder'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Complete Form'),
            trailing: Icon(CupertinoIcons.right_chevron),
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
          Divider(),
          ListTile(
            title: Text('Signup Form'),
            trailing: Icon(CupertinoIcons.right_chevron),
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
        ],
      ),
    );
  }
}
