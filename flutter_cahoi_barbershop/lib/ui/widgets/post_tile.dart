import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart' as format_date;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/post2.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
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

class _PostTileState extends State<PostTile> with TickerProviderStateMixin {
  Size size = Size.zero;
  double heiHeart = 24;

  int activeIndex = 0;

  bool isLiked = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );

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
        border: Border.symmetric(
          horizontal: BorderSide(
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
                        widget.post.task?.customer?.avatar != null
                            ? '$localHost${widget.post.task?.customer?.avatar}'
                            : avatarDefault,
                        height: 50,
                        fit: BoxFit.cover,
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
                        title: Text(appLang(context)!.bottombar_menu),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              if (widget.onEdit != null) {
                                widget.onEdit!();
                              }
                            },
                            child: Text(
                              appLang(context)!.edit,
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              if (widget.onDelete != null) {
                                widget.onDelete!();
                              }
                            },
                            child: Text(
                              appLang(context)!.delete,
                            ),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            appLang(context)!.cancel,
                          ),
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
          Row(
            children: [
              const Icon(
                Icons.person,
                color: primaryColor,
                size: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Tooltip(
                message: appLang(context)!.stylist,
                child: Text(
                  "Stylist: ${widget.post.task?.stylist?.user?.name ?? "no name"}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: fontBold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GestureDetector(
              onDoubleTap: () {
                _animationController.forward().whenComplete(
                  () {
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        _animationController.reverse();
                      },
                    );
                  },
                );

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
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    itemBuilder: (context, index, realIndex) => Image.network(
                      "$localHost/${widget.post.task?.image![index].link}",
                      errorBuilder: (context, _, ___) => Container(),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      cacheHeight: 1080,
                    ),
                    itemCount: widget.post.task?.image!.length,
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      initialPage: 1,
                      enableInfiniteScroll: false,
                      height: double.infinity,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Visibility(
                      // visible: widget.top != null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: widget.top == 1,
                              child: IconTop.first(),
                            ),
                            Visibility(
                              visible: widget.top == 2,
                              child: IconTop.second(),
                            ),
                            Visibility(
                              visible: widget.top == 3,
                              child: IconTop.third(),
                            ),
                            Text(
                              "${appLang(context)!.top} ${widget.top}"
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: fontBold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-1.0, -1),
                            end: Alignment(-1.0, 1),
                            colors: [
                              Colors.transparent,
                              Colors.black87,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ScaleTransition(
                      scale: _animation,
                      child: SvgPicture.asset(
                        "assets/icon/heart_active.svg",
                        color: Colors.red.withOpacity(0.9),
                        height: 70,
                        width: 70,
                      ),
                    ),
                  ),
                ],
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
                  right: 0,
                  child: IconButton(
                    highlightColor: headerColor1,
                    onPressed: () {
                      Navigator.pushNamed(context, "/booking");
                    },
                    tooltip: 'Booking Now',
                    icon: const Icon(
                      Icons.bookmark_border_rounded,
                      color: Colors.black87,
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
              '${widget.post.likeCount} ${appLang(context)!.like}',
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class IconTop extends StatelessWidget {
  const IconTop({Key? key, required this.top}) : super(key: key);

  final int top;

  factory IconTop.first() => const IconTop(top: 1);

  factory IconTop.second() => const IconTop(top: 2);

  factory IconTop.third() => const IconTop(top: 3);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(_getAsset());
  }

  String _getAsset() {
    switch (top) {
      case 1:
        return "assets/top1.svg";
      case 2:
        return "assets/top2.svg";
      case 3:
        return "assets/top3.svg";
      default:
        return "assets/top3.svg";
    }
  }
}
