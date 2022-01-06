import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/discover_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/discover/show_photo_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class DiscoverView extends StatefulWidget {
  DiscoverView({Key? key}) : super(key: key);

  @override
  _DiscoverViewState createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  DiscoverModel model = locator<DiscoverModel>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiscoverModel>(
      create: (context) => model,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Discover".toUpperCase()),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Discover the most popular hairstyles with CAHOI BARBERSHOP',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
            ),
            Consumer<DiscoverModel>(
              builder: (context, value, child) => Expanded(
                child: MasonryGridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: model.photos.length,
                  mainAxisSpacing: 32.0,
                  crossAxisSpacing: 20.0,
                  gridDelegate:
                      const SliverMasonryGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
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
                          model.photos[index].src,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
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
                            model.photos[index].name,
                            style: Theme.of(context).textTheme.headline3,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
