import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/story_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/post_tile.dart';

class YourStoryView extends StatefulWidget {
  const YourStoryView({Key? key}) : super(key: key);

  @override
  State<YourStoryView> createState() => _YourStoryViewState();
}

class _YourStoryViewState extends State<YourStoryView> {
  Size size = const Size(0, 0);
  bool like = true;
  final user = locator<AuthenticationService>().user;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
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
                tooltip: 'Your Story',
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            model.resetList();
            await model.changePosts();
          },
          child: ListView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: model.posts.length,
            itemBuilder: (context, index) => PostTile(
              post: model.posts[index],
              onLikePost: () async {
                await model.likePost(model.posts[index].id ?? 0);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
