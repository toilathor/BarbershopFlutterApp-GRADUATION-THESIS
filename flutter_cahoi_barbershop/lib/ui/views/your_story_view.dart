import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/post2.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/story_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
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
    size = MediaQuery.of(context).size;

    return BaseView<StoryModel>(
      onModelReady: (model) async {
        await model.changePosts(userId: user.id);

        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              !model.isLoading) {
            await model.changePosts(userId: user.id);
          }
        });
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            model.resetList();
            await model.changePosts(userId: user.id);
          },
          child: ListView.builder(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: model.posts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.23,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 0,
                              child: Material(
                                elevation: 8.0,
                                child: SizedBox(
                                  height: size.height * 0.15,
                                  width: size.width,
                                  child: Image.asset(
                                    "assets/bg_cahoibarbershop.jpg",
                                    fit: BoxFit.fitWidth,
                                    color: Colors.black.withOpacity(0.7),
                                    colorBlendMode: BlendMode.colorBurn,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              height: size.height * 0.15,
                              child: ClipRRect(
                                borderRadius: borderRadiusCircle,
                                child: Image.network(
                                  "${user.avatar}",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                        child: FittedBox(
                          child: Text(
                            '${user.name}',
                            style: const TextStyle(fontFamily: fontBold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              Post2 post = model.posts[index - 1];
              int isLiked = model.likedPost.firstWhere(
                (element) => element == post.id,
                orElse: () => -1,
              );

              return PostTile(
                post: post,
                isLiked: isLiked != -1,
                onLikePost: () async {
                  return await model.likePost(post.id ?? 0);
                },
                onDelete: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.QUESTION,
                    btnOkOnPress: () async {
                      await model.deletePost(postId: post.id!);
                    },
                    btnCancelOnPress: () {},
                    body: const Text(
                      "Bạn có chắc chắn muốn xóa vĩnh viễn bài viết này không?",
                    ),
                    title: "Xác nhận",
                  ).show();
                },
                onEdit: () {
                  // model.onEdit();
                },
              );
            },
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
