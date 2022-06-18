import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
          child: CircularProgressIndicator(),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(appLang(context)!.loading)
      ],
    );
  }
}
