import 'package:flutter/material.dart';

class NoItemWidget extends StatelessWidget {
  const NoItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Image.asset(
        'assets/not_item.png',
        height: size.width * 0.5,
        // width: ,
      ),
    );
  }
}
