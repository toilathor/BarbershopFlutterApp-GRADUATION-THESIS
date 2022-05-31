import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart' as format_date;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/post2.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostTile extends StatefulWidget {
  const PostTile({
    Key? key,
    required this.post,
    required this.onLikePost,
    required this.isLiked,
    this.onDelete,
    this.onEdit,
    this.top,
  }) : super(key: key);

  final Post2 post;
  final bool isLiked;
  final int? top;
  final Function() onLikePost;
  final Function()? onDelete;
  final Function()? onEdit;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  Size size = Size.zero;
  double heiHeart = 24;

  int activeIndex = 0;

  bool isLiked = false;

  @override
  void initState() {
    isLiked = widget.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Container(
      height: size.width * 1.5,
      width: size.width,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRect(
                      child: Image.network(
                        '${widget.post.task?.customer?.avatar}',
                        height: 50,
                        errorBuilder: (context, _, ___) => Container(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.task?.customer?.name ?? "no name",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontBold,
                          ),
                        ),
                        Text(
                          format_date.formatDate(
                            DateTime.parse(widget.post.publicAt ?? ""),
                            dateVI,
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.post.task?.customer?.id ==
                    locator<AuthenticationService>().user.id,
                child: InkWell(
                  borderRadius: borderRadiusCircle,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: const Text("Tùy chọn"),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              if (widget.onEdit != null) {
                                widget.onEdit!();
                              }
                            },
                            child: const Text("Chỉnh sửa"),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              if (widget.onDelete != null) {
                                widget.onDelete!();
                              }
                            },
                            child: const Text("Xóa"),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.more_horiz,
                      color: Color(0xFF262626),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: widget.post.captions != null,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                '${widget.post.captions}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: fontLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onDoubleTap: () {
                if (widget.isLiked) {
                  return;
                }
                setState(() {
                  heiHeart = 24 / 2;
                });
                Future.delayed(
                  const Duration(milliseconds: 245),
                  () async {
                    setState(() {
                      heiHeart = 24;
                    });
                    isLiked = await widget.onLikePost();
                  },
                );
              },
              child: CarouselSlider.builder(
                itemBuilder: (context, index, realIndex) => Image.network(
                    "$localHost/${widget.post.task?.image![index].link}",
                    errorBuilder: (context, _, ___) => Container(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    cacheHeight: 1080),
                itemCount: widget.post.task?.image!.length,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  initialPage: 1,
                  height: double.infinity,
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
                  left: 14,
                  height: 24,
                  width: 24,
                  child: GestureDetector(
                    onTapDown: (details) {
                      setState(() {
                        heiHeart = 24 / 2;
                      });
                      Future.delayed(
                        const Duration(milliseconds: 245),
                        () async {
                          isLiked = await widget.onLikePost();
                          setState(() {
                            heiHeart = 24;
                          });
                        },
                      );
                    },
                    child: Center(
                      child: AnimatedContainer(
                        height: heiHeart,
                        width: heiHeart,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 245),
                        child: SvgPicture.asset(
                          isLiked
                              ? 'assets/icon/heart_active.svg'
                              : 'assets/icon/heart.svg',
                          color: isLiked ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: widget.post.task?.image?.length ?? 0,
                    effect: const WormEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Color(0xFFC4C4C4),
                      type: WormType.thin,
                      dotWidth: 6,
                      dotHeight: 6,
                      paintStyle: PaintingStyle.fill,
                      spacing: 5,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  height: 24,
                  width: 24,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/booking");
                    },
                    tooltip: 'Booking Now',
                    icon: const Icon(
                      Icons.bookmark_border_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              '${widget.post.likeCount} Likes',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontFamily: fontBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
