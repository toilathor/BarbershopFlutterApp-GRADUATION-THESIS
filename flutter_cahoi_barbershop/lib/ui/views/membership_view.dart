import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/views/promotion_mechanism_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MembershipView extends StatefulWidget {
  const MembershipView({Key? key}) : super(key: key);

  static String name = "membership";

  @override
  State<MembershipView> createState() => _MembershipViewState();
}

class _MembershipViewState extends State<MembershipView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            appLang(context)!.navi_home_member,
          ),
        ),
        body: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, PromotionMechanismView.name);
              },
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.black12, width: 0.5),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLang(context)!.promotion_mechanism,
                    style: const TextStyle(
                      fontFamily: fontBold,
                    ),
                  ),
                  const Icon(
                    Icons.navigate_next,
                  )
                ],
              ),
            ),
            Container(
              height: 10,
            ),
            TabBar(
              onTap: (value) {},
              labelColor: Colors.black,
              labelStyle: const TextStyle(
                color: Colors.black,
                fontFamily: fontBold,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.grey.shade500,
              ),
              unselectedLabelColor: Colors.grey.shade500,
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  text: "Sliver",
                ),
                Tab(
                  text: "Gold",
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  _TabSliver(),
                  _TabGold(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabSliver extends StatelessWidget {
  const _TabSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MemberRewardTile(
          title: appLang(context)!.title_calendar_time,
          subTitle: appLang(context)!.sub_calendar_time_s,
          icon: "assets/icon/calendar_time.svg",
        ),
        MemberRewardTile(
          title: appLang(context)!.title_reward,
          subTitle: appLang(context)!.sub_reward(10),
          icon: "assets/icon/reward.svg",
        ),
        MemberRewardTile(
          title: appLang(context)!.title_benefits,
          subTitle: appLang(context)!.sub_benefits_s,
          icon: "assets/icon/benefits.svg",
        ),
        MemberRewardTile(
          title: appLang(context)!.title_reward_birthday,
          subTitle: appLang(context)!.sub_reward_birthday,
          icon: "assets/icon/birthday.svg",
        ),
        MemberRewardTile(
          title: appLang(context)!.title_book_stylist,
          subTitle: appLang(context)!.sub_book_stylist,
          icon: "assets/icon/star.svg",
        ),
      ],
    );
  }
}

class _TabGold extends StatelessWidget {
  const _TabGold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MemberRewardTile(
          title: appLang(context)!.title_calendar_time,
          subTitle: appLang(context)!.sub_calendar_time_g,
          icon: "assets/icon/calendar_time.svg",
        ),
        MemberRewardTile(
          title: appLang(context)!.title_reward,
          subTitle: appLang(context)!.sub_reward(15),
          icon: "assets/icon/reward.svg",
        ),
        MemberRewardTile(
          title: appLang(context)!.title_benefits,
          subTitle: appLang(context)!.sub_benefits_g,
          icon: "assets/icon/benefits.svg",
        ),
        MemberRewardTile(
          title: appLang(context)!.title_benefits_new,
          subTitle: appLang(context)!.sub_benefits_new,
          icon: "assets/icon/benefits_new.svg",
        ),
        MemberRewardTile(
          title: appLang(context)!.title_book_stylist,
          subTitle: appLang(context)!.sub_book_stylist,
          icon: "assets/icon/star.svg",
        ),
      ],
    );
  }
}

class MemberRewardTile extends StatelessWidget {
  const MemberRewardTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 20,
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        child: SvgPicture.asset(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: fontBold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          subTitle,
        ),
      ),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black12,
          width: 0.5,
        ),
      ),
    );
  }
}
