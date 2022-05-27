import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/fake-data/data.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/discover/show_photo_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DiscoverPageView extends StatefulWidget {
  const DiscoverPageView({Key? key}) : super(key: key);

  @override
  _DiscoverPageViewState createState() => _DiscoverPageViewState();
}

class _DiscoverPageViewState extends State<DiscoverPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Khám phá".toUpperCase()),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              'Khám phá những kiểu tóc phổ biến nhất với CAHOI BARBERSHOP',
              style: TextStyle(
                fontFamily: fontBold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: MasonryGridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: photos.length,
              mainAxisSpacing: 32.0,
              crossAxisSpacing: 20.0,
              gridDelegate:
                  const SliverMasonryGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowPhotoView(
                          currentPhoto: index,
                        ),
                      ));
                },
                child: Column(
                  children: [
                    Image.network(
                      photos[index].src,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        photos[index].name,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
