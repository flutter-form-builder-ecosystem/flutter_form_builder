import 'package:example/code_page.dart';
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
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CodePage(
                      title: 'Complete Form',
                      child: CompleteForm(),
                      sourceFilePath: 'lib/sources/complete_form.dart',
                    ))),
          ),
          Divider(),
        ],
      ),
    );
  }
}
