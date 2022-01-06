import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/discover_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:provider/provider.dart';

class ShowPhotoView extends StatefulWidget {
  int currentPhoto = 0;
  ShowPhotoView({
    Key? key,
    required this.currentPhoto,
  }) : super(key: key);

  @override
  _ShowPhotoViewState createState() => _ShowPhotoViewState();
}

class _ShowPhotoViewState extends State<ShowPhotoView> {
  DiscoverModel model = locator<DiscoverModel>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiscoverModel>(
      create: (context) => model,
      child: Consumer(
        builder: (context, value, child) => Scaffold(
          body: CarouselSlider.builder(
            itemBuilder: (context, index, realIndex) => Container(
              color: Colors.black,
              child: ExtendedImage.network(
                model.photos[index].src,
                fit: BoxFit.contain,
                mode: ExtendedImageMode.gesture,
                initGestureConfigHandler: (state) {
                  return GestureConfig(
                    minScale: 1,
                    animationMinScale: 0.7,
                    maxScale: 3.0,
                    animationMaxScale: 3.5,
                    speed: 1.0,
                    inertialSpeed: 100.0,
                    initialScale: 1.0,
                    inPageView: false,
                    initialAlignment: InitialAlignment.center,
                  );
                },
              ),
            ),
            // Image.network(model.photos[index].src),
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              initialPage: widget.currentPhoto,
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1,
            ),
            itemCount: model.photos.length,
          ),
        ),
      ),
    );
  }
}
