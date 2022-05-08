import 'package:flutter/material.dart';

class TextRegex extends StatefulWidget {
  final String title;
  final bool validated;

  const TextRegex({
    Key? key,
    required this.title,
    this.validated = false,
  }) : super(key: key);

  @override
  _TextRegexState createState() => _TextRegexState();
}

class _TextRegexState extends State<TextRegex> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
        color: widget.validated ? Colors.green : Colors.red,
        fontFamily: Theme.of(context).textTheme.subtitle2?.fontFamily,
        fontSize: Theme.of(context).textTheme.subtitle2?.fontSize,
      ),
    );
  }
}
