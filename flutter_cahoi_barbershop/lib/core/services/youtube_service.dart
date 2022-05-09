import 'dart:convert';

import 'package:flutter_cahoi_barbershop/core/models/clip_youtube.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:http/http.dart';

class YoutubeService {
  Client client = Client();

  Future<Map<String, List<dynamic>>> getPlayListYouTube(
      {String nextPageId = '', int maxResults = 10}) async {
    String url = '$baseLinkAPIYT/playlistItems?part=snippet'
        '&maxResults=$maxResults'
        '&pageToken=$nextPageId'
        '&playlistId=$playlistId'
        '&fields=items(snippet(resourceId(videoId)))%2CnextPageToken'
        '&key=$apiKeyFirebase';

    Response response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      return {json['nextPageToken'] ?? '': json['items']};
    }

    return {'': []};
  }

  Future<List<dynamic>> getInfoVideosYouTube(List<IdClipYouTube> idList) async {
    String url = '$baseLinkAPIYT/videos?part=statistics&part=snippet';

    for (var item in idList) {
      url += '&id=${item.id}';
    }

    url += '&maxResults=50&'
        '&fields=items(statistics(viewCount)%2Cid%2Csnippet(publishedAt%2Ctitle%2Cthumbnails(maxres(url))))'
        '&key=$apiKeyFirebase';

    Response response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      return json['items'];
    }

    return [];
  }
}
