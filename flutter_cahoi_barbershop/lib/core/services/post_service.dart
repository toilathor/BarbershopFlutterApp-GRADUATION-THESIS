import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/post.dart';
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

  Future<List<Post>> getPost({required int page}) async {
    var res = await _api.getPost(data: {"page": page});

    if (res != null) {
      return List<Post>.from(res.data.map((e) => Post.fromJson(e)).toList());
    }

    return [];
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
}