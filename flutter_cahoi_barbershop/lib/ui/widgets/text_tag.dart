import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/product.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';

class TextTag extends StatelessWidget {
  final Product product;

  const TextTag({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        height: 40,
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: primaryColor),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.yellow,
              ),
              child: Text(
                "${product.price}K",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
