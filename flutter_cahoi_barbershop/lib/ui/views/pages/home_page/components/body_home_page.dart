import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/pages/home_page/components/chanel_youtube.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/slider_image.dart';
import 'package:provider/provider.dart';

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({Key? key}) : super(key: key);

  @override
  _BodyHomePageState createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  final model = locator<HomePageModel>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<HomePageModel>(
      create: (context) => model,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SliderImage(
              height: size.height * 0.23,
              width: size.width,
              items: model.itemsSlider,
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: ChanelYouTube(),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildLockBook(context, size),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildLockBook(BuildContext context, Size size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("CAHOI Lookbook", style: Theme.of(context).textTheme.headline3),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  width: size.width,
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
