import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/youtube_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class PlaylistYoutubeModel extends ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _youtubeApi = locator<YoutubeService>();

  List<IdClipYoutube> clipIdList = [];
  List<ItemYoutube> clipInfoList = [];
  bool _disposed = false;

  changeClipIdList({String nextPageId = ''}) async {
    var response = await _youtubeApi.getPlayListYouTube(
        nextPageId: nextPageId, maxResults: 50);

    String nextPageToken = response.keys.first;

    List<IdClipYoutube> clipIdListTemp =
        response.values.first.map((i) => IdClipYoutube.fromMap(i)).toList();

    clipIdList += clipIdListTemp;

    notifyListeners();

    if (nextPageToken.isNotEmpty) {
      await changeClipInfoList(clipIdListTemp);
      await changeClipIdList(nextPageId: nextPageToken);
    } else {
      await changeClipInfoList(clipIdListTemp);
    }
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
}
