import 'package:flutter_cahoi_barbershop/core/models/data_post.dart';
import 'package:flutter_cahoi_barbershop/core/models/post2.dart';
import 'package:flutter_cahoi_barbershop/core/services/post_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StoryModel extends BaseModel {
  final _postService = locator<PostService>();

  List<Post2> posts = [];
  List<int> likedPost = [];

  bool isLoading = false;
  int currentPage = 1;

  Future changePosts({int? userId}) async {
    if (currentPage == 0) {
      return;
    }

    isLoading = true;
    notifyListeners();

    DataPost? res;
    if (userId != null) {
      res = await _postService.getWall(
        userId: userId,
        page: currentPage,
      );
    } else {
      res = await _postService.getPost(
        page: currentPage,
      );
    }

    if (res != null && res.posts != null) {
      if (res.posts!.isNotEmpty) {
        posts.addAll(res.posts ?? []);
        likedPost.addAll(res.likedPost ?? []);
        currentPage++;
      } else {
        currentPage = 0;
      }
    } else {
      Fluttertoast.showToast(msg: "Error!");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> likePost(int postId) async {
    var res = await _postService.likePost(postId: postId);
    int indexPost =
        posts.indexOf(posts.firstWhere((element) => element.id == postId));
    int indexLikedPost = likedPost.indexOf(
      likedPost.firstWhere((element) => element == postId, orElse: () => -1),
    );
    if (res == null) {
      Fluttertoast.showToast(msg: 'Error!');
      return false;
    } else if (res == true) {
      posts[indexPost].likeCount = (posts[indexPost].likeCount ?? 0) + 1;
      if (indexLikedPost == -1) {
        likedPost.add(postId);
      }
      notifyListeners();
      return true;
    } else {
      posts[indexPost].likeCount = (posts[indexPost].likeCount ?? 0) - 1;
      if (indexLikedPost != -1) {
        likedPost.removeAt(indexLikedPost);
      }
      notifyListeners();
      return false;
    }
  }

  Future deletePost({required int postId}) async {
    var res = await _postService.deletePost(postId: postId);

    if (res) {
      Fluttertoast.showToast(msg: "Đã xóa bài viết!");
    } else {
      Fluttertoast.showToast(msg: "Đã có lỗi sảy ra!");
    }
  }

  Future updatePost({required int postId, required String captions}) async {
    var res = await _postService.updatePost(postId: postId, captions: captions);

    if (res) {
      Fluttertoast.showToast(msg: "Thành công!");
    } else {
      Fluttertoast.showToast(msg: "Đã có lỗi sảy ra!");
    }
  }

  resetList() {
    posts.clear();
    likedPost.clear();
    isLoading = false;
    currentPage = 1;
    notifyListeners();
  }
}
