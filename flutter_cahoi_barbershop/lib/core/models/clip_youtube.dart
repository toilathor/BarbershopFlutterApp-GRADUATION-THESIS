class ClipYouTube {
  ClipYouTube({
    required this.title,
    required this.linkImage,
    required this.id,
    required this.publishedAt,
    required this.viewCount,
  });

  String title;
  String linkImage;
  String id;
  String publishedAt;
  String viewCount;

  factory ClipYouTube.fromJson(Map<String, dynamic> json) {
    return ClipYouTube(
      id: json['id'] as String,
      title: json['snippet']['title'] as String,
      linkImage: json['snippet']['thumbnails']['maxres'] == null
          ? ''
          : json['snippet']['thumbnails']['maxres']['url'].toString(),
      publishedAt: json['snippet']['publishedAt'] as String,
      viewCount: json['statistics']['viewCount'] as String,
    );
  }

  @override
  String toString() {
    return 'ItemYoutube(title: $title, linkImage: $linkImage, id: $id, publishedAt: $publishedAt, viewCount: $viewCount)';
  }
}

class IdClipYouTube {
  String id;

  IdClipYouTube({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory IdClipYouTube.fromMap(Map<String, dynamic> map) {
    return IdClipYouTube(
      id: map['snippet']['resourceId']['videoId'] ?? '',
    );
  }
}
