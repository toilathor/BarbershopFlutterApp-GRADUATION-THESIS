import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/post.dart';
import 'package:flutter_cahoi_barbershop/core/models/screen_arguments.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/post_tile.dart';

class StoryPageView extends StatefulWidget {
  const StoryPageView({Key? key}) : super(key: key);

  @override
  _StoryPageViewState createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  Size size = const Size(0, 0);
  bool like = true;
  final user = locator<AuthenticationService>().user;

  @override
  Widget build(BuildContext context) {
    if (size.isEmpty) {
      size = MediaQuery.of(context).size;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/your-story',
                  arguments: ScreenArguments("hello", "ok"),
                );
              },
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  '${user.avatar}',
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.location_history_rounded,
                  ),
                ),
              ),
              tooltip: 'Your Story',
            ),
          )
        ],
        title: Image.asset(
          "assets/favicon-ngang.png",
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
        ),
      ),
      body: ListView.builder(
        // padding: const EdgeInsets.all(8.0),
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => PostTile(
          post: Post.initial(),
        ),
      ),
    );
  }
}
