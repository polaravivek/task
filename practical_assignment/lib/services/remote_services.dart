import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:practical_assignment/models/freeAppModel.dart';

class RemoteService {
  String url;
  RemoteService({
    required this.url,
  });
  Future<List<FreeAppApi>?> getFreeAppList() async {
    var client = http.Client();
    Map mapresponse;

    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      mapresponse = json.decode(jsonString);
      print(mapresponse["feed"]["results"].runtimeType);
      List<FreeAppApi> mapApi = mapresponse["feed"]["results"]
          .map<FreeAppApi>((json) => FreeAppApi.fromJson(json))
          .toList();

      return mapApi.toList();
    }
    return [];
  }
}
