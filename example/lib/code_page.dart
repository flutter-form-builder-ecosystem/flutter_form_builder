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
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: widget.child,
    );
  }
}
