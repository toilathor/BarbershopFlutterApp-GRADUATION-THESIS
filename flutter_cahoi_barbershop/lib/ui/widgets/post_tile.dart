import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostTile extends StatefulWidget {
  const PostTile({Key? key}) : super(key: key);

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  Size size = Size.zero;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage('https://bit.ly/3rbo72k'),
                        ),
                        borderRadius: BorderRadius.circular(size.width * 0.1),
                      ),
                      height: size.width * 0.1,
                      width: size.width * 0.1,
                    ),
                    const Text(
                      'toilathor',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontBold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.more_horiz,
                    color: Color(0xFF262626),
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(),
            SizedBox(
              height: size.width,
              width: size.width,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
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
                      child: SvgPicture.asset(
                        'assets/icon/heart_active.svg',
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: 1,
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
            const Text(
              '100 Likes',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontFamily: fontBold,
              ),
            ),
            RichText(
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
          ],
        ),
      ),
    );
  }
}
