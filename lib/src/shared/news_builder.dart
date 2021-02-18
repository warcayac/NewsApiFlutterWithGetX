import 'package:comparing_getters/models/article_model.dart';
import 'package:comparing_getters/src/controllers/news_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewsBuilder extends StatelessWidget {
  final String keyword;
  final bool isSearching;
  /* ---------------------------------------------------------------------------- */
  const NewsBuilder({Key key, this.keyword, this.isSearching = false}) : super(key: key);
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return ['', null].contains(keyword) && isSearching
      ? Container()
      : FutureBuilder<List<Article>>(
          future: !isSearching
            ? NewsApiController.getTopHeadlines()
            : NewsApiController.getSearchBy(keyword),
          builder: (context, snapshot) {
            return snapshot.hasError
              ? Text(snapshot.error, style: TextStyle(color: Colors.red))
              : snapshot.connectionState == ConnectionState.waiting
                ? Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
                : snapshot.connectionState == ConnectionState.done && snapshot.hasData
                  ? Column(children: _buildArticles(snapshot.data))
                  : Center(child: Icon(Icons.error_outline, size: 20, color: Colors.red));
          },
      );
  }
  /* ---------------------------------------------------------------------------- */
  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final diffDates = now.difference(dt).inDays;

    return diffDates > 1
      ? DateFormat('EEEE, MMMM d, y   HH:mm').format(dt)
      : (diffDates == 1 || dt.day != now.day ? 'Yesterday' : 'Today') + DateFormat(',   HH:mm').format(dt);
  }
  /* ---------------------------------------------------------------------------- */
  List<Widget> _buildArticles(List<Article> data) {
    return List<Widget>.generate(data.length, (index) => Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 8, 5, 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _formatDateTime(data[index].publishedAt_UTC.toLocal()), 
                  style: TextStyle(fontSize: 10, color: Colors.amber[900]),
                ),
              ],
            ),
            if (data[index].title != null) ...[
              Text(data[index].title, style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.purple[900]
              )),
              SizedBox(height: 4),
            ],
            if (data[index].urlToImage != null) ...[
              Image.network(data[index].urlToImage),
              SizedBox(height: 4),
            ],
            if (data[index].description != null) 
              Text(data[index].description, style: TextStyle(
                fontSize: 12, color: Colors.black.withOpacity(0.7)
              )),
            if (index == data.length-1) SizedBox(height: 8),
          ],
        ),
      ),
    ));
  }
}