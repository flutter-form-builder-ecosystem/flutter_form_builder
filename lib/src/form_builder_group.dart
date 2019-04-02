import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class FormBuilderGroup extends StatefulWidget {
  final Widget header;
  final bool collapsible;
  final bool initialExpanded;
  final List<Widget> children;

  FormBuilderGroup({
    this.header,
    this.initialExpanded = true,
    this.collapsible = true,
    @required this.children,
  });

  @override
  _FormBuilderGroupState createState() => _FormBuilderGroupState();
}

class _FormBuilderGroupState extends State<FormBuilderGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: ExpandablePanel(
        initialExpanded: widget.initialExpanded,
        header: widget.header,
        tapHeaderToExpand: widget.collapsible,
        hasIcon: widget.collapsible,
        expanded: Column(
          children: widget.children,
        ),
      ),
    );
  }
}
