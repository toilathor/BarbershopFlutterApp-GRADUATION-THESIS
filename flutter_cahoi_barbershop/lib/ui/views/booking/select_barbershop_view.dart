import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';

class SelectBarbershopView extends StatefulWidget {
  const SelectBarbershopView({Key? key}) : super(key: key);

  @override
  _SelectBarbershopViewState createState() => _SelectBarbershopViewState();
}

class _SelectBarbershopViewState extends State<SelectBarbershopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Barbershop"),
        automaticallyImplyLeading: false,
        leading: CupertinoNavigationBarBackButton(
          color: Theme.of(context).backgroundColor,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                    (route) => false);
              },
              icon: Icon(
                Icons.home,
                size: Theme.of(context).iconTheme.size ?? 24,
              ),
              tooltip: 'Home',
            ),
          )
        ],
      ),
    );
  }
}
