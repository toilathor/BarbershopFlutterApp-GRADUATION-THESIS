import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/admin_model/home_admin_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeAdminView extends StatefulWidget {
  const HomeAdminView({Key? key}) : super(key: key);

  @override
  State<HomeAdminView> createState() => _HomeAdminViewState();
}

class _HomeAdminViewState extends State<HomeAdminView> {
  Size size = Size.zero;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final user = locator<AuthenticationService>().user;

    return BaseView<HomeAdminModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(size.width),
                        child: SizedBox(
                          width: size.width * 0.2,
                          child: Image.network(
                            '${user.avatar}',
                          ),
                        ),
                      ),
                      Text(
                        '${user.name}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: headerColor1,
                          fontFamily: fontBold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const ListTile(
                      leading: Icon(Icons.lock),
                      title: Text(
                        'HR',
                      ),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.business_center),
                      title: Text('Business'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.cut),
                      title: Text(
                        'Product',
                      ),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.bar_chart),
                      title: Text(
                        'analysis',
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () async {
                        var res =
                            await locator<AuthenticationService>().logOut();
                        if (res) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                          return;
                        }

                        Fluttertoast.showToast(msg: "Error!");
                      },
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: const Text('Logout'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Container(),
        ),
      ),
    );
  }
}
