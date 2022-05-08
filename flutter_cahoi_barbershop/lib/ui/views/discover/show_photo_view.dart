import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/fake-data/data.dart';

class ShowPhotoView extends StatefulWidget {
  final int currentPhoto;

  const ShowPhotoView({
    Key? key,
    this.currentPhoto = 0,
  }) : super(key: key);

  @override
  _ShowPhotoViewState createState() => _ShowPhotoViewState();
}

class _ShowPhotoViewState extends State<ShowPhotoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider.builder(
        itemBuilder: (context, index, realIndex) => Container(
          color: Colors.black,
          child: ExtendedImage.network(
            photos[index].src,
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
        itemCount: photos.length,
      ),
    );
  }
}
