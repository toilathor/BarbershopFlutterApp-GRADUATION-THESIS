import 'package:date_format/date_format.dart' as date_format;
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/clip_youtube.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/play_clip_view.dart';

class ItemClipYoutube extends StatefulWidget {
  final ClipYouTube item;

  const ItemClipYoutube({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ItemClipYoutubeState createState() => _ItemClipYoutubeState();
}

class _ItemClipYoutubeState extends State<ItemClipYoutube> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlayClipView(id: widget.item.id),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SizedBox(
          height: size.height * 0.15,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Image.network(
                  widget.item.linkImage,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text('${widget.item.viewCount} views ▶ '
                              '${date_format.formatDate(
                            DateTime.tryParse(widget.item.publishedAt) ??
                                timeStart,
                            fullFormatDatetime,
                          )}'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
