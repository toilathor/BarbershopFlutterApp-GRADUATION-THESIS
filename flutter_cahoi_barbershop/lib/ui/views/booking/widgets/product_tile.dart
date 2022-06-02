import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/product.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/elevated_button_icon.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  final Function() onPressSelect;
  final bool isSelected;
  final double width;
  final double height;

  const ProductTile({
    Key? key,
    required this.product,
    required this.onPressSelect,
    this.isSelected = false,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var res = await Navigator.pushNamed(
          context,
          '/info-product',
          arguments: widget.product,
        );

        if (res != null && res == true) {
          widget.onPressSelect();
        }
      },
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Hero(
                    tag: widget.product.id,
                    child: Image.network(
                      '$localHost${widget.product.image}',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: fontBold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.sortDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: fontLight,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.product.price}K',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: fontBold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timelapse_outlined,
                              color: Theme.of(context).secondaryHeaderColor,
                              size: 18,
                            ),
                            Text(
                              '${widget.product.duration} phút',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    width: widget.width,
                    child: widget.isSelected
                        ? ElevatedButtonIcon(
                            width: widget.width,
                            onPressed: widget.onPressSelect,
                            title: 'Selected',
                            icon: const Icon(
                              Icons.check_circle_outline,
                              size: 24,
                            ),
                          )
                        : OutlinedButton(
                            style: Theme.of(context).outlinedButtonTheme.style,
                            onPressed: widget.onPressSelect,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Chọn",
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Icon(
              Icons.info_outline,
              color: Theme.of(context).backgroundColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
