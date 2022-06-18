import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';

class PromotionMechanismView extends StatefulWidget {
  const PromotionMechanismView({Key? key}) : super(key: key);

  static String name = "promotion_mechanism";

  @override
  State<PromotionMechanismView> createState() => _PromotionMechanismViewState();
}

class _PromotionMechanismViewState extends State<PromotionMechanismView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLang(context)!.promotion_mechanism,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 4,
                bottom: 20.0,
              ),
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.centerRight,
              width: size.width,
              height: size.width / 2,
              child: Image.asset("assets/banner.png"),
              decoration: BoxDecoration(
                borderRadius: borderRadius20,
                gradient: LinearGradient(
                  colors: [
                    Colors.yellow,
                    Colors.yellow.withOpacity(0.5),
                    Colors.yellow.withOpacity(0),
                  ],
                ),
              ),
            ),
            Text(
              appLang(context)!.sub_promotion_mechanism,
            ),
          ],
        ),
      ),
    );
  }
}
