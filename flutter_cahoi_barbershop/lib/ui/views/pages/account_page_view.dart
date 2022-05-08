import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({Key? key}) : super(key: key);

  @override
  _AccountPageViewState createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  Size size = Size.zero;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          _buildTileSetting(
            icon: Container(),
            title: 'Đăng xuất',
            onPress: () async {
              var res = await locator<AuthenticationService>().logOut();
              if (res) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'login',
                  (route) => false,
                );

                return;
              }

              Fluttertoast.showToast(msg: "Error!");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTileSetting({
    required Widget icon,
    required String title,
    required Function() onPress,
  }) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        height: size.height * 0.1,
        width: size.width,
        child: Row(
          children: [
            const Icon(
              Icons.person,
              color: Colors.black,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
