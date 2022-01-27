import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/service_cut/service_cut.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/elevated_button_icon.dart';

class ItemService extends StatefulWidget {
  final ServiceCut serviceCut;
  final Function() onPressSelect;
  final Function() onPressInfo;
  final bool isSelected;
  final double width;
  final double height;

  const ItemService({
    Key? key,
    required this.serviceCut,
    required this.onPressSelect,
    this.isSelected = false,
    required this.width,
    required this.height,
    required this.onPressInfo,
  }) : super(key: key);

  @override
  _ItemServiceState createState() => _ItemServiceState();
}

class _ItemServiceState extends State<ItemService> {
  @override
  Widget build(BuildContext context) {
    final heightImage = widget.height / 2;

    return GestureDetector(
      onTap: widget.onPressInfo,
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/bg_cahoibarbershop.jpg',
                  height: heightImage,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.serviceCut.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.serviceCut.shortDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.serviceCut.price}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timelapse_outlined,
                            color: Theme.of(context).secondaryHeaderColor,
                            size: 18,
                          ),
                          Text(
                            '${widget.serviceCut.duration}m',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
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
                              child: Text("Select",
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
