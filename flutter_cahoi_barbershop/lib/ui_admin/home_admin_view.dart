import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/server_config.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/logout_dialog.dart';
import 'package:flutter_cahoi_barbershop/ui_admin/views/analysis_tab.dart';
import 'package:flutter_cahoi_barbershop/ui_admin/views/business_tab.dart';
import 'package:flutter_cahoi_barbershop/ui_admin/views/hr_tab.dart';
import 'package:flutter_cahoi_barbershop/ui_admin/views/product/product_tab.dart';

class HomeAdminView extends StatefulWidget {
  const HomeAdminView({Key? key}) : super(key: key);

  @override
  State<HomeAdminView> createState() => _HomeAdminViewState();
}

class _HomeAdminViewState extends State<HomeAdminView> {
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
                  _drawerTile(
                    tab: AdminTab.hr,
                    title: appLang(context)!.hr,
                    icon: const Icon(Icons.lock),
                  ),
                  const Divider(),
                  _drawerTile(
                    tab: AdminTab.business,
                    title: appLang(context)!.work,
                    icon: const Icon(Icons.business_center),
                  ),
                  const Divider(),
                  _drawerTile(
                    tab: AdminTab.product,
                    title: appLang(context)!.product,
                    icon: const Icon(Icons.cut),
                  ),
                  const Divider(),
                  _drawerTile(
                    tab: AdminTab.analysis,
                    title: appLang(context)!.analysis,
                    icon: const Icon(Icons.bar_chart),
                  ),
                  ListTile(
                    onTap: () async {
                      LogoutDialog.show(context);
                    },
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: Text(
                      appLang(context)!.logout,
                    ),
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

  Widget _getTab() {
    switch (currentTab) {
      case AdminTab.hr:
        return const HRTab();
      case AdminTab.business:
        return const BusinessTab();
      case AdminTab.product:
        return const ProductTab();
      case AdminTab.analysis:
        return const AnalysisTab();
      default:
        return const HRTab();
    }
  }

  Widget _drawerTile({
    String? title,
    required AdminTab tab,
    required Icon icon,
  }) =>
      ListTile(
        selected: currentTab == tab,
        selectedTileColor: Colors.grey.shade300,
        selectedColor: Colors.black,
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentTab = tab;
          });
        },
        leading: icon,
        title: Text(
          '$title',
        ),
      );
}
