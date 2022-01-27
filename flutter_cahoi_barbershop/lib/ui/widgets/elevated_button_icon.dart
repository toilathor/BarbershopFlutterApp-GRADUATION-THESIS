import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';

class ElevatedButtonIcon extends StatefulWidget {
  final double? width;
  final Function()? onPressed;
  final String title;
  final Widget? icon;

  const ElevatedButtonIcon(
      {Key? key, this.width, this.onPressed, required this.title, this.icon})
      : super(key: key);

  @override
  _ElevatedButtonIconState createState() => _ElevatedButtonIconState();
}

class _ElevatedButtonIconState extends State<ElevatedButtonIcon> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.width ?? size.width,
      child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: textColorLight2)),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      child: widget.icon,
                    )
                  : Container(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText1!.fontFamily,
                    color: Theme.of(context).backgroundColor,
                    fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
