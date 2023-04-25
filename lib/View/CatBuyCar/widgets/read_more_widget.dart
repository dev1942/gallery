import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> with TickerProviderStateMixin<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      AnimatedSize(
          // ignore: deprecated_member_use
          vsync: this,
          duration: const Duration(milliseconds: 500),
          child: ConstrainedBox(
              constraints: isExpanded ? const BoxConstraints() : const BoxConstraints(maxHeight: 45.0),
              child: Text(
                widget.text,
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
      isExpanded
          ? ConstrainedBox(constraints: const BoxConstraints())
          : TextButton(child: const Text('Read More'), onPressed: () => setState(() => isExpanded = true))
    ]);
  }
}
