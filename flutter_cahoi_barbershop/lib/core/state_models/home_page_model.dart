import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/clip_youtube.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/services/youtube_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class HomePageModel extends ChangeNotifier {
  final _youtubeApi = locator<YoutubeService>();

  bool _disposed = false;

  final _authService = locator<AuthenticationService>().user;
  List<IdClipYouTube> clipIdList = [];
  List<ClipYouTube> clipInfoList = [];

  Future changeClipIdList() async {
    var response = await _youtubeApi.getPlayListYouTube(maxResults: 5);

    clipIdList =
        response.values.first.map((i) => IdClipYouTube.fromMap(i)).toList();

    notifyListeners();

    await changeClipInfoList(clipIdList);
  }

  Future changeClipInfoList(List<IdClipYouTube> clipIdList) async {
    var response = await _youtubeApi.getInfoVideosYouTube(clipIdList);

    try {
      clipInfoList += response.map((i) => ClipYouTube.fromJson(i)).toList();

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
    changeClipIdList();
  }
}
