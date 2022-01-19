import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:date_format/date_format.dart' as date_format;
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/play_clip_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/playlist_youtube_view.dart';
import 'package:provider/provider.dart';

class ChanelYouTube extends StatefulWidget {
  const ChanelYouTube({Key? key}) : super(key: key);

  @override
  _ChanelYouTubeState createState() => _ChanelYouTubeState();
}

class _ChanelYouTubeState extends State<ChanelYouTube> {
  final model = locator<HomePageModel>();

  @override
  void initState() {
    model.changeClipIdList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<HomePageModel>(
      create: (context) => model,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("CAHOI Barbershop",
                  style: Theme.of(context).textTheme.headline3),
              TextButton(
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PlaylistYoutube(),
                    ));
                  },
                  child: Text("More >",
                      style: Theme.of(context).textTheme.headline3)),
            ],
          ),
          Consumer<HomePageModel>(
            builder: (context, value, child) => SizedBox(
              width: size.width,
              height: size.height * 0.32,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: model.clipInfoList.length > 5
                    ? 5
                    : model.clipInfoList.length,
                itemBuilder: (context, index) {
                  return _buildItemChanelYoutube(
                      size, model.clipInfoList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemChanelYoutube(Size size, ItemYoutube item) {
    final width = size.width * 0.8;
    final heightImage = width * 9 / 16;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlayClipView(id: item.id),
          ),
        );
      },
      child: Card(
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                item.linkImage,
                width: width,
                height: heightImage - 12,
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            Positioned(
              top: heightImage - 12,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  child: Column(
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        style: const TextStyle(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Divider(color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${item.viewCount} views'),
                          Text(
                            date_format.formatDate(
                                DateTime.tryParse(item.publishedAt) ??
                                    timeStart,
                                fullFormatDatetime),
                          ),
                        ],
                      )
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
