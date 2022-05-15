import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingDialog {
  static show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(0xFF1A1A3F),
                rightDotColor: const Color(0xFFEA3799),
                size: 50,
              ),
              const Material(
                color: Colors.transparent,
                child: Text(
                  'loading...',
                  style: TextStyle(
                    color: headerColor1,
                    fontSize: 16,
                    fontFamily: fontBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}
