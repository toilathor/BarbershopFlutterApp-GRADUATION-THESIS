import 'package:flutter/material.dart';

class PlayClipView extends StatefulWidget {
  final String id;

  const PlayClipView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PlayClipViewState createState() => _PlayClipViewState();
}

class _PlayClipViewState extends State<PlayClipView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
