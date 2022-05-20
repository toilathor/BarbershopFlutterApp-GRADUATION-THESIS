import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/server_config.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/logout_dialog.dart';
import 'package:flutter_cahoi_barbershop/ui_employee/task_tab.dart';

class EmployeeHomeView extends StatefulWidget {
  const EmployeeHomeView({Key? key}) : super(key: key);

  @override
  State<EmployeeHomeView> createState() => _EmployeeHomeViewState();
}

class _EmployeeHomeViewState extends State<EmployeeHomeView> {
  Size size = Size.zero;

  AdminTab currentTab = AdminTab.hr;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final user = locator<AuthenticationService>().user;

    return Scaffold(
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
                      borderRadius: borderRadiusCircle,
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
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.cut),
                    title: const Text(
                      'Nhiệm vụ',
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () async {
                      LogoutDialog.show(context);
                    },
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: const Text('Đăng xuất'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: _getTab(),
      ),
    );
  }

  Widget _getTab() => const TaskTab();
}
