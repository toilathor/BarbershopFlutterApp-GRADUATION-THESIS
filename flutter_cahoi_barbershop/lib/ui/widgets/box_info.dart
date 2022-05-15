import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';

class BoxInfo extends StatelessWidget {
  const BoxInfo({Key? key, this.height, this.width, this.title, this.content})
      : super(key: key);

  final double? height;
  final double? width;
  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title ?? "Unknown",
              style: const TextStyle(
                fontSize: 16,
                fontFamily: fontBold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                content ?? "Unknown",
                overflow: TextOverflow.ellipsis,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
