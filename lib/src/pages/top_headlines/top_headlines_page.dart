import 'package:comparing_getters/src/shared/base_news_page.dart';
import 'package:comparing_getters/src/shared/news_builder.dart';
import 'package:flutter/material.dart';


class TopHeadlinesPage extends BaseNewsPage {
  /* ---------------------------------------------------------------------------- */
  const TopHeadlinesPage({Key key}) : super(key: key, pageId: 'th');
  /* ---------------------------------------------------------------------------- */
  @override
  Widget buildBody() {
    return SingleChildScrollView(
      child: NewsBuilder(),
    );
  }
}
