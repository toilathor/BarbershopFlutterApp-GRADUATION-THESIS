import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductTab extends StatefulWidget {
  const ProductTab({Key? key}) : super(key: key);

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Product')
    );
  }
}
