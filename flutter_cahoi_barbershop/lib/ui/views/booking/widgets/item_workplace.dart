import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/workplace/workplace.dart';

/// @param distance có đơn vị là m
class ItemWorkplace extends StatefulWidget {
  final Workplace workplace;
  final double distance;
  final bool isFirst;
  final Function() onPress;

  const ItemWorkplace(
      {Key? key,
      required this.workplace,
      required this.distance,
      required this.onPress,
      this.isFirst = false})
      : super(key: key);

  @override
  _ItemWorkplaceState createState() => _ItemWorkplaceState();
}

class _ItemWorkplaceState extends State<ItemWorkplace> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onPress,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/bg_cahoibarbershop.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.workplace.name),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                              color: widget.isFirst ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(4.0),
                              boxShadow: [
                                BoxShadow(
                                    color: widget.isFirst
                                        ? Colors.green.shade600
                                        : Colors.red.shade600,
                                    offset: const Offset(0, 0),
                                    blurRadius: 5,
                                    spreadRadius: 0.5),
                              ]),
                          child: Text(
                            'about ${widget.distance >= 1000 ? (widget.distance / 1000).toStringAsFixed(2) : widget.distance.toStringAsFixed(2)} ${widget.distance >= 1000 ? 'km' : 'm'}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        const Text('opposite building A')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
