import 'dart:convert';

import 'package:project06/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String path) {
    return "http://$ip$path";
  }

  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

  // Base64 인코딩
  static String plainToBase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(plain);
  }

  static DateTime stringToDateTime(String value) {
    return DateTime.parse(value);
  }
}


