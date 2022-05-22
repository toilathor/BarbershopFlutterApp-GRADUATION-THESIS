import 'package:date_format/date_format.dart';
import 'package:date_format/date_format.dart' as date_format;
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/story_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
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
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (size.isEmpty) {
      size = MediaQuery.of(context).size;
    }

    return BaseView<StoryModel>(
      onModelReady: (model) async {
        await model.changePosts();

        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              !model.isLoading) {
            await model.changePosts();
          }
        });
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/your-story',
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
                tooltip: 'Trang cá nhân',
              ),
            )
          ],
          title: Text("Top ${date_format.formatDate(DateTime.now(), [MM])}"),
        ),
        body: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              model.resetList();
              await model.changePosts();
            },
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: model.posts.length,
              itemBuilder: (context, index) => PostTile(
                post: model.posts[index],
                onLikePost: () async {
                  return await model.likePost(model.posts[index].id ?? 0);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
