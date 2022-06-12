import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/avatar.dart';

class SelectStylist extends StatefulWidget {
  const SelectStylist({
    Key? key,
    this.stylists = const [],
    required this.onSelected,
    this.current,
  }) : super(key: key);

  final List<StylistRate> stylists;
  final StylistRate? current;
  final Function(StylistRate? stylist) onSelected;

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
        GestureDetector(
          onTap: () {
            // print('object');
            widget.onSelected(null);
          },
          child: _buildAvatarStylist(
            size: size,
            title: appLang(context)!.name_random_select,
            src: "https://bit.ly/3FMV625",
            isSelected: widget.current == null,
          ),
        ),

        // Bạn tự chọn stylist thích hợp
        SizedBox(
          height: size.width * 0.44,
          width: size.width * 0.56,
          child: widget.stylists.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Cơ sở bạn đã chọn vào ngày bạn chọn không có nhân viên',
                      style: TextStyle(color: Colors.red, shadows: [
                        Shadow(
                          color: Colors.red.shade500,
                          offset: const Offset(0, 0),
                          blurRadius: 5,
                        )
                      ]),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.stylists.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      widget.onSelected(widget.stylists[index]);
                    },
                    child: _buildAvatarStylist(
                      size: size,
                      title: "${widget.stylists[index].name}",
                      src: '${widget.stylists[index].avatar}',
                      isSelected: widget.current == widget.stylists[index],
                    ),
                  ),
                ),
        )
      ],
    );
  }

  Widget _buildAvatarStylist({
    required Size size,
    required String title,
    required String src,
    bool isSelected = false,
  }) =>
      Column(
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
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      );
}
