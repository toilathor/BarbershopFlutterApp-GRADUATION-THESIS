import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/widgets/listview_clip.dart';

class PlaylistYoutube extends StatefulWidget {
  const PlaylistYoutube({Key? key}) : super(key: key);

  @override
  _PlaylistYoutubeState createState() => _PlaylistYoutubeState();
}

class _PlaylistYoutubeState extends State<PlaylistYoutube> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomePageModel>(
      onModelReady: (model) async {
        await model.changeClipIdList();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: CupertinoNavigationBarBackButton(
            color: Theme.of(context).backgroundColor,
          ),
          title: const Text('Youtube Channel'),
        ),
        body: ListviewClip(clipList: model.clipInfoList),
      ),
    );
  }
}
