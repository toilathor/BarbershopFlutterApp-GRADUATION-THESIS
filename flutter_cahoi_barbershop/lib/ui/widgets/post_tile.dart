import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/fake-data/data.dart';
import 'package:flutter_cahoi_barbershop/core/models/post.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostTile extends StatefulWidget {
  const PostTile({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  Size size = Size.zero;
  double heiHeart = 24;

  int activeIndex = 1;

  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 25.0),
        padding: const EdgeInsets.only(bottom: 25.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade500,
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage('https://bit.ly/3rbo72k'),
                        ),
                        borderRadius: BorderRadius.circular(size.width * 0.1),
                      ),
                      height: size.width * 0.1,
                      width: size.width * 0.1,
                    ),
                    Text(
                      widget.post.userName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontBold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.more_horiz,
                      color: Color(0xFF262626),
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RichText(
                text: const TextSpan(
                  text: 'Name',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Lorem ipsum dolor sit amet, '
                          'consectetur adipiscing elit, sed do eiusmod '
                          'tempor incididunt... more',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: fontLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  heiHeart = 24 / 2;
                });
                Future.delayed(
                  const Duration(milliseconds: 245),
                  () {
                    setState(() {
                      heiHeart = 24;
                      isLike = !isLike;
                    });
                  },
                );
              },
              child: SizedBox(
                // height: size.width * 1.1,
                width: size.width,
                child: CarouselSlider.builder(
                  itemBuilder: (context, index, realIndex) => Image.asset(
                    imagePostDemo[index],
                    fit: BoxFit.fitWidth,
                  ),
                  itemCount: imagePostDemo.length,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    initialPage: 1,
                    enableInfiniteScroll: false,
                    autoPlayInterval: const Duration(seconds: 5),
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              width: size.width,
              height: 24,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    height: 24,
                    width: 24,
                    child: GestureDetector(
                      onTapDown: (details) {
                        setState(() {
                          heiHeart = 24 / 2;
                        });
                        Future.delayed(
                          const Duration(milliseconds: 245),
                          () {
                            setState(() {
                              heiHeart = 24;
                              isLike = !isLike;
                            });
                          },
                        );
                      },
                      // onLongPressDown: (details) {
                      //   setState(() {
                      //     heiHeart = 24/2;
                      //   });
                      // },
                      // onLongPressUp: () {
                      //   setState(() {
                      //     heiHeart = 24;
                      //   });
                      // },
                      child: Center(
                        child: AnimatedContainer(
                          height: heiHeart,
                          width: heiHeart,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 245),
                          child: SvgPicture.asset(
                            isLike
                                ? 'assets/icon/heart_active.svg'
                                : 'assets/icon/heart.svg',
                            color: isLike ? Colors.red : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: 4,
                      effect: const WormEffect(
                        activeDotColor: Colors.blue,
                        dotColor: Color(0xFFC4C4C4),
                        type: WormType.thin,
                        dotWidth: 10,
                        dotHeight: 10,
                        paintStyle: PaintingStyle.fill,
                        spacing: 4,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    height: 24,
                    width: 24,
                    child: GestureDetector(
                      child: const Icon(
                        Icons.bookmark_border_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Text(
                '100 Likes',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontFamily: fontBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
