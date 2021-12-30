import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/booking_view.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/slider_image.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> items = [
    Image.asset(
      "assets/slider_demo/demo1.png",
    ),
    Image.asset(
      "assets/slider_demo/demo2.png",
    ),
    Image.asset(
      "assets/slider_demo/demo3.png",
    ),
    Image.asset(
      "assets/slider_demo/demo4.png",
    ),
    Image.asset(
      "assets/slider_demo/demo5.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
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
          Expanded(
            flex: 4,
            child: _buildHeaderHomeView(size, context),
          ),
          Expanded(
            flex: 9,
            child: _buildBody(context, size),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderHomeView(Size size, BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SizedBox(
            height: 150,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Container(
                  width: 70,
                  height: 70,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Le Quang Tho",
                      style: Theme.of(context).textTheme.headline1,
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
              height: 90,
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
                          builder: (context) => BookingView(),
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
            height: 200,
            width: size.width,
            items: items,
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("CAHOI Barbershop",
                style: Theme.of(context).textTheme.headline3),
            Text("More >", style: Theme.of(context).textTheme.headline3),
          ],
        ),
        SizedBox(
          width: size.width,
          height: 200,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return _buildItemChanelYoutube(size);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItemChanelYoutube(Size size) {
    return Card(
      child: Container(
        color: Colors.white,
        width: size.width * 0.8,
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
                  color: Colors.white,
                  width: size.width,
                  height: 200,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
