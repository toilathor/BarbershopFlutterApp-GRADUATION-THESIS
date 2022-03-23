import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/providers/playlist_youtube_provider.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/widgets/listview_clip.dart';
import 'package:provider/provider.dart';

class PlaylistYoutube extends StatefulWidget {
  const PlaylistYoutube({Key? key}) : super(key: key);

  @override
  _PlaylistYoutubeState createState() => _PlaylistYoutubeState();
}

class _PlaylistYoutubeState extends State<PlaylistYoutube> {
  final model = locator<PlaylistYoutubeProvider>();

  @override
  void initState() {
    model.changeClipIdList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlaylistYoutubeProvider>(
      create: (context) => model,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: CupertinoNavigationBarBackButton(
            color: Theme.of(context).backgroundColor,
          ),
          title: const Text('Youtube Channel'),
        ),
        body: Consumer<PlaylistYoutubeProvider>(
          builder: (context, value, child) =>
              ListviewClip(clipList: model.clipInfoList),
        ),
      ),
    );
  }
}
