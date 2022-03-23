import 'package:flutter/material.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({Key? key}) : super(key: key);

  @override
  _AccountPageViewState createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _buildTileSetting(
            icon: Container(),
            title: 'Cahoi Member',
            onPress: () {},
            context: context),
        const Divider(
          color: Colors.black,
        ),
        _buildTileSetting(
            icon: Container(),
            title: 'Thông tin tài khoản',
            onPress: () {},
            context: context),
        const Divider(
          color: Colors.black,
        ),
        _buildTileSetting(
            icon: Container(),
            title: 'Rewards',
            onPress: () {},
            context: context),
        const Divider(
          color: Colors.black,
        ),
        _buildTileSetting(
            icon: Container(),
            title: 'Lịch sử cắt',
            onPress: () {},
            context: context),
        const Divider(
          color: Colors.black,
        ),
        _buildTileSetting(
            icon: Container(),
            title: 'Đăng xuất',
            onPress: () {},
            context: context),
      ],
    )
        // Center(
        //   child: TextButton(
        //     child: const Text("Logout!"),
        //     onPressed: () {
        //       Navigator.of(context).pushAndRemoveUntil(
        //           MaterialPageRoute(
        //             builder: (context) => const LoginView(),
        //           ),
        //           (route) => false);
        //     },
        //   ),
        // ),
        );
  }

  Widget _buildTileSetting({
    required Container icon,
    required String title,
    required Null Function() onPress,
    required BuildContext context,
  }) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.05,
      child: Row(
        children: [
          const Icon(
            Icons.person,
            color: Colors.black,
          ),
          Text(
            title,
          ),
        ],
      ),
    );
  }
}
