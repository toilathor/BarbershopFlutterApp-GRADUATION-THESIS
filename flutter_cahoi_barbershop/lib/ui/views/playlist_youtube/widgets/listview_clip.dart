import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/clip_youtube.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/widgets/item_clip_youtube.dart';

class ListviewClip extends StatefulWidget {
  const ListviewClip({
    Key? key,
    required this.clipList,
  }) : super(key: key);

  final List<ClipYouTube> clipList;

  @override
  _ListviewClipState createState() => _ListviewClipState();
}

class _ListviewClipState extends State<ListviewClip> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.clipList.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(4.0),
      itemBuilder: (context, index) =>
          ItemClipYoutube(item: widget.clipList[index]),
    );
  }
}
