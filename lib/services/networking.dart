import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';


class NetTools {
  /* ---------------------------------------------------------------------------- */
  static Future<Map<String, Object>> getJsonHttp(String url) {
    return http.get(Uri.parse(url))
      .then((response) => response.statusCode == 200 
        ? jsonDecode(response.body) as Map<String, Object> 
        : null
      )
      .catchError((err) => print(err));
  }
  /* ---------------------------------------------------------------------------- */
  static Future<Map<String, Object>> getJsonDio(String url) {
    return Dio().get<Map<String, Object>>(url)
      .then((response) => (response.statusCode == 200) ? response.data : null)
      .catchError((err) => print(err));
  }
}
