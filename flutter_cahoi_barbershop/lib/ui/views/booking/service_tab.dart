import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/service_cut/service_cut.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class ServiceTab extends StatefulWidget {
  final List<ServiceCut> serviceCuts;
  final Function() onPress;
  final bool isSelected ;

  const ServiceTab({
    Key? key,
    required this.serviceCuts,
    required this.onPress,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _ServiceTabState createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Tab(
      child: MasonryGridView.builder(
        itemCount: widget.serviceCuts.length,
        gridDelegate: const SliverMasonryGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => _buildItemService(
            width: size.width / 2, height: size.height / 4, index: index),
      ),
    );
  }

  Widget _buildItemService(
      {required double width, required double height, required int index}) {
    return Card(
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                "assets/slider_demo/demo1.png",
                height: height / 2,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(widget.serviceCuts[index].name),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(widget.serviceCuts[index].sortDescription),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                          "${int.parse(widget.serviceCuts[index].price) ~/ 1000}K"),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: width,
                        child: widget.isSelected
                            ? ElevatedButton.icon(
                                onPressed: widget.onPress,
                                icon: const Icon(Icons.check_circle),
                                label: const Text("Selected"))
                            : ElevatedButton(
                                onPressed: widget.onPress,
                                child: const Text("Select"),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
