import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/pages/home_page/components/body_home_page.dart';
import 'package:flutter_cahoi_barbershop/ui/views/pages/home_page/components/header_home_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final model = locator<HomePageModel>();

  @override
  void initState() {
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
        floatingActionButton: FloatingActionButton(
          heroTag: 'HostLine',
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          onPressed: () async {
            if (await canLaunch("tel:$hostLine")) {
              await launch("tel:$hostLine");
            }
          },
          tooltip: 'Hotline',
          child: Icon(
            Icons.call,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.255,
              child: const HeaderHomePage(),
            ),
            const Expanded(
              child: BodyHomePage(),
            ),
          ],
        ),
      ),
    );
  }
}
