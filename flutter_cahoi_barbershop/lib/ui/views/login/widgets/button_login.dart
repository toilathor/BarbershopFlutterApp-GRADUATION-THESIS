import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';

class ButtonLogin extends StatefulWidget {
  final double height;
  final double width;
  final Function()? onPressed;
  final String title;
  const ButtonLogin({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  State<ButtonLogin> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
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
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle1!.fontFamily,
              color: Theme.of(context).textTheme.subtitle1!.color,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
