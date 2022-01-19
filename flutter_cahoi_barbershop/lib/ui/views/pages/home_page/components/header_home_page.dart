import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/booking_view.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/avatar.dart';
import 'package:provider/provider.dart';

class HeaderHomePage extends StatefulWidget {
  const HeaderHomePage({Key? key}) : super(key: key);

  @override
  _HeaderHomePageState createState() => _HeaderHomePageState();
}

class _HeaderHomePageState extends State<HeaderHomePage> {
  final model = locator<HomePageModel>();

  @override
  void initState() {
    model.changeUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<HomePageModel>(
      create: (context) => model,
      child: Stack(
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
}
