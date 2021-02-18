import 'package:comparing_getters/src/controllers/news_api_controller.dart';
import 'package:comparing_getters/src/shared/base_news_page.dart';
import 'package:comparing_getters/src/shared/news_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SearchNewsPage extends BaseNewsPage {
  final watcher = Get.find<NewsApiController>();
  final disposition = UnfocusDisposition.scope;
  /* ---------------------------------------------------------------------------- */
  SearchNewsPage({Key key}) : super(key: key, pageId: 'se');
  /* ---------------------------------------------------------------------------- */
  @override
  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(),
                    SizedBox(width: 4),
                    Obx(() => _buildSearchButton()),
                  ],
                ),
              ),
            ),
            Obx(() => NewsBuilder(
              keyword: watcher.keyword.value.trim(),
              isSearching: true,
            )),
          ],
        ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  Expanded _buildTextField() {
    return Expanded(
      child: TextField(
        controller: watcher.searchController,
        maxLength: 15,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.input),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: 'keyword'
        ),
        // onSubmitted: (value) {
        //   watcher
        //     ..keyword.value = watcher.searchController.text
        //     ..searchController.text = '';
        // },
      ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  Widget _buildSearchButton() {
    return Container(
      height: 59,
      margin: EdgeInsets.all(0),
      width: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FlatButton(
          padding: EdgeInsets.all(0),
          color: Colors.purple[100],
          child: Icon(Icons.search),
          disabledColor: Colors.grey[350],
          highlightColor: Colors.purple[300],
          onPressed: watcher.enabledButton.isTrue 
            ? () {
              primaryFocus.unfocus(disposition: disposition);
              watcher
                ..keyword.value = watcher.searchController.text
                ..searchController.text = '';
            }
            : null,
        ),
      ),
    );
  }
}
