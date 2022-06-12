import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
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
              onTap: () {},
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.black12, width: 0.5),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Cơ chế thăng hạng",
                  ),
                  Icon(Icons.navigate_next)
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
      children: const [
        MemberRewardTile(
          title: "Quyền lợi đặt trước lịch",
          subTitle: "Đặt trước 5 ngày",
          icon: "assets/icon/calendar_time.svg",
        ),
        MemberRewardTile(
          title: "Ưu đãi chiết khấu",
          subTitle: "- Chiết khấu ~10% cho Shine Combo và VIP Combo\n"
              "- Chiết khấu 10% dịch vụ hóa chất Uốn/Nhuộm\n"
              "- Chiết khấu lên đến 30% khi mua sản phẩm\n",
          icon: "assets/icon/reward.svg",
        ),
        MemberRewardTile(
          title: "Quyền lợi về phục vụ",
          subTitle:
              "- Được đưa yêu cầu phục vụ riêng khi đặt trước lịch cắt tóc",
          icon: "assets/icon/benefits.svg",
        ),
        MemberRewardTile(
          title: "Ưu đãi bất ngờ",
          subTitle: "- Nhận mã khuyến mại bất ngờ mỗi tháng",
          icon: "assets/icon/birthday.svg",
        ),
        MemberRewardTile(
          title: "Quyền đặt trước Stylist (thợ cắt)",
          subTitle: "- Được book stylist\n"
              "- Xem thông tin tay nghề stylist và luôn được gợi "
              "ý top thợ được khách hàng đánh giá cao nhất",
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
      children: const [
        MemberRewardTile(
          title: "Quyền lợi đặt trước lịch",
          subTitle: "- Đặt trước 6 ngày\n"
              "- Book sát giờ",
          icon: "assets/icon/calendar_time.svg",
        ),
        MemberRewardTile(
          title: "Ưu đãi chiết khấu",
          subTitle: "- Chiết khấu 10% ~ 15% cho Shine Combo và VIP Combo\n"
              " - Chiết khấu 10% dịch vụ hóa chất Uốn/Nhuộm\n"
              "- Chiết khấu lên đến 30% khi mua sản phẩm\n",
          icon: "assets/icon/reward.svg",
        ),
        MemberRewardTile(
          title: "Quyền lợi về phục vụ",
          subTitle: "- Luôn có nhân viên chăm sóc trực tiếp, sẵn sàng hỗ trợ\n"
              "- Được sử dụng các dịch vụ, sản phẩm và phụ kiện dành riêng cho Gold Member tại salon",
          icon: "assets/icon/benefits.svg",
        ),
        MemberRewardTile(
          title: "Quyền lợi sử dụng trước các dịch vụ mới nhất",
          subTitle:
              "- Là 1 trong những người đầu tiên được mời đến trải nghiệm "
              "mỗi khi có sản phẩm/dịch vụ mới ra mắt",
          icon: "assets/icon/birthday.svg",
        ),
        MemberRewardTile(
          title: "Quyền đặt trước Stylist (thợ cắt)",
          subTitle: "- Được book stylist\n"
              "- Xem thông tin tay nghề stylist và luôn được gợi "
              "ý top thợ được khách hàng đánh giá cao nhất",
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
