import 'package:flutter/material.dart';

class ServiceTab extends StatefulWidget {
  ServiceTab({Key? key}) : super(key: key);

  @override
  _ServiceTabState createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Tab(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        shrinkWrap: true,
        children: _buildItemsService(height: size.height, width: size.width),
      ),
    );
  }

  List<Widget> _buildItemsService(
      {required double width, required double height}) {
    List<Widget> items = [];

    items.add(_buildItemService(width: width / 2, height: height / 2));
    items.add(_buildItemService(width: width / 2, height: height / 2));
    items.add(_buildItemService(width: width / 2, height: height / 2));
    items.add(_buildItemService(width: width / 2, height: height / 2));
    items.add(_buildItemService(width: width / 2, height: height / 2));
    items.add(_buildItemService(width: width / 2, height: height / 2));
    items.add(_buildItemService(width: width / 2, height: height / 2));

    return items;
  }

  Widget _buildItemService({required double width, required double height}) {
    return Card(
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Image.asset(
                "assets/slider_demo/demo1.png",
                height: height / 2,
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Select"),
                )),
          ],
        ),
      ),
    );
  }
}
