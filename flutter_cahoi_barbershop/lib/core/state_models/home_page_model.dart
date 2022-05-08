import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/user/user.dart';
import 'package:flutter_cahoi_barbershop/core/services/youtube_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/store_secure.dart';

class HomePageModel extends ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _youtubeApi = locator<YoutubeService>();
  final _storeSecure = locator<StoreSecure>();

  bool _disposed = false;

  List<IdClipYoutube> clipIdList = [];
  List<ItemYoutube> clipInfoList = [];
  MUser user = MUser.defaultUser();

  changeUser() async {
    String? sUser = await _storeSecure.getUser();

    user = MUser.fromJson(
        sUser != null ? jsonDecode(sUser) : MUser.defaultUser().toJson());

    notifyListeners();
  }

  changeClipIdList() async {
    var response = await _youtubeApi.getPlayListYouTube(maxResults: 5);

    clipIdList =
        response.values.first.map((i) => IdClipYoutube.fromMap(i)).toList();

    notifyListeners();

    await changeClipInfoList(clipIdList);
  }

  changeClipInfoList(List<IdClipYoutube> clipIdList) async {
    var response = await _youtubeApi.getInfoVideosYouTube(clipIdList);

    try {
      clipInfoList += response.map((i) => ItemYoutube.fromJson(i)).toList();

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  initHomePage() {
    changeUser();
    changeClipIdList();
  }
}

class ItemYoutube {
  String title;
  String linkImage;
  String id;
  String publishedAt;
  String viewCount;

  ItemYoutube({
    required this.title,
    required this.linkImage,
    required this.id,
    required this.publishedAt,
    required this.viewCount,
  });

  set setViewCount(int viewCount) => this.viewCount = '$viewCount';

  factory ItemYoutube.fromJson(Map<String, dynamic> json) {
    return ItemYoutube(
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

class IdClipYoutube {
  String id;

  IdClipYoutube({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory IdClipYoutube.fromMap(Map<String, dynamic> map) {
    return IdClipYoutube(
      id: map['snippet']['resourceId']['videoId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IdClipYoutube.fromJson(String source) =>
      IdClipYoutube.fromMap(json.decode(source));
}
