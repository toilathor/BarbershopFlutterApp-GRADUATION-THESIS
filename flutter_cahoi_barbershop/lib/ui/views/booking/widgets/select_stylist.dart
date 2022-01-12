import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist/stylist.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/avatar.dart';

class SelectStylist extends StatefulWidget {
  final Function(int index) onTap;
  final List<Stylist> stylists;
  final int currentIndex;

  const SelectStylist({
    Key? key,
    required this.onTap,
    required this.stylists,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  _SelectStylistState createState() => _SelectStylistState();
}

class _SelectStylistState extends State<SelectStylist> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Chúng tôi sẽ chọn cho bạn stylist thích hợp
        _buildAvatarStylist(
          size: size,
          title: "We choose stylist for you",
          src: "https://bit.ly/3FMV625",
          index: 0,
          isSelected: widget.currentIndex == 0,
        ),

        // Bạn tự chọn stylist thích hợp
        SizedBox(
          height: size.width * 0.44,
          width: size.width * 0.56,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _buildAvatarStylist(
              size: size,
              title: widget.stylists[index].name,
              src: widget.stylists[index].avatar,
              index: index + 1,
              isSelected: widget.currentIndex == index + 1,
            ),
            itemCount: widget.stylists.length,
          ),
        )
      ],
    );
  }

  Widget _buildAvatarStylist(
          {required Size size,
          required String title,
          required String src,
          required int index,
          bool isSelected = false}) =>
      GestureDetector(
        onTap: () => widget.onTap(index),
        child: Column(
          children: [
            Container(
              width: size.width * 0.22,
              height: size.width * 0.22,
              color: Theme.of(context).backgroundColor,
              child: Stack(
                children: [
                  isSelected
                      ? Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  width: 3.0),
                              borderRadius: BorderRadius.circular(size.width)),
                        )
                      : Container(),
                  Avatar(
                    height: size.width * 0.18,
                    src: src,
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: isSelected
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.check,
                              size: size.width * 0.04,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(
                                size.width,
                              ),
                            ),
                          )
                        : Container(),
                  )
                ],
              ),
            ),
            Container(
              width: size.width * 0.22,
              height: size.width * 0.22,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.headline1!.fontFamily,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      );
}
