import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late OverlayEntry? floatingOverlay;
  bool dropdownOpening = false;

  void closeDropDown() {
    if (floatingOverlay != null) {
      floatingOverlay?.remove();
      dropdownOpening = false;
    }
  }
}