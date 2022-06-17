import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/data_post.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class PostService {
  final _api = locator<Api>();

  Future<bool> sharePost({required int taskId, String? caption}) async {
    Map<String, dynamic> data = {
      "task_id": taskId,
    };

    if (caption != null) {
      data["captions"] = caption;
    }

    var res = await _api.sharePost(data: data);

    if (res != null && res.data != null) {
      return true;
    }

    return false;
  }

  /// return map
  /// {
  ///   "posts" => List<Post>,
  ///   "likedPost" => List<int>
  /// }
  Future<DataPost?> getPost({required int page}) async {
    var res = await _api.getPost(data: {"page": page});

    if (res != null) {
      return DataPost.fromJson(res.data);
    }

    return null;
  }

  Future<DataPost?> getPostLastMonth({required int page}) async {
    var res = await _api.getPostLastMonth();

    if (res != null) {
      return DataPost.fromJson(res.data);
    }

    return null;
  }

  Future<bool?> likePost({required int postId}) async {
    var res = await _api.likePost(data: {
      "post_id": postId,
    });

    if (res != null) {
      return res.data;
    }
    return null;
  }

  Future<DataPost?> getWall({
    required int userId,
    required int page,
  }) async {
    var res = await _api.getWall(
      data: {"page": page, "user_id": userId},
    );

    if (res != null) {
      return DataPost.fromJson(res.data);
    }

    return null;
  }

  Future<bool> deletePost({required int postId}) async {
    var res = await _api.deletePost(data: {
      "post": postId,
    });

    if (res != null) {
      return res.data;
    }

    return false;
  }

  Future<bool> updatePost(
      {required int postId, required String captions}) async {
    var res =
        await _api.updatePost(data: {"post_id": postId, "captions": captions});

    if (res != null) {
      return res.data;
    }

    return false;
  }
}
