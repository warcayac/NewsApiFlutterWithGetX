import 'package:comparing_getters/models/article_model.dart';
import 'package:comparing_getters/private/credentials.dart';
import 'package:comparing_getters/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class NewsApiController extends GetxController {
  var searchController = TextEditingController();
  var enabledButton = false.obs;
  var keyword = ''.obs;
  /* ---------------------------------------------------------------------------- */
  NewsApiController() {
    searchController.addListener(() => enabledButton.value = searchController.text.length >= 3);
  }
  /* ---------------------------------------------------------------------------- */
  static Future<List<Object>> _fetchArticles(String url) {
    final _maxResult = 40;

    return NetTools.getJsonHttp(url)
      .then((response) {
        if (response != null && response['status'] == 'ok') {
          final List<Object> list = response['articles'];
          return (list.length > _maxResult)
            ? list.take(_maxResult).toList()
            : list;
        }
        return null;
      });
  }
  /* ---------------------------------------------------------------------------- */
  static Future<List<Article>> getTopHeadlines() {
    var _topHeadlines = List<Article>();

    return _fetchArticles(ServerInfo.headlines)
      .then((news) {
        news.forEach((article) => _topHeadlines.add(Article.fromJson(article)));
        return _topHeadlines;
      });
  }
  /* ---------------------------------------------------------------------------- */
  static Future<List<Article>> getSearchBy(String keyword) {
    var _queryResult = List<Article>();

    return _fetchArticles('${ServerInfo.search}=$keyword')
      .then((news) {
        news.forEach((article) => _queryResult.add(Article.fromJson(article)));
        return _queryResult;
      });
  }
}

/* ============================================================================================= */

class SearchNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NewsApiController());
  }  
}
