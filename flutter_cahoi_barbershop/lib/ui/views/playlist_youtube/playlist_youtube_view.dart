import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/playlist_youtube_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/widgets/listview_clip.dart';
import 'package:provider/provider.dart';

class PlaylistYoutube extends StatefulWidget {
  const PlaylistYoutube({Key? key}) : super(key: key);

  @override
  _PlaylistYoutubeState createState() => _PlaylistYoutubeState();
}

class _PlaylistYoutubeState extends State<PlaylistYoutube> {
  final model = locator<PlaylistYoutubeModel>();

  @override
  void initState() {
    model.changeClipIdList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlaylistYoutubeModel>(
      create: (context) => model,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: CupertinoNavigationBarBackButton(
            color: Theme.of(context).backgroundColor,
          ),
          title: const Text('Youtube Channel'),
        ),
        body: Consumer<PlaylistYoutubeModel>(
          builder: (context, value, child) =>
              ListviewClip(clipList: model.clipInfoList),
        ),
      ),
    );
  }
}
