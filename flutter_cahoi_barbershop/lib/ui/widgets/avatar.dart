import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';

class Avatar extends StatefulWidget {
  final double height;
  final String src;

  const Avatar({
    Key? key,
    required this.height,
    required this.src,
  }) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: widget.height,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.height),
        color: Colors.grey.withOpacity(0.5),
        image: DecorationImage(
          image: NetworkImage(
            widget.src,
          ),
          onError: (exception, stackTrace) {
            logger.e(exception.toString());
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
