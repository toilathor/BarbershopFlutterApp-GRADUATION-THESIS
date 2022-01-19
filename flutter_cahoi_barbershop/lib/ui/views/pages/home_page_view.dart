import 'package:date_format/date_format.dart' as date_format;
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/booking_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/play_clip_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/playlist_youtube/playlist_youtube_view.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/avatar.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/slider_image.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final model = locator<HomePageModel>();

  @override
  void initState() {
    model.changeClipIdList();
    model.changeUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<HomePageModel>(
      create: (context) => model,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              //TODO: Wallet
            },
            icon: Icon(
              Icons.notifications_none,
              size: Theme.of(context).iconTheme.size ?? 24,
            ),
            tooltip: 'Wallet',
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: Theme.of(context).iconTheme.size ?? 24,
                ),
                tooltip: 'Wallet',
              ),
            )
          ],
          title: Image.asset(
            "assets/favicon-ngang.png",
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
                height: size.height * 0.255,
                child: _buildHeaderHomeView(size, context)),
            Expanded(
              child: _buildBody(context, size),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderHomeView(Size size, BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SizedBox(
            height: size.height * 0.188,
            width: size.width,
            child: Image.asset("assets/bg_cahoibarbershop.jpg",
                fit: BoxFit.fitWidth,
                color: Colors.black.withOpacity(0.7),
                colorBlendMode: BlendMode.colorBurn),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Avatar(
                height: size.width * 0.18,
                src: "https://bit.ly/3FMV625",
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<HomePageModel>(
                      builder: (context, value, child) => Text(
                        model.user.name,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "No membership class yet",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
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
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingView(),
                        )),
                  ),
                  _buildNaviRoute(
                    context: context,
                    icons: "assets/ic_history.png",
                    title: "History",
                    onTap: () => null,
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
    );
  }

  Widget _buildBody(BuildContext context, Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SliderImage(
            height: size.height * 0.23,
            width: size.width,
            items: model.itemsSlider,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: _buildChanelYoutube(context, size),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: _buildLockBook(context, size),
          )
        ],
      ),
    );
  }

  Widget _buildNaviRoute(
          {required BuildContext context,
          required String icons,
          required String title,
          required Function() onTap}) =>
      GestureDetector(
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
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
        onTap: onTap,
      );

  Widget _buildChanelYoutube(BuildContext context, Size size) {
    return Consumer<HomePageModel>(
      builder: (context, value, child) => Column(
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
          SizedBox(
            width: size.width,
            height: size.height * 0.32,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: model.clipInfoList.length > 5 ? 5 : model.clipInfoList.length,
              itemBuilder: (context, index) {
                return _buildItemChanelYoutube(size, model.clipInfoList[index]);
              },
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

  Widget _buildLockBook(BuildContext context, Size size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("CAHOI Lookbook", style: Theme.of(context).textTheme.headline3),
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
}
