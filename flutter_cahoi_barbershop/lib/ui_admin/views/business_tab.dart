import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessTab extends StatefulWidget {
  const BusinessTab({Key? key}) : super(key: key);

  @override
  State<BusinessTab> createState() => _BusinessTabState();
}

class _BusinessTabState extends State<BusinessTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Business')
    );
  }
}
