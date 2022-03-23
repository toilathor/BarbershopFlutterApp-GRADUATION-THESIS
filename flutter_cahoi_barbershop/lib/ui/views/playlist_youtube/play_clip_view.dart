import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://www.youtube.com/watch?v=${widget.id}',
          javascriptMode: JavascriptMode.unrestricted,
          allowsInlineMediaPlayback: true,
          debuggingEnabled: true,
          zoomEnabled: false,
          gestureNavigationEnabled: true,
          initialMediaPlaybackPolicy:
              AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
