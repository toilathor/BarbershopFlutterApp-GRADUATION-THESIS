import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';

class BaseButton extends StatefulWidget {
  final double height;
  final double width;
  final Function()? onPressed;
  final String title;
  const BaseButton({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: textColorLight2)),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          child: Text(
            widget.title,
            style: const TextStyle(
              fontFamily: fontBold,
              color: backgroundColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
