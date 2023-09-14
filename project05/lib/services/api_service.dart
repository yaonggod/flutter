import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project05/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  // 비동기적으로 데이터 받아오기 -> Future 리턴, 올 수도 있고 안 올수도 있음
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // String -> JSON
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var w in webtoons) {
        // 웹툰 클래스 인스턴스로 만들기
        final webtoon = WebtoonModel.fromJson(w);
        webtoonInstances.add(webtoon);
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
