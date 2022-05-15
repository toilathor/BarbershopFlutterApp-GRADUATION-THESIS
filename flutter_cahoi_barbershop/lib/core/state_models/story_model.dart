import 'package:flutter_cahoi_barbershop/core/models/post.dart';
import 'package:flutter_cahoi_barbershop/core/services/post_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StoryModel extends BaseModel {
  final _postService = locator<PostService>();

  List<Post> posts = [];

  bool isLoading = false;
  int currentPage = 1;

  Future changePosts() async {
    if (currentPage == 0) {
      return;
    }

    isLoading = true;
    notifyListeners();

    var res = await _postService.getPost(
      page: currentPage,
    );

    posts += res;

    currentPage++;

    if (res.isEmpty) {
      currentPage = 0;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> likePost(int postId) async {
    var res = await _postService.likePost(postId: postId);

    if (res == null) {
      Fluttertoast.showToast(msg: 'Error!');
      return false;
    } else if (res == true) {
      posts.firstWhere((element) => element.id == postId).likeCount =
          (posts.firstWhere((element) => element.id == postId).likeCount ?? 0) +
              1;
      return true;
    } else {
      posts.firstWhere((element) => element.id == postId).likeCount =
          (posts.firstWhere((element) => element.id == postId).likeCount ?? 0) -
              1;
      return false;
    }
  }

  resetList() {
    posts.clear();
    isLoading = false;
    currentPage = 1;
    notifyListeners();
  }
}
