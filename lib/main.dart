import 'package:comparing_getters/src/controllers/news_api_controller.dart';
import 'package:comparing_getters/src/pages/search_news/search_news_page.dart';
import 'package:comparing_getters/src/pages/top_headlines/top_headlines_page.dart';
import 'package:comparing_getters/src/shared/pages_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() => runApp(MyApp());

/* ============================================================================================= */

class MyApp extends StatelessWidget {
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        GetPage(
          name: kPagesInfo['th']['path'], 
          page: () => TopHeadlinesPage(),
        ),
        GetPage(
          name: kPagesInfo['se']['path'], 
          page: () => SearchNewsPage(),
          binding: SearchNewsBinding(),
        ),
      ],
      initialRoute: kPagesInfo['th']['path'],
    );
  }
}
