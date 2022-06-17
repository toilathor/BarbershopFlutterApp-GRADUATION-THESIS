import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:date_format/date_format.dart' as date_format;
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/post2.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/story_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/components/bottom_sheet_edit_post.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/loading_widget.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/no_item.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/post_tile.dart';

class StoryPageView extends StatefulWidget {
  const StoryPageView({Key? key}) : super(key: key);

  @override
  _StoryPageViewState createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView>
    with SingleTickerProviderStateMixin {
  Size size = const Size(0, 0);
  bool like = true;
  final user = locator<AuthenticationService>().user;
  ScrollController scrollController = ScrollController();

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    if (size.isEmpty) {
      size = MediaQuery.of(context).size;
    }

    return BaseView<StoryModel>(
      onModelReady: (model) async {
        await model.changePosts();

        await model.changePostsLastMonth();

        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              !model.isLoading) {
            await model.changePosts();
          }
        });
      },
      builder: (context, model, child) => DefaultTabController(
        initialIndex: currentTab,
        length: 2,
        child: Scaffold(
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
                  tooltip: appLang(context)!.your_story,
                ),
              ),
            ],
            bottom: TabBar(
              onTap: (value) {
                setState(() {
                  currentTab = value;
                });
              },
              tabs: [
                Tab(
                  text: "Top ${date_format.formatDate(DateTime.now(), [MM])}",
                ),
                Tab(
                  text: "Top ${date_format.formatDate(
                    DateTime.now().subtract(
                      const Duration(
                        days: 30,
                      ),
                    ),
                    [MM],
                  )}",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: model.isLoading
                    ? const Center(
                        child: LoadingWidget(),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          model.resetList();
                          await model.changePosts();
                        },
                        child: model.posts.isEmpty
                            ? const Center(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  child: NoItemWidget(),
                                ),
                              )
                            : ListView.builder(
                                controller: scrollController,
                                physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                itemCount: model.posts.length,
                                itemBuilder: (context, index) {
                                  Post2 post = model.posts[index];
                                  int isLiked = model.likedPost.firstWhere(
                                    (element) => element == post.id,
                                    orElse: () => -1,
                                  );

                                  return PostTile(
                                    post: post,
                                    isLiked: isLiked != -1,
                                    onLikePost: () async {
                                      return await model
                                          .likePost(model.posts[index].id ?? 0);
                                    },
                                    onDelete: () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.QUESTION,
                                        btnOkOnPress: () async {
                                          await model.deletePost(
                                              postId: post.id!);
                                        },
                                        btnCancelOnPress: () {},
                                        body: Text(
                                          appLang(context)!.question_del_post,
                                        ),
                                        title: appLang(context)!.confirm,
                                      ).show();
                                    },
                                    onEdit: () async {
                                      await _showEditPost(post: post);
                                      await model.resetList();
                                      await model.changePosts();
                                    },
                                  );
                                },
                              ),
                      ),
              ),
              Center(
                child: model.isLoading
                    ? const Center(
                        child: LoadingWidget(),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await model.changePostsLastMonth();
                        },
                        child: model.postsLastMonth.isEmpty
                            ? const Center(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  child: NoItemWidget(),
                                ),
                              )
                            : ListView.builder(
                                controller: scrollController,
                                physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                itemCount: model.postsLastMonth.length,
                                itemBuilder: (context, index) {
                                  return PostTile(
                                    post: model.postsLastMonth[index],
                                    isLiked: true,
                                    onLikePost: () {},
                                    onDelete: () {},
                                    onEdit: () {},
                                  );
                                },
                              ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _showEditPost({required Post2 post}) async {
    await BottomSheetEditPost.show(context, post);
    Navigator.pop(context);
  }
}
