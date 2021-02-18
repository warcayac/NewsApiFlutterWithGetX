class Article {
  Source source;
  String author, title, description, url, urlToImage;
  DateTime publishedAt_UTC;
  String content;
  /* ---------------------------------------------------------------------------- */
  Article.fromJson(Map<String, Object> data) {
    source = Source.fromJson(data['source']);
    author = data['author'];
    title = data['title'];
    description = data['description'];
    url = data['url'];
    urlToImage = data['urlToImage'];
    publishedAt_UTC = DateTime.tryParse(data['publishedAt']);
    content = data['content'];
  }
}

/* ============================================================================================= */

class Source {
  String id, name;
  /* ---------------------------------------------------------------------------- */
  Source.fromJson(Map<String, Object> data) {
    id = data['id'];
    name = data['name'];
  }
}
