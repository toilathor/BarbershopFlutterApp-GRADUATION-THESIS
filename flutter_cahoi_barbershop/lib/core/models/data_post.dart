import 'package:flutter_cahoi_barbershop/core/models/post.dart';

class DataPost {
  DataPost({
    this.posts,
    this.likedPost,
  });

  DataPost.fromJson(dynamic json) {
    posts = json['posts']["data"] != null
        ? List<Post>.from(
            json['posts']["data"].map((e) => Post.fromJson(e)).toList())
        : null;
    if (json['likedPost'] != null) {
      likedPost = List<int>.from(json["likedPost"].map((e) => e).toList());
    }
  }

  List<Post>? posts;
  List<int>? likedPost;

  DataPost copyWith({
    List<Post>? posts,
    List<int>? likedPost,
  }) =>
      DataPost(
        posts: posts ?? this.posts,
        likedPost: likedPost ?? this.likedPost,
      );
}
