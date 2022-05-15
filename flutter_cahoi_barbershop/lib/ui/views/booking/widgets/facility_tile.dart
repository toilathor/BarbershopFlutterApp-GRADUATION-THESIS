import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/facility.dart';

/// @param distance có đơn vị là m
class FacilityTile extends StatefulWidget {
  final Facility facility;
  final double distance;
  final bool isFirst;
  final Function()? onPress;

  const FacilityTile(
      {Key? key,
      required this.facility,
      required this.distance, this.onPress,
      this.isFirst = false})
      : super(key: key);

  @override
  _FacilityTileState createState() => _FacilityTileState();
}

class _FacilityTileState extends State<FacilityTile> {
  @override
  Widget build(BuildContext context) {
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
                        Text("${widget.facility.address}"),
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
