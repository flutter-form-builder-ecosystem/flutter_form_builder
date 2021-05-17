import 'package:flutter/material.dart';
// import 'package:widget_with_codeview/widget_with_codeview.dart';

class CodePage extends StatefulWidget {
  final String title;
  final Widget child;
  final String sourceFilePath;

  const CodePage({
    Key? key,
    required this.title,
    required this.child,
    required this.sourceFilePath,
  }) : super(key: key);

  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      /*body: WidgetWithCodeView(
        child: widget.child,
        sourceFilePath: widget.sourceFilePath,
        // 1codeLinkPrefix` is optional. When it's specified, two more buttons
        // (open-code-in-browser, copy-code-link) will be added in the code view.
        // codeLinkPrefix: 'https://github.com/danvick/flutter_form_builder/blob/version_4/example/',
      ),*/
      body: widget.child,
    );
  }
}
