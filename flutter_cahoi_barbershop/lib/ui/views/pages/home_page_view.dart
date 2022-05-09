import 'package:date_format/date_format.dart' as date_format;
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/fake-data/data.dart';
import 'package:flutter_cahoi_barbershop/core/models/clip_youtube.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/play_clip_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/playlist_youtube_view.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/avatar.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/slider_image.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  Size size = Size.zero;
  final user = locator<AuthenticationService>().user;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BaseView<HomePageModel>(
      onModelReady: (model) {
        model.initHomePage();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: textColorLight2,
          leading: IconButton(
            onPressed: () async {},
            icon: Icon(
              Icons.notifications_none,
              size: Theme.of(context).iconTheme.size ?? 24,
            ),
            tooltip: 'Wallet',
          ),
          title: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo_appbar.png",
                  height: 50,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
                const Text('Mr.Cahoi')
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'HostLine',
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          onPressed: () async {
            if (await canLaunch("tel:$hostLine")) {
              await launch("tel:$hostLine");
            }
          },
          tooltip: 'Hotline',
          child: Icon(
            Icons.call,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.255,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      height: size.height * 0.188,
                      width: size.width,
                      child: Image.asset(
                        "assets/bg_cahoibarbershop.jpg",
                        fit: BoxFit.fitWidth,
                        color: Colors.black.withOpacity(0.7),
                        colorBlendMode: BlendMode.colorBurn,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Avatar(
                          height: size.width * 0.18,
                          src: user.avatar ?? "",
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${user.name}",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: fontBold,
                                    color: headerColor1,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "your rank is ${user.rank?.rankName}",
                                  style: const TextStyle(
                                    color: Colors.white54,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Card(
                      child: SizedBox(
                        width: size.width,
                        height: size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildNaviRoute(
                                context: context,
                                icons: "assets/ic_calendar.png",
                                title: "Booking",
                                onTap: () {
                                  Navigator.pushNamed(context, '/booking');
                                }),
                            _buildNaviRoute(
                              context: context,
                              icons: "assets/ic_history.png",
                              title: "History",
                              onTap: () {
                                Navigator.pushNamed(context, '/history');
                              },
                            ),
                            _buildNaviRoute(
                              context: context,
                              icons: "assets/ic_membership.png",
                              title: "Membership",
                              onTap: () => null,
                            ),
                            _buildNaviRoute(
                              context: context,
                              icons: "assets/ic_gift.png",
                              title: "Rewards",
                              onTap: () => null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: ClampingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    SliderImage(
                      height: size.height * 0.23,
                      width: size.width,
                      items: itemsSlider,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "CAHOI TV",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: fontBold,
                                ),
                              ),
                              TextButton(
                                style: const ButtonStyle(
                                    splashFactory: NoSplash.splashFactory),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PlaylistYoutube(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "More >",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: fontBold,
                                    color: Colors.cyan,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
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
                                  model.clipInfoList[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: _buildLockBook(context, size),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockBook(BuildContext context, Size size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "CAHOI Lookbook",
          style: TextStyle(
            fontSize: 16,
            fontFamily: fontBold,
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  width: size.width,
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildNaviRoute({
    required BuildContext context,
    required String icons,
    required String title,
    required Function() onTap,
  }) =>
      Expanded(
        child: GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icons,
                color: Theme.of(context).primaryColor,
                height: 32,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
          onTap: onTap,
        ),
      );

  Widget _buildItemChanelYoutube(ClipYouTube item) {
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
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  child: Column(
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        style: const TextStyle(
                          fontFamily: fontBold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Divider(color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
