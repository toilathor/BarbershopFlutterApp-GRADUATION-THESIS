import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/post2.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/story_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/change_avatar_sheet.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/components/bottom_sheet_edit_post.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/loading_widget.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/post_tile.dart';
import 'package:image_picker/image_picker.dart';

class YourStoryView extends StatefulWidget {
  const YourStoryView({Key? key}) : super(key: key);

  @override
  State<YourStoryView> createState() => _YourStoryViewState();
}

class _YourStoryViewState extends State<YourStoryView> {
  ScrollController scrollController = ScrollController();
  final user = locator<AuthenticationService>().user;

  late Size size;
  bool like = true;
  PickedFile? image;

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
        body: model.isLoading
            ? const Center(
                child: LoadingWidget(),
              )
            : RefreshIndicator(
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
                                    child: InkWell(
                                      onTap: () async {
                                        image = null;

                                        await showMenuPick();
                                        if (image != null) {
                                          showBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                ChangeAvatarSheet(
                                              image: image!,
                                            ),
                                          );
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: borderRadiusCircle,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: Image.network(
                                                  user.avatar != null
                                                      ? "$localHost${user.avatar}"
                                                      : avatarDefault,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.black38,
                                                  size: 24,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white70,
                                                borderRadius:
                                                    borderRadiusCircle,
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
    );
  }

  Future _showEditPost({required Post2 post}) async {
    await BottomSheetEditPost.show(context, post);
    Navigator.pop(context);
  }

  Future showMenuPick() async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              _buildChooseCamera(
                icon: const Icon(
                  Icons.camera,
                  color: Colors.grey,
                ),
                onTap: () async {
                  var imagePicked =
                      // ignore: invalid_use_of_visible_for_testing_member
                      await ImagePicker.platform.pickImage(
                    source: ImageSource.camera,
                    maxHeight: 1080,
                    maxWidth: 1080,
                  );

                  if (imagePicked != null) {
                    setState(() {
                      image = imagePicked;
                    });
                  }
                },
                label: 'Camera',
              ),
              const SizedBox(
                width: 10,
              ),
              _buildChooseCamera(
                icon: const Icon(
                  Icons.collections_sharp,
                  color: Colors.grey,
                ),
                onTap: () async {
                  var imagePicked =
                      // ignore: invalid_use_of_visible_for_testing_member
                      await ImagePicker.platform.pickImage(
                    maxHeight: 1080,
                    maxWidth: 1080,
                    source: ImageSource.gallery,
                  );
                  if (imagePicked != null) {
                    setState(() {
                      image = imagePicked;
                    });
                  }
                  Navigator.pop(context);
                },
                label: 'Thư viện',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChooseCamera(
      {Function()? onTap, required Icon icon, required String label}) {
    return Expanded(
      child: InkWell(
        borderRadius: borderRadius12,
        onTap: onTap,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: borderRadius12,
            color: Colors.black12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: fontBold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
