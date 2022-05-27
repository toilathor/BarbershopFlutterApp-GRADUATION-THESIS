import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/facility.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';

/// @param distance có đơn vị là m
class FacilityTile extends StatefulWidget {
  final Facility facility;
  final double distance;
  final bool isFirst;
  final Function()? onPress;

  const FacilityTile(
      {Key? key,
      required this.facility,
      required this.distance,
      this.onPress,
      this.isFirst = false})
      : super(key: key);

  @override
  _FacilityTileState createState() => _FacilityTileState();
}

class _FacilityTileState extends State<FacilityTile> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

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
                  child: SizedBox(
                    height: 150,
                    child: Image.network(
                      '$localHost${widget.facility.image}',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.facility.address}",
                          style: const TextStyle(
                            fontFamily: fontBold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: widget.isFirst
                                ? Colors.green.shade400
                                : Colors.red.shade400,
                            borderRadius: BorderRadius.circular(4.0),
                            boxShadow: [
                              BoxShadow(
                                color: widget.isFirst
                                    ? Colors.green.shade300
                                    : Colors.red.shade300,
                                offset: const Offset(0, 0),
                                blurRadius: 5,
                                spreadRadius: 0.5,
                              ),
                            ],
                          ),
                          child: Text(
                            'about ${widget.distance >= 1000 ? (widget.distance / 1000).toStringAsFixed(2) : widget.distance.toStringAsFixed(2)} ${widget.distance >= 1000 ? 'km' : 'm'}',
                            style: const TextStyle(
                              fontFamily: fontBold,
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                        ),
                        Text(
                          widget.facility.description,
                          style: const TextStyle(fontSize: 10),
                        )
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
