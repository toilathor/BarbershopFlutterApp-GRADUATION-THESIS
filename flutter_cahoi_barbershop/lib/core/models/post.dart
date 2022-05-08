class Post {
  int postId;
  int userId;
  int stylistId;
  String userName;
  String stylistName;
  List<String> images;
  String? caption;
  String publicAt;
  int likeCount;

  Post(
      {required this.postId,
      required this.userId,
      required this.stylistId,
      required this.userName,
      required this.stylistName,
      required this.images,
      required this.publicAt,
      required this.likeCount,
      this.caption});

  Post.initial()
      : postId = 1,
        userId = 1,
        stylistId = 1,
        userName = 'toilathor',
        stylistName = 'Thuận Cahoi',
        likeCount = 123,
        images = [],
        publicAt = '2022-01-01 12:00',
        caption = '';

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    postId: json['postId']?.toInt() ?? 0,
    userId: json['userId']?.toInt() ?? 0,
    stylistId: json['stylistId']?.toInt() ?? 0,
    userName: json['userName'] ?? '',
    stylistName: json['stylistName'] ?? '',
    images: List<String>.from(json['images']),
    likeCount: json['likeCount']?.toInt() ?? 0,
    caption: json['caption'] ?? '',
    publicAt: json['publicAt'] ?? '',
  );
}
