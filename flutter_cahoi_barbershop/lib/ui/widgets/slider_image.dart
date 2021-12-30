import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderImage extends StatefulWidget {
  const SliderImage({
    Key? key,
    required this.height,
    required this.width,
    required this.items,
  }) : super(key: key);

  final double height;
  final double width;
  final List<Widget> items;

  @override
  _SliderImageState createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.items,
          options: CarouselOptions(
            height: widget.height,
            autoPlay: true,
            scrollPhysics: const BouncingScrollPhysics(),
            initialPage: 1,
            autoPlayInterval: const Duration(seconds: 5),
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        Positioned(
          width: widget.width,
          bottom: 12,
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: widget.items.length,
              effect: const WormEffect(
                  activeDotColor: Colors.orange,
                  dotColor: Colors.white,
                  type: WormType.thin,
                  dotWidth: 10,
                  dotHeight: 10,
                  paintStyle: PaintingStyle.fill,
                  spacing: 4),
            ),
          ),
        ),
      ],
    );
  }
}
