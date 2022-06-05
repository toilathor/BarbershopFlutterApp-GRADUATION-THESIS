import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/product.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/elevated_button_icon.dart';

class InfoProductView extends StatefulWidget {
  const InfoProductView({Key? key}) : super(key: key);

  @override
  State<InfoProductView> createState() => _InfoProductViewState();
}

class _InfoProductViewState extends State<InfoProductView> {
  late Product product;
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Hero(
            tag: product.id,
            child: Image.network(
              '$localHost${product.image}',
              fit: BoxFit.cover,
              height: size.width,
              width: size.width,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: fontBold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price}K',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: fontBold,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.timelapse_outlined,
                                color: Theme.of(context).secondaryHeaderColor,
                                size: 18,
                              ),
                            ),
                            Text(
                              '${product.duration} phút',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Mô tả",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: fontBold,
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      product.fullDescription,
                      style: const TextStyle(
                        fontFamily: fontLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButtonIcon(
                // width: size.width,
                onPressed: () {
                  Navigator.pop(context, true);
                },
                title: 'Chọn',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
